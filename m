Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267653AbUIUNHQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267653AbUIUNHQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 09:07:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267666AbUIUNHQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 09:07:16 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:34787 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S267653AbUIUNHL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 09:07:11 -0400
Message-ID: <4150282B.4090808@sgi.com>
Date: Tue, 21 Sep 2004 08:10:03 -0500
From: Ray Bryant <raybry@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       Ray Bryant <raybry@austin.rr.com>, linux-mm <linux-mm@kvack.org>,
       Jesse Barnes <jbarnes@sgi.com>, Dan Higgins <djh@sgi.com>,
       lse-tech <lse-tech@lists.sourceforge.net>,
       Brent Casavant <bcasavan@sgi.com>, Nick Piggin <piggin@cyberone.com.au>,
       linux-kernel <linux-kernel@vger.kernel.org>, Paul Jackson <pj@sgi.com>,
       Dave Hansen <haveblue@us.ibm.com>, stevel@mwwireless.net
Subject: Re: [PATCH 2.6.9-rc2-mm1 0/2] mm: memory policy for page cache allocation
References: <20040920190033.26965.64678.54625@tomahawk.engr.sgi.com> <20040920205509.GF4242@wotan.suse.de> <414F560E.7060207@sgi.com> <20040920223742.GA7899@wotan.suse.de> <414F8424.5080308@sgi.com> <20040921091353.GG8058@wotan.suse.de> <20040921093316.GG9106@holomorphy.com>
In-Reply-To: <20040921093316.GG9106@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> On Mon, Sep 20, 2004 at 08:30:12PM -0500, Ray Bryant wrote:
> 
>>>I'm sorry if this is confusing, personal terminology usually gets in the 
>>>way.
>>>The idea is that just like for the page allocation policy (your current 
>>>code), if you wanted, you would have a global, default page cache 
>>
> On Tue, Sep 21, 2004 at 11:13:54AM +0200, Andi Kleen wrote:
> 
>>Having both a per process page cache and a global page cache policy
>>would seem like overkill to me.
>>And having both doesn't make much sense anyways, because when the 
>>system admin wants to change the global policy to free memory
>>on nodes he would still need to worry about conflicting per process policies 
>>anyways. So as soon as you have process policy you cannot easily
>>change global anymore.
>

(Andi,)

I don't think the requirement is so much to be able to dynamically change
policies while the system is running, I think that the requirement is to be
able to set the global policy at boot time or near then.  We don't want to
have to recompile the kernel to boot it for a webserver or fileserver (likely 
local page cache allocation) versus an HPC system (likely round robin
page cache allocation policy).

The rationale for the local policy is partially implementation (see below),
and thinking that even on your big HPC system, some processes in some cpusets
might be running a file server application, and they would want local
allocation.  Having said that, of course, begs the question as to whether we
need a per cpuset policy, I suppose.  But read on for the implemenation
argument, and if that is not persuasive, then I'll go with a global only
policy and see where that leads.

> 
> Ray, would being able to change the default policy via kernel command-
> line options (and perhaps sysctl) suffice? It seems that a global
> default and some global state (e.g. per-cpu state) should largely
> capture what you're after. If not, could you clarify where it doesn't?
> 

Bill,

That would capture most of our requirements, I think.  Part of the reason
for doing a global and local policy is that is the way that the code works 
now, and all I did was piggyback on that.  So, because there is a global
policy with a per process override for the existing page allocation policy,
you get a similiar structure for the page cache policy.

The overhead is an additional word per task structure, an additional
mempolicy copy (if there is a per process page cache allocation policy)
and structure, plus some code that looks like this in alloc_pages_by_policy():

struct page *
alloc_pages_by_policy(unsigned gfp, unsigned order, unsigned policy)
  {

        struct mempolicy *pol;

        if (policy >= NR_MEM_POLICIES)
                BUG();
        pol = current->mempolicy[policy];
        if (!pol)
                pol = default_policy[policy];
. . .

Som it is elegant that way and readily allows for additional memory
allocation cases (slab cache, anyone?).

> Also, this switch statement stuff is getting a little hairy; maybe
> it's time to bring in mempolicy_ops. Or at least trudging through the
> switch () statements is turning into a moderate amount of work for me.
> 
> 
> -- wli
> 

Yes, it is getting a little out of hand.  However, if we can get by without
the MEMPOL_ROUNDROBIN, we are back to where we were there.

-- 
Best Regards,
Ray
-----------------------------------------------
                   Ray Bryant
512-453-9679 (work)         512-507-7807 (cell)
raybry@sgi.com             raybry@austin.rr.com
The box said: "Requires Windows 98 or better",
            so I installed Linux.
-----------------------------------------------

