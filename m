Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268775AbUJPQG0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268775AbUJPQG0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 12:06:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268776AbUJPQG0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 12:06:26 -0400
Received: from mx1.elte.hu ([157.181.1.137]:58033 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S268775AbUJPQGU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 12:06:20 -0400
Date: Sat, 16 Oct 2004 18:07:37 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Lee Revell <rlrevell@joe-job.com>, Alan Stern <stern@rowland.harvard.edu>,
       Laurent Riffard <laurent.riffard@free.fr>,
       USB development list <linux-usb-devel@lists.sourceforge.net>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>, Paul Fulghum <paulkf@microgate.com>
Subject: [patch, 2.6.9-rc4-mm1] fix rmmod uhci_hcd oops
Message-ID: <20041016160737.GA19630@elte.hu>
References: <Pine.LNX.4.44L0.0410151318580.1052-100000@ida.rowland.org> <1097861761.2820.18.camel@deimos.microgate.com> <1097872927.5119.5.camel@krustophenia.net> <1097874840.2915.18.camel@deimos.microgate.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1097874840.2915.18.camel@deimos.microgate.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


this patch fixes the rmmod oops reported by Paul Fulghum. It is caused
by the generic-irqs subsystem creating multiple /proc/irq/<nr>/<name>
directory entries with the same name which then confuses procfs upon
module removal.

	Ingo

Signed-off-by: Ingo Molnar <mingo@elte.hu>

--- linux/kernel/irq/proc.c.orig
+++ linux/kernel/irq/proc.c
@@ -66,11 +66,24 @@ static int irq_affinity_write_proc(struc
 
 #define MAX_NAMELEN 128
 
+static int name_unique(unsigned int irq, struct irqaction *new_action)
+{
+	struct irq_desc *desc = irq_desc + irq;
+	struct irqaction *action;
+
+	for (action = desc->action ; action; action = action->next)
+		if ((action != new_action) && action->name &&
+				!strcmp(new_action->name, action->name))
+			return 0;
+	return 1;
+}
+
 void register_handler_proc(unsigned int irq, struct irqaction *action)
 {
 	char name [MAX_NAMELEN];
 
-	if (!irq_dir[irq] || action->dir || !action->name)
+	if (!irq_dir[irq] || action->dir || !action->name ||
+					!name_unique(irq, action))
 		return;
 
 	memset(name, 0, MAX_NAMELEN);

