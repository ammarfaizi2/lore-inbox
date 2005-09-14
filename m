Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965046AbVINIMi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965046AbVINIMi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 04:12:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965077AbVINIMi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 04:12:38 -0400
Received: from s1.mailresponder.info ([193.24.237.10]:7438 "EHLO
	s1.mailresponder.info") by vger.kernel.org with ESMTP
	id S965046AbVINIMh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 04:12:37 -0400
Subject: 2.6.13 brings buffer underruns when recording DVDs in 16x (was Re:
	"Read my lips: no more merges" - aka Linux 2.6.14-rc1)
From: Mathieu Fluhr <mfluhr@nero.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0509131210090.3351@g5.osdl.org>
References: <Pine.LNX.4.58.0509122019560.3351@g5.osdl.org>
	 <1126608030.3455.23.camel@localhost.localdomain>
	 <1126630878.2066.6.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0509131010010.3351@g5.osdl.org>
	 <1126635160.2183.6.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0509131210090.3351@g5.osdl.org>
Content-Type: multipart/mixed; boundary="=-GPk5Hq5SAAyWsB/0cCOD"
Organization: Nero AG
Date: Wed, 14 Sep 2005 10:11:19 +0200
Message-Id: <1126685479.2010.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-GPk5Hq5SAAyWsB/0cCOD
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2005-09-13 at 12:11 -0700, Linus Torvalds wrote:
> 
> On Tue, 13 Sep 2005, Mathieu Fluhr wrote:
> > 
> > Okay, here is the point: I will have these bloody buffer underruns
> > unless I select a 'Timer frequency' of 1000 Hz in 'Processor type and
> > features' section of the kernel configuration. That's quite
> > understandable, as recording a DVD at 16x requires a throughput of 22160
> > KB/s, which is quite fast.
> > 
> > I will have a deep look in the patch, and maybe write a patched patch
> > (Ooooo my god what am I writing ?) in the next few days.
> 
> It may just be an application bug too. Too small a buffer, and depending 
> on 2.6.x with a 1kHz timer having timers that run faster...
> 

According to the MMC documentation, you can thoeriticaly send at most
65535 (16 bits int) blocks in one WRITE(10) CDB. This would means
sending a buffer of ~127 MB on case of writing a mode 1 data track (2048
bytes per block)...

Now, practically, it is really not safe to send more than 64 KB per CDB
(Mostly device related). And with such values, you have the following:
 - at 100 Hz  -> 64 KB * 100  = 6400 KB/s  <=> ~4.62x  DVD 
 - at 250 Hz  -> 64 KB * 250  = 16000 KB/s <=> ~11.55x DVD 
 - at 1000 Hz -> 64 KB * 1000 = 64000 KB/s <=> ~46.20x DVD

I would suggest to leave to default value of the timer frequency to 1000
Hz and to add some more comment in the Kconfig.hz file. (Patch attached)

Mathieu

> 		Linus
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--=-GPk5Hq5SAAyWsB/0cCOD
Content-Disposition: attachment; filename=TimerFrequency.patch
Content-Type: text/x-patch; name=TimerFrequency.patch; charset=us-ascii
Content-Transfer-Encoding: 7bit

--- linux-2.6.13.1.clean/kernel/Kconfig.hz	2005-09-10 04:42:58.000000000 +0200
+++ linux-2.6.13.1/kernel/Kconfig.hz	2005-09-13 20:32:35.000000000 +0200
@@ -4,7 +4,7 @@
 
 choice
 	prompt "Timer frequency"
-	default HZ_250
+	default HZ_1000
 	help
 	 Allows the configuration of the timer frequency. It is customary
 	 to have the timer interrupt run at 1000 HZ but 100 HZ may be more
@@ -35,6 +35,8 @@
 	help
 	 1000 HZ is the preferred choice for desktop systems and other
 	 systems requiring fast interactive responses to events.
+	 1000 HZ is also required if you want to use large throughput on your
+	 burning devices, like when burning a DVD at 16x.
 
 endchoice
 

--=-GPk5Hq5SAAyWsB/0cCOD--

