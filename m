Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261308AbUJWVEG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261308AbUJWVEG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 17:04:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261278AbUJWVEG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 17:04:06 -0400
Received: from smtp4.netcabo.pt ([212.113.174.31]:26075 "EHLO
	exch01smtp12.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S261308AbUJWVD2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 17:03:28 -0400
Message-ID: <32800.192.168.1.5.1098565193.squirrel@192.168.1.5>
In-Reply-To: <20041023135409.GB18747@elte.hu>
References: <20041020094508.GA29080@elte.hu> <20041021132717.GA29153@elte.hu>
    <20041022133551.GA6954@elte.hu> <20041022155048.GA16240@elte.hu>
    <20041022175633.GA1864@elte.hu>
    <32871.192.168.1.5.1098491242.squirrel@192.168.1.5>
    <20041023102909.GD30270@elte.hu>
    <32880.192.168.1.5.1098534617.squirrel@192.168.1.5>
    <20041023125104.GA10883@elte.hu>
    <32989.192.168.1.5.1098539101.squirrel@192.168.1.5>
    <20041023135409.GB18747@elte.hu>
Date: Sat, 23 Oct 2004 21:59:53 +0100 (WEST)
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-U10.2
From: "Rui Nuno Capela" <rncbc@rncbc.org>
To: "Ingo Molnar" <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, "Lee Revell" <rlrevell@joe-job.com>,
       mark_h_johnson@raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       "Bill Huey" <bhuey@lnxw.com>, "Adam Heath" <doogie@debian.org>,
       "Florian Schmidt" <mista.tapas@gmx.net>,
       "Thomas Gleixner" <tglx@linutronix.de>,
       "Michal Schmidt" <xschmi00@stud.feec.vutbr.cz>,
       "Fernando Pablo Lopez-Lezcano" <nando@ccrma.stanford.edu>,
       "Alexander Batyrshin" <abatyrshin@ru.mvista.com>
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: multipart/mixed;boundary="----=_20041023215953_53833"
X-Priority: 3 (Normal)
Importance: Normal
X-OriginalArrivalTime: 23 Oct 2004 21:03:25.0964 (UTC) FILETIME=[BD1824C0:01C4B943]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_20041023215953_53833
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

> Ingo Molnar
>
> Rui Nuno Capela wrote:
>
>> OK. All affirmative. NIC is natsemi.
>>
>> Here it is:
>>
>> SysRq : IRQ 1/776: BUG in write_msg at drivers/net/netconsole.c:87
>
> doh! Go to line 77 and spot the bug. (yes, the PREEMPT_REALTIME needs to
> become CONFIG_PREEMPT_REALTIME) With that fixed does it work for you?
>

OK again. And found another place where PREEMPT_REALTIME is in place of
CONFIG_PREEMPT_REALTIME, on drivers/ide/ide-taskfile.c, lines 287 and 308
(see appended diffs).

Anyway, back to my jackd -R issue. I tell you that things are really
different now: hitting SysRq+T, just about when it all gets frozen, I see
nothing on netconsole capture end, only this single line:

SysRq : Show State

and nothing more.
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org

------=_20041023215953_53833
Content-Type: text/x-diff;
      name="linux-2.6.9-mm1-RT-U10.3_netconsole-2.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
      filename="linux-2.6.9-mm1-RT-U10.3_netconsole-2.patch"

--- linux-2.6.9-mm1-RT-U10.3/drivers/net/netconsole.c.orig	2004-10-23 16:24:45.178795840 +0100
+++ linux-2.6.9-mm1-RT-U10.3/drivers/net/netconsole.c	2004-10-23 16:25:12.869586200 +0100
@@ -74,7 +74,7 @@
 		return;
 
 	local_irq_save(flags);
-#ifdef PREEMPT_REALTIME
+#ifdef CONFIG_PREEMPT_REALTIME
 	/*
 	 * A bit hairy. Netconsole uses mutexes (indirectly) and
 	 * thus must have interrupts enabled:
------=_20041023215953_53833
Content-Type: text/x-diff;
      name="linux-2.6.9-mm1-RT-U10.3_ide-taskfile-2.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
      filename="linux-2.6.9-mm1-RT-U10.3_ide-taskfile-2.patch"

--- linux-2.6.9-mm1-RT-U10.3/drivers/ide/ide-taskfile.c.orig	2004-10-23 14:13:38.000000000 +0100
+++ linux-2.6.9-mm1-RT-U10.3/drivers/ide/ide-taskfile.c	2004-10-23 16:34:10.142908240 +0100
@@ -284,7 +284,7 @@
 	u8 *buf;
 
 	page = sg[hwif->cursg].page;
-#if defined(CONFIG_HIGHMEM) && !defined(PREEMPT_REALTIME)
+#if defined(CONFIG_HIGHMEM) && !defined(CONFIG_PREEMPT_REALTIME)
 	local_irq_save(flags);
 #endif
 	buf = kmap_atomic(page, KM_BIO_SRC_IRQ) +
@@ -305,7 +305,7 @@
 		taskfile_input_data(drive, buf, SECTOR_WORDS);
 
 	kunmap_atomic(page, KM_BIO_SRC_IRQ);
-#if defined(CONFIG_HIGHMEM) && !defined(PREEMPT_REALTIME)
+#if defined(CONFIG_HIGHMEM) && !defined(CONFIG_PREEMPT_REALTIME)
 	local_irq_restore(flags);
 #endif
 }
------=_20041023215953_53833--


