Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937896AbWLGBQd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937896AbWLGBQd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 20:16:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937910AbWLGBQd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 20:16:33 -0500
Received: from smtp.osdl.org ([65.172.181.25]:33635 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937896AbWLGBQb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 20:16:31 -0500
Date: Wed, 6 Dec 2006 17:16:10 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
cc: linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net,
       nfsv4@linux-nfs.org
Subject: Re: [GIT] Please pull the NFS client update for 2.6.19
In-Reply-To: <1165424156.5744.10.camel@lade.trondhjem.org>
Message-ID: <Pine.LNX.4.64.0612061713270.3542@woody.osdl.org>
References: <1165424156.5744.10.camel@lade.trondhjem.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 6 Dec 2006, Trond Myklebust wrote:
> 
>    git pull git://git.linux-nfs.org/pub/linux/nfs-2.6.git
> 
> This will update the following files through the appended changesets.

Well, right now it conflicts with the workqueue cleanups. Can you fix up 
the conflicts and push again? Quite frankly, I could try, but since I 
don't even run NFS, I _really_ don't think you want me to do so.

Did you see the explanation of the split? Appended here just in case.

		Linus
---
From: David Howells <dhowells@redhat.com>

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

