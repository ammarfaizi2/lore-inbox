Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964830AbWETNDo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964830AbWETNDo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 May 2006 09:03:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964835AbWETNDo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 May 2006 09:03:44 -0400
Received: from pne-smtpout2-sn1.fre.skanova.net ([81.228.11.159]:27110 "EHLO
	pne-smtpout2-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S964830AbWETNDo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 May 2006 09:03:44 -0400
Date: Sat, 20 May 2006 15:03:27 +0200
From: Peter Lundkvist <p.lundkvist@telia.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Page writeback broken after resume: wb_timer lost
Message-ID: <20060520130326.GA6092@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I have noticed for some time that nr_dirty never drops but
increases except when VM pressure forces it down. This only
occurs after a resume, never on a freshly booted system.

It seems the wb_timer is lost when the timer function is
trying to start a frozen pdflush thread, and this occurs
during suspend or resume.

I have included a patch which work for me. Don't know if the
test also should include a check for freezing to be safe, ie
  if ( !frozen(..) && !freezing(..) )



diff -ru linux-2.6.17.org/mm/pdflush.c linux-2.6.17/mm/pdflush.c
--- linux-2.6.17.org/mm/pdflush.c	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6.17/mm/pdflush.c	2006-05-20 14:22:35.000000000 +0200
@@ -213,12 +213,16 @@
 		struct pdflush_work *pdf;
 
 		pdf = list_entry(pdflush_list.next, struct pdflush_work, list);
-		list_del_init(&pdf->list);
-		if (list_empty(&pdflush_list))
-			last_empty_jifs = jiffies;
-		pdf->fn = fn;
-		pdf->arg0 = arg0;
-		wake_up_process(pdf->who);
+		if (!frozen(pdf->who)) {
+			list_del_init(&pdf->list);
+			if (list_empty(&pdflush_list))
+				last_empty_jifs = jiffies;
+			pdf->fn = fn;
+			pdf->arg0 = arg0;
+			wake_up_process(pdf->who);
+		}
+		else
+			ret = -1;
 		spin_unlock_irqrestore(&pdflush_lock, flags);
 	}
 	return ret;

-- 
Peter Lundkvist
