Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265654AbUHHPno@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265654AbUHHPno (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Aug 2004 11:43:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265661AbUHHPno
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Aug 2004 11:43:44 -0400
Received: from 104.engsoc.carleton.ca ([134.117.69.104]:199 "EHLO
	certainkey.com") by vger.kernel.org with ESMTP id S265654AbUHHPnl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Aug 2004 11:43:41 -0400
Date: Sun, 8 Aug 2004 11:38:46 -0400
From: Jean-Luc Cooke <jlcooke@certainkey.com>
To: "Theodore Ts'o" <tytso@mit.edu>, James Morris <jmorris@redhat.com>,
       "YOSHIFUJI Hideaki / ?$B5HF#1QL@" <yoshfuji@linux-ipv6.org>,
       mludvig@suse.cz, cryptoapi@lists.logix.cz, linux-kernel@vger.kernel.org,
       davem@redhat.com
Subject: Re: [PATCH]
Message-ID: <20040808153846.GR23994@certainkey.com>
References: <20040806042852.GD23994@certainkey.com> <Xine.LNX.4.44.0408060040360.20834-100000@dhcp83-76.boston.redhat.com> <20040806125427.GE23994@certainkey.com> <20040807222634.GA15806@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040807222634.GA15806@thunk.org>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Glad to have you join the discussion Ted!

On Sat, Aug 07, 2004 at 06:26:34PM -0400, Theodore Ts'o wrote:
> On Fri, Aug 06, 2004 at 08:54:27AM -0400, Jean-Luc Cooke wrote:
> > That and it's not endian-correct.  There are other issues with random.c (lack
> > for forward secrecy in the case of seed discovery, use of the insecure MD4 in
> > creating syn and seq# for tcp, the use of halfMD4 and twothridsMD4 is
> > madness
> > (what is 2/3's of 16!?!), 
> 
> This was deliberate becasue sequence number generation could not be
> slow for some workloads.  The sequence number attacks that MD4
> protects against are tcp hijacking attacks where the attacker is on
> the network path ---- if you really want security you'd be using real
> crypto for encryption and for integrity protection at the application
> layer.

In our paper (I'm testing the patch now) we'll be proposing using the Fortuna
PRNG inplace of the current design.  It only uses SHA256 and AES256 (or any
message digest & block cipher combo).  The primary advantages of this design
would be:
 - It's simpler
 - It's faster
 - It doesn't "rool your own" crypto

> > the use of LFSRs for "mixing" when they're linear,
> > the polymonials used are not even primitive, 
> 
> The basic idea here is that you can mix in arbitrary amounts of zero
> data without destroying the randomness of the pool.  This is
> important, and was an explicit design goal.

If you pass all input data into a Yarrow-type PRNG - like the Fortuna PRNG
we're going to propose - you will never care about this since the current
state of the pools are always based on all the previous input.

> > the ability for root to wipe-out
> > the random pool, the ability for root to access the random seed directly, the
> > paper I'm co-authoring will explain all of this).
> 
> Yawn.  Root has access to /dev/mem.  Your point?

I guess the point I was trying to make was:
 - You never want to wipe out the pool
 - You never want to let people (not even yourself) get access to the pool
   The closest thing you can do (and the paper will explain this) is hash
   a counter and the data from each of your pools though a message digest
   and concatenate it together.

I'm really putting the horse infront of the cart here.  We'll put a paper up
for lkml to read by the end of the month which will fully explain:
 - Our reasoning
 - Our goals
 - Our results

Cheers,

JLC
