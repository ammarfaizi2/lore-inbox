Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932198AbWESC3T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932198AbWESC3T (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 22:29:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932194AbWESC3T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 22:29:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:62885 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932182AbWESC3S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 22:29:18 -0400
From: Neil Brown <neilb@suse.de>
To: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 19 May 2006 12:28:50 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17517.11618.885744.164970@cse.unsw.edu.au>
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
       dan.j.williams@gmail.com, daniel.j.thompson@intel.com,
       Chris Leech <christopher.leech@intel.com>
Subject: Re: [RFC][PATCH] MD RAID Acceleration: Move stripe operations outside
	the spin lock
In-Reply-To: message from Dan Williams on Tuesday May 16
References: <1147818171.18360.14.camel@dwillia2-linux.ch.intel.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday May 16, dan.j.williams@intel.com wrote:
> This is the second revision of the effort to enable offload of MD's xor
> and copy operations to dedicated hardware resources.  Please comment on
> the approach of this patch and whether it will be suitable to expand
> this to the other areas in handle_stripe where such calculations are
> performed.  Implementation of the xor offload API is a work in progress,
> the intent is to reuse I/OAT.
> 
> Overview:
> Neil, as you recommended, this implementation flags the necessary
> operations on a stripe and then queues the execution to a separate
> thread (similar to how disk cycles are handled).  See the comments added
> to raid5.h for more details.

Hi.

This certainly looks like it is heading in the right direction - thanks.

I have a couple of questions, which will probably lead to more.

You obviously need some state-machine functionality to oversee the
progression like  xor - drain - xor (for RMW) or clear - copy - xor
(for RCW).
You have encoded the different states on a per block basis (storing it
in sh->dev[x].flags) rather than on a per-strip basis (and so encoding
it in sh->state).
What was the reason for this choice?

The only reason I can think of is to allow more parallelism :
different blocks within a strip can be in different states.  I cannot
see any value in this as the 'xor' operation will work across all
(active) blocks in the strip and so you will have to synchronise all
the blocks on that operation.

I feel the code would be simpler if the state was in the strip rather
than the block.

The wait_for_block_op queue and it's usage seems odd to me.
handle_stripe should never have to wait for anything.
when a block_op is started, the sh->count should be incremented, and
the decremented when the block-ops have finished.  Only when will
handle_stripe get to look at the stripe_head again.  So waiting
shouldn't be needed.

Your GFP_KERNEL kmalloc is a definite no-no which can lead to
deadlocks (it might block while trying to write data out thought the
same raid array).  At least it should be GFP_NOIO.
However a better solution would be to create and use a mempool - they
are designed for exactly this sort of usage.
However I'm not sure if even that is needed.  Can a stripe_head have
move than one active block_ops task happening?  If not, the
'stripe_work' should be embedded in the 'stripe_head'.

There will probably be more questions once these are answered, but as
the code is definitely a good start.

Thanks,
NeilBrown


(*) Since reading the DDF documentation again, I've realised that
using the word 'stripe' both for a chunk-wide stripe and a block-wide
stripe is very confusing.  So I've started using 'strip' for a
block-wide stripe.  Thus a 'stripe_head' should really be a
'strip_head'.

I hope this doesn't end up being even more confusing :-)
