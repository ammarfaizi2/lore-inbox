Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288979AbSA0Wuk>; Sun, 27 Jan 2002 17:50:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288992AbSA0Wua>; Sun, 27 Jan 2002 17:50:30 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:27922 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S288979AbSA0WuU>; Sun, 27 Jan 2002 17:50:20 -0500
Message-ID: <3C548269.E05CA8C1@zip.com.au>
Date: Sun, 27 Jan 2002 14:42:49 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Vincent Sweeney <v.sweeney@barrysworld.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: high system usage / poor SMP network performance
In-Reply-To: <004701c1a781$387d2570$0201010a@frodo>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vincent Sweeney wrote:
> 
> Naturally I would really like to know where / what is using up all this
> system cpu so I would like to try profiling the kernel as I'm sure this is a
> pure kernel network layer performance issue but I have no idea where to
> start so does anyone have some advice / tips on where I should start?

Yes, profiling the kernel is clearly the next step.  And it's
really easy.

1: If possible, rebuild your kernel with as few modules as possible.
   Current profiler doesn't cope with code which is in modules.

2: If you're on uniprocessor, enable the "Local APIC support on
   Uniprocessors" option.  This allows higher-resolution profiling.

3: Arrange for the kernel to be provided the `profile=1' boot
   option.  I use

	append="profile=1"

   in /etc/lilo.conf

   After a reboot, the kernel is profiling itself.  The overhead is
   really low.

4: Bring the server online and wait until it starts to play up.

Now we can profile it.  I use this script:

mnm:/home/akpm> cat $(which akpm-prof)
#!/bin/sh
TIMEFILE=/tmp/$(basename $1).time
sudo readprofile -r
sudo readprofile -M10
time "$@"
readprofile -v -m /boot/System.map | sort -n +2 | tail -40 | tee $TIMEFILE
echo created $TIMEFILE

Let's go through it:

	readprofile -r

		This clears out the kernel's current profiling info

	readprofile -M10

		This attempts to set the profiling interval to 10*HZ
		(1000 Hz).  This requires a local APIC, and a recent
		util-linux package.  Not very important if this fails.
		This command also cleans out the kernel's current
		profiling info (it's a superset of -r).

	time "$@"

		Runs the command which we wish to profile

	readprofile ...

		Emits the profile info, sorted in useful order.
		You must make sure that /boot/System.map is the
		correct one for the currently-running kernel!

So in your situation, the command which you want to profile isn't
important - you want to profile kernel activity arising from
*existing* processes.  So you can use:

	akpm-prof sleep 30

Please send the results!

-
