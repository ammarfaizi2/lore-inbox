Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932651AbVISV5P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932651AbVISV5P (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 17:57:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932666AbVISV5P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 17:57:15 -0400
Received: from cantor2.suse.de ([195.135.220.15]:12181 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932651AbVISV5O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 17:57:14 -0400
From: Andi Kleen <ak@suse.de>
To: Christoph Lameter <clameter@engr.sgi.com>
Subject: Re: NUMA mempolicy /proc code in mainline shouldn't have been merged
Date: Mon, 19 Sep 2005 23:56:55 +0200
User-Agent: KMail/1.8
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
References: <200509101120.19236.ak@suse.de> <20050919194038.GB12810@verdi.suse.de> <Pine.LNX.4.62.0509191426250.26388@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.62.0509191426250.26388@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509192356.56300.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 19 September 2005 23:32, Christoph Lameter wrote:
> On Mon, 19 Sep 2005, Andi Kleen wrote:
> > On Mon, Sep 19, 2005 at 10:11:20AM -0700, Christoph Lameter wrote:
> > > However, one still does not know which memory section (vma) is
> > > allocated on which nodes. And this may be important since critical data
> > > may need to
> >
> > Maybe. Well sure of things could be maybe important. Or maybe not.
> > Doesn't seem like a particularly strong case to add a lot of ugly
> > code though.
>
> We gradually need to fix the deficiencies of the policy layer. Calling
> fixes "ugly code" and refusing to discuss solutions does not help anyone.

I'm happy to discuss solutions given a clear use case what you want
to do, why you want to do it etc. 

> > > External memory policy management is a necessary feature for system
> > > administration, batch process scheduling as well as for testing and
> > > debugging a system.
> >
> > I'm not convinced of this at all. Most of these things proposed so far
> > can be done much simpler with 90% of the functionality (e.g. just swapoff
> > per process for migration) , and I haven't seen a clear rationale except
> > for lots of maybes that the missing 10% are worth all the complexity
> > you seem to plan to add.
>
> Have you ever had the challenge to work with large HPC applications on a
> large NUMA system? 

Ah - my code is better because my credentials are better. Maybe better than
maybe... I did only some tuning on large systems, but I spent quite some time 
tuning NUMA code on small NUMA systems. Also  I did spent a bit of time 
looking at some of the tools offered by other Unixes and it left the clear 
impression that they were far too complex and shouldn't be emulated in Linux.

The existing NUMA API was designed by keeping things relatively
simple (in fact my experience so far was that most users only
want to have the most simple of its policies - even the moderately
fancy stuff in there seems to  be rarely used) so I think the bar
for more NUMA policy should be set extremly high and everything
come with extremly good rationales.

> Which things? Many HPC apps do not use swap space 
> at all and we likely wont be using swap for page migration 

Yes that was a lot of quite complicated code that seemed to me
quite overkill for its job.

Regarding swap: surely you know swapping doesn't necessarily
write to disk but first put stuff into the swap cache (we even
talked about that in Ottawa). So the plan would be to first
implement swapoff_process() that writes out to disk. And then
if someone really comes up with a clear case where this doesn't work
for them this can be extended to migrate directly out of the swap
cache missing the IO step.

-Andi
