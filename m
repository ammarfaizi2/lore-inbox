Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932721AbVHPVPQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932721AbVHPVPQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 17:15:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932722AbVHPVPQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 17:15:16 -0400
Received: from rproxy.gmail.com ([64.233.170.206]:33834 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932721AbVHPVPO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 17:15:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XSLzz6sZqtC+OvULugi1YFvUjXAHWxXoLS4XjVtt0tFXLuDUwWPjo73UNSQfJJks9v+3ClVIrPceHMRh9xiJm8lGW7RlEekKv7SIKQ+LJV7TwzhNCi0qGvTe0rfwEZUnU/Un6ZpM9aBJeHArRTsuY95rmLvhOPAZ9mngqIfr6tU=
Message-ID: <5a2cf1f605081614152c41d5ac@mail.gmail.com>
Date: Tue, 16 Aug 2005 23:15:14 +0200
From: jerome lacoste <jerome.lacoste@gmail.com>
To: Christoph Lameter <clameter@engr.sgi.com>
Subject: Re: 2.6.12.3 clock drifting twice too fast (amd64)
Cc: lkml <linux-kernel@vger.kernel.org>,
       Marie-Helene Lacoste <manies@tele2.fr>
In-Reply-To: <Pine.LNX.4.62.0508161103360.7101@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <5a2cf1f6050816031011590972@mail.gmail.com>
	 <Pine.LNX.4.62.0508161103360.7101@schroedinger.engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/16/05, Christoph Lameter <clameter@engr.sgi.com> wrote:
> On Tue, 16 Aug 2005, jerome lacoste wrote:
> 
> > Installed stock 2.6.12.3 on a brand new amd64 box with an Asus extreme
> > AX 300 SE/t mainboard.

Ooops the main board is a Sapphire Axion XP200PA-A58SL. The
aforementionned name is the video card's one...

> > I remember seeing a message in the boot saying something along:
> >
> >   "cannot connect to hardware clock."
> >
> > And now I see that the time is changing too fast (about 2 seconds each second).
> 
> The timer interrupt is probably called twice for some reason and therefore
> time runs twice as fast. Try using HPET for interrupt timing.

Sorry to sound stupid but how do you use HPET?

My latest kernel config has:

> grep HPET /usr/src/linux-2.6.12.3/.config
CONFIG_HPET_TIMER=y
CONFIG_HPET=y
# CONFIG_HPET_RTC_IRQ is not set
CONFIG_HPET_MMAP=y

So it should be enabled, right?

The kernel config doc talks about a 'miscdevice' named /dev/hpec/

I have this
root@manies:/usr/src/linux-2.6.12.3 # ls -la /dev/hpet 
crw-rw----  1 root root 10, 228 Aug 16 15:17 /dev/hpet

I didn't find /usr/src/linux-2.6.12.3/Documentation/hpet.txt very
explicit on what to do. I managed to compile the example code after
tweeking it

--- hpet.c.orig 2005-08-16 23:30:58.000000000 +0200
+++ hpet.c      2005-08-17 00:01:43.000000000 +0200
@@ -1,3 +1,6 @@
+/**
+ * Compile with  gcc -s -I/usr/src/linux-`uname -r`/include -Wall
-Wstrict-prototypes hpet.c -o hpet
+ */
 #include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>
@@ -13,6 +16,8 @@
 #include <fcntl.h>
 #include <errno.h>
 #include <sys/time.h>
+typedef u_int32_t u32;
+typedef u_int64_t u64;
 #include <linux/hpet.h>
 
 
But as I don't know which device_name to specify (I tried /dev/hpet
and /dev/rtc), I am kinda stuck.


I've also tried rtctest.c (from the rtc. documentation). When run, it
ends by displaying:
Typing "cat /proc/interrupts" will show 131 more events on IRQ 8.
But it only add 117 interrupts for me.
And when ran, this test program correctly counts the seconds. I.e.
time is not too fast.

I also see that the reported RTC time really differs from the time
returned by the date command. I am a little bit confused.

E.g. 

with rtctestnew a modified version of rtctest.c that: displays current
rtc time, register an alarm for 5 secs, waits for the event, and
redisplays for the new rtc time.

> date; ./rtctestnew ; date
Tue Aug 16 22:49:18 CEST 2005
Current RTC date/time is 17-8-2005, 03:03:20.
Alarm time now set to 03:03:25.
Waiting 5 seconds for alarm... okay. Alarm rang.
Current RTC date/time is 17-8-2005, 03:03:25.
                         *** Test complete ***
Tue Aug 16 22:49:28 CEST 2005

rtc time is now 7 hours more than current time. rtc time updates
correctly (+5 seconds) while date is increased 10 seconds. timezone is
correct.

Any idea?

> > I don't have visual on the boot sequence anymore (only remote access).
> 
> Use serial console or netconsole. The boot information is logged. Try
> dmesg.

serial will be hard. The machine is 2500 km away with a non geek in front of it.

Can I use netconsole over ppp ?

Jerome
