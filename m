Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263448AbTDNP2k (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 11:28:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263469AbTDNP2k (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 11:28:40 -0400
Received: from franka.aracnet.com ([216.99.193.44]:33712 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S263448AbTDNP2i (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Apr 2003 11:28:38 -0400
Date: Mon, 14 Apr 2003 08:39:05 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Antonio Vargas <wind@cocodriloo.com>
cc: Timothy Miller <tmiller10@cfl.rr.com>, linux-kernel@vger.kernel.org,
       nicoya@apia.dhs.org
Subject: Re: Quick question about hyper-threading (also some NUMA stuff)
Message-ID: <12790000.1050334744@[10.10.2.4]>
In-Reply-To: <20030414152947.GB14552@wind.cocodriloo.com>
References: <001301c3028a$25374f30$6801a8c0@epimetheus> <10760000.1050332136@[10.10.2.4]> <20030414152947.GB14552@wind.cocodriloo.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Perhaps it would be good to un-COW pages:
> 
> 1. fork process
> 2. if current node is not loaded, continue as usual
> 3. if current node is loaded:
> 3a. pick unloaded node
> 4b. don't do COW for data pages, but simply copy them to node-local memory
> 
> This way, read-write sharings would be replicated for each node.

Sharing read-write stuff is a total nightmare - you have to deal with
all the sync stuff, and invalidation. In real-life scenarios, I really
doubt the complexity is worth it - read-only is quite complex enough,
thanks ;-) 

Theoretically, if you had some pages that were predominatly read-only, 
and very occasionally got written to, it *might* be worth it. 
But probably not ;-)

> Also, keeping an per-node active-page-list and then forcefully copying
> the page to a node-local page-frame when accesing a page which is
> active on another node could be good.

Not sure what you mean by this. wrt the active-page list here's a per-node 
LRU already. Or you mean something on a per-address-space basis?

Yes, faulting the pages in lazily from another node as we touch them is 
probably the right thing to do. Giving secondary copies some LRU disadvantage
(perhaps always keeping them on the inactive list, never the active),
would be fun, but then you get into the whole "who is the primary owner,
and what do we do when they ditch the page" complexity. The node bitmap
I suggested earlier might help. But I'd rather keep it simple at first ;-)

M.
