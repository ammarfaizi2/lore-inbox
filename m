Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264991AbUGTAcH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264991AbUGTAcH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jul 2004 20:32:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264936AbUGTAcH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jul 2004 20:32:07 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:5020 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S264991AbUGTAcB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jul 2004 20:32:01 -0400
Date: Mon, 19 Jul 2004 17:31:45 -0700
From: Paul Jackson <pj@sgi.com>
To: ak@suse.de, linux-kernel@vger.kernel.org
Cc: Paul Jackson <pj@sgi.com>
Subject: Re: numa mm/mempolicy.c maxnode off by one
Message-Id: <20040719173145.04867dc8.pj@sgi.com>
In-Reply-To: <20040718181855.07226c74.pj@sgi.com>
References: <20040718181855.07226c74.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This seems to be undocumented ...

Actually, documented, but with text that I find misleading.

And more over a hardcoded 64 in mm/mempolicy.c that could surprise
a 32 bit user by overwriting an additional long, unexpectedly.

Presume for example I have a 32 bit system (sizeof(long) == 4), and I
have 32 nodes, numbered 0 .. 31.  Further presume that the size of the
kernel's nodemask_t is 32 bits (4 bytes).  Finally, presume that I have
a user level nodemask that is essentially a single unsigned long (32
bits).

The get_mempolicy(2) man page (numactl-0.7-pre1) states:

    maxnode is the maximum bit number plus one that can be stored
    into nodemask.  The bit number is always rounded to an multiple
    of unsigned long.

Since the highest numbered bit I can store is bit number 31, I
would expect to specify maxnode == 32 on calls.

But if I read the code correctly:

 1) I'm off by one, and should pass 33.  See further the various
    maxnode-- and maxnode-1 expressions in mm/mempolicy.c.

 2) Actually, that's wrong too.  Since the kernel doesn't round up
    by a multiple of unsigned long, but a multiple of 64, in the
    source file mm/mempolicy.c of linux version 2.6.7-mm1:

	/* Copy a kernel node mask to user space */
	static int copy_nodes_to_user(unsigned long __user *mask,
				unsigned long maxnode, void *nodes, unsigned nbytes)
	{
        	unsigned long copy = ALIGN(maxnode-1, 64) / 8;

   I had better actually have a user nodemask of 64 bits, and pass in 65.

The mbind(2) and set_mempolicy(2) state this in different words,
but words which, to me, mean pretty much the same (wrong) thing:

    nodemask is pointer to a bit field of nodes that contains upto maxnode
    bits. The bit field size is rounded to the next multiple of
    sizeof(unsigned long), but the kernel will only use bits upto maxnode.

So, in addition to suggesting that the kernel not be decrementing or
subtracting one from the passed in value of maxnode (which may require
some hackery to avoid breaking shipped libraries), I also suggest that
the allignment in copy_nodes_to_user() be to the number of bits in an
unsigned long, not to a hardcoded 64.  I speculate that without this
last change, a user on a 32 bit system such as in my example above would
be surprised when the kernel responded to their get_mempolicy request by
overwriting 64 bits where they expected to get 32 bits.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
