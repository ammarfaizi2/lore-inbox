Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264507AbTFQBtq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 21:49:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264509AbTFQBtq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 21:49:46 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:54659 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S264507AbTFQBtm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 21:49:42 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Rusty Russell <rusty@rustcorp.com.au>
Date: Tue, 17 Jun 2003 09:10:48 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16110.20088.351260.156860@gargle.gargle.HOWL>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
cc: Martin Diehl <lists@mdiehl.de>
cc: Andrew Morton <akpm@digeo.com>
Subject: Re: [PATCH] Add module_kernel_thread for threads that live in modules.
In-Reply-To: message from Rusty Russell on Monday June 16
References: <20030616065058.D1C9E2C08A@lists.samba.org>
X-Mailer: VM 7.16 under Emacs 21.3.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday June 16, rusty@rustcorp.com.au wrote:
> Hi Neil,

Hi Rusty.  Thanks for the comments... I probably should have Cc:ed you
in the first place....

> 
> 	There are several problems with this patch.  Ignoring the fact
> that you use __module_get.  Firstly, you bump the module count
> permentantly while the thread is running: how does it ever get
> unloaded?  Secondly, modprobe becomes your parent.

We seem to have very different views of the problem, as you seem to be
calling into question aspects that I thought were obviously correct.

__module_get:
   In all the cases I am interested in (nfsd, lockd,
   lockd-helper-thread), the thread is started by code running
   inside the module and so there will be a reference held on the
   module while the thread is being started, thus __module_get is the
   correct thing to do as "we know we already have a refcount"...

module count bumped permananelt while thread is running:
   well ofcourse, the thread runs code in the module which can only
   be done safely while we have a ref-count.
how does it ever get unloaded:
   the thread exits, the refcount drops, and the module can be
   unloaded.
   In the case of nfsd, the threads get signalled and die gracefully.
   For lockd, the number of users (nfs mounts or nfsd threads) drops
   to zero, the process is signalled, and exits gracefully.
   For the lockd helper threads, the complete there assigned task and
   exit. 
   The threads I am thinking of aren't running "whenever the module is
   loaded".  They are running "whenever their service is needed".
modprobe becomes your parent:
   No, modprobe has nothing to do with it in my case. rpc.nfsd, or 
   mount_nfs or lockd might be the parent.  I thought reparent_to_init
   handled all that.  Apparently there are question marks over that
   which I wasn't aware of.

> 
> 	There have been ambitious attempts to do a nice "thread
> creation and stopping" interface before.  Given the delicate logic
> involved in shutting threads down, I think this makes sense.  Maybe
> something like: 
> 
> /* Struct which identifies a kernel thread, handed to creator and
>    thread. */
> struct kthread
> {
> 	int pid;
> 	int should_die; /* Thread should exit when this is set. */
> 
> 	/* User supplied arg... */
> 	void *arg;
> };
> 
> struct kthread *create_thread(int (*fn)(struct kthread*), void *arg, 
> 			      unsigned long flags,
> 			      const char *namefmt, ...);
> void cleanup_thread(struct kthread *);
> 
> create_thread would use keventd to start the thread, and stop_thread
> would tell keventd to set should_die, wmb(), wake it up, and
> sys_wait() for it.
> 
> Thoughts?

I don't want to have to call "cleanup_thread" or de-allocate the
"struct kthread".  I want to be able to SIGKILL a process and have it
go away and release everything, including possibly the last refernce
to the module.

In short, it really feels like we are trying to solve different
problems :-)

I will have a look at keventd and see if it's services can be of
assistance to solve my problem.

Thanks,
NeilBrown
