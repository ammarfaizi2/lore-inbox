Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267935AbUJDOIr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267935AbUJDOIr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 10:08:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267951AbUJDOIr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 10:08:47 -0400
Received: from mail01.hpce.nec.com ([193.141.139.228]:36036 "EHLO
	mail01.hpce.nec.com") by vger.kernel.org with ESMTP id S267935AbUJDOIm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 10:08:42 -0400
From: Erich Focht <efocht@hpce.nec.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [Lse-tech] [PATCH] cpusets - big numa cpu and memory placement
Date: Mon, 4 Oct 2004 16:05:30 +0200
User-Agent: KMail/1.6.2
Cc: pj@sgi.com, nagar@watson.ibm.com, ckrm-tech@lists.sourceforge.net,
       mbligh@aracnet.com, lse-tech@lists.sourceforge.net, hch@infradead.org,
       steiner@sgi.com, jbarnes@sgi.com, sylvain.jeaugey@bull.net, djh@sgi.com,
       linux-kernel@vger.kernel.org, colpatch@us.ibm.com, Simon.Derr@bull.net,
       ak@suse.de, sivanich@sgi.com
References: <20040805100901.3740.99823.84118@sam.engr.sgi.com> <200410032221.26683.efocht@hpce.nec.com> <20041003134842.79270083.akpm@osdl.org>
In-Reply-To: <20041003134842.79270083.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200410041605.30395.efocht@hpce.nec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 03 October 2004 22:48, Andrew Morton wrote:
> Erich Focht <efocht@hpce.nec.com> wrote:
> >  Can CKRM be extended to do what cpusets do? 
> > 
> >  Certainly. Probably easilly. But cpusets will have to be reinvented, I
> >  guess. Same hooks, same checks, different user interface...
> 
> Well if it is indeed the case that the CKRM *framework* is up to the task
> of being used to deliver the cpuset functionality then that's the way we
> should go, no?  It's more work and requires coordination and will deliver
> later, but the eventual implementation will be better.
> 
> But I'm still not 100% confident that the CKRM framework is suitable. 
> Mainly because the CKRM and cpuset teams don't seem to have looked at each
> other's stuff enough yet.

My optimistic assumption that it is easy to build cpusets into CKRM is
only valid for adding a cpuset controller into the CKRM framework and
forgetting about the other controllers. The problems start with the
other controllers... As Hubertus said: CKRM and cpusets are
orthogonal.

Now CKRM consists of a set of more or less independent (orthogonal)
controllers. There is a cpu cycles and memory controller. Their aims
are different from that of cpuset and they cannot fulfil the
requirements of cpusets. But they make sense for themselves.

Adding cpusets as another special resource controller is fine but
breaks the requirement of having independent controllers. With this we
suddenly have two ways of controlling cpu and memory assignment. As
discussed previously in this thread it probably makes more sense to
let the old CKRM controllers manage resources inside each cpuset (at
certain level in the cpusets tree). One could even imagine switching
off the CKRM controllers in particular sets. The old cpucycles and
memory controllers will not be able to influence cycles and memory
distribution outside a cpuset, anyway, because these are hardly
limited by the affinity masks. So adding cpusets into CKRM must lead
to dependent controllers and a hierarchy between them (cpusets being
above the old controllers). This is indeed difficult but Dipankar
mentioned that CKRM people think about such a design (if I interpreted
his email correctly).

If CKRM sticks at the requirement for independent controllers (which
is clean in design and has been demonstrated to work) then it should
maybe first learn to run in an arbitrary cpuset and ignore the rest of
the machine. Having separate CKRM instances running in each partition
of a machine soft-partitioned with cpusets could be a target.

If CKRM wants to be a universal resource controller in the kernel then
a resource dependency tree and hierarchy might need to get somehow
into the CKRM infrastructure. The cpu cycles controller should notice
that there is another controller above it (cpusets) and might ask
that controller which processes it should take into account for its
job. The memory controller might get a different answer... Uhmmm, this
looks like a difficult problem.

Regards,
Erich

