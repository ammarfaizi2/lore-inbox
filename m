Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261785AbVAMWdD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261785AbVAMWdD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 17:33:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261806AbVAMWal
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 17:30:41 -0500
Received: from rproxy.gmail.com ([64.233.170.197]:18702 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261796AbVAMW0s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 17:26:48 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=LSOdl+IJFQI/QaF1aZ/bgGF3MSlBG6ux3OE1zJC2sBaW6t/SIeYcxjCjyJxv9C1CuKZgiOtZjdOp4Ag//fSlllAuZ5kKjufeHA/tOdct2k/7j1rShzmOLeA/r44wz80Vi6yj+9VVmWxNY1busn5OBTyVZWGzuLzmzKZv+PTtqIo=
Message-ID: <36b714c80501131426a91c908@mail.gmail.com>
Date: Thu, 13 Jan 2005 17:26:45 -0500
From: Brian Waite <linwoes@gmail.com>
Reply-To: Brian Waite <linwoes@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] ppc: fix powersave with interrupts disabled
In-Reply-To: <36b714c805011312586718520f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <200501120407.j0C477s1019067@hera.kernel.org>
	 <36b714c805011312586718520f@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jan 2005 15:58:34 -0500, Brian Waite <linwoes@gmail.com> wrote:
> On Wed, 12 Jan 2005 01:41:19 +0000, Linux Kernel Mailing List
> <linux-kernel@vger.kernel.org> wrote:
> > ChangeSet 1.2369, 2005/01/11 17:41:19-08:00, tglx@linutronix.de
> >
> >         [PATCH] ppc: fix idle with interrupts disabled
> >
> >         The idle-thread-preemption-fix.patch in mm1/2 leads to a stalled box on PPC
> >         machines which do not provide a powersave function and therefor poll the
> >         idle loop with interrupts disabled.  The patch reenables interrupts.
> There is still a stall with PPC  boxes that have powersave enabled. I
> use a 74xx based board and unless I disable powersave
> (ppc_md.power_save=NULL), I get a stall at:
> NET: Registered protocol family 2
> 
It looks like the problem has to do with entering the powersave
routine with irqs disabled. Here is a patch that will only enter
powersave if irqs are enabled:

Entering powersave on PPC while irqs are disabled causes a hang. Only
enter powersave if irqs are disabled.

Signed-off-by: Brian Waite <waite@skycomputers.com>
===== arch/ppc/kernel/idle.c 1.22 vs edited =====
--- 1.22/arch/ppc/kernel/idle.c Tue Jan 11 19:42:36 2005
+++ edited/arch/ppc/kernel/idle.c       Thu Jan 13 17:22:25 2005
@@ -39,8 +39,9 @@
        powersave = ppc_md.power_save;

        if (!need_resched()) {
-               if (powersave != NULL)
-                       powersave();
+               if ((powersave != NULL) && !irqs_disabled())
+                           powersave();
+
                else {
 #ifdef CONFIG_SMP
                        set_thread_flag(TIF_POLLING_NRFLAG);
