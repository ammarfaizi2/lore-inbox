Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264322AbUDOPlO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 11:41:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264321AbUDOPlN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 11:41:13 -0400
Received: from citrine.spiritone.com ([216.99.193.133]:40098 "EHLO
	citrine.spiritone.com") by vger.kernel.org with ESMTP
	id S264319AbUDOPlE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 11:41:04 -0400
Date: Thu, 15 Apr 2004 08:40:50 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Hugh Dickins <hugh@veritas.com>
cc: Rajesh Venkatasubramanian <vrajesh@umich.edu>,
       Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] anobjrmap 9 priority mjb tree
Message-ID: <41380000.1082043649@[10.10.2.4]>
In-Reply-To: <Pine.LNX.4.44.0404151122190.6954-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0404151122190.6954-100000@localhost.localdomain>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> FYI, even without prio-tree, I get a 12% boost from converting i_shared_sem
>> into a spinlock. I'll try doing the same on top of prio-tree next.
> 
> Good news, though not a surprise.
> 
> Any ideas how we might handle latency from vmtruncate (and
> try_to_unmap) if using prio_tree with i_shared_lock spinlock?

I've been thinking about that. My rough plan is to go wild, naked and lockless.
If we arrange things in the correct order, new entries onto the list would
pick up the truncated image of the file (so they'd be OK). Entries removed
from the list don't matter anyway. We just need to make sure that everything
that was on the list when we start does get truncated.

Basically there are two sets of operations ... ones that map and unmap
the file object (address_space) and ones that alter it - we should be
able to proceed with inserts and deletes whilst truncating, though we
probably need to protect against the alterations. The two op types could
go under separate locking.

But I need to think on it some more - would not suprise me to come to the
conclusion that I'm full of shit ;-) The opinions of others would be
very welcome ...

M.
