Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261915AbVBAKLe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261915AbVBAKLe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 05:11:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261938AbVBAKLe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 05:11:34 -0500
Received: from mx1.elte.hu ([157.181.1.137]:40320 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261915AbVBAKLb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 05:11:31 -0500
Date: Tue, 1 Feb 2005 11:11:05 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [patch] sys_setpriority() euid semantics fix
Message-ID: <20050201101105.GA28194@elte.hu>
References: <20050120172506.GA20295@elte.hu> <87wtu6fho8.fsf@sulphur.joq.us> <20050122165458.GA14426@elte.hu> <87hdl940ph.fsf@sulphur.joq.us> <20050124085902.GA8059@elte.hu> <20050124125814.GA31471@elte.hu> <20050125135613.GA18650@elte.hu> <41F6C5CE.9050303@bigpond.net.au> <20050126092014.GA7003@elte.hu> <41FEB951.8070307@bigpond.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41FEB951.8070307@bigpond.net.au>
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


* Peter Williams <pwil3058@bigpond.net.au> wrote:

> I've just noticed what might be a bug in the original code.  Shouldn't
> the following:
> 
>        if ((current->euid != p->euid) && (current->euid != p->uid) &&
>                !capable(CAP_SYS_NICE))
> 
> be:
> 
>        if ((current->uid != p->uid) && (current->euid != p->uid) &&
>                !capable(CAP_SYS_NICE))
> 
> I.e. if the real or effective uid of the task doing the setting is not
> the same as the uid of the target task it is not allowed to change the
> target task's policy unless it is specially privileged.

no. The original code is quite logical: when doing something to others,
only the euid is taken into account. When others do something to you,
both the uid and the euid is checked ('others' might have no idea about
this task temporarily changing the euid to a less/more privileged uid). 
So sys_setscheduler() [and sys_setaffinity(), which does the same] is
fine.

what _is_ inconsistent is kernel/sys.c's setpriority()/set_one_prio(). 

It checks current->euid|uid against p->uid, which makes little sense,
but is how we've been doing it ever since. It's a Linux quirk documented
in the manpage. To make things funnier, SuS requires current->euid|uid
match against p->euid.

The patch below fixes it (and brings the logic in line with what
setscheduler()/setaffinity() does), but if we do it then it should be
done only in 2.6.12 or later, after good exposure in -mm.

(Worst-case this could break an application but i highly doubt it: it at
most could deny renicing another task to positive (or in very rare
cases, to negative) nice values, which no application should crash on
something like that, normally.)

	Ingo

--

fix a setpriority() Linux quirk, implement euid semantics correctly.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

--- linux/kernel/sys.c.orig
+++ linux/kernel/sys.c
@@ -216,12 +216,13 @@ int unregister_reboot_notifier(struct no
 }
 
 EXPORT_SYMBOL(unregister_reboot_notifier);
+
 static int set_one_prio(struct task_struct *p, int niceval, int error)
 {
 	int no_nice;
 
 	if (p->uid != current->euid &&
-		p->uid != current->uid && !capable(CAP_SYS_NICE)) {
+		p->euid != current->euid && !capable(CAP_SYS_NICE)) {
 		error = -EPERM;
 		goto out;
 	}
