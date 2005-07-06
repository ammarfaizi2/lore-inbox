Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261998AbVGFBOi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261998AbVGFBOi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 21:14:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262026AbVGFBOi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 21:14:38 -0400
Received: from unused.mind.net ([69.9.134.98]:6041 "EHLO echo.lysdexia.org")
	by vger.kernel.org with ESMTP id S261998AbVGFBOV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 21:14:21 -0400
Date: Tue, 5 Jul 2005 18:13:18 -0700 (PDT)
From: William Weston <weston@sysex.net>
X-X-Sender: weston@echo.lysdexia.org
To: Carlo Scarfoglio <mi2332@mclink.it>
cc: linux-kernel@vger.kernel.org
Subject: Re: realtime-preempt-2.6.12-final-V0.7.51-01 compile error and more
 problems
In-Reply-To: <42CB1707.6000205@mclink.it>
Message-ID: <Pine.LNX.4.58.0507051701440.13700@echo.lysdexia.org>
References: <42CB1707.6000205@mclink.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Jul 2005, Carlo Scarfoglio wrote:

> Compilation stops at this point:
> 
> make[1]: `arch/i386/kernel/asm-offsets.s' is up to date.
>    CHK     include/linux/compile.h
>    CHK     usr/initramfs_list
>    CC      net/ipv4/netfilter/ip_conntrack_proto_tcp.o
> net/ipv4/netfilter/ip_conntrack_proto_tcp.c: In function 
> `tcp_print_conntrack':
> net/ipv4/netfilter/ip_conntrack_proto_tcp.c:333: error: `tcp_lock' 
> undeclared (first use in this function)
> net/ipv4/netfilter/ip_conntrack_proto_tcp.c:333: error: (Each undeclared 
> identifier is reported only once
> net/ipv4/netfilter/ip_conntrack_proto_tcp.c:333: error: for each 
> function it appears in.)
> net/ipv4/netfilter/ip_conntrack_proto_tcp.c:333: warning: type defaults 
> to `int' in declaration of `type name'
> etc. etc..
> 
> Most likely it depends on the redefinition of DECLARE_RWLOCK in lockhelp.h

Same here...

> More problems....
> 
> Patch 7.50-48 has been the first rt kernel that compiled and booted 
> cleanly on my system.

-50-43 is the most recent out of the -50 series that's compiled and
operated cleanly on my Athlon box.  So far, it appears to be rock-solid.  
I'd recommend giving it a try if you haven't already.

> I'm testing the rt kernels because I want to use jack as my system sound 
> mixer/router
> and to record lp's with my ice1712-based sound card. I have no rt 
> requrements, of course,
> but I want to get rid of xruns. Kernel 2.6.12 vanilla is quite good 
> already (a big improvement
> over previous kernels) but still ...

Audio without xruns is an RT requirement, IMHO  ;-}

> Patch 7.50-48 been running for two days now and seems pretty stable but:
> 
> 1) My logs are filled with Apic errors all like this
> 
> Jul  5 04:30:01 linux kernel: APIC error on CPU0: 02(02)
> 
> every 2 seconds, or minute, at random. I've never seen these messages 
> before with vanilla kernels,
> so it's a bit weird.

Have you tried disabling CONFIG_X86_IOAPIC_FAST?  This is new in the
realtime-preempt patches.  It's currently stable on 3 out of the 4 boxes
I'm testing RT on.  On the fourth (P4 with an SIS chipset), it didn't seem
to make any difference.  I finally had to switch from APIC to PIC (in
BIOS) to get the APIC errors on CPU0 to go away.

> 2) Whenever I play an mp3 or watch a movie (through jack) I get 
> thousands of times these errors in the logs
> 
> Jul  5 20:45:56 linux kernel: `IRQ 8'[828] is being piggy. 
> need_resched=0, cpu=0
> Jul  5 20:45:56 linux kernel: Read missed before next interrupt
> Jul  5 20:45:56 linux kernel: wow!  That was a 12 millisec bump
> Jul  5 20:45:56 linux kernel: bug in rtc_read(): called in state S_IDLE!
> Jul  5 20:45:56 linux kernel: `IRQ 8'[828] is being piggy. 
> need_resched=0, cpu=0
> Jul  5 20:45:56 linux kernel: Read missed before next interrupt
> Jul  5 20:45:56 linux kernel: wow!  That was a 3 millisec bump
> Jul  5 20:45:56 linux kernel: bug in rtc_read(): called in state S_IDLE!
> 
> This is a known issue, RTC  interrupts are missed. I have noticed it 
> many times when ntp is
> running. It stops working after a few minutes of playing when the the 
> error exceeds 500 PPM.
> But I thought that ntp compared external reference clocks to the system 
> timer, so the system
> was missing int 0, not int 8.  My mobo has a crappy timer anyway. I had 
> to reduce the tick to 9934
> in order to allow ntp to run.

Is the RTC the only thing on IRQ 8?  The last time I saw the 'IRQ 8 is 
being piggy' messages on my Athlon box was when the RTC was sharing IRQ 8 
with either the video or the USB.

> 3) I had to disable polling of the cpu temperature by kacpid because 
> whenever it did the sound
> stopped for 1-3 seconds. The polling took longer and longer after a few 
> hours of uptime.
> The nice thing is, it caused no xruns. Kernel 2.6.12 vanilla has the 
> same problem, though.
> 
> 4) Xruns occur every 10-60 minutes even when the system is practically 
> idle (no playback
> or recording). When copying large files (between sata disks on two 
> sil3112 controllers)
> xruns frequency is much higher.  When sound is used xruns occur every 2 
> or 20 minutes.

Do these xruns coincide with the RTC 'Read missed before next interrupt'
messages?

Have you tried running JACK with a larger buffer period size?  Some cards
are perfectly happy with -p64, while others need -p128 or -p256 to be xrun
free for an extended time.  In the past, I've seen a difference between
running with 2 and 3 buffer periods (-n2 or -n3).

Also, have you tried bumping up JACK's RT priority?  If JACK is running at 
a lower priority than the IRQ threads for your SATA, then disk activity 
will most likely cause additional xruns.  I've had good luck running JACK 
with '-R -P60', which sets it's realtime priority above all the IRQ 
threads.

You may also want to run the IRQ threads for your audio hardware at a 
slightly higher RT priority than the rest of the IRQ threads.

> This is a nForce2-mobo (Abit NF7-S V 2.0), Athlon 2800, 1 GB Ram, 
> Terratec DMX6Fire,
> nVidia 4200 video card, 2 sil3112 sata controllers with 3 disks,etc. 
> SuSE 9.1 with KDE 3.4 and
> uptodate jack, xmms, mplayer, sound libraries and recording apps.
> 
> If more details are needed or I can perform some tests, feel free to ask.

If you haven't tried this out yet, jack_test4.1 should be a big help for 
system tuning:

http://www.joq.us/jack/tests/jack_test4.1.tar.gz

Edit jack_test4_run.sh to change settings for JACK priority, number of 
test clients, etc.  On your system, you should be able to run with 28 or 
more clients without any xruns.


Best Regards,
--ww
