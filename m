Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264072AbRGGA1M>; Fri, 6 Jul 2001 20:27:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264238AbRGGA1D>; Fri, 6 Jul 2001 20:27:03 -0400
Received: from mysql.sashanet.com ([209.181.82.108]:1664 "EHLO
	mysql.sashanet.com") by vger.kernel.org with ESMTP
	id <S264072AbRGGA0v>; Fri, 6 Jul 2001 20:26:51 -0400
Content-Type: text/plain; charset=US-ASCII
From: Sasha Pachev <sasha@mysql.com>
Organization: MySQL
To: linux-kernel@vger.kernel.org
Subject: Test case for kernel crash
Date: Fri, 6 Jul 2001 18:30:32 -0600
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01070618303201.00772@mysql>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am able to crash 2.4.3 kernel on a dual Pentium 500 with 256 MB RAM and no 
swap space with the program below. to compile, gcc -o oom oom.c -lpthread

Found out that my magic SysRq for some reason was not working :( so I could  
not get much detail - will fix the magic and report more when it becomes 
available. I have observed three types of behavior:

* once the program locked everything up ( test run from X), the machine did 
not even ping. However, after some time ( about 5 minutes), the machine 
became functional again 
* another time, there was a complete lockup ( again in X), I waited 10 
minutes, nothing happened, so I just rebooted
* then I tried the test after a clean boot - this time no X, just plain 
consoles - after the run I actually got the shell back, could not type 
anything. I could switch between virtual consoles, type my username at the 
login prompt, but would never get the password prompt. The machine pinged, 
and I could even connect to ports that had services, but got no response 
after a successfull connect. My explanation is that the kernel ran out of 
memory, but could not clean up.

The only relevant thing I could find in syslog is messages like this:

Jul  6 17:33:31 mysql kernel: Out of Memory: Killed process 25500 (oom).
Jul  6 17:33:35 mysql last message repeated 84 times
Jul  6 17:33:35 mysql kernel: Out of Memory: Killed process 25501 (oom).
Jul  6 17:33:35 mysql last message repeated 5 times
Jul  6 17:33:35 mysql kernel: Out of Memory: Killed process 25502 (oom).
Jul  6 17:33:35 mysql last message repeated 263 times

And last but not least - the whole reason for writing the program below was 
to create a simple test case and isolate the problem in a real life threaded 
application that left some unkillable ( even with -9 ) processes after 
running out of memory and getting killed itself. So I suspect I have 
accomplished my goal of creating unkillable process, which is what, 
apparently, makes it so difficult for the kernel to recover from the stress. 

Note that I had to get the process stuck in I/O to cause the problem - 
without the I/O the kernel kills all the bad guys and recovers gracefully.

So let's hope this is enough info to track down the bug - if not let me know 
what else is needed.

----------------------------cut------------------

#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <unistd.h>

#define LEAK_BLOCK (1024*1024)
#define MB (1024*1024)
#define NUM_THREADS 64

int pipe_fd[2];

void* run_thread(void* arg)
{
  unsigned long total = 0;
  char buf[3];
  
  for (;;)
  {
    char* p, *p_end;
    if(!(p=malloc(LEAK_BLOCK)))
    {
      fprintf(stderr, "malloc() failed\n");
      exit(1);
    }
    p_end = p + LEAK_BLOCK;
    while(p < p_end)
      *p++ = 0;
    total += LEAK_BLOCK;
    printf("Allocated %d MB\n", total/MB);
    fflush(stdout);
    read(pipe_fd[0], buf, 3);
  }
  return 0;
}

int main()
{
  pthread_t th[NUM_THREADS];
  int i;

  if(pipe(pipe_fd) == -1)
  {
    fprintf(stderr, "Could not create pipe\n");
    exit(1);
  }

  for(i = 0; i < NUM_THREADS; i++)
    if(pthread_create(th + i, 0, run_thread, 0))
    {
      fprintf(stderr, "Could not create thread\n");
      exit(1);
    }

  while(1)
  {
    write(pipe_fd[1], "foo", 3);
  }

  for(i = 0; i < NUM_THREADS; i++)
    if(pthread_join(th[i], 0))
    {
      fprintf(stderr, "Error in pthread_join\n");
      exit(1);
    }
  
  return 0;   
}

-----------------------------cut------------------------



-- 
MySQL Development Team
For technical support contracts, visit https://order.mysql.com/
   __  ___     ___ ____  __ 
  /  |/  /_ __/ __/ __ \/ /   Sasha Pachev <sasha@mysql.com>
 / /|_/ / // /\ \/ /_/ / /__  MySQL AB, http://www.mysql.com/
/_/  /_/\_, /___/\___\_\___/  Provo, Utah, USA
       <___/                  
