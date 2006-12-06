Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936927AbWLFRn2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936927AbWLFRn2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 12:43:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936933AbWLFRn2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 12:43:28 -0500
Received: from mx1.redhat.com ([66.187.233.31]:44043 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936927AbWLFRn2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 12:43:28 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <Pine.LNX.4.64.0612060822260.3542@woody.osdl.org> 
References: <Pine.LNX.4.64.0612060822260.3542@woody.osdl.org>  <1165125055.5320.14.camel@gullible> <20061203011625.60268114.akpm@osdl.org> <Pine.LNX.4.64N.0612051642001.7108@blysk.ds.pg.gda.pl> <20061205123958.497a7bd6.akpm@osdl.org> <6FD5FD7A-4CC2-481A-BC87-B869F045B347@freescale.com> <20061205132643.d16db23b.akpm@osdl.org> <adaac22c9cu.fsf@cisco.com> <20061205135753.9c3844f8.akpm@osdl.org> <Pine.LNX.4.64N.0612061506460.29000@blysk.ds.pg.gda.pl> <20061206075729.b2b6aa52.akpm@osdl.org> 
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, David Howells <dhowells@redhat.com>,
       "Maciej W. Rozycki" <macro@linux-mips.org>,
       Roland Dreier <rdreier@cisco.com>,
       Andy Fleming <afleming@freescale.com>,
       Ben Collins <ben.collins@ubuntu.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] Export current_is_keventd() for libphy 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Wed, 06 Dec 2006 17:43:13 +0000
Message-ID: <21690.1165426993@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:

> How about something like this?

At first glance, this looks reasonable.

It also looks like it should be used to replace a lot of the
cancel_delayed_work() calls that attempt to cancel _undelayed_ work items.
That would allow a number of work items to be downgraded from delayed_work to
work_struct.

Also, the name "run_scheduled_work" sort of suggests that the work *will* be
run regardless of whether it was pending or not.  Given the confusion over
cancel_delayed_work(), I imagine this will rain confusion too.

+	if (get_wq_data(work) == cwq
+	    && test_bit(WORK_STRUCT_PENDING, &work->management)

I wonder if those can be combined, perhaps:

+	if ((work->management & ~WORK_STRUCT_NOAUTOREL) ==
+	    ((unsigned long) cwq | (1 << WORK_STRUCT_PENDING))

Otherwise for i386 the compiler can't combine them because test_bit() is done
with inline asm.

And:

+		if (!test_bit(WORK_STRUCT_PENDING, &work->management))

Should possibly be:

+		if (!work_pending(work))

David
