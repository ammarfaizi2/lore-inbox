Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288747AbSAIC4C>; Tue, 8 Jan 2002 21:56:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288744AbSAICzx>; Tue, 8 Jan 2002 21:55:53 -0500
Received: from mysql.sashanet.com ([209.181.82.108]:16512 "EHLO
	mysql.sashanet.com") by vger.kernel.org with ESMTP
	id <S288738AbSAICzo>; Tue, 8 Jan 2002 21:55:44 -0500
Message-Id: <200201090245.g092jnt02235@mysql.sashanet.com>
Content-Type: text/plain;
  charset="us-ascii"
From: Sasha Pachev <sasha@mysql.com>
Organization: MySQL
To: linux-kernel@vger.kernel.org
Subject: Test case for cache leak in 2.17.2-rc2
Date: Tue, 8 Jan 2002 19:45:49 -0700
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following test program demonstrates incorrect cache shrinking logic in 
2.17.2-rc2 with 0 swap. I suspect the same problem will happen if swap is not 
zero but is filled up. I have not noticed anything relevant in the changelogs 
between my version and 2.4.18-pre2, so I assume the bug is still there. It 
would be nice if somebody could verify it.

First the code:

-------------------start---------------------
#include <stdio.h>
#include <stdlib.h>
#include <signal.h>
#include <unistd.h>

#define BLOCK_SIZE 1024

int done_hog_cache=0;
int done_hog_free=0;
int go_pipe[2];
pid_t child_pid=0;

void stop_hog_cache()
{
  done_hog_cache=1;
}

void stop_hog_free()
{
  done_hog_free=1;
}

void stop_all()
{
  done_hog_free=done_hog_cache=1;
  if (child_pid>0)
    kill(child_pid,SIGHUP);
}

void hog_free(int blocks)
{
  char* buf;
  char go_buf[2];
  
  signal(SIGHUP,stop_hog_free);
  signal(SIGTERM,stop_hog_free);
  printf("Hogging free mem, to stop, do kill -HUP %d in another terminal\n",
	 getpid());
  read(go_pipe[0],go_buf,2);
  if (!(buf=(char*)malloc(blocks*BLOCK_SIZE)))
  {
    fprintf(stderr,"malloc() failed\n");
    exit(1);
  }
  memset(buf,0xff,blocks*BLOCK_SIZE);
  while (!done_hog_free)
  {
    sleep(1);
  }
}

void hog_cache(int blocks)
{
  FILE* fp;
  char buf[BLOCK_SIZE];
  const char* hog_file="/tmp/hog-file";
  int i;
  
  memset(buf,0xff,sizeof(buf));
  if (!(fp=fopen(hog_file,"w+")))
  {
    fprintf(stderr,"Could not open crash file\n");
    exit(1);
  }
  signal(SIGHUP,stop_hog_cache);
  signal(SIGTERM,stop_hog_free);
  printf("Hogging disk cache, to stop, do kill -HUP %d in another terminal\n",
	 getpid());
  for (i=0;i<blocks;i++)
  {
    fwrite(buf,1,sizeof(buf),fp);
  }
  fflush(fp);
  write(go_pipe[1],"go",2);
  while (!done_hog_cache)
  {
    fseek(fp,0L,SEEK_SET);
    for (i=0;i<blocks;i++)
    {
      fread(buf,1,sizeof(buf),fp);
    }
  }
  
  fclose(fp);
  unlink(hog_file);
  printf("Finished cleanup of disk cache hog\n");
}

int main(int argc,char** argv)
{
  int cache_blocks,free_blocks;
  if (argc<3)
  {
    fprintf(stderr,"Usage: ./crash-kernel cache_blocks free_blocks\n");
    exit(1);
  }
  cache_blocks=atoi(argv[1]);
  free_blocks=atoi(argv[2]);
  if (pipe(go_pipe) == -1)
  {
    fprintf(stderr,"could not create pipe\n");
    exit(1);
  }
  signal(SIGINT,stop_all);
  switch ((child_pid=fork()))
  {
  case 0:  hog_cache(cache_blocks); break;
  case -1:
    fprintf(stderr, "cannot fork\n");
    exit(1);
  default: hog_free(free_blocks); break;
  }
}
-----------------end------

To see the problem, ./crash-kernel cache_blocks free_blocks

set cache_blocks to eat up all of your physical RAM + swap, and free_blocks 
to some sigficant amount, but less than what is actually available before you 
run the test.

As you can see from the source, crash-kernel first tries to bloat the cache 
by creating a large file, and then tries to keep it bloated by reading the 
file data in a loop. As soon as the file is created, the other fork tries to 
allocate and initialize a chunk of memory, and then goes to sleep.

The correct behaviour would be, of course, to shrink the bloated cache and 
give memory from it. But what happens on 2.4.17-rc2 is that the memory thread 
gets killed instead.

Please CC me on replies as I do not subsribe to the list...

-- 
MySQL Development Team
For technical support contracts, visit https://order.mysql.com/
   __  ___     ___ ____  __ 
  /  |/  /_ __/ __/ __ \/ /   Sasha Pachev <sasha@mysql.com>
 / /|_/ / // /\ \/ /_/ / /__  MySQL AB, http://www.mysql.com/
/_/  /_/\_, /___/\___\_\___/  Provo, Utah, USA
       <___/                  
