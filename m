Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262912AbTDVDAw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 23:00:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262914AbTDVDAw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 23:00:52 -0400
Received: from [12.47.58.203] ([12.47.58.203]:28833 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S262912AbTDVDAt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 23:00:49 -0400
Date: Mon, 21 Apr 2003 20:13:20 -0700
From: Andrew Morton <akpm@digeo.com>
To: trelane@digitasaru.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.68 oopses
Message-Id: <20030421201320.59f28288.akpm@digeo.com>
In-Reply-To: <20030422015612.GB599@digitasaru.net>
References: <20030422015612.GB599@digitasaru.net>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Apr 2003 03:12:46.0740 (UTC) FILETIME=[0C55F540:01C3087D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joseph Pingenot <trelane@digitasaru.net> wrote:
>
> I get the following when booting 2.5.68:
> 
> Apr 21 00:41:37 paulus kernel: airo: Doing fast bap_reads
> Apr 21 00:41:37 paulus kernel: airo: MAC enabled eth1 0:7:e:b8:d6:7d
> Apr 21 00:41:37 paulus kernel: eth1: index 0x05: Vcc 5.0, Vpp 5.0, irq 4, io 0x0100-0x013f
> Apr 21 00:41:37 paulus kernel: bad: scheduling while atomic!

It's not really an oops - but it's trying hard to become one.

Could you please run with this patch for a while, and let me know
what it puts in the logs?

 drivers/net/wireless/airo.c |   13 ++++++++++---
 1 files changed, 10 insertions(+), 3 deletions(-)

diff -puN drivers/net/wireless/airo.c~airo-schedule-fix drivers/net/wireless/airo.c
--- 25/drivers/net/wireless/airo.c~airo-schedule-fix	2003-04-21 20:09:39.000000000 -0700
+++ 25-akpm/drivers/net/wireless/airo.c	2003-04-21 20:11:43.000000000 -0700
@@ -44,6 +44,7 @@
 #include <linux/ioport.h>
 #include <linux/config.h>
 #include <linux/pci.h>
+#include <linux/delay.h>
 #include <asm/uaccess.h>
 
 #ifdef CONFIG_PCI
@@ -2376,20 +2377,26 @@ static u16 setup_card(struct airo_info *
 static u16 issuecommand(struct airo_info *ai, Cmd *pCmd, Resp *pRsp) {
         // Im really paranoid about letting it run forever!
 	int max_tries = 600000;
+	static int max = 0;
+	int count = 0;
 
 	if (sendcommand(ai, pCmd) == (u16)ERROR)
 		return ERROR;
 
 	while (max_tries-- && (IN4500(ai, EVSTAT) & EV_CMD) == 0) {
-		if (!in_interrupt() && (max_tries & 255) == 0)
-			schedule();
+		udelay(1);
+		count++;
 	}
-	if ( max_tries == -1 ) {
+	if (max_tries == -1) {
 		printk( KERN_ERR
 			"airo: Max tries exceeded waiting for command\n" );
                 return ERROR;
 	}
 	completecommand(ai, pRsp);
+	if (count > max) {
+		max = count;
+		printk("%s: max delay = %d usec\n", __FUNCTION__, max);
+	}
 	return SUCCESS;
 }
 

_

