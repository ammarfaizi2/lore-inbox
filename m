Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265529AbUBPNgW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 08:36:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265532AbUBPNgW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 08:36:22 -0500
Received: from websrv.werbeagentur-aufwind.de ([213.239.197.241]:11962 "EHLO
	mail.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S265529AbUBPNgT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 08:36:19 -0500
Subject: Re: kthread, signals and PF_FREEZE (suspend)
From: Christophe Saout <christophe@saout.de>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: LKML <linux-kernel@vger.kernel.org>, pavel@suse.cz
In-Reply-To: <20040216034251.0912E2C0F8@lists.samba.org>
References: <20040216034251.0912E2C0F8@lists.samba.org>
Content-Type: text/plain
Message-Id: <1076938575.7350.29.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 16 Feb 2004 14:36:15 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mo, den 16.02.2004 schrieb Rusty Russell um 04:38:

> > That means that signal_pending() will return true for that process which
> > will make kthread stop the thread.
> 
> Yes, the way they are currently coded.  I had assumed that spurious
> signals do not occur.

Yes, the freeze signalling is somewhat hackish. It sets the PF_FREEZE
flag and calls signal_wake_up on the process.

> Pavel, what is the answer here?  Should the refrigerator code be in
> the kthread infrastructure?  Why does the workqueue code set
> PF_IOTHREAD?

If PF_IOTHREAD is set the suspend code won't try to freeze the process
(kthread works here with the suspend code).

But you could change

while (!signal_pending(current))
        ret = threadfn(data);

to

for (;;) {
	if (current->flags & PF_FREEZE)
		refrigerator(PF_IOTHREAD);
	if (signal_pending())
		break;
        ret = threadfn(data);
}

or something like that.

The threadfn will return when it sees a signal. If it was a "PF_FREEZE
signal" the refrigerator will suspend the code and flush the signal. The
threadfn will be reentered afterwards (it should be prepared for this to
happen if it doesn't handle PF_FREEZE itself).

If it was real signal the thread will exit.

BTW: You might want to export the kthread functions:

EXPORT_SYMBOL(kthread_create);
EXPORT_SYMBOL(kthread_bind);
EXPORT_SYMBOL(kthread_stop);

Should I send a patch to Andrew?


