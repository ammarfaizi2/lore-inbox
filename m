Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271831AbTGRU6O (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 16:58:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271846AbTGRU6J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 16:58:09 -0400
Received: from fw.osdl.org ([65.172.181.6]:3211 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S271859AbTGRU45 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 16:56:57 -0400
Date: Fri, 18 Jul 2003 14:04:14 -0700
From: Andrew Morton <akpm@osdl.org>
To: James Bourne <jbourne@hardrock.org>
Cc: breed@users.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [BUG REPORT 2.6.0] cisco airo_cs scheduling while atomic
Message-Id: <20030718140414.371cdb55.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.44.0307180656090.19070-100000@cafe.hardrock.org>
References: <Pine.LNX.4.44.0307180656090.19070-100000@cafe.hardrock.org>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bourne <jbourne@hardrock.org> wrote:
>
> The Cisco Airo card driver calls schedule while atomic in the function
> issuecommand in drivers/net/wireless/airo.c line 2388.
> 
> 
> Jul 17 15:27:10 localhost kernel: bad: scheduling while atomic!
> Jul 17 15:27:10 localhost kernel: Call Trace:
> Jul 17 15:27:10 localhost kernel:  [<c0119754>] schedule+0x3c4/0x3d0
> Jul 17 15:27:10 localhost kernel:  [<d18cbb51>] sendcommand+0xa1/0xe0 [airo]
> Jul 17 15:27:10 localhost kernel:  [<d18cba80>] issuecommand+0x60/0x90 [airo]
> Jul 17 15:27:10 localhost kernel:  [<d18cc001>] PC4500_accessrid+0x41/0x80 [airo]
> Jul 17 15:27:10 localhost kernel:  [<d18cc0a3>] PC4500_readrid+0x63/0x130 [airo]
> Jul 17 15:27:10 localhost kernel:  [<d18c95d9>] readStatsRid+0x29/0x50 [airo]
> Jul 17 15:27:10 localhost kernel:  [<d18c9c0a>] airo_get_stats+0x2a/0xe0 [airo]

I've been waiting months for someone to test this patch.  Can you please do
so?


diff -puN drivers/net/wireless/airo.c~airo-schedule-fix drivers/net/wireless/airo.c
--- 25/drivers/net/wireless/airo.c~airo-schedule-fix	2003-06-26 17:37:47.000000000 -0700
+++ 25-akpm/drivers/net/wireless/airo.c	2003-06-26 17:37:47.000000000 -0700
@@ -44,6 +44,7 @@
 #include <linux/ioport.h>
 #include <linux/config.h>
 #include <linux/pci.h>
+#include <linux/delay.h>
 #include <asm/uaccess.h>
 
 #ifdef CONFIG_PCI
@@ -2379,20 +2380,26 @@ static u16 setup_card(struct airo_info *
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

