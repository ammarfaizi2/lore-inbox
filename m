Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265920AbTFSTb5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 15:31:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265927AbTFSTb4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 15:31:56 -0400
Received: from flamingo.mail.pas.earthlink.net ([207.217.120.232]:6334 "EHLO
	flamingo.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S265920AbTFSTbe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 15:31:34 -0400
Subject: Re: airo_cs load error
From: Tom Sightler <ttsig@tuxyturvy.com>
To: Matthew Koch <MatthewK@hsius.com>
Cc: svenud@ozemail.com.au, Russell King <rmk@arm.linux.org.uk>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1056025814.3074.8.camel@neutrino>
References: <1055941189.861.1.camel@localhost>
	 <1056025814.3074.8.camel@neutrino>
Content-Type: multipart/mixed; boundary="=-BL09M2RkVVBfZpOftHXg"
Organization: 
Message-Id: <1056051882.2354.3.camel@iso-8590-lx.zeusinc.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 19 Jun 2003 15:45:06 -0400
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-3.2, required 10,
	AWL, IN_REP_TO, REFERENCES, SPAM_PHRASE_00_01)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-BL09M2RkVVBfZpOftHXg
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


> Jun 19 08:22:21 neutrino cardmgr[2280]: executing: 'modprobe airo_cs'
> Jun 19 08:22:21 neutrino kernel: airo: Doing fast bap_reads
> Jun 19 08:22:21 neutrino kernel: airo: MAC enabled eth1 0:9:e8:62:c0:75
> Jun 19 08:22:21 neutrino kernel: eth1: index 0x05: Vcc 5.0, Vpp 5.0, irq
> 3, io 0x0100-0x013f
> Jun 19 08:22:21 neutrino cardmgr[2280]: executing: './network start
> eth1'
> Jun 19 08:22:21 neutrino kernel: bad: scheduling while atomic!

Could you try with this patch, it should fix the "scheduling while
atomic" error in airo.c.

It actually also includes a few other things, mostly cleanups and fixes
pulled from the CVS version of the airo.c driver for 2.4 so I don't
think it will cause you any harm.  It has worked well for me on three
fairly different cards, (a PCMCIA, a PCI card, and a Mini-PCI).

Later,
Tom


--=-BL09M2RkVVBfZpOftHXg
Content-Disposition: attachment; filename=airo.c-nosched.diff
Content-Type: text/plain; name=airo.c-nosched.diff; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- airo.c	2003-05-31 09:26:12.000000000 -0400
+++ airo.c.tom	2003-06-19 15:37:07.100811000 -0400
@@ -44,6 +44,7 @@
 #include <linux/ioport.h>
 #include <linux/config.h>
 #include <linux/pci.h>
+#include <linux/delay.h>
 #include <asm/uaccess.h>
 
 #ifdef CONFIG_PCI
@@ -1762,6 +1763,8 @@
 	int i;
 	struct airo_info *ai = dev->priv;
 
+	if (down_interruptible(&ai->sem))
+		return -1;
 	waitbusy (ai);
 	OUT4500(ai,COMMAND,CMD_SOFTRESET);
 	set_current_state (TASK_UNINTERRUPTIBLE);
@@ -1771,6 +1774,7 @@
 	schedule_timeout (HZ/5);
 	if ( setup_card(ai, dev->dev_addr ) != SUCCESS ) {
 		printk( KERN_ERR "airo: MAC could not be enabled\n" );
+		up(&ai->sem);
 		return -1;
 	} else {
 		printk( KERN_INFO "airo: MAC enabled %s %x:%x:%x:%x:%x:%x\n",
@@ -1788,6 +1792,7 @@
 	}
 	enable_interrupts( ai );
 	netif_wake_queue(dev);
+	up(&ai->sem);
 	return 0;
 }
 
@@ -1866,6 +1871,7 @@
 
 		if ( status & EV_MIC ) {
 			OUT4500( apriv, EVACK, EV_MIC );
+			if (apriv->flags & FLAG_MIC_CAPABLE)
 			airo_read_mic( apriv );
 		}
 		if ( status & EV_LINK ) {
@@ -2379,20 +2385,26 @@
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
 
@@ -2653,11 +2665,11 @@
 	if (down_interruptible(&ai->sem))
 		return ERROR;
 	if (issuecommand(ai, &cmd, &rsp) != SUCCESS) {
-		txFid = 0;
+		txFid = ERROR;
 		goto done;
 	}
 	if ( (rsp.status & 0xFF00) != 0) {
-		txFid = 0;
+		txFid = ERROR;
 		goto done;
 	}
 	/* wait for the allocate event/indication
@@ -2704,7 +2716,7 @@
 
 	len >>= 16;
 
-	if (len < ETH_ALEN * 2) {
+	if (len <= ETH_ALEN * 2) {
 		printk( KERN_WARNING "Short packet %d\n", len );
 		return ERROR;
 	}
@@ -4838,7 +4850,7 @@
 	readCapabilityRid(local, &cap_rid);
 
 	dwrq->length = sizeof(struct iw_range);
-	memset(range, 0, sizeof(*range));
+	memset(range, 0, sizeof(range));
 	range->min_nwid = 0x0000;
 	range->max_nwid = 0x0000;
 	range->num_channels = 14;

--=-BL09M2RkVVBfZpOftHXg--

