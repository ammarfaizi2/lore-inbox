Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264732AbTF1X4U (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jun 2003 19:56:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265486AbTF1X4U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jun 2003 19:56:20 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:39838 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S264732AbTF1X4T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jun 2003 19:56:19 -0400
Date: Sat, 28 Jun 2003 17:10:36 -0700
From: Andrew Morton <akpm@digeo.com>
To: Valdis.Kletnieks@vt.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.73-mm2 - odd audio problem, bad intel8x0/ac97 clocking.
Message-Id: <20030628171036.4af51e08.akpm@digeo.com>
In-Reply-To: <200306282131.h5SLVjGk001833@turing-police.cc.vt.edu>
References: <200306282131.h5SLVjGk001833@turing-police.cc.vt.edu>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 29 Jun 2003 00:10:36.0346 (UTC) FILETIME=[DD6731A0:01C33DD2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:
>
> This is *not* the "clock runs really really fas"t issue - I left -mm2 running overnight and
>  in some 8 hours the system clock only drifted a few seconds versus wall clock (and it's
>  possible it was off a few seconds when it booted, as it didn't get an NTP sync at boot).
> 
>  Audio plays "too fast" - a 4 minute .ogg goes through in about 3:40, sounding a bit
>  high-pitched in the process.
> 
>  lspci -v:
>  00:1f.5 Multimedia audio controller: Intel Corp. 82801CA/CAM AC'97 Audio (rev 02)
>          Subsystem: Cirrus Logic: Unknown device 5959
>          Flags: bus master, medium devsel, latency 0, IRQ 11
>          I/O ports at d800 [size=256]
>          I/O ports at dc80 [size=64]
> 
>  relevant dmesg output:
>  Advanced Linux Sound Architecture Driver Version 0.9.4 (Mon Jun 09 12:01:18 2003 UTC).
>  request_module: failed /sbin/modprobe -- snd-card-0. error = -16
>  PCI: Setting latency timer of device 0000:00:1f.5 to 64
>  intel8x0: clocking to 51084
>  ALSA sound/pci/intel8x0.c:2520: joystick(s) found
>  ALSA device list:
>    #0: Intel 82801CA-ICH3 at 0xd800, irq 11
> 
>  The 'clocking to 51084' is *VERY* suspicious

It could be that do_gettimeofday() has gone silly.  Could you
add this patch and see what it says?


 sound/pci/intel8x0.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff -puN sound/pci/intel8x0.c~intel8x0-cleanup sound/pci/intel8x0.c
--- 25/sound/pci/intel8x0.c~intel8x0-cleanup	2003-06-28 17:07:43.000000000 -0700
+++ 25-akpm/sound/pci/intel8x0.c	2003-06-28 17:09:07.000000000 -0700
@@ -2062,10 +2062,8 @@ static void __devinit intel8x0_measure_a
 
 	t = stop_time.tv_sec - start_time.tv_sec;
 	t *= 1000000;
-	if (stop_time.tv_usec < start_time.tv_usec)
-		t -= start_time.tv_usec - stop_time.tv_usec;
-	else
-		t += stop_time.tv_usec - start_time.tv_usec;
+	t += stop_time.tv_usec - start_time.tv_usec;
+	printk(KERN_INFO "%s: measured %lu usecs\n", __FUNCTION__, t);
 	if (t == 0) {
 		snd_printk(KERN_ERR "?? calculation error..\n");
 		return;

_

