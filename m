Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262526AbUKBXBJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262526AbUKBXBJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 18:01:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262527AbUKBW6n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 17:58:43 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:36232 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262343AbUKBWwp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 17:52:45 -0500
Date: Tue, 02 Nov 2004 14:51:59 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Brent Casavant <bcasavan@sgi.com>
cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       hugh@veritas.com
Subject: Re: [PATCH] Use MPOL_INTERLEAVE for tmpfs files
Message-ID: <239530000.1099435919@flay>
In-Reply-To: <Pine.SGI.4.58.0411021613300.79056@kzerza.americas.sgi.com>
References: <Pine.SGI.4.58.0411011901540.77038@kzerza.americas.sgi.com><14340000.1099410418@[10.10.2.4]> <20041102155507.GA323@wotan.suse.de><40740000.1099414515@[10.10.2.4]> <Pine.SGI.4.58.0411021613300.79056@kzerza.americas.sgi.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I fully agree with Martin's statement "You WANT your data to be local."
> However, it can become non-local in two different manners, each of
> which wants tmpfs to behave differently.  (The next two paragraphs are
> simply to summarize, no position is being taken.)
> 
> The manner I'm concerned about is when a long-lived file (long-lived
> meaning at least for the duration of the run of a large multithreaded app)
> is placed in memory as an accidental artifact of the CPU which happened
> to create the file.

Agreed, I see that point - if it's a globally accessed file that's
created by one CPU, you want it spread around. However ... how the hell
is the VM meant to distinguish that? The correct way is for the application
to tell us that - ie use the NUMA API.

> Imagine, for instance, an application startup
> script copying a large file into a tmpfs filesystem before spawning
> the actual computation application itself.  There is a large class of
> HPC applications which are tightly synchronized, and which require nearly
> all of the system memory (i.e. almost all the memory on each node).
> In this case the "victim" node will be forced to go off-node for the
> bulk of its memory accesses, destroying locality, and slowing down
> the entire application.  This problem is alleviated if the tmpfs file
> is fairly well distributed across the nodes.

There are definitely situations where you'd want both, I'd agree.

> But I do understand the opposite situation.  If a lightly-threaded
> application wants to access the file data, or the application does
> not require large amounts of additional memory (i.e. nearly all the
> memory on each node) getting the file itself allocated close to the
> processor is more beneficial.  In this case the distribution of tmpfs
> pages is non-ideal (though I'm not sure it's worst-case).

Well, it's not quite worst case  ... you'll only get (n-1)/n of your pages
off node (where n is number of nodes). I guess we could deliberately
force ALL of them off-node just to make sure ;-)

>> > But that's a big ugly to distingush, that is why I suggested the sysctl.
>> 
>> As long as it defaults to off, I guess I don't really care. Though I'm still
>> wholly unconvinced it makes much sense. I think we're just papering over the
>> underlying problem - that we don't do good balancing between nodes under
>> mem pressure.
> 
> It's a tough situation, as shown above.  The HPC workload I mentioned
> would much prefer the tmpfs file to be distributed.  A non-HPC workload
> would prefer the tmpfs files be local.  Short of a sysctl I'm not sure
> how the system could make an intelligent decision about what to do under
> memory pressure -- it simply isn't knowledge the kernel can have.

It is if you tell it from the app ;-) But otherwise yes, I'd agree.
 
> I've got a new patch including Andi's suggested sysctl ready to go.
> But I've seen one vote for defaulting to on, and one for defaulting
> to off.  I'd vote for on, but then again I'm biased. :)  Who arbitrates
> this one, Hugh Dickins (it's a tmpfs change, after all)?  From SGI's
> perspective we can live with it either way; we'll simply need to
> document our recommendations for our customers.

I guess Hugh or Andrew. But I'm very relucant to see the current default
changed to benefit one particular set of workloads ... unless there's
overwhelming evidence that those workloads are massively predominant.
A per-arch thing might make sense I suppose if you're convinced that
all ia64 NUMA machines will ever run is HPC apps.

> As soon as I know whether this should default on or off, I'll post
> the new patch, including the sysctl.

Another way might be a tmpfs mount option ... I'd prefer that to a sysctl
personally, but maybe others wouldn't. Hugh, is that nuts?

M.

