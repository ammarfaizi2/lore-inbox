Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267389AbUG2A7Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267389AbUG2A7Q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 20:59:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267390AbUG2A7Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 20:59:16 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:57272 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S267389AbUG2A7F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 20:59:05 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: suparna@in.ibm.com, fastboot@osdl.org, mbligh@aracnet.com,
       linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
       jbarnes@engr.sgi.com
Subject: Re: [Fastboot] Re: Announce: dumpfs v0.01 - common RAS output API
References: <16734.1090513167@ocs3.ocs.com.au>
	<20040725235705.57b804cc.akpm@osdl.org>
	<m1r7qw7v9e.fsf@ebiederm.dsl.xmission.com>
	<200407280903.37860.jbarnes@engr.sgi.com> <25870000.1091042619@flay>
	<m14qnr7u7b.fsf@ebiederm.dsl.xmission.com>
	<20040728133337.06eb0fca.akpm@osdl.org>
	<1091044742.31698.3.camel@localhost.localdomain>
	<m1llh367s4.fsf@ebiederm.dsl.xmission.com>
	<20040728164457.732c2f1d.akpm@osdl.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 28 Jul 2004 18:58:02 -0600
In-Reply-To: <20040728164457.732c2f1d.akpm@osdl.org>
Message-ID: <m1d62f6351.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> Shutdown methods will typically call into the slab allocator and the page
> allocator to free stuff, and they are pretty common sources of oopses. 
> Often with locks held.  You run an excellent change of deadlocking.

Hmm..  Last I looked shutdown methods typically don't exist at all.
The shutdown methods are explicitly separated from the remove methods
for exactly this reason.  It is a BUG for any shutdown method to
free memory.  Their only function is to shutdown the hardware. 

> Possibly one could add
> 
> #ifdef CONFIG_WHATEVER
> 	if (unlikely(oops_in_progress))
> 		return;
> #endif
> 
> to the relevant entry points.
> 
> The shutdown routines may also call into sysfs/kobject/procfs release entry
> points, and they're even more popular oops sites.

Again.  If a shutdown method does that it is a BUG.  Only the remove method
should do that.  

If I actually believed that shutdown methods existed, and did that 
I would be in favor of writing a patch to test for any accesses of
memory management or sysfs/kobject/procfs release stuff and BUG
if it happened.

> We really want to get into the new kernel ASAP and clean stuff up from
> in there.

I agree.  However the gymnastics for doing that have not been worked out.
The drivers cannot clean up stuff yet, nor do we have a good way to run
in memory where DMA transfers on not ongoing.

So for a first pass I think calling the shutdown methods make sense.

For a second pass we need to use a relocatable that can do everything itself.
And we should run it out of a reserved area of memory.

But the first pass is worth it (at least in the kexec tree) to sort out all
of the interface issues and catch the low hanging fruit.

Eric
