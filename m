Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422933AbWJPXhi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422933AbWJPXhi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 19:37:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750814AbWJPXhi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 19:37:38 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:43669 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750805AbWJPXhh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 19:37:37 -0400
Date: Mon, 16 Oct 2006 16:37:33 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Will Schmidt <will_schmidt@vnet.ibm.com>
cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: kernel BUG in __cache_alloc_node at linux-2.6.git/mm/slab.c:3177!
In-Reply-To: <1161031821.31903.28.camel@farscape>
Message-ID: <Pine.LNX.4.64.0610161630430.8341@schroedinger.engr.sgi.com>
References: <1160764895.11239.14.camel@farscape> 
 <Pine.LNX.4.64.0610131158270.26311@schroedinger.engr.sgi.com> 
 <1160769226.11239.22.camel@farscape> <1160773040.11239.28.camel@farscape> 
 <Pine.LNX.4.64.0610131515200.28279@schroedinger.engr.sgi.com> 
 <1161026409.31903.15.camel@farscape>  <Pine.LNX.4.64.0610161221300.6908@schroedinger.engr.sgi.com>
 <1161031821.31903.28.camel@farscape>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Oct 2006, Will Schmidt wrote:

> This is output from 2.6.18-rc2.   MemFree, MemTotal, MemUsed still
> wrong.  Node0 slab is still zero.  I've also attached the numa=debug
> boot log from this boot, in case it has any clues that were missing from
> the other boot log. 

It looks as if node 0 is allready full on bootup. The new code in 2.6.19 
controls locality in a more strict form in the slab. 2.6.18 and earlier 
were able to tolerate if a request for a page from the slab allocator for 
node 0 returns memory on node1 even if node 1 has not been bootstrapped 
yet. But this resulted in a problem in the slab because the node lists 
dedicated for node 0 now had memory from node 1 in it (which led to 
latency problems since slab code subsequently assumes that node local 
memory is very fast, which with corrupted per node lists is no longer 
true.).

You must bootstrap on a node that has memory available. If you would 
bootstrap the slab on node 1 that would work.

> Node 0 MemTotal:       229376 kB
> Node 0 MemUsed:        229376 kB

^^^^^ This node should not be full!!!

Increase memory on node 0 so that the slab can bootstrap.

