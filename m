Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261173AbUJ3Rgg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261173AbUJ3Rgg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 13:36:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261219AbUJ3Rgg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 13:36:36 -0400
Received: from mail.gmx.de ([213.165.64.20]:39346 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261173AbUJ3RgX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 13:36:23 -0400
X-Authenticated: #4399952
Date: Sat, 30 Oct 2004 19:53:15 +0200
From: Florian Schmidt <mista.tapas@gmx.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: Paul Davis <paul@linuxaudiosystems.com>,
       Thomas Gleixner <tglx@linutronix.de>,
       LKML <linux-kernel@vger.kernel.org>, Lee Revell <rlrevell@joe-job.com>,
       mark_h_johnson@raytheon.com, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       jackit-devel <jackit-devel@lists.sourceforge.net>,
       Rui Nuno Capela <rncbc@rncbc.org>
Subject: Re: [Fwd: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.4]
Message-ID: <20041030195315.37bed27f@mango.fruits.de>
In-Reply-To: <20041030131507.GA5189@elte.hu>
References: <20041029170948.GA13727@elte.hu>
	<20041029193303.7d3990b4@mango.fruits.de>
	<20041029172151.GB16276@elte.hu>
	<20041029172243.GA19630@elte.hu>
	<20041029203619.37b54cba@mango.fruits.de>
	<20041029204220.GA6727@elte.hu>
	<20041029233117.6d29c383@mango.fruits.de>
	<20041029212545.GA13199@elte.hu>
	<20041030003122.03bcf01b@mango.fruits.de>
	<20041030005058.136fe94f@mango.fruits.de>
	<20041030131507.GA5189@elte.hu>
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Sat__30_Oct_2004_19_53_15_+0200_KvBBvrB6xcMv4AUb"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart=_Sat__30_Oct_2004_19_53_15_+0200_KvBBvrB6xcMv4AUb
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 30 Oct 2004 15:15:07 +0200
Ingo Molnar <mingo@elte.hu> wrote:

> should have mentioned that in the user-triggered modus you have to do
> the latency measurement in userspace. It is only the trace that is
> correct, for the time being. This trace shows what i'd expect a jackd
> wakeup to look like normally: 13 usecs.
> 
> 	Ingo
> 

Hi,

i thought, why not try to get jack out of the equation first and use a
different irq source. So i wrote a small test app for /dev/rtc to see if i
see the same erratic behaviour [.cc source file atached. find a small
tarball here: http://affenbande.org/~tapas/wakeup.tgz (it has a simple
makefile, plus a script which does the chrt thing to make it SCHED_FIFO)].

This program takes two parameters: the desired freq of the rtc and the
number of irq's to be measured.

Then it polls on the fd of /dev/rtc and takes a cpu cycle count timestamp as
soon as poll returns. At the end of the program i tried to gather some
[useful ???] statistics of the data: 

- the mean difference in cycles between two wakeups

- the max difference in cycles between two wakeups (and how much this
differs from the  mean difference)

- the min difference in cycles between two wakeups (and how much this
differs from the  mean difference)

- the mean difference from the mean difference :)

And alas, wiggling windows screws up the timing on V0.5.6 for this, too.

dunno, if this is any useful to you, but i felt the urge to try it :)

	flo


P.S.: don't forget to make your rtc irq SCHED_FIFO with a high priority, too

here's a sample output with window wiggling in X (rt_wakeup runs chrt -f 90
wakeup, so make rtc at least prio 91):

~/source/my_projects/wakeup$ ./rt_wakeup 1024 6000
freq: 1024 #: 6000
setting up /dev/rtc...
locking memory...
turning irq on, beginning measurement (might take a while)...
...measurement done

mean cycle difference betweem two wakeups: 1.17845e+06 cycles

