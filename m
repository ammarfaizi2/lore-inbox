Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1163164AbWLGSRk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1163164AbWLGSRk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 13:17:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1163160AbWLGSRk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 13:17:40 -0500
Received: from smtp.osdl.org ([65.172.181.25]:53291 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1163164AbWLGSRh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 13:17:37 -0500
Date: Thu, 7 Dec 2006 10:16:05 -0800
From: Andrew Morton <akpm@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: David Howells <dhowells@redhat.com>,
       "Maciej W. Rozycki" <macro@linux-mips.org>,
       Roland Dreier <rdreier@cisco.com>,
       Andy Fleming <afleming@freescale.com>,
       Ben Collins <ben.collins@ubuntu.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] Export current_is_keventd() for libphy
Message-Id: <20061207101605.ba446f79.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0612071000380.3615@woody.osdl.org>
References: <1165125055.5320.14.camel@gullible>
	<20061203011625.60268114.akpm@osdl.org>
	<Pine.LNX.4.64N.0612051642001.7108@blysk.ds.pg.gda.pl>
	<20061205123958.497a7bd6.akpm@osdl.org>
	<6FD5FD7A-4CC2-481A-BC87-B869F045B347@freescale.com>
	<20061205132643.d16db23b.akpm@osdl.org>
	<adaac22c9cu.fsf@cisco.com>
	<20061205135753.9c3844f8.akpm@osdl.org>
	<Pine.LNX.4.64N.0612061506460.29000@blysk.ds.pg.gda.pl>
	<20061206075729.b2b6aa52.akpm@osdl.org>
	<Pine.LNX.4.64.0612060822260.3542@woody.osdl.org>
	<Pine.LNX.4.64.0612061719420.3542@woody.osdl.org>
	<20061206224207.8a8335ee.akpm@osdl.org>
	<Pine.LNX.4.64.0612070846550.3615@woody.osdl.org>
	<20061207095253.30059224.akpm@osdl.org>
	<Pine.LNX.4.64.0612071000380.3615@woody.osdl.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Dec 2006 10:01:56 -0800 (PST)
Linus Torvalds <torvalds@osdl.org> wrote:

> 
> 
> On Thu, 7 Dec 2006, Andrew Morton wrote:
> > 
> > umm..  Putting a work_struct* into struct cpu_workqueue_struct and then
> > doing appropriate things with cpu_workqueue_struct.lock might work.
> 
> Yeah, that looks sane. We can't hide anything in "struct work", because we 
> can't trust it any more once it's been dispatched,

We _can_ trust it in the context of

	void flush_work(struct work_struct *work)

because the caller "owns" the work_struct.  It'd be pretty nutty for the
caller to pass in a pointer to something which could be freed at any time. 
Most flush_work_queue() callers do something like:


	flush_scheduled_work();
	kfree(my_object_which_contains_a_work_struct);

hopefully libphy follows that model...

> but adding a pointer to 
> the cpu_workqueue_struct that is only used to compare against another 
> pointer sounds fine.

ho-hum.  I'll take a look at turning that into something which compiles,
then I'll convert a few oft-used flush_scheduled_work() callers over to use
it.  To do this on a sensible timescale perhaps means that we should export
current_is_keventd(), get the howling hordes off our backs.

