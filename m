Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283976AbRLAFnh>; Sat, 1 Dec 2001 00:43:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283977AbRLAFn2>; Sat, 1 Dec 2001 00:43:28 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:60433 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S283976AbRLAFnV>; Sat, 1 Dec 2001 00:43:21 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: 2.5.1-pre5 not easy to boot with devfs
Date: Sat, 1 Dec 2001 05:37:32 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <9u9qas$1eo$1@penguin.transmeta.com>
In-Reply-To: <3C085FF3.813BAA57@wanadoo.fr>
X-Trace: palladium.transmeta.com 1007185378 6702 127.0.0.1 (1 Dec 2001 05:42:58 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 1 Dec 2001 05:42:58 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3C085FF3.813BAA57@wanadoo.fr>,
Pierre Rousselet  <pierre.rousselet@wanadoo.fr> wrote:
>As far as I can see,
>
>when CONFIG_DEBUG_KERNEL is set
>  and 
>when devfsd is started at boot time
>I get an Oops when remounting, rw the root fs :
>
>Unable to handle kernel request at va 5a5a5a5e

POISON_BYTE is 0x5a. Something in devfs is using a pointer from a data
structure that was already free'd, and was thus corrupted by poisoning.

(the above is almost certainly just a pointer dereference off 0x5a5a5a5a
with an offset of 4 for some entry at the beginning of a structure,
which is why you get the final "5e" in the page fault address). 

>It boots OK with devfsd when CONFIG_DEBUG_KERNEL is not set.
>It boots OK without devfsd when CONFIG_DEBUG_KERNEL is set (then devfsd
>can be started after login).

Well, not poisoning the free'd memory makes it "work" only in the sense
that usually the free'd memory hasn't been re-allocated yet, so you
don't see the bug even if it is still there.

Richard Gooch probably wants a full stack trace, with symbols. Which
should show it fairly clearly. At least EIP and the first few "stack
trace" entries..

		Linus