min. cycle difference betweem two wakeups: 185992 cycles (#: 1563) 
 diff from mean diff: 992461

max. cycle difference betweem two wakeups: 9.73166e+06 cycles (#: 1546) 
 diff from mean diff: 8.5532e+06
                      ^this is bad i suppose :)

mean difference from mean difference: 25279.2 cycles


here's one on a rather idle system:

~/source/my_projects/wakeup$ ./rt_wakeup 1024 6000
freq: 1024 #: 6000
setting up /dev/rtc...
locking memory...
turning irq on, beginning measurement (might take a while)...
...measurement done

mean cycle difference betweem two wakeups: 1.16697e+06 cycles

min. cycle difference betweem two wakeups: 1.1486e+06 cycles (#: 5492) 
 diff from mean diff: 18379.2

max. cycle difference betweem two wakeups: 1.18439e+06 cycles (#: 5491) 
 diff from mean diff: 17417.8

mean difference from mean difference: 1144.82 cycles
~/source/my_projects/wakeup$ 

--Multipart=_Sat__30_Oct_2004_19_53_15_+0200_KvBBvrB6xcMv4AUb
Content-Type: text/x-c++src;
 name="wakeup.cc"
Content-Disposition: attachment;
 filename="wakeup.cc"
Content-Transfer-Encoding: 7bit

#include <iostream>
#include <sstream>
#include <string>

#include <linux/rtc.h>
#include <sys/ioctl.h>
#include <sys/time.h>
#include <sys/types.h>
#include <sys/mman.h>
#include <fcntl.h>
#include <errno.h>
#include <unistd.h>
#include <poll.h>

#include <cmath>

// this program is partly ripped off the rtc docs in the linux kernel source tree

// the cycle count count ripped from jackd
typedef unsigned long long cycles_t;

extern cycles_t cacheflush_time;

#define rdtscll(val) \
     __asm__ __volatile__("rdtsc" : "=A" (val))

static inline cycles_t get_cycles (void)
{
	unsigned long long ret;

	rdtscll(ret);
	return ret;
}



int main(int argc, char *argv[]) {
  if (argc < 3) {
    std::cout << "usage: wakeup [freqency(hz)] [number of interrupts]" << std::endl;
  }
  
  std::stringstream args;
  args << argv[1] << " " << argv[2];
  
  int freq;
  args >> freq;

  int number;
  args >> number;

  std::cout << "freq: " << freq << " #: " << number << std::endl;

  if (number < 3) {
    std::cout << "number of irq's must be >= 3" << std::endl;
    return(0);
  }

  // an array to store the cycles for each interrupt in.
  cycles_t *cycles = new cycles_t[number];

  std::cout << "setting up /dev/rtc..." << std::endl;

  int fd;
  fd = open("/dev/rtc", O_RDONLY);
  if (fd ==  -1) {
    perror("/dev/rtc");
    exit(errno);
  }
  
  int retval = ioctl(fd, RTC_IRQP_SET, freq);
  if (retval == -1) {
    perror("ioctl");
    exit(errno);
  }

  
  // we poll only on a single descriptor, the /dev/rtc one
  struct pollfd fds[1];
  pollfd pfd;
  pfd.fd = fd;
  pfd.events = POLLRDNORM|POLLRDBAND;
  fds[0] = pfd;


  // we set the timeout to 8 periods
  int timeout;
  timeout = 8*( (int)( (1.0f/(float)freq)*1000.0f ) );

  std::cout << "locking memory..." << std::endl;
  mlockall(MCL_CURRENT);
  // std::cout << "sleeping 1 sec" << std::endl;
  // sleep(1);

  std::cout << "turning irq on, beginning measurement (might take a while)..." << std::endl;
  
  retval = ioctl(fd, RTC_PIE_ON, 0);
  if (retval == -1) {
    perror("ioctl");
    exit(errno);
  }
  
  unsigned long data;
  for (int i = 0; i < number; ++i) {
    // first we poll, until data is available
    retval = poll(fds, 1, timeout);
    if (retval == -1) {
      perror("poll");
      exit(errno);
    }

    // then we take a timestamp;
    cycles[i] = get_cycles();
    // std::cout << "irq!" << std::endl;
    
    // then we read it
    retval = read(fd, &data, sizeof(unsigned long));
    if (retval == -1) {
      perror("read");
      exit(errno);
    }

    // see if the high bytes of the data contains a number of irq > 1. probably wrong,
    data = (data >> 16);
    if (data > 1) {std::cout << "more than 1 irq happened inbetween this and last wakeup" << std::endl;}
  }

  
  std::cout << "...measurement done" << std::endl;

  // first one is often skewed
  double mean_diff = ((double)cycles[number-1] - (double)cycles[1])/(double)(number-2);

  // std::cout << "0: \t" << cycles[0] << std::endl;
  double min_diff, max_diff;
  min_diff = max_diff = (double)(cycles[2] - cycles[1]);

  unsigned int min_diff_i, max_diff_i;
  min_diff_i = max_diff_i = 2;
  
  double mean_diff_diff = 0;

  for (int i = 2; i < number; ++i) {
    double diff = (double)(cycles[i] - cycles[i-1]);
    if (diff < min_diff) {min_diff = diff; min_diff_i = i;}
    if (diff > max_diff) {max_diff = diff; max_diff_i = i;}

    mean_diff_diff += fabs(mean_diff - diff);
    // std::cout << i << ": \t" << cycles[i] << std::endl;
  }
  mean_diff_diff /= (double)(number - 2);
  
  std::cout << std::endl << "mean cycle difference betweem two wakeups: " 
	    << mean_diff 
	    << " cycles" <<  std::endl << std::endl;

  std::cout << "min. cycle difference betweem two wakeups: " 
	    << min_diff << " cycles (#: " << min_diff_i << ") \n diff from mean diff: " 
	    << fabs(min_diff - mean_diff) << std::endl << std::endl;

  std::cout << "max. cycle difference betweem two wakeups: " 
	    << max_diff << " cycles (#: " << max_diff_i << ") \n diff from mean diff: " 
	    << fabs(max_diff - mean_diff) << std::endl << std::endl;
  
  std::cout << "mean difference from mean difference: " 
	    << mean_diff_diff << " cycles" << std::endl;
  
  // return success
  close(fd);
  return 1;
}

--Multipart=_Sat__30_Oct_2004_19_53_15_+0200_KvBBvrB6xcMv4AUb--
