Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264012AbUEMPbX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264012AbUEMPbX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 11:31:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264258AbUEMPbW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 11:31:22 -0400
Received: from wingding.demon.nl ([82.161.27.36]:9603 "EHLO wingding.demon.nl")
	by vger.kernel.org with ESMTP id S264012AbUEMP35 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 11:29:57 -0400
Date: Thu, 13 May 2004 17:30:56 +0200
From: rutger@nospam.com
To: clemens kurtenbach <moqua@kurtenba.ch>
Cc: linux-kernel@vger.kernel.org
Subject: Re: cpufreq and p4 prescott
Message-ID: <20040513153056.GA12267@nospam.com>
Reply-To: linux-kernel@tux.tmfweb.nl
References: <20040512171433.GA10481@dominikbrodowski.de> <40A33DA2.70708@kurtenba.ch>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="wRRV7LY7NUeQGEoC"
Content-Disposition: inline
In-Reply-To: <40A33DA2.70708@kurtenba.ch>
Organization: M38c
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 13, 2004 at 11:19:30AM +0200, clemens kurtenbach wrote:
> Hi,
> 
> >>[ck@holodeck:cpufreq] cat /proc/cpuinfo | grep Mhz
> >>cpu MHz         : 2807.131
> >>cpu MHz         : 2807.131
> >
> >The cpu MHz entry in /proc/cpuinfo is the same for all CPUs, and no 
> >reliable
> >source to detect the current cpu frequency anyway.  Use
> 
> i thought this because on my ibook i can see different MHz
> entry's when cpudyn changes the frequence.
> 
> >/sys/devices/system/cpu/cpu0/scaling_cur_freq or even cpuinfo_cur_freq for
> >that.[*] So p4-clockmod-throttling does work on your p4 prescott.
> >
> >	Dominik
> >
> >[*] Available in 2.6.7, hopefully, if Linus merges the latest cpufreq-bk
> >tree from Dave. It'll be in the next -mm release, though.
> 
> o.k, when i understand you right p4-clockmod-throttling _is working_
> on my system, but i can't see this in /sys until Dave Jones
> patches are includet. So i patched my 2.6.6 kernel with
> cpufreq-2004-05-13.diff.
> 
> Now cpuinfo_cur_freq and scaling_cur_freq show changing entry's
> when eg powernowd handles the frequence.
> 
> The reason why i want to throttle down my prescott is the heat.
> Strange is that when the frequence is changed to 350MHz
> (after 30min running with 2.8GHz), neither the CPU&System temperature
> nor tools that calculate the CPU speed (like gkrellm-x86info)
> show a difference to 2.8GHz. All voltages on my system are the
> same with 350MHz/2.8GHz, too.
> 
> So i'm not sure if throttling does work until now?

No, I think something is broken. There is something wrong, but I do
not know what exactly. Maybe other people can help.

Problem #1 is the speed measurement, as you described. As far as I
understand, p4-clockmod delivers the same external clock to the P4,
but work is not done during every clock tick. E.g. when running at
12.5% of the maximum frequency, only one tick in eight something is
done.

The program attached (cpufreq.c) shows the external clock.

Which gives before clock modulation:
Current CPU speed: 2804Mhz
Which is the same as after clock modulation.

Ok, so if it is true that only the work is done part of the ticks,
then all instructions should take more ticks! Therefore, I try to
measure the number of ticks which the 'rdtsc' instruction itself
takes. I take the minimum of 10 runs, to run
instruction-cache-hot. See cpuclockmod.c .

This gives '140' cycles in the pre-modulated phase (including some
overhead) when running on an idle system, and 154 or 161 running on a
loaded system (1 thread busy looping). If clock modulation meant
'skipping ticks', I would expect this number to multiply.

For this at, I measure the amount of work we can do in 0.1second, not
measured in clockticks but in actual work (in this case:
counting). See attachement idlespeed.c .

This gives something like
$ ./idlespeed 
 16721212 17663088 17753061 17735590 17722159 17711258 17736497
 17738416 17285056 16777378 16811129 17754396 17489097 16838288
 16771207 16522451 17607507 17741537 17696223 17711259 17727780
 16207944 17753235 ...

So quite constant.

Ok, now enabling p4-clockmod:

