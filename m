Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264110AbUDGGwj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 02:52:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264106AbUDGGwi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 02:52:38 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:63358 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S264110AbUDGGvs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 02:51:48 -0400
Date: Tue, 6 Apr 2004 23:50:00 -0700
From: Paul Jackson <pj@sgi.com>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: colpatch@us.ibm.com, wli@holomorphy.com, linux-kernel@vger.kernel.org
Subject: Re: [Patch 17/23] mask v2 = [6/7] nodemask_t_ia64_changes
Message-Id: <20040406235000.6c06af9a.pj@sgi.com>
In-Reply-To: <200404070855.03742.vda@port.imtp.ilyichevsk.odessa.ua>
References: <20040401122802.23521599.pj@sgi.com>
	<20040401131240.00f7d74d.pj@sgi.com>
	<20040406043732.6fb2df9f.pj@sgi.com>
	<200404070855.03742.vda@port.imtp.ilyichevsk.odessa.ua>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis asked:
> why such a simple thing require 700 bytes of code in the first place? 

Well ... it doesn't "require" 700 bytes of code.  But it is currently
consuming that much in this patch set, each time a for node loop is
invoked.

This is because "for_each_online_node" boils down to two copies of
"find_next_bit" (to get the first bit and then to get the next bit), and
in the file include/asm-ia64/bitops.h, find_next_bit() is the following
hefty chunk of inline code:

/*
 * Find next bit in a bitmap reasonably efficiently..
 */
static inline int
find_next_bit(const void *addr, unsigned long size, unsigned long offset)
{
        unsigned long *p = ((unsigned long *) addr) + (offset >> 6);
        unsigned long result = offset & ~63UL;
        unsigned long tmp;

        if (offset >= size)
                return size;
        size -= result;
        offset &= 63UL;
        if (offset) {
                tmp = *(p++);
                tmp &= ~0UL << offset;
                if (size < 64)
                        goto found_first;
                if (tmp)
                        goto found_middle;
                size -= 64;
                result += 64;
        }
        while (size & ~63UL) {
                if ((tmp = *(p++)))
                        goto found_middle;
                result += 64;
                size -= 64;
        }
        if (!size)
                return result;
        tmp = *p;
  found_first:
        tmp &= ~0UL >> (64-size);
        if (tmp == 0UL)         /* Are any bits set? */
                return result + size; /* Nope. */
  found_middle:
        return result + __ffs(tmp);
}

===

Some things that Matthew might want to try:
 1) Don't inline ia64 find_next_bit
 2) Hunt down and minimize uses find_next_bit (benefits more than just numamask)
 3) Instead of having the loop macro evaluate to:

	for (i = first_node(mask);  i < MAX_NUMNODES;  i = next_node(i, mask))

    rather have it evaluate something like this (node_set is more efficient):

	for (
	      ({ i = 0; while(!node_set(i, mask) && i < MAX_NUMNODES) i++; i; });
	      i < MAX_NUMNODES; 
	      ({ i++; while(!node_set(i, mask) && i < MAX_NUMNODES) i++; i; })
	)

Hmmm ... (3) looks rather nice (in an ugly sort of way ...).  It might be
worth moving lower, perhaps into bitmap, for use by both cpumask and
nodemask.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
