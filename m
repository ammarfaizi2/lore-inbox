Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318852AbSHRFfD>; Sun, 18 Aug 2002 01:35:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318854AbSHRFfD>; Sun, 18 Aug 2002 01:35:03 -0400
Received: from waste.org ([209.173.204.2]:39141 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S318852AbSHRFfC>;
	Sun, 18 Aug 2002 01:35:02 -0400
Date: Sun, 18 Aug 2002 00:38:59 -0500
From: Oliver Xymoron <oxymoron@waste.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Robert Love <rml@tech9.net>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] (0/4) Entropy accounting fixes
Message-ID: <20020818053859.GM21643@waste.org>
References: <1029642713.863.2.camel@phantasy> <Pine.LNX.4.44.0208172058200.1640-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0208172058200.1640-100000@home.transmeta.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 17, 2002 at 09:01:20PM -0700, Linus Torvalds wrote:
> 
> On 17 Aug 2002, Robert Love wrote:
> > 
> > [1] this is why I wrote my netdev-random patches.  some machines just
> >     have to take the entropy from the network card... there is nothing
> >     else.
> 
> I suspect that Oliver is 100% correct in that the current code is just
> _too_ trusting. And parts of his patches seem to be in the "obviously
> good" category (ie the xor'ing of the buffers instead of overwriting).

Make sure you don't miss this bit, I should have sent it
separately. This is a longstanding bug that manufactures about a
thousand bits out of thin air when the pool runs dry.

Ironically, any confidence anyone had in /dev/random vs /dev/urandom
up until now has been misplaced.

--- a/drivers/char/random.c	2002-07-20 14:11:07.000000000 -0500
+++ b/drivers/char/random.c	2002-08-17 19:47:54.000000000 -0500
@@ -1239,18 +1184,18 @@
 
 	if (r->entropy_count < nbytes * 8 &&
 	    r->entropy_count < r->poolinfo.POOLBITS) {
-		int nwords = min_t(int,
-				   r->poolinfo.poolwords - r->entropy_count/32,
-				   sizeof(tmp) / 4);
+		int bytes = min_t(int,
+				   nbytes - r->entropy_count/8,
+				   sizeof(tmp));
 
-		DEBUG_ENT("xfer %d from primary to %s (have %d, need %d)\n",
-			  nwords * 32,
+		DEBUG_ENT("xfer %d to %s (have %d, need %d)\n",
+			  bytes * 8,
 			  r == sec_random_state ? "secondary" : "unknown",
 			  r->entropy_count, nbytes * 8);
 
-		extract_entropy(random_state, tmp, nwords * 4, 0);
-		add_entropy_words(r, tmp, nwords);
-		credit_entropy_store(r, nwords * 32);
+		extract_entropy(random_state, tmp, bytes, 0);
+		add_entropy_words(r, tmp, (bytes+3)/4);
+		credit_entropy_store(r, bytes*8);
 	}
 	if (r->extract_count > 1024) {
 		DEBUG_ENT("reseeding %s with %d from primary\n",

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.." 
