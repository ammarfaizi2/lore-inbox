Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264535AbTFQEWV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 00:22:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264551AbTFQEWV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 00:22:21 -0400
Received: from dp.samba.org ([66.70.73.150]:11728 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S264535AbTFQEWF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 00:22:05 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Cc: Martin Diehl <lists@mdiehl.de>
Cc: Andrew Morton <akpm@digeo.com>
Subject: Re: [PATCH] Add module_kernel_thread for threads that live in modules. 
In-reply-to: Your message of "Tue, 17 Jun 2003 09:10:48 +1000."
             <16110.20088.351260.156860@gargle.gargle.HOWL> 
Date: Tue, 17 Jun 2003 14:25:45 +1000
Message-Id: <20030617043558.82FAD2C7B6@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <16110.20088.351260.156860@gargle.gargle.HOWL> you write:
> On Monday June 16, rusty@rustcorp.com.au wrote:
> > Hi Neil,
> 
> Hi Rusty.  Thanks for the comments... I probably should have Cc:ed you
> in the first place....

Yeah, that does tend to get faster response, but I know some hackers
consider it completely optional 8(

> > 	There are several problems with this patch.  Ignoring the fact
> > that you use __module_get.  Firstly, you bump the module count
> > permentantly while the thread is running: how does it ever get
> > unloaded?  Secondly, modprobe becomes your parent.
> 
> We seem to have very different views of the problem, as you seem to be
> calling into question aspects that I thought were obviously correct.
> 
> __module_get:
>    In all the cases I am interested in (nfsd, lockd,
>    lockd-helper-thread), the thread is started by code running
>    inside the module and so there will be a reference held on the
>    module while the thread is being started, thus __module_get is the
>    correct thing to do as "we know we already have a refcount"...

But do you wait for it?  Theoretically the init code could have
finished, and someone done rmmod, before this thread gets as far as
__module_get, no?

> module count bumped permananelt while thread is running:
>    well ofcourse, the thread runs code in the module which can only
>    be done safely while we have a ref-count.

For future reference: this isn't quite true.  If a function/thread is
synchronously stopped by the exit code/failed init code then they
don't need to hold a reference count: it still *can* hold a reference
count, which really depends on whether the module should be considered
"in use" by the thread... cf. timers.

>    The threads I am thinking of aren't running "whenever the module is
>    loaded".  They are running "whenever their service is needed".

My bad: I wasn't sure given my (admittedly brief) glance at the code.
Thanks for clarifing!

> modprobe becomes your parent:
>    No, modprobe has nothing to do with it in my case. rpc.nfsd, or 
>    mount_nfs or lockd might be the parent.  I thought reparent_to_init
>    handled all that.  Apparently there are question marks over that
>    which I wasn't aware of.

Andrew has been trying to kill it, and I think he's right.  In
practical terms, it's much easier to start from a clean environment
than to clean up an unknown one, and keep that cleanup code uptodate.

> I don't want to have to call "cleanup_thread" or de-allocate the
> "struct kthread".  I want to be able to SIGKILL a process and have it
> go away and release everything, including possibly the last refernce
> to the module.
> 
> In short, it really feels like we are trying to solve different
> problems :-)

Agreed: threads under their own control are much simpler than ones
under external control.

> I will have a look at keventd and see if it's services can be of
> assistance to solve my problem.

I will think, which usually seems to help me when presented with new
information 8)

Thanks!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
