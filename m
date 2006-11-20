Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966868AbWKTWQn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966868AbWKTWQn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 17:16:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966857AbWKTWPn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 17:15:43 -0500
Received: from smtp109.sbc.mail.mud.yahoo.com ([68.142.198.208]:31318 "HELO
	smtp109.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S966606AbWKTWPl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 17:15:41 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=QoDWn8bdcmGAudqA1L6lSZ6iSOhA0X5ea27eNrrgzbwL1TuK0ENoSDdHQDw7RB7oA3sgPIRt7YNy4dJg2EucEiH32jZ8gAj7XFPiqs6zowzeAPiC3VLrY+YLmPbsDEWpeoxagEWfLciuiJ4R4DoF2njp1cgYmsQ1C775ezufFUI=  ;
X-YMail-OSG: hr.7OnYVM1mgMG2VO80t1XrWAqt2B.o8sM4z.ngP2aiHjE0NsLKMOwKf2j2WzqnjKWLQu3kb9YJ_xF76y_uL9ScPLTid4IHtVVIFP055CLgDgzzgYpvn1g--
From: David Brownell <david-b@pacbell.net>
To: Alessandro Zummo <alessandro.zummo@towertech.it>
Subject: [patch 2.6.19-rc6 1/6] rtc class /proc/driver/rtc update
Date: Mon, 20 Nov 2006 10:17:19 -0800
User-Agent: KMail/1.7.1
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
References: <200611201014.41980.david-b@pacbell.net>
In-Reply-To: <200611201014.41980.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611201017.19961.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix two minor botches in the procfs dumping of RTC alarm status:

 - Stop confusing "alarm enabled" with "wakeup enabled".

 - Don't display bogus "irq pending/un-acked" status; those are the rather
   pointless semantics EFI assigned to this (for a no-IRQs environment).

The main RTC that seems confused about this is the sa1100 one, which
doesn't actually report whether it enabled the alarm.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

Index: g26/drivers/rtc/rtc-proc.c
===================================================================
--- g26.orig/drivers/rtc/rtc-proc.c	2006-11-20 09:35:39.000000000 -0800
+++ g26/drivers/rtc/rtc-proc.c	2006-11-20 09:36:23.000000000 -0800
@@ -66,9 +66,11 @@ static int rtc_proc_show(struct seq_file
 		else
 			seq_printf(seq, "**\n");
 		seq_printf(seq, "alrm_wakeup\t: %s\n",
+				device_may_wakeup(class_dev->dev)
+					? "yes" : "no");
+		seq_printf(seq, "alrm_enabled\t: %s\n",
 				alrm.enabled ? "yes" : "no");
-		seq_printf(seq, "alrm_pending\t: %s\n",
-				alrm.pending ? "yes" : "no");
+		/* alrm.pending ("irq un-acked") is useless ... */
 	}
 
 	seq_printf(seq, "24hr\t\t: yes\n");
