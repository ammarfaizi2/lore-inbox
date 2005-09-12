Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751256AbVILJ02@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751256AbVILJ02 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 05:26:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751258AbVILJ02
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 05:26:28 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:3566 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751256AbVILJ01 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 05:26:27 -0400
Date: Mon, 12 Sep 2005 02:26:15 -0700
From: Paul Jackson <pj@sgi.com>
To: "Andi Kleen" <ak@suse.de>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [2/3] {PREFIX:-x86_64}: Convert mempolicies to nodemask_t
Message-Id: <20050912022615.0140cc64.pj@sgi.com>
In-Reply-To: <4322CA79.mailAO51VX9XB@suse.de>
References: <4322CA79.mailAO51VX9XB@suse.de>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi wrote:
> Convert mempolicies to nodemask_t

Good.

Minor comments as I read the patch.

 1) Can the include of 'linux/bitmap.h' be removed from the file
    linux/include/linux/mempolicy.h?

 2) /* AK: shouldn't this error out instead? */
    Andi add the above comment on a cpuset_restrict_to_mems_allowed()
    call.

    The question is this - if an app tries to use mbind/set_mempolicy
    to ask for some memory nodes, some of which are allowed in
    their current cpuset, and some of which are outside that cpuset,
    should the kernel silently trim their request to those allowed
    in the cpuset, or should the kernel complain because some of the
    requested memory nodes are not allowed.

    My guess is that Andi is right (kernel should error), and it was
    my unrelenting drive to trim to an absolute minimum the size of
    the cpuset impact on the mempolicy code that led me to the other
    answer (trim silently).

    I suppose I should conjure up a patch that changes this, to what
    Andi suspects is the proper way.

 3) Either this current patch of Andi's, or the patch considered for (2)
    above should also convert whatever kernel/cpuset.c call the mempolicy.c
    code is making from bitmaps to nodemasks, rather than convert to bitmaps
    across the boundary:

	cpuset_restrict_to_mems_allowed(nodes_addr(*nodes));

 4) Should the following line:

	+	PDprintk("setting mode %d nodes[0] %lx\n", mode, nodes_addr(nodes)[0]);

    instead be:

	+	PDprintk("setting mode %d nodes[0] %lx\n", mode, nodes_addr(*nodes)[0]);

 
  5) If anyone ever (even for debugging) adds something to the nodemask_t structure,
     then the following line in sys_get_mempolicy() will die a horrible death:

	+		err = copy_nodes_to_user(nmask, maxnode, &nodes, sizeof(nodes));

     In this, 'nodes' is of type nodemask_t.  The address of the bits in a nodemask_t
     is properly obtained using the nodes_addr() macro, not '&nodes', and the number of
     bytes in those bits is 'BITS_TO_LONGS(MAX_NUMNODES) * sizeof(unsigned long)', not
     'sizeof(nodes)'.

 6) How come I don't see changes for the 'compat_sys_get_mempolicy()' routine?

 7) Do -not- add one for the next node in interleave_nodes():

	+	next = next_node(1+nid, policy->v.nodes);

    The next_node() macro, unlike the find_next_bit() macro, already adds one.
    Off hand, that seems like an annoying inconsistency.  But since I may well
    be the person that introduced it, I'd rather not think about it too much ;).

 8) Ditto (7), in offset_il_node():

	+		nid = next_node(nid+1, pol->v.nodes);


Otherwise, looks good.


-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
