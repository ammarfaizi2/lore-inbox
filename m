Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031675AbWLEVlc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031675AbWLEVlc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 16:41:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031667AbWLEVlc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 16:41:32 -0500
Received: from mx1.redhat.com ([66.187.233.31]:34439 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031668AbWLEVla (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 16:41:30 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20061205121632.65572efb.akpm@osdl.org> 
References: <20061205121632.65572efb.akpm@osdl.org>  <20061122130222.24778.62947.stgit@warthog.cambridge.redhat.com> <24327.1165348363@redhat.com> 
To: Andrew Morton <akpm@osdl.org>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, jdike@karaya.com,
       user-mode-linux-devel@lists.sourceforge.net,
       linux-arm-kernel@lists.arm.linux.org.uk
Subject: Re: GIT pull on work_struct reduction tree 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Tue, 05 Dec 2006 21:41:02 +0000
Message-ID: <25990.1165354862@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:

> > I've brought the work_struct reduction patches up to date.  They're in a GIT
> > tree for you to pull when you're ready.
> 
> Given that I (and probably many others) now have a pile of build errors to
> fix, it would be nice to have a short-but-full description of what one must
> do to fix those up, please.

Okay.

 (1) Any work_struct struct that has one of the following called upon it:

	queue_delayed_work()
	queue_delayed_work_on()
	schedule_delayed_work()
	schedule_delayed_work_on()
	cancel_rearming_delayed_work()
	cancel_rearming_delayed_workqueue()
	cancel_delayed_work()

     needs changing into a delayed_work struct.

     Note that cancel_delayed_work() is often called where it'll be ineffective
     - I think people misunderstand what it does.

 (2) A delayed_work struct must be initialised with:

	__DELAYED_WORK_INITIALIZER
	DECLARE_DELAYED_WORK
	INIT_DELAYED_WORK

     Rather than:

	__WORK_INITIALIZER
	DECLARE_WORK
	INIT_WORK

     Those only apply to work_struct (non-delayable work).

 (3) The initialisation functions no longer take a data argument, and this
     should be deleted.

 (4) Anywhere one of the following is called on a delayed_work struct:

	queue_work()
	queue_work_on()
	schedule_work()
	schedule_work_on()

     it must be converted to the equivalent one of:

	queue_delayed_work()
	queue_delayed_work_on()
	schedule_delayed_work()
	schedule_delayed_work_on()

     and given a 0 timeout argument as an additional argument.  This just
     queues the work item and doesn't set the timer.

 (5) Anywhere the work item's pending flag is examined directly with:

	test_bit(0, &work->pending)

     This should be replaced with the appropriate one of:

	work_pending(work)
	delayed_work_pending(work)

 (6) The work function _must_ be changed to conform to the following prototype:

	void foo_work_func(struct work_struct *work)
	{
		...
	}

     This applies to both work_struct and delayed_work handlers.

     (a) If the arbitary datum previously passed to the initialiser was NULL,
     	 then the work argument should just be ignored.

     (b) If the datum was the address of the structure containing the
     	 work_struct, then something like the following should be used:

	struct foo {
		struct work_struct worker;
		...
	};

	void foo_work_func(struct work_struct *work)
	{
		struct foo *foo = container_of(work, struct foo, worker);
		...
	}

	 If the work_struct can be placed at the beginning of the containing
	 structure this will eliminate the subtraction instruction
	 container_of() might otherwise require.

     (c) If the datum was the address of the structure containing the
     	 delayed_work, then something like the following should be used:

	struct foo {
		struct delayed_work worker;
		...
	};

	void foo_work_func(struct work_struct *work)
	{
		struct foo *foo = container_of(work, struct foo, worker.work);
		...
	}

	 NOTE!  There's an extra ".work" in the container_of() because the
	 work_struct pointed to is embedded within the delayed_work.

     (d) If the datum is not a pointer to the container, but the container is
     	 guaranteed to exist whilst the work handler runs, then the datum can
     	 be stored in an extra variable in the container.

	 The handler would then be formed as for (b) or (c), and the extra
	 variable accessed after the container_of() line.

	 Quite often there's a linked pair of structures, with a work_struct in
	 one being initialised with the address of the other as its datum.  The
	 typical case is struct net_device and the private data.  In this case
	 just adding a back pointer from the private data to the net_device
	 struct seems to work.

     (e) If the auxiliary datum is totally unrelated and can't be stored in an
     	 extra variable because the container might go away, then the
     	 work_struct or delayed_work should be initialised with one of these
     	 instead:

	DECLARE_WORK_NAR
	DECLARE_DELAYED_WORK_NAR
	INIT_WORK_NAR
	INIT_DELAYED_WORK_NAR
	__WORK_INITIALIZER_NAR
	__DELAYED_WORK_INITIALIZER_NAR

	 These take the same arguments as the normal initialisers, but set a
	 flag in the work_struct to indicate that the pending flag is not to be
	 cleared before the work function is called.

	 The datum is then stored in an extra variable in the container:
	
	struct foo {
		struct work_struct worker;
		void *worker_data;
		...
	};

	 And a work item is initialised with something like this:

	void thing(struct foo *foo)
	{
		...
		INIT_WORK_NAR(&foo->worker, foo_work_func);
		foo->worker_data = silly_data;
		...
	}

	 And then the work function releases the work item itself when it has
	 extracted the auxiliary data:

	void foo_work_func(struct work_struct *work)
	{
		struct foo *foo = container_of(work, struct foo, worker);
		void *silly_data = foo->worker_data;
		work_release(work);
		...
	}

	 As an added bonus, you can have multiple auxiliary data if you so
	 desire.  You're not limited to a single word.

 (7) If the work function was being called directly, then rather than passing
     in the auxiliary datum, you have to pass in the address of the work_struct
     instead.  So for a work_struct, you'd change:

	void call_work(struct foo *foo)
	{
		...
	-	foo_work_func(foo);
	+	foo_work_func(&foo->worker);
		...
	}

     And for a delayed_work, you'd do:

	void call_work(struct foo *foo)
	{
		...
	-	foo_work_func(foo);
	+	foo_work_func(&foo->worker.work);
		...
	}

David
