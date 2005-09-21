Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751376AbVIUTT5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751376AbVIUTT5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 15:19:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751381AbVIUTT5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 15:19:57 -0400
Received: from gold.veritas.com ([143.127.12.110]:12344 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S1751376AbVIUTT4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 15:19:56 -0400
Date: Wed, 21 Sep 2005 20:19:31 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Frank van Maarseveen <frankvm@frankvm.com>
cc: Jay Lan <jlan@engr.sgi.com>, Christoph Lameter <clameter@engr.sgi.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.14-rc2] fix incorrect mm->hiwater_vm and mm->hiwater_rss
In-Reply-To: <20050921182627.GB17272@janus>
Message-ID: <Pine.LNX.4.61.0509211958410.10449@goblin.wat.veritas.com>
References: <20050921121915.GA14645@janus> <Pine.LNX.4.61.0509211515330.6114@goblin.wat.veritas.com>
 <43319111.1050803@engr.sgi.com> <Pine.LNX.4.61.0509211802150.8880@goblin.wat.veritas.com>
 <4331990A.80904@engr.sgi.com> <Pine.LNX.4.61.0509211835190.9340@goblin.wat.veritas.com>
 <4331A0DA.5030801@engr.sgi.com> <20050921182627.GB17272@janus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 21 Sep 2005 19:19:56.0008 (UTC) FILETIME=[733ACE80:01C5BEE1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Sep 2005, Frank van Maarseveen wrote:
> 
> What about calling
> 
> static inline void grow_total_vm(struct mm_struct *mm, unsigned long increase)
> {
> 	mm->total_vm += increase;
> 	if (mm->total_vm > mm->hiwater_vm)
> 		mm->hiwater_vm = mm->total_vm;
> }
> 
> whenever total_vm is increased and possibly doing something similar for rss at
> different places? If it is not on the fast path then it's not necessary to
> #ifdef the thing anywhere.

I think there's a good argument for separating hiwater_vm and hiwater_rss
completely (and you don't seem to be interested in hiwater_rss yourself).

hiwater_rss is on some fast paths: well, I don't see them as fast paths
myself (the page faults), but they are of exceptional concern to Christoph,
and the less we have to mess with struct mm at those points the happier he
is.  I guess hiwater_rss should remain updated from the timer tick for now.

But I think you're right that hiwater_vm is best updated where total_vm
is: I'm not sure if it covers all cases completely (I think there's one
or two places which don't bother to call __vm_stat_account because they
believe it won't change anything), but in principle it would make lots of
sense to do it in the __vm_stat_account which typically follows adjusting
total_vm, as you did, and if possible nowhere else; rather than adding
your inline above.

Would you be satisfied with that, Christoph?

I should warn you that I'll shortly (shortly meaning in days rather
than hours) be sending Andrew a patch which will remove the "__" from
__vm_stat_account, since the old vm_stat_account is now hardly used.
I'm also rearranging the rss,anon_rss accounting.  Maybe come back
to the hiwaters later on?

Hugh
