Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262426AbTDQUDl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 16:03:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262239AbTDQUDl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 16:03:41 -0400
Received: from [12.47.58.203] ([12.47.58.203]:58318 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S262426AbTDQUDk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 16:03:40 -0400
Date: Thu, 17 Apr 2003 13:16:09 -0700
From: Andrew Morton <akpm@digeo.com>
To: farshad_kh@yahoo.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: softirq.c bug
Message-Id: <20030417131609.087069f2.akpm@digeo.com>
In-Reply-To: <200304171823.00338.farshad_kh@yahoo.com>
References: <200304171823.00338.farshad_kh@yahoo.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 Apr 2003 20:15:31.0086 (UTC) FILETIME=[184552E0:01C3051E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

farshad khoshkhui <farshad_kh@yahoo.com> wrote:
>
> I'm using 2.5.67, on a duron 1200 box , my keyboard lock up when a ppp 
> connection goes down and also
> pppd process won't die and kill, and the box don't event shutdown!

I submitted the below (sad) patch yesterday:



This BUG_ON is triggering via ppp's line discipline flushing, due to
brokenness in tty_io.c.

We need to fix tty.  Meanwhile, let's not gratuitously nuke people's boxes.



 25-akpm/kernel/softirq.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN kernel/softirq.c~local_bh_enable-niceness kernel/softirq.c
--- 25/kernel/softirq.c~local_bh_enable-niceness	Wed Apr 16 13:51:42 2003
+++ 25-akpm/kernel/softirq.c	Wed Apr 16 13:51:47 2003
@@ -102,7 +102,7 @@ restart:
 void local_bh_enable(void)
 {
 	__local_bh_enable();
-	BUG_ON(irqs_disabled());
+	WARN_ON(irqs_disabled());
 	if (unlikely(!in_interrupt() &&
 		     local_softirq_pending()))
 		invoke_softirq();



> I also found that my ethernet (rtl8139 NIC) don't work while CONFIG_ACPI=y
> it's response to other stations arp requests but don't add others to arp table

Please log this in http://bugzilla.kernel.org

