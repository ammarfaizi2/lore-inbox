Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261371AbVFUMtv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261371AbVFUMtv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 08:49:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261325AbVFUMmu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 08:42:50 -0400
Received: from pilet.ens-lyon.fr ([140.77.167.16]:19592 "EHLO
	relaissmtp.ens-lyon.fr") by vger.kernel.org with ESMTP
	id S261444AbVFUMkY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 08:40:24 -0400
Message-ID: <42B80AB5.7090506@ens-lyon.org>
Date: Tue, 21 Jun 2005 14:40:21 +0200
From: Brice Goglin <Brice.Goglin@ens-lyon.org>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-mm1
References: <20050619233029.45dd66b8.akpm@osdl.org> <42B6777F.2050008@ens-lyon.org>
In-Reply-To: <42B6777F.2050008@ens-lyon.org>
X-Enigmail-Version: 0.91.0.0
Content-Type: multipart/mixed;
 boundary="------------020200000701000706060203"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020200000701000706060203
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit

Brice Goglin a écrit :
> Hi Andrew,
> 
> I got this oops during boot.
> I copied it by hand since my machine crashed soon after (because of yenta).
> It doesn't occur when snd_maestro3 is skipped by discover.
> 
> divide error: 0000 [#1]
> PREEMPT
> ...
> CPU: 0
> EIP: 0060:[<e8957f9f>] Not tainted VLI
> EFLAGS: 00000282 (2.6.12-mm1=LoulousMobiles)
> EIP is at and_m3_enable_ints+0x1f/0x40 [snd_maestro3]
> eax: 00000050 ebx: 00002400 ecx: 00000050 edx: 00002418
> esi: 00002418 edi: 00000000 ebp: 000000f0 esp: e6f5ce54
> ds: 007b es: 007b ss: 0068
> Process modprobe (pid: 2405, threadinfo=e6f5c000, task=e7a31570)
> ...
> Call trace:
>  snd_m3_create+0x303/0x405 [snd_maestro3]

The problem comes from git-alsa.patch.
Adding HV_INT_ENABLE to outw in snd_m3_enable_ints (in
sound/pci/maestro3.c) makes it generate a divide error
on my laptop.

The attached patch reverts this and fixes my problem.

Signed-off-by: Brice Goglin <Brice.Goglin@ens-lyon.org>

Brice

--------------020200000701000706060203
Content-Type: text/x-patch;
 name="fix-maestro3-outw.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fix-maestro3-outw.patch"

--- linux-mm/sound/pci/maestro3.c.old	2005-06-21 14:36:19.000000000 +0200
+++ linux-mm/sound/pci/maestro3.c	2005-06-21 14:36:31.000000000 +0200
@@ -2527,7 +2527,7 @@ snd_m3_enable_ints(m3_t *chip)
 	unsigned long io = chip->iobase;
 
 	/* TODO: MPU401 not supported yet */
-	outw(ASSP_INT_ENABLE | HV_INT_ENABLE /*| MPU401_INT_ENABLE*/, io + HOST_INT_CTRL);
+	outw(ASSP_INT_ENABLE /*| MPU401_INT_ENABLE*/, io + HOST_INT_CTRL);
 	outb(inb(io + ASSP_CONTROL_C) | ASSP_HOST_INT_ENABLE,
 	     io + ASSP_CONTROL_C);
 }

--------------020200000701000706060203--
