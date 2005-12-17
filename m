Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751364AbVLQDdf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751364AbVLQDdf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 22:33:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751370AbVLQDdf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 22:33:35 -0500
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:3555 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751364AbVLQDdf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 22:33:35 -0500
Subject: Re: 2.6.15-rc5-rt2 slowness
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: john stultz <johnstul@us.ibm.com>,
       Gunter Ohrner <G.Ohrner@post.rwth-aachen.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <dnu8ku$ie4$1@sea.gmane.org>
References: <dnu8ku$ie4$1@sea.gmane.org>
Content-Type: text/plain
Date: Fri, 16 Dec 2005 22:33:20 -0500
Message-Id: <1134790400.13138.160.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo,

After searching all over to find out where the slowness is, I finally
discovered it.  It's the SLOB!

I noticed a that a make install of the kernel over NFS took on
2.6.15-rc5 ~26 seconds to complete, and on 2.6.15-rc5-rt2 it took almost
2 minutes for the same operation on the same machine.

I added my logdev device to record lots of output, and it found the
place that is taking the longest:

In 2.6.15-rc5-rt2:

[  789.171773] cpu:0 kfree_skbmem:291 in
[  789.171873] cpu:0 kfree_skbmem:295 1
[  789.172357] cpu:0 kfree_skbmem:320 out

in 2.6.15-rc5:

[  343.253988] cpu:0 kfree_skbmem:291 in
[  343.253990] cpu:0 kfree_skbmem:295 1
[  343.253991] cpu:0 kfree_skbmem:320 out

Here's the code for both systems (they are identical here):

void kfree_skbmem(struct sk_buff *skb)
{
	struct sk_buff *other;
	atomic_t *fclone_ref;

	edprint("in");
	skb_release_data(skb);
	switch (skb->fclone) {
	case SKB_FCLONE_UNAVAILABLE:
	edprint("1");
		kmem_cache_free(skbuff_head_cache, skb);
		break;

	case SKB_FCLONE_ORIG:
	edprint("2");
		fclone_ref = (atomic_t *) (skb + 2);
		if (atomic_dec_and_test(fclone_ref))
			kmem_cache_free(skbuff_fclone_cache, skb);
		break;

	case SKB_FCLONE_CLONE:
	edprint("3");
		fclone_ref = (atomic_t *) (skb + 1);
		other = skb - 1;

		/* The clone portion is available for
		 * fast-cloning again.
		 */
		skb->fclone = SKB_FCLONE_UNAVAILABLE;

		if (atomic_dec_and_test(fclone_ref))
			kmem_cache_free(skbuff_fclone_cache, other);
		break;
	};
	edprint("out");
}

My edprint records in a ring buffer (much like relayfs), and produces
the above output.  The time in brackets is in seconds. We see the
difference between "1" and "out" is greatly different.  (Note, I have a
edprint in all interrupts, so I would know if one was taken, and these
times are not a one time deal, but show up like this every time).

So for 2.6.15-rc5 the time difference is 343.253991 - 343.253990 or
1 usec, where as the time for 2.6.15-rc5-rt2 is 789.172357 - 789.171873
or 484 usecs!  We're talking about a 48,400% increase here!

The difference here is that the kmem_cache_free in rt is a SLOB where as
the vanilla kernel still uses SLABs,  What's the rational for SLOB now?

The patches used are here:

For the logdev device:
http://www.kihontech.com/logdev/logdev-2.6.15-rc5-rt2.patch
http://www.kihontech.com/logdev/logdev-2.6.15-rc5.patch

For debugging (on top of logdev):
http://www.kihontech.com/logdev/debug-2.6.15-rc5-rt2.patch
http://www.kihontech.com/logdev/debug-2.6.15-rc5.patch

(I also added my patches previously posted to get it to compile and
handle the softirq hrtimer problems).

Thanks,

-- Steve