# modprobe p4-clockmod
# cd /sys/devices/system/cpu
# ls -l cpu0/cpufreq/scaling_governor
-rw-r--r--  1 root root 4096 May 13 16:28 scaling_governor
# echo powersave > cpu0/cpufreq/scaling_governor
# ls -l cpu0/cpufreq/scaling_governor
-rw-r--r--  1 root root 0 May 13 16:28 cpu0/cpufreq/scaling_governor

??? Something changed the size of the virtual file. Strange.

idlespeed has been downscaled by a factor 8 (to be expected) now half
of the time:

$ idlespeed
  2335688 2271157 2251869 2365142 2263489 2325059 2279944 2352220
  2409125 2333738 2743530 2282674 2319563 2482246 2293931 2393624
  ....

..but re-running this several times, yields sometimes (50%) different
results!

$ idlespeed
 17419738 17726984 17560937 17575017 17731884 17745776 17640391
 17669128 17576263 17734663 17711101 17741851 17721642 17748703
 ...
 17581598 17680249

This can also be seen by doing ^S/^Q several times; sometimes it
switches. gkrellm indicates that switching is dependant on which
_virtual_ CPU it runs! Virtual CPU0, the hyper-threaded sibling of
CPU1, has been downscaled, but CPU1 has not!

Now it gets even more weird when running 2 idlespeed's simultanously:
the speed is now about 11671640 on both! And ^Sing one of them, lets
the other jump to 2.3M or 17M depending on the virtual processor it
runs on.

Ok, we throttle the other virtual CPU also:

# echo powersave > cpu1/cpufreq/scaling_governor

This doesn't change a thing, which is to be expected since cpufreq
talks to real CPUs. However, Virtual CPU0 maintains to be the slow
CPU, and Virtual CPU1 is the fast one.

Now the frequency hasn't changed: cpufreq still gives 2804Mhz. But the
number of ticks per instruction have also not changed: still about 160
ticks for doing a rtdc()! What's wrong with my reasoning? What is
happening under the hood?

Playing a little more with cpu0 and cpu1, I sometimes can get to a
state where both virtual cpu's are slowed down, but I cannot reproduce
it 100%. And it's quite difficult to get them both back on full-speed
again.

[used kernel: 2.6.6-bk Wed May 12 22:29:41 with SMT scheduler enabled;
preempt enabled; 2.8Ghz Prescott Pentium 4 chip]

Regards,
Rutger.

-- 
Rutger Nijlunsing ---------------------------- rutger ed tux tmfweb nl
never attribute to a conspiracy which can be explained by incompetence
----------------------------------------------------------------------
--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="cpufreq.c"

/* Measure CPU speed in ticks per second */

#include <stdio.h>
#include <unistd.h>

unsigned long long rdtsc (void) {
  unsigned long long returned;
  asm volatile (" rdtsc " : "=A" (returned));
  return returned;
}

int main(void) {
  unsigned long long prevtime = rdtsc();
  sleep(1);
  unsigned long long newtime = rdtsc();
  printf("Current CPU speed: %.0fMhz\n", (newtime - prevtime) / 1000000.0);
  return 0;
}

--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="cpuclockmod.c"

/* Measure the number of clock ticks it takes to measure the number of
   clock ticks */

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

unsigned long long rdtsc (void) {
  unsigned long long returned;
  asm volatile (" rdtsc " : "=A" (returned));
  return returned;
}

int main(void) {
  while (1) {
    int j;
    int minimum = (1 << 30);
    for (j = 0; j < 10; j++) {
      unsigned long long elapsed = -rdtsc();
      elapsed += rdtsc();
      minimum = (elapsed < minimum) ? elapsed : minimum;
    }
    printf("%i\n", minimum);
    usleep(100000); /* 10Hz */
  }
  return 0;
}

--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="idlespeed.c"

/* Count the number of busy loops we can do in 0.1sec. */

#include <signal.h>
#include <stdio.h>
#include <sys/time.h>
#include <sys/types.h>
#include <unistd.h>

int interrupt = 0;

void handler(int signal) {
  interrupt = 1;
}

int main(void) {
  if (fork() != 0) {
    signal(SIGALRM, handler);
    while(1) {
      long long counter = 0;
      interrupt = 0;
      while (!interrupt) counter++;
      printf("%9llu ", counter);
      fflush(stdout);
    }
  } else {
    int pid = getppid();
    while (1) {
      usleep(100000); /* Wake up parent at 10Hz */
      kill(pid, SIGALRM);
    }
  }
}

--wRRV7LY7NUeQGEoC--
