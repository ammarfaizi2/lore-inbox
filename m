Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751230AbVIWAZ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751230AbVIWAZ5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 20:25:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751234AbVIWAZ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 20:25:57 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:64955 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S1751230AbVIWAZ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 20:25:56 -0400
Message-ID: <43334B92.8010800@vc.cvut.cz>
Date: Fri, 23 Sep 2005 02:25:54 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050802 Debian/1.7.10-1
X-Accept-Language: en
MIME-Version: 1.0
To: Christoph Lameter <clameter@engr.sgi.com>
CC: Andrew Morton <akpm@osdl.org>, alokk@calsoftinc.com,
       linux-kernel@vger.kernel.org, manfred@colorfullife.com
Subject: Re: 2.6.14-rc1-git-now still dying in mm/slab - this time line 1849
References: <4329A6A3.7080506@vc.cvut.cz> <20050916023005.4146e499.akpm@osdl.org> <432AA00D.4030706@vc.cvut.cz> <20050916230809.789d6b0b.akpm@osdl.org> <432EE103.5020105@vc.cvut.cz> <20050919112912.18daf2eb.akpm@osdl.org> <Pine.LNX.4.62.0509191141380.26105@schroedinger.engr.sgi.com> <20050919122847.4322df95.akpm@osdl.org> <Pine.LNX.4.62.0509191351440.26388@schroedinger.engr.sgi.com> <20050919221614.6c01c2d1.akpm@osdl.org> <43301578.8040305@vc.cvut.cz> <Pine.LNX.4.62.0509201800460.6792@schroedinger.engr.sgi.com> <4330B5C2.3080300@vc.cvut.cz> <Pine.LNX.4.62.0509210856410.10272@schroedinger.engr.sgi.com> <Pine.LNX.4.62.0509221250120.17975@schroedinger.engr.sgi.com> <20050922130150.0822b882.akpm@osdl.org> <43332161.20806@vc.cvut.cz> <20050922144619.05bebbbb.akpm@osdl.org> <Pine.LNX.4.62.0509221448360.18810@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.62.0509221448360.18810@schroedinger.engr.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:
> On Thu, 22 Sep 2005, Andrew Morton wrote:
> 
> 
>>Great, thanks.   Christoph, was that patch the final official version?
> 
> 
> This should deal with the node ownership issue. So yes.
> 
> I still have some open question on how pages ended up on the wrong node.
> This should only happen if a zone / node has run out of memory. If pages 
> ended up on the wrong node without that then there may be a different 
> issue still to be fixed.
> 
> Maybe Petr can give us some more details on when the problem occurs?

Problem seems to happen immediately, and just first run of cache_reap
(2 seconds after eventd initializes if I understand it correctly) already
finds problem.

But I'm confused.  I've just added code which is supposed to verify all
additions to the cache entry[] (http://platan.vc.cvut.cz/verify-all-entry-add.diff)
on the top of Christoph patch to catch one which later causes problem in cache_reap,
and it logs nothing at the time crash was happening :-(  Only incident it logs is
"while (batchcount > 0)" loop in cache_alloc_refill, saying that

objp ffff81007ffd9430 belonging to the slab ffff81007ffd9000 which belongs
    to node 1 was added to array_cache belonging to node 0 (called from
    ffffffff8016e4a9)  (mm/slab.c ~ line 2430)
... cache avc_node

This repeats couple of times, for avc_node, mnt_cache, proc_inode_cache
and bdev_cache.  Nothing else.

So I've reverted your fix, and still I did not catch offender, so I'm probably
missing some place which populates array_cache entry[] :-(

Only if after I added logging to free_block() I was able to find that offender is
proc_inode_cache.  But I have no idea how this object appeared in the incorrect
node cache...
								Petr

