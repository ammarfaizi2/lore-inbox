Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261801AbVDZVj5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261801AbVDZVj5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 17:39:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261802AbVDZVj5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 17:39:57 -0400
Received: from mailfe10.swipnet.se ([212.247.155.33]:48801 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S261801AbVDZVjy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 17:39:54 -0400
X-T2-Posting-ID: k1c2aGMK8Lj9Cnpb+Eju4eOhqUzXuhsckJNC9B9P7R8=
Date: Tue, 26 Apr 2005 23:42:41 +0200
From: Frederik Deweerdt <dev.deweerdt@laposte.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Don't oops when unregistering unknown kprobes
Message-ID: <20050426214241.GF27406@gilgamesh.home.res>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20050426162203.GE27406@gilgamesh.home.res> <20050426162751.GD32766@in.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="uQr8t48UFsdbeI+V"
Content-Disposition: inline
In-Reply-To: <20050426162751.GD32766@in.ibm.com>
User-Agent: Mutt/1.5.6i
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--uQr8t48UFsdbeI+V
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Le 26/04/05 21:57 +0530, Prasanna S Panchamukhi =E9crivit:
> This is wrong. You should call get_kprobe() with spin_lock().
> =20
Right, corrected patch attached. It also sets flags to zero.

Signed-off-by: Frederik Deweerdt <frederik.deweerdt@laposte.net>

Regards,
Frederik

--=20
o----------------------------------------------o
| http://open-news.net : l'info alternative    |
| Tech - Sciences - Politique - International  |
o----------------------------------------------o

--uQr8t48UFsdbeI+V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dont.oops.on.unregister.unknown.kprobe.patch"

--- linux-2.6.12-rc3/kernel/kprobes.c	2005-04-26 16:35:22.000000000 +0200
+++ linux-2.6.12-rc3-devel/kernel/kprobes.c	2005-04-26 23:18:47.000000000 +0200
@@ -106,13 +106,22 @@ rm_kprobe:
 
 void unregister_kprobe(struct kprobe *p)
 {
-	unsigned long flags;
+	unsigned long flags = 0;
+
+	spin_lock_irqsave(&kprobe_lock, flags);
+	if (!get_kprobe(p)) {
+		printk(KERN_WARNING "Warning: Attempt to unregister "
+					"unknown kprobe (addr:0x%lx)\n",
+					(unsigned long) p);
+		goto out;
+	}
 	arch_remove_kprobe(p);
 	spin_lock_irqsave(&kprobe_lock, flags);
 	*p->addr = p->opcode;
 	hlist_del(&p->hlist);
 	flush_icache_range((unsigned long) p->addr,
 			   (unsigned long) p->addr + sizeof(kprobe_opcode_t));
+out:
 	spin_unlock_irqrestore(&kprobe_lock, flags);
 }
 

--uQr8t48UFsdbeI+V--
