Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751368AbWBPCwb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751368AbWBPCwb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 21:52:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751369AbWBPCwb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 21:52:31 -0500
Received: from smtp.osdl.org ([65.172.181.4]:51340 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751368AbWBPCwb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 21:52:31 -0500
Date: Wed, 15 Feb 2006 18:51:20 -0800
From: Andrew Morton <akpm@osdl.org>
To: Charles-Edouard Ruault <ce@ruault.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] kernel 2.6.15.4: soft lockup detected on CPU#0!
Message-Id: <20060215185120.6c35eca2.akpm@osdl.org>
In-Reply-To: <43EF8388.10202@ruault.com>
References: <43EF8388.10202@ruault.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Charles-Edouard Ruault <ce@ruault.com> wrote:
>
> i was trying to rip a CD when the whole machine started to freeze
>  periodicaly, i then looked at the logs and found the following :
> 
>  Feb 12 19:23:39 ruault kernel: hdc: irq timeout: status=0x80 { Busy }
>  Feb 12 19:23:39 ruault kernel: ide: failed opcode was: unknown
>  Feb 12 19:23:39 ruault kernel: hdd: status timeout: status=0x80 { Busy }
>  Feb 12 19:23:39 ruault kernel: ide: failed opcode was: unknown
>  Feb 12 19:23:39 ruault kernel: hdd: drive not ready for command

No idea what caused that.

>  Feb 12 19:23:39 ruault kernel: BUG: soft lockup detected on CPU#0!

The following was merged today.  Hopefully it suppresses this false
positive.

--- devel/drivers/ide/ide-taskfile.c~ide-touch-softlockup-detector-during-pio	2006-02-15 14:57:05.000000000 -0800
+++ devel-akpm/drivers/ide/ide-taskfile.c	2006-02-15 14:57:05.000000000 -0800
@@ -34,6 +34,7 @@
 #include <linux/kernel.h>
 #include <linux/timer.h>
 #include <linux/mm.h>
+#include <linux/sched.h>
 #include <linux/interrupt.h>
 #include <linux/major.h>
 #include <linux/errno.h>
@@ -314,6 +315,8 @@ static void ide_pio_datablock(ide_drive_
 	if (rq->bio)	/* fs request */
 		rq->errors = 0;
 
+	touch_softlockup_watchdog();
+
 	switch (drive->hwif->data_phase) {
 	case TASKFILE_MULTI_IN:
 	case TASKFILE_MULTI_OUT:
_

