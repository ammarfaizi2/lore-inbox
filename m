Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315427AbSFYAhf>; Mon, 24 Jun 2002 20:37:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315429AbSFYAhe>; Mon, 24 Jun 2002 20:37:34 -0400
Received: from tomts19-srv.bellnexxia.net ([209.226.175.73]:25308 "EHLO
	tomts19-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S315427AbSFYAhc>; Mon, 24 Jun 2002 20:37:32 -0400
Message-ID: <3D17BB4B.F5E2571F@sympatico.ca>
Date: Mon, 24 Jun 2002 20:37:31 -0400
From: Christian Robert <xtian-test@sympatico.ca>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en, fr-CA
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: gettimeofday problem
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For your eyes,

while reading this thread I wrote a sample program to test if the clock
sometimes goes backward/forward.

I started my program while continuing reading threads on the linux-kernel
archive. After about 90 minutes of continuous running I went back to the window
running the program and surprise I saw this:

$ ./tloop 
Bump negative -4294967295
^C
Summary:
-------
 Min = 0
 Max = 257845
 Avg = 1 (6009092476/5521919279)


So it looks like the time changed somewhere of a value +/- 4,295 seconds.

kernel 2.4.18

$ cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 1
cpu MHz         : 602.566
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips        : 1202.58

--------------------- program tloop.c -------------------------

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

#include <sys/time.h>
#include <signal.h>

typedef long long LL;

LL GetTime (void)
{
  struct timeval tv;
  LL     retval;

  gettimeofday (&tv, NULL);
  retval = (tv.tv_sec * 1000000) + (tv.tv_usec);
  return retval;
}

volatile int Break = 0;

void Trap (int sig)
{
  Break = 1;
}

int main (void)
{
  LL Now, Old;
  LL Dt,  Min=9999999, Max=0, Num=0, Tot=0;

  Old = Now = GetTime ();

  signal (SIGINT,  Trap);
  signal (SIGQUIT, Trap);

  for ( ; Break==0 ; )
  {
    Now = GetTime();

    if (Now < Old)
    {
      printf ("Bump negative %lld\n", (Now-Old));
    }
    else
    {
      Dt  = Now-Old;

      Min = (Dt < Min) ? Dt : Min;
      Max = (Dt > Max) ? Dt : Max;

      Tot += Dt;
      Num += 1;
    }

    Old = Now;
  }

  printf ("Summary:\n-------\n Min = %lld\n Max = %lld\n "
          "Avg = %lld (%lld/%lld)\n", Min, Max, Tot/Num, Tot, Num);

  return 0;
}
