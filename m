Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932270AbWKJJnJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932270AbWKJJnJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 04:43:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946223AbWKJJnJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 04:43:09 -0500
Received: from pfx2.jmh.fr ([194.153.89.55]:13192 "EHLO pfx2.jmh.fr")
	by vger.kernel.org with ESMTP id S932270AbWKJJnG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 04:43:06 -0500
From: Eric Dumazet <dada1@cosmosbay.com>
To: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] x86_64: Make the NUMA hash function nodemap allocation dynamic and remove NODEMAPSIZE
Date: Fri, 10 Nov 2006 10:43:14 +0100
User-Agent: KMail/1.9.5
Cc: Amul Shah <amul.shah@unisys.com>, LKML <linux-kernel@vger.kernel.org>
References: <1163029076.3553.36.camel@ustr-linux-shaha1.unisys.com> <200611100748.30889.ak@suse.de>
In-Reply-To: <200611100748.30889.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611101043.14749.dada1@cosmosbay.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 10 November 2006 07:48, Andi Kleen wrote:

> Have you checked how much the code .text size changes because
> of the pointer reference? If it's a lot phys_to_nid might need to
> be out of lined.

Here I have also big numbers on pfn_to_page(), on a machine with mapsize=1  
(NUMA kernel, but one node)

oprofile results L1_AND_L2_DTLB_MISSES /usr/src/linux-2.6.18/vmlinux

Counted L1_AND_L2_DTLB_MISSES events (L1 and L2 DTLB misses) with a unit mask 
of 0x00 (No unit mask) count 10000 

ffffffff80258fa0 <pfn_to_page>: /* pfn_to_page total:  48433  0.4914 */

So adding yet another indirection (to a another cache line) might hurt.

Therefore I suggest to use a structure like that :

struct memnode {
 	int shift;
	unsigned int mapsize; /* no need to use 8 bytes here */
	u8 *map;
	u8 embedded_map[64-8]; /* total size = 64 bytes */
 } ____cacheline_aligned;

and make memnode.map point to memnode.embedded_map if mapsize <= 56 ?

This way, most AMD64 dual/quad processors wont waste a full PAGE to store few 
bytes in it, and should use only one cache line.

Thank you

Eric
