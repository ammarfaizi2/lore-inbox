Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269187AbUJFKPK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269187AbUJFKPK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 06:15:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269188AbUJFKPJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 06:15:09 -0400
Received: from smtp.poczta.interia.pl ([217.74.65.43]:7743 "EHLO
	smtp.poczta.interia.pl") by vger.kernel.org with ESMTP
	id S269187AbUJFKOR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 06:14:17 -0400
Message-ID: <4163C574.50805@interia.pl>
Date: Wed, 06 Oct 2004 12:14:12 +0200
From: Patryk Jakubowski <patrics@interia.pl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040630
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Invisible threads in 2.6.9
References: <S268296AbUJDTjb/20041004193948Z+2396@vger.kernel.org> <41630B2C.5020709@interia.pl> <4163619C.4070600@vgertech.com> <4163A3E2.2060609@stud.feec.vutbr.cz>
In-Reply-To: <4163A3E2.2060609@stud.feec.vutbr.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-EMID: 959f6acc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Schmidt wrote:

>
> It doesn't work for me:
>
> # ps aux | grep [t]hread
> michich   7447  0.0  0.0     0    0 pts/1    Zl+  09:43   0:00 
> [threadbug] <defunct>
> # ps auwxH | grep [t]hread
> #
>
> And I can't inspect /proc directly:
>
> Isn't it strange?
>
> Michal Schmidt
>

Yes. It is badly strange for me. It is not the bug in procps. procps 
scans the /proc tree for information, top and ps too. I know that I'm 
amateur programmer, but not kernel programmer.

When i run this example program (threadbug) and let its PID be 6024. Its 
first subthread can be PID 6025 (for example). The lider thread exits. 
And /proc/6024/task is inaccesible, ls shows it empty. 
/proc/6024/task/6025 should exist. However, cat /proc/6025/cmdline 
returns ./threadbug. But ls -d /proc/602? do not shows /proc/6025. Any 
way. I'm almost sure that /proc/6024/task/* should be visible. It is bug 
in procfs filesystem or buggy strategy to show tasks in /proc.



I put here my session with threadbug. Important lines are prefixed with "!".

  pat@pat:/tmp$ cat > threadbug.c
  #include <pthread.h>
  #include <unistd.h>
 
  void *run(void *arg)
  {
      for(;;);
  }
 
  int main()
  {
      pthread_t t;
      int i;
      for (i = 0; i < 10; ++i)
          pthread_create(&t, NULL, run, NULL);
      sleep(30);
      pthread_exit(NULL);
  }

  pat@pat:/tmp$ gcc -o threadbug -lpthread threadbug.c

  pat@pat:/tmp$ ./threadbug &
  [1] 6907

  pat@pat:/tmp$ date
  Wed Oct  6 11:37:41 CEST 2004

! pat@pat:/tmp$ ls /proc/6907/task    # threads are detectable
  6907  6908  6909  6910  6911  6912  6913  6914  6915  6916  6917

  pat@pat:/tmp$ ps m
    PID TTY      STAT   TIME COMMAND
   1647 pts/0    -      0:00 /bin/bash
      - -        Ss     0:00 -
   6019 pts/2    -      0:00 /bin/bash
      - -        Ss     0:00 -
   6035 pts/3    -      0:00 /bin/bash
      - -        Ss+    0:00 -
   6907 pts/2    -      0:00 ./threadbug
      - -        S      0:00 -
      - -        R      0:06 -
      - -        R      0:06 -
      - -        R      0:06 -
      - -        R      0:05 -
      - -        R      0:06 -
      - -        R      0:06 -
      - -        R      0:06 -
      - -        R      0:05 -
      - -        R      0:07 -
      - -        R      0:07 -
   6928 pts/2    -      0:00 ps m
      - -        R+     0:00 -

! pat@pat:/tmp$ date    # now leader thread is exited
!  Wed Oct  6 11:40:15 CEST 2004

  pat@pat:/tmp$ ls /proc/6907/task
!  ls: /proc/6907/task: No such file or directory    # no threads and 
other info

  pat@pat:/tmp$ ps m
    PID TTY      STAT   TIME COMMAND
   1647 pts/0    -      0:00 /bin/bash
      - -        Ss     0:00 -
   6019 pts/2    -      0:00 /bin/bash
      - -        Ss     0:00 -
   6035 pts/3    -      0:00 /bin/bash
      - -        Ss+    0:00 -
   6907 pts/2    -      0:00 [threadbug] <defunct>
   6942 pts/2    -      0:00 ps m
      - -        R+     0:00 -

!  pat@pat:/tmp$ cat /proc/69[01]?/cmdline   # where are the threads?

!  pat@pat:/tmp$ cat /proc/6907/cmdline    # where is info?

  pat@pat:/tmp$ cat /proc/6908/cmdline    # some info is hidden here
  ./threadbug

  pat@pat:/tmp$ cat /proc/6909/cmdline
  ./threadbug

  pat@pat:/tmp$ cat /proc/6910/cmdline
 ./threadbug

! pat@pat:/tmp$ cat /proc/6910/status    # and here
  Name:   threadbug
  State:  R (running)
  SleepAVG:       0%
! Tgid:   6907
! Pid:    6910   # this is PID of the thread of process 6907
  PPid:   6019
  TracerPid:      0
  Uid:    1000    1000    1000    1000
  Gid:    100     100     100     100
  FDSize: 256
  Groups: 4 5 24 29 33 44 100 1001
  VmSize:    83528 kB
  VmLck:         0 kB
  VmRSS:       456 kB
  VmData:    82076 kB
  VmStk:        12 kB
  VmExe:         1 kB
  VmLib:     83343 kB
!  Threads:        11    # 10 subthreads and 1 leader thread
  SigPnd: 0000000000000000
  ShdPnd: 0000000000000000
  SigBlk: 0000000000000000
  SigIgn: 0000000000000000
  SigCgt: 0000000080000000
  CapInh: 0000000000000000
  CapPrm: 0000000000000000
  CapEff: 0000000000000000
  pat@pat:/tmp$ kill %1
  pat@pat:/tmp$
  [1]+  Terminated              ./threadbug
  pat@pat:/tmp$


I have checked threadbug program ont RedHat Enterprise with 2.4.21 
kernel with NPTL 0.60. Threads was visible after leader thread exits and 
process become zombie state.

My configuration:
Kernel: 2.6.9-rc9, SMP/SMT, not preemptible
libc6-2.3.2

GNU_LIBPTHREAD_VERSION = NPTL 0.60
P4 Presscott processor, HT
gcc-3.4




----------------------------------------------------------------------
Portal INTERIA.PL zaprasza... >>> http://link.interia.pl/f17cb

