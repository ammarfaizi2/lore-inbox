Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269018AbUJKOjy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269018AbUJKOjy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 10:39:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269006AbUJKOcA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 10:32:00 -0400
Received: from mx1.elte.hu ([157.181.1.137]:64453 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S269022AbUJKO2g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 10:28:36 -0400
Date: Mon, 11 Oct 2004 16:29:53 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Lee Revell <rlrevell@joe-job.com>, "K.R. Foley" <kr@cybsft.com>,
       Rui Nuno Capela <rncbc@rncbc.org>,
       Florian Schmidt <mista.tapas@gmx.net>, Mark_H_Johnson@raytheon.com,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Daniel Walker <dwalker@mvista.com>, Andrew Morton <akpm@osdl.org>
Subject: [patch] CONFIG_PREEMPT_REALTIME, 'Fully Preemptible Kernel', VP-2.6.9-rc4-mm1-T4
Message-ID: <20041011142953.GA32607@elte.hu>
References: <20040921074426.GA10477@elte.hu> <20040922103340.GA9683@elte.hu> <20040923122838.GA9252@elte.hu> <20040923211206.GA2366@elte.hu> <20040924074416.GA17924@elte.hu> <20040928000516.GA3096@elte.hu> <20041003210926.GA1267@elte.hu> <20041004215315.GA17707@elte.hu> <20041005134707.GA32033@elte.hu> <20041007105230.GA17411@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041007105230.GA17411@elte.hu>
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


i've released the -T4 VP patch:

  http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc4-mm1-T4

the big change in this release is the addition of PREEMPT_REALTIME,
which is a new implementation of a fully preemptible kernel model:

 - spinlocks and rwlocks use semaphores and are preemptible by default

 - the _irq variants of these locks do not disable interrupts but rely
   on IRQ threading to exclude against interrupt contexts.

note that this implementation is different from other kernel-preemption
patches, in a number of key areas. Initially i looked at merging the
MontaVista patchset from two days ago but decided to implement a new one
from scratch to cure a number of conceptual problems:

 - this patch auto-detects the 'type' of the lock at compilation time. 

   All fully-preemptible kernel patches i've seen so far suffer from one
   nasty problem: they are very large because they redefine _all_ the
   spinlock APIs to provide separation between 'mutex based' and
   'original' spinlocks. E.g. check out the sheer size of the MontaVista
   patchset: Linux-2.6.9-rc3-RT_spinlock1.patch and
   Linux-2.6.9-rc3-RT_spinlock2.patch are 84K and 92K and they convert
   ~30 core spinlocks to new APIs.

   OTOH this patch converts _90_ spinlocks in roughly half the
   patchsize, which makes a large difference in maintainability.

   How it works: this implementation uses a gcc feature to detect the
   type of the spinlock compile-time and to switch to the mutex or
   raw_spinlock API accordingly. Only one, very isolated change has to
   be done to switch a generic spinlock to a spin-only lock: spinlock_t
   is changed to raw_spinlock_t and the initializer is fixed up. All the
   other code remains untouched - and this even if a single C module
   contains both mutex-based and spinlock-based API calls. This approach
   is quite close to a simple object-oriented lock type - but written in
   C and compatible with the existing spinlock APIs.

 - i used the native Linux semaphores/rwsems to implement
   spinlock/rwlock preemption. E.g. the MontaVista patches use separate
   synchronization objects (kmutex/pmutex) to implement this.

   I believe using native semaphores is the better approach
   architecturally because this means that we have to add priority
   inheritance handling only once and to the native Linux semaphores. 
   This has the additional benefit of fixing all mutex-using
   kernel code's priority inheritance problems. (which kmutex/pmutex
   does not solve.)

   OTOH the MontaVista patches naturally have the advantage of having a
   working priority-inheritance mechanism in the pmutex code, right now. 
   (I did a brief attempt to plug the pmutex code into this patch but it
   didnt look good of a match - but others might want to try to 
   integrate it nevertheless.)

   also, another bad property of the kmutex/pmutex code is that it uses
   assembly which makes it quite hard to port to non-x86 architectures. 
   OTOH, the native Linux semaphores and rwsems work on every
   architecture.

 - the patch converts rwlocks too, while e.g. the MontaVista patchset
   still keeps rwlocks as spinlocks. It is important to convert rwlocks
   to rw-semaphores, most notably this allow the conversion of the
   tasklist and signal spinlocks.

 - finally, i went for correctness primarily, not latencies. I checked
   out the MontaVista patches and they categorize roughly 30 spinlocks
   as the ones that are necessary to be 'raw'. Unfortunately this is
   inadequate, my patch excludes 90 such locks and it's still probably
   not a 100% correct conversion. The core kernel needs changes in the
   locking infrastructure to get rid of most of the these 90 non-mutex
   locks.

it is highly recommended to enable DEBUG_PREEMPT when enabling
PREEMPT_REALTIME. It will warn about all the places that are unsafe. The
patch is x86-only for the time being, but the changes necessary for
other architectures should be relatively low.

NOTE: CONFIG_PREEMPT_REALTIME is default-off and i'd only suggest to
enable it on non-critical systems. It is the first iteration of this
feature and it will sure have rough edges. Not for the faint hearted!

NOTE2: some of the lock-break functionality offered by the -VP patchset
is disabled if PREEMPT_REALTIME is enabled - this is temporary. This
will likely result in an increase of the maximum measured latencies.

NOTE3: since so many spinlocks are still non-mutex, even average
latencies will be well above what we could achieve - but i wanted to
reach a known-correct codebase first. For example, most of the
networking spinlocks had to be made non-mutex because of networking's
use of RCU locking primitives and per-CPU data structures. The same is
true for the VFS - many of its locks are non-mutex still due to RCU. 
Once this infrastructure work is done the size of the patch will
decrease significantly.

to build a -T4 tree from scratch the patching order is:

   http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.8.tar.bz2
 + http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.9-rc4.bz2
 + http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc4/2.6.9-rc4-mm1/2.6.9-rc4-mm1.bz2
 + http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc4-mm1-T4

	Ingo
