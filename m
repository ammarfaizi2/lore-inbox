Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314138AbSDZTZ4>; Fri, 26 Apr 2002 15:25:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314139AbSDZTZz>; Fri, 26 Apr 2002 15:25:55 -0400
Received: from relay2.EECS.Berkeley.EDU ([169.229.60.28]:59789 "EHLO
	relay2.EECS.Berkeley.EDU") by vger.kernel.org with ESMTP
	id <S314138AbSDZTZx>; Fri, 26 Apr 2002 15:25:53 -0400
Message-ID: <3CC9A9BE.7030606@cs.berkeley.edu>
Date: Fri, 26 Apr 2002 12:25:50 -0700
From: Hao Chen <hchen@cs.berkeley.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc1) Gecko/20020417
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: David Wagner <daw@cs.berkeley.edu>, ddean@csl.sri.com,
        Hao Chen <hchen@eecs.berkeley.edu>
Subject: A security bug w.r.t. fsuid?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We came across a possible security bug with regard to fsuid while doing
research on Linux's user ID model.  In linux/kernel/sys.c, in the comment
just before the body of cap_emulate_setxuid(), it says:

   *  fsuid is handled elsewhere. fsuid == 0 and {r,e,s}uid!= 0 should
   *  never happen.

However, the following program shows that a process can enter the state
where ruid=euid=suid!=0 and fsuid=0.  The problem is with setresuid().
While setuid() and setreuid() always set fsuid to euid, setresuid(ruid,
euid, suid) fails to do the same when the euid parameter is -1.

Normally, a programmer expects that if none of the ruid, euid, and suid of a
process is zero, the process has no root privileges.  This seems to be the
reason behind the above comment from linux/kernel/sys.c.  If this invariant
is not satisfied, i.e. if a process can get ruid=euid=suid!=0 and fsuid=0, 
an unwary programmer may allow the process to create a file whose data are
supplied by an untrusted user.  Since fsuid=0, the file will be owned by
root.   If the file happens to be setuid-root, then the user can gain root
access (by asking the process to write shell command into the file and then
running the file).

We are not sure if this invariant is a true invariant or just a 
documentation error, and how much kernel code rely on this invariant.  Could 
anyone point out?

Thanks,

- Hao


Run the following program as user root
-------------------------------------------------------
#include <stdio.h>
#include <unistd.h>
#include <sys/types.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>
#include <fcntl.h>

int getresuid(uid_t *ruid, uid_t *euid, uid_t *suid);
int setresuid(uid_t ruid, uid_t euid, uid_t suid);
int setfsuid(uid_t);

int getfsuid(uid_t *fsuid)
{
    pid_t pid;
    char filename[1024], str[1024], *str2;
    FILE *fp;
    int i;

    if ((pid = getpid()) < 0)
    {
      perror("getpid()");
      exit(1);
    }
    sprintf(filename, "/proc/%u/status", pid);
    if ((fp = fopen(filename, "r")) == NULL)
    {
      perror("fopen()");
      exit(1);
    }
    while (fgets(str, 1023, fp) != NULL)
    {
      if ((str2 = strstr(str, "Uid:")) == str)
      {
        strtok(str, "\t");
        for (i = 0; i < 4; i++)
          str2 = strtok(NULL, "\t");
        *fsuid = atoi(str2);
        fclose(fp);
        return 0;
      }
    }

    return -1;
}

int main()
{
    uid_t alice = 100;
    uid_t ruid, euid, suid, fsuid;

    // Now ruid==0, euid==0, suid==0, fsuid==0
    if (setresuid(alice, alice, -1) < 0)
    {
      perror("setresuid");
      exit(1);
    }
    // Now ruid==alice, euid==alice, suid==0, fsuid==alice
    setfsuid(0);
    // Now ruid==alice, euid==alice, suid==0, fsuid==0
    if (setresuid(-1, -1, alice) < 0)
    {
      perror("setresuid");
      exit(1);
    }
    // Now ruid==alice, euid==alice, suid==alice, fsuid==0
    // But according to linux/kernel/sys.c:
    // "fsuid == 0 and {r,e,s}uid!= 0 should never happen."
    if (getresuid(&ruid, &euid, &suid) < 0)
    {
      perror("getresuid");
      exit(1);
    }
    if (getfsuid(&fsuid) < 0)
    {
      fprintf(stderr, "getfsuid failed\n");
    }
    printf("ruid=%u  euid=%u  suid=%d  fsuid=%d\n", ruid, euid, suid, fsuid);
}


