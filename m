Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261717AbUKOU7H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261717AbUKOU7H (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 15:59:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261711AbUKOU5j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 15:57:39 -0500
Received: from almesberger.net ([63.105.73.238]:43019 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S261712AbUKOUya (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 15:54:30 -0500
Date: Mon, 15 Nov 2004 17:54:15 -0300
From: Werner Almesberger <werner@almesberger.net>
To: Rajesh Venkatasubramanian <vrajesh@umich.edu>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Generalize prio_tree (1/3)
Message-ID: <20041115175415.X28802@almesberger.net>
References: <20041114235646.K28802@almesberger.net> <Pine.LNX.4.58.0411151226010.20003@red.engin.umich.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0411151226010.20003@red.engin.umich.edu>; from vrajesh@umich.edu on Mon, Nov 15, 2004 at 01:13:48PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rajesh Venkatasubramanian wrote:
> Again I don't like the following approach fully. I couldn't come
> out with a clean generalization something like rb_tree code.

Hmm, GET_INDEX/get_index grows and grows, and also generates a
hotspot for patch collisions ...

And what if we took the hit and moved the key into struct
prio_tree_node ? struct vm_area_struct.shared.vm_set already is
one word longer than vm_area_struct.shared.prio_tree_node, so
half of the key is free (in terms of storage - the key updates
when vm_pgoff, vm_end, or vm_start changes aren't free). The
other half could also be made free (in terms of storage and
processing) with a little tweaking, e.g.  by adding

	...
	union {
		unsigned long vm_pgoff;
		struct vm_set {
			unsigned long vm_pgoff;
			...
		} vm_set;
		struct prio_tree_node prio_tree_node;
	}
	...

#define vm_pgoff shared.vm_pgoff

(Untested. This kind of #define is of course risky, so it may be
better to just rewrite all the accesses.)

Then, we could have

	struct prio_tree_node {
		unsigned long r_index, h_index;
		...
	};

For the elevators, the keys (the "footprint" of a set of overlapping
requests) are already stored as separate variables, so that could be
migrated very easily, at no additional cost.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina     werner@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
