Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266867AbUHIS72@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266867AbUHIS72 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 14:59:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266897AbUHIS4o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 14:56:44 -0400
Received: from 104.engsoc.carleton.ca ([134.117.69.104]:48588 "EHLO
	certainkey.com") by vger.kernel.org with ESMTP id S266867AbUHISzB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 14:55:01 -0400
Date: Mon, 9 Aug 2004 14:49:51 -0400
From: Jean-Luc Cooke <jlcooke@certainkey.com>
To: "Theodore Ts'o" <tytso@mit.edu>, James Morris <jmorris@redhat.com>,
       "YOSHIFUJI Hideaki / ?$B5HF#1QL@" <yoshfuji@linux-ipv6.org>,
       mludvig@suse.cz, cryptoapi@lists.logix.cz, linux-kernel@vger.kernel.org,
       davem@redhat.com
Subject: Re: [PATCH]
Message-ID: <20040809184951.GH2192@certainkey.com>
References: <20040806042852.GD23994@certainkey.com> <Xine.LNX.4.44.0408060040360.20834-100000@dhcp83-76.boston.redhat.com> <20040806125427.GE23994@certainkey.com> <20040807222634.GA15806@thunk.org> <20040808153846.GR23994@certainkey.com> <20040809184324.GA22741@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040809184324.GA22741@thunk.org>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 09, 2004 at 02:43:24PM -0400, Theodore Ts'o wrote:
> On Sun, Aug 08, 2004 at 11:38:46AM -0400, Jean-Luc Cooke wrote:
> > In our paper (I'm testing the patch now) we'll be proposing using the Fortuna
> > PRNG inplace of the current design.  It only uses SHA256 and AES256 (or any
> > message digest & block cipher combo).  The primary advantages of this design
> > would be:
> >  - It's simpler
> >  - It's faster
> >  - It doesn't "rool your own" crypto
> 
> SHA is not going to be faster than the cut-down MD4 --- and you can't
> use a pure random sequence number for the initial TCP sequence number,
> lest a packet from a previous TCP connection get mistaken as belong to
> the newly created TCP stream.  See Bellovin's recommendations for
> secure TCP sequnce number genreation for a discussion of the
> constraints.  
> 
> > If you pass all input data into a Yarrow-type PRNG - like the Fortuna PRNG
> > we're going to propose - you will never care about this since the current
> > state of the pools are always based on all the previous input.
> 
> The Yarrow-type PRNG suffers from the problem that the entropy pool is
> pathetically small.  It fundamentally assumes that the crypto checksum
> is secure, and it is really much more of a *P*RNG than anything else.
> The scheme used in the current /dev/random design is much closer to
> that used by GPG, and relies on a large pool so that we can collect as
> much entropy as possible from the hardware sources available to the
> kernel.  I'm not familiar with the Fortuna PRNG that you're going to
> propose, but my guess is that it will have a similar, much heavier
> dependence on the crypto algorithms in terms of its assumptions.

Fortuna overcomes the small pool size problem.  For the most part, I really
like how the current random.c collects data.  

The only parts we're proposing to replace are:
 - The pooling (thus, mixing) mechanizums as per in Fortuna by Schnier and
   Furguson
 - The random data output mechanizum (Fortuna)
 - TCP sequence number generation (AES in CTR mode truncated to 32 bits, has
   period of 2^32 and cannot be easily determined from pervious sequences)
   I will read your reference and learn from the implementation in random.c
 - TCP SYNcookies to encrypt 8bit "count" value and the 24bit "data" (MSS)
   value with AES in CTR mode.  I can prove that this is exactly what is
   being done now with the "two SHA1 hashes and a bunch of addition" method.

Crutial to my proposal will be not "not rock the boat".  That is, keeping all
important interfaces intact to not break anything else in the kernel.

JLC
