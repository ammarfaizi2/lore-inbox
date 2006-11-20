Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966707AbWKTUyH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966707AbWKTUyH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 15:54:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966708AbWKTUyG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 15:54:06 -0500
Received: from extu-mxob-1.symantec.com ([216.10.194.28]:23503 "EHLO
	extu-mxob-1.symantec.com") by vger.kernel.org with ESMTP
	id S966707AbWKTUyD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 15:54:03 -0500
X-AuditID: d80ac21c-a7a96bb00000207f-b2-456215eaa6e9 
Date: Mon, 20 Nov 2006 20:54:14 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: cmm@us.ibm.com, Mel Gorman <mel@skynet.ie>,
       "Martin J. Bligh" <mbligh@mbligh.org>, linux-kernel@vger.kernel.org,
       "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
Subject: Re: Boot failure with ext2 and initrds
In-Reply-To: <Pine.LNX.4.64.0611201544510.16530@blonde.wat.veritas.com>
Message-ID: <Pine.LNX.4.64.0611202031370.5912@blonde.wat.veritas.com>
References: <20061114014125.dd315fff.akpm@osdl.org> <20061114184919.GA16020@skynet.ie>
 <Pine.LNX.4.64.0611141858210.11956@blonde.wat.veritas.com>
 <20061114113120.d4c22b02.akpm@osdl.org> <Pine.LNX.4.64.0611142111380.19259@blonde.wat.veritas.com>
 <Pine.LNX.4.64.0611151404260.11929@blonde.wat.veritas.com>
 <20061115214534.72e6f2e8.akpm@osdl.org> <455C0B6F.7000201@us.ibm.com>
 <20061115232228.afaf42f2.akpm@osdl.org> <1163666960.4310.40.camel@localhost.localdomain>
 <20061116011351.1401a00f.akpm@osdl.org> <1163708116.3737.12.camel@dyn9047017103.beaverton.ibm.com>
 <20061116132724.1882b122.akpm@osdl.org> <Pine.LNX.4.64.0611201544510.16530@blonde.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 20 Nov 2006 20:54:02.0271 (UTC) FILETIME=[0239EAF0:01C70CE6]
X-Brightmail-Tracker: AAAAAA==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Nov 2006, Hugh Dickins wrote:
> 
> I'll do a little staring at the code myself: I'm unlikely to notice
> anything you've missed, but there's just a chance staring at it will
> direct me to some detail I've jotted down from before.

Not found anything relevant, but I keep noticing these lines
in ext2_try_to_allocate_with_rsv(), ext3 and ext4 similar:

		} else if (grp_goal > 0 &&
				(my_rsv->rsv_end - grp_goal + 1) < *count)
			try_to_extend_reservation(my_rsv, sb,
					*count-my_rsv->rsv_end + grp_goal - 1);

They're wrong, a no-op in most groups, aren't they?  rsv_end is an
absolute block number, whereas grp_goal is group-relative, so the
calculation ought to bring in group_first_block?  Or I'm confused.

(Whereas in my hang the grp_goal to ext2_try_to_allocate was -1
when I looked, with group 0 and num 1.)

Hugh
