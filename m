Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261808AbTEVUfo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 16:35:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263250AbTEVUfo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 16:35:44 -0400
Received: from smtp8.wanadoo.fr ([193.252.22.30]:56686 "EHLO
	mwinf0101.wanadoo.fr") by vger.kernel.org with ESMTP
	id S261808AbTEVUfm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 16:35:42 -0400
From: Duncan Sands <baldrick@wanadoo.fr>
To: Andi Kleen <ak@suse.de>
Subject: Re: Use of sti in entry.S question
Date: Thu, 22 May 2003 22:48:44 +0200
User-Agent: KMail/1.5.1
Cc: linux-kernel@vger.kernel.org
References: <200305220939.13619.baldrick@wanadoo.fr.suse.lists.linux.kernel> <p73ptmb8jwu.fsf@oldwotan.suse.de>
In-Reply-To: <p73ptmb8jwu.fsf@oldwotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305222248.44459.baldrick@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

...
> > Is this a mistake or an optimization?  Elsewhere in entry.S, interrupts
> > are turned on before calling schedule:
>
> It's a mistake, but a harmless one. The scheduler turns off interrupts
> soon itself and the instructions it executes before that don't care.
> The only reason it's not recommended to call schedule with interrupts
> off is that the scheduler will turn them on again, usually breaking
> your critical section. In this case it's ok because the next
> instrution is a cli again.

Do you think it's worth pushing this fix?

diff -Nru a/arch/i386/kernel/entry.S b/arch/i386/kernel/entry.S
--- a/arch/i386/kernel/entry.S	Thu May 22 22:45:50 2003
+++ b/arch/i386/kernel/entry.S	Thu May 22 22:45:50 2003
@@ -306,6 +306,7 @@
 	testb $_TIF_NEED_RESCHED, %cl
 	jz work_notifysig
 work_resched:
+	sti
 	call schedule
 	cli				# make sure we don't miss an interrupt
 					# setting need_resched or sigpending

