Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267333AbUJGK4q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267333AbUJGK4q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 06:56:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269793AbUJGK4q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 06:56:46 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:10896 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S267333AbUJGK4e
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 06:56:34 -0400
Message-Id: <200410071053.i97ArLnQ011548@owlet.beaverton.ibm.com>
To: Paul Jackson <pj@sgi.com>
cc: colpatch@us.ibm.com, mbligh@aracnet.com, Simon.Derr@bull.net,
       pwil3058@bigpond.net.au, frankeh@watson.ibm.com, dipankar@in.ibm.com,
       akpm@osdl.org, ckrm-tech@lists.sourceforge.net, efocht@hpce.nec.com,
       lse-tech@lists.sourceforge.net, hch@infradead.org, steiner@sgi.com,
       jbarnes@sgi.com, sylvain.jeaugey@bull.net, djh@sgi.com,
       linux-kernel@vger.kernel.org, ak@suse.de, sivanich@sgi.com
Subject: Re: [Lse-tech] [PATCH] cpusets - big numa cpu and memory placement 
In-reply-to: Your message of "Thu, 07 Oct 2004 01:51:07 PDT."
             <20041007015107.53d191d4.pj@sgi.com> 
Date: Thu, 07 Oct 2004 03:53:21 -0700
From: Rick Lindsley <ricklind@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    > I don't see what non-exclusive cpusets buys us.
    
    One can nest them, overlap them, and duplicate them ;)
    
    For example, we could do the following:

Once you have the exclusive set in your example, wouldn't the existing
functionality of CKRM provide you all the functionality the other
non-exclusive sets require?

Seems to me, we need a way to *restrict use* of certain resources
(exclusive) and a way to *share use* of certain resources (non-exclusive.)
CKRM does the latter right now, I believe, but not the former. (Does
CKRM support sharing hierarchies as in the dept/group/individual example
you used?)

What about this model:

    * All exclusive sets exist at the "top level" (non-overlapping,
      non-hierarchical) and each is represented by a separate sched_domain
      hierarchy suitable for the hardware used to create the cpuset.
      I can't imagine anything more than an academic use for nested
      exclusive sets.

    * All non-exclusive sets are rooted at the "top level" but may
      subdivide their range as needed in a tree fashion (multiple levels
      if desired).  Right now I believe this functionality could be
      provided by CKRM.

Observations:

    * There is no current mechanism to create exclusive sets; cpus_allowed
      alone won't cut it.  A combination of Matt's patch plus Paul's
      code could probably resolve this.

    * There is no clear policy on how to amiably create an exclusive set.
      The main problem is what to do with the tasks already there.
      I'd suggest they get forcibly moved.  If their current cpus_allowed
      mask does not allow them to move, then if they are a user process
      they are killed.  If they are a system process and cannot be
      moved, they stay and gain squatter's rights in the newly created
      exclusive set.

    * Interrupts are not under consideration right now. They land where
      they land, and this may affect exclusive sets.  If this is a
      problem, for now, you simply lay out your hardware and exclusive
      sets more intelligently.

    * Memory allocation has a tendency and preference, but no hard policy
      with regards to where it comes from.  A task which starts on one
      part of the system but moves to another may have all its memory
      allocated relatively far away.  In unusual cases, it may acquire
      remote memory because that's all that's left.  A memory allocation
      policy similar to cpus_allowed might be needed. (Martin?)

    * If we provide a means for creating exclusive sets, I haven't heard
      a good reason why CKRM can't manage this.

Rick
