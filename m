Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268184AbUJDP0K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268184AbUJDP0K (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 11:26:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268189AbUJDP0K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 11:26:10 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:34533 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S268184AbUJDP0E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 11:26:04 -0400
Date: Mon, 4 Oct 2004 08:23:51 -0700
From: Paul Jackson <pj@sgi.com>
To: Erich Focht <efocht@hpce.nec.com>
Cc: frankeh@watson.ibm.com, akpm@osdl.org, nagar@watson.ibm.com,
       ckrm-tech@lists.sourceforge.net, mbligh@aracnet.com,
       lse-tech@lists.sourceforge.net, hch@infradead.org, steiner@sgi.com,
       jbarnes@sgi.com, sylvain.jeaugey@bull.net, djh@sgi.com,
       linux-kernel@vger.kernel.org, colpatch@us.ibm.com, Simon.Derr@bull.net,
       ak@suse.de, sivanich@sgi.com
Subject: Re: [Lse-tech] [PATCH] cpusets - big numa cpu and memory placement
Message-Id: <20041004082351.5c111aa2.pj@sgi.com>
In-Reply-To: <200410041615.24384.efocht@hpce.nec.com>
References: <20040805100901.3740.99823.84118@sam.engr.sgi.com>
	<200410032221.26683.efocht@hpce.nec.com>
	<416156E8.7060708@watson.ibm.com>
	<200410041615.24384.efocht@hpce.nec.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erich, responding to Hubertus:
> > (a) is it a guarantee/property that cpusets at with the same
> >      parent cpuset do not overlap ?
> 
> Right now it isn't AFAIK. Paul, if all cpusets on the same level are
> disjunct this certainly simplifies life. Would this be a too strong
> limitation for you? We could live with it.

Correct, Erich, it is not a guarantee that sibling cpusets don't
overlap, unless, as Simon noted, they are all marked exclusive.

Yes, it would be a stronger limitation than I would agree to, but that's
ok, because in my humble opinion, CKRM doesn't need it to operate within
cpusets.

I think what's needed for CKRM to operate within cpusets is clear
ownership.

Each instance of CKRM needs (tell me if I'm wrong here):
 1) to have a clear and unambiguous answer to the question of
    which CPUs, which Memory Nodes, and which Tasks it is
    controlling,
 2) no overlap of these sets with another instance of CKRM,
 3) the CPUs and Memory Nodes on which any of these Tasks are
    allowed to run must be a subset of those controlled by
    this instance of CKRM, and
 4) all Tasks allowed to run on any of the CPUs and Memory
    Nodes controlled by this CKRM instance are in the list
    of Tasks this CKRM knows it controls.

In short - each CKRM instance needs clear, unambiguous, non-overlapping
ownership of all it surveys.

Requesting that all cpusets be marked exclusive for both CPU and Memory
is an overzealous precondition for the above.

Another way to obtain the above requirements would be to assign each
CKRM instance to a separate cpuset subtree, where the root of the
subtree is marked exclusive for cpu and memory, where that CKRM instance
controls all CPUs and Memory owned by that subtree and all Tasks
attached to any cpuset in that subtree, and where any tasks attached to
ancestors of the root are either (1) not allowed to use any of the CPUs
and Memory assigned to the subtree, or (2) are both [2a] allowed to use
only some subset of the CPUs and Memory assigned to the subtree and [2b]
are included in the list of tasks to be managed by that CKRM instance.

(The last 4.5 lines above are the special case required to handle the
indigenous per-cpu tasks, such as the migration threads - sorry.)

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
