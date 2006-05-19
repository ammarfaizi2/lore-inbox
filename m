Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932201AbWESDM2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932201AbWESDM2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 23:12:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932202AbWESDM2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 23:12:28 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:5102 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932201AbWESDM1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 23:12:27 -0400
Date: Thu, 18 May 2006 20:12:07 -0700
From: Paul Jackson <pj@sgi.com>
To: David Chinner <dgc@sgi.com>
Cc: akpm@osdl.org, Simon.Derr@bull.net, linux-kernel@vger.kernel.org,
       nickpiggin@yahoo.com.au, clameter@sgi.com
Subject: Re: [PATCH 01/03] Cpuset: might sleep checking zones allowed fix
Message-Id: <20060518201207.87b6a244.pj@sgi.com>
In-Reply-To: <20060519022144.GT1390195@melbourne.sgi.com>
References: <20060518043556.15898.73616.sendpatchset@jackhammer.engr.sgi.com>
	<20060517222543.600cb20a.akpm@osdl.org>
	<20060518054750.GN1390195@melbourne.sgi.com>
	<20060518174800.f13e2c86.pj@sgi.com>
	<20060519022144.GT1390195@melbourne.sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David wrote:
> Basically, Case B falls back to case A when the cpuset is
> full. So my question really is whether we need to attempt
> to allocaate within the cpuset for GFP_ATOMIC because
> most of the time the local node will be within the cpuset
> anyway....
> 
> So that's what lead to me asking this - is there really a
> noticable distinction between A and B, or is it just
> cluttering up the code with needless complex logic?

Perhaps I'm missing something, but that's what I thought you were
asking, and that's what I tried to answer, in my last post, saying:

pj wrote:
> I suspect we could do this, and it might be a good idea.  There may
> well not be good enough reason to be making a special case of [B] above.


You sound frustrated that I am not understanding your question,
and I am feeling a little frustrated that you don't seem to have
realized that I thought I already recognized and responded to your
question, with an answer sympathetic to your concerns, and a possible
patch to address them.


David wrote:
> Why not simply check this is __cpuset_zone_allowed() and return
> true? We shouldn't put the burden of getting this right on the
> callers when it is something internal to the cpuset workings....

The callers are already conscious of whether or not they can wait.
For all of the callers of cpuset_zone_allowed() except __alloc_pages,
they can very well wait, and such a check is noise.  For __alloc_pages,
it is quite consciously managing what actions it takes based on what
can wait and what can't.

Please see my belts and suspenders metaphor in the previous message.
or the kfree analogy.

In some programming contexts, I add redundancy for robustness, and
in some contexts I minimize redundancy for lean and mean code.  The
kernel tends to be the latter, especially on important code paths.  In
particular, I have spent quite a bit of effort over the last year or
two, reducing to a minimum the number of instructions, cache lines,
locks and conditional jumps imposed on the memory allocation code path
by cpusets.


> > But what do we do if 'wait' is not set, such as when in interrupt or
> > for GFP_ATOMIC requests.  Calling cpuset_zone_allowed() is no longer
> > allowed in that case.
> 
> Sorry, I don't follow why you'd think that this would be not
> allowed. Can you explain this further?

I've probably already written enough words for today on why I suggested
having cpuset_zone_allowed() not be called if it could not wait.

And even if it could be called, say with the "__GFP_WAIT" check you
suggest, there is still the question of what kswapd daemons to wake up
when a memory allocation off an interrupt comes up short of memory on
all nodes.  Picking off the nodes in the interrupted tasks cpuset seems
to be rather arbitrary, at best.


> Why push another wait flag around when there's already one in the
> gfp_mask?

Good point - I was just in the habit of using the local variable
'wait' in the __alloc_pages code, and not re-extracting it from
gfp_mask.


-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
