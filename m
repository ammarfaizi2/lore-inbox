Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270399AbUJUIHG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270399AbUJUIHG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 04:07:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270395AbUJUH7c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 03:59:32 -0400
Received: from mx1.elte.hu ([157.181.1.137]:20383 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S270336AbUJUHy4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 03:54:56 -0400
Date: Thu, 21 Oct 2004 09:56:13 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Chris Wright <chrisw@osdl.org>
Cc: johansen@immunix.com, Stephen Smalley <sds@epoch.ncsc.mil>,
       Thomas Bleher <bleher@informatik.uni-muenchen.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] delay rq_lock acquisition in setscheduler
Message-ID: <20041021075613.GC20573@elte.hu>
References: <20041020183238.U2357@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041020183238.U2357@build.pdx.osdl.net>
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


* Chris Wright <chrisw@osdl.org> wrote:

> Hi Ingo,
> 
> Doing access control checks with rq_lock held can cause deadlock when
> audit messages are created (via printk or audit infrastructure), as
> noted by both SELinux and SubDomain folks.  This patch will let the
> security checks happen w/out lock held, then re-sample the p->policy
> in case it was raced.  Original patch from John Johansen, with some
> updates from me.  What do you think?

i dont this this patch is correct, because it changes semantics by
pushing a security-subsystem failure back into userspace. There's
nothing wrong with two tasks trying to change a third task's policy in
parallel - our API allows that.

I agree that this is a very special case of lock dependency and that the
security subsystem should not be burdened with double-buffering messages
just to avoid the runqueue lock on syslogd wakeup. Only this single
scheduling-related system-call is affected by this problem.

i think the right solution would be to retry the permission check if the
policy has changed (an unlikely event). It is livelockable the same way
seqlocks are livelockable so i'd not worry about it too much. It is also
preemptible with PREEMPT so not a big issue. Also, the check & repeat
code should possibly be #ifdef CONFIG_SECURITY.

	Ingo
