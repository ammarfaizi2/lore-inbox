Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263909AbUDVKUW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263909AbUDVKUW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 06:20:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263907AbUDVKUW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 06:20:22 -0400
Received: from p4.ensae.fr ([195.6.240.202]:55462 "EHLO pc809.ensae.fr")
	by vger.kernel.org with ESMTP id S263909AbUDVKUL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 06:20:11 -0400
From: Guillaume =?iso-8859-1?q?Lac=F4te?= <Guillaume@Lacote.name>
Reply-To: Guillaume@Lacote.name
Organization: Guillaume@Lacote.name
To: =?iso-8859-1?q?J=F6rn=20Engel?= <joern@wohnheim.fh-wedel.de>
Subject: Re: Using compression before encryption in device-mapper
Date: Thu, 22 Apr 2004 12:20:08 +0200
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org, Linux@glacote.com
References: <200404131744.40098.Guillaume@Lacote.name> <200404220959.14440.Guillaume@Lacote.name> <20040422091829.GA3691@wohnheim.fh-wedel.de>
In-Reply-To: <20040422091829.GA3691@wohnheim.fh-wedel.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404221220.08987.Guillaume@Lacote.name>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for your prompt answer ;)

> Before:
> http://marc.theaimsgroup.com/?l=linux-kernel&m=107419912024246&w=2
Yes, I had seen this.

> After:

> And of course it has to be at the beginning of a compression block, so
> the offset is known in advance.
OK, but this is not the case anymore if you insert random bytes first (?).
Where does the encrypted non-random data start ? This depends on the huffman 
encoding, which you know nothing about.

>
> Ok, that makes the attack a little harder (but not much).  After any
> amount of random data, you end up with a random huffman tree, agreed.
> Compress another 1k of zeros and see what the huffman tree looks like
> now.  There are not too many options, what the compressed data could
> look like, right?  Somewhere in the ballpark of 2, 4 or maybe 8.
OK, you are right. So assuming you have:
 1) n randomly choosen bytes (n is itselft random)
      Here the dynamic Huffman tree is T1 (uniformly distributed among all 
trees)
 2) p zero bytes
      Now the tree is T2.
 3) some more valuable data you would not want the attacker to know about.
My whole idea is useless if the attacker can gain sufficient knowledge on T2. 
So if p >> n, then T2 will look like the well-known tree with 0 stored on 1 
bit. I had missed this problem, thank you.

However (?):
a) the attacker stills knows nothing about the rest of the tree (ie what the 
encoding of all other bits are). Basically to construct T2 you take T1, let 
"0" be the coding of "0", and prefix the code of all other bytes with a "1".

On the other hand, replace (2) with a known sequence of p _equally 
distributed_ bytes: now T2 looks like the well-balanced tree, and its 
encoding is trivial and totally know to the attacker. This is a real problem 
(apart from b and c below), but how often can this happen ?

b) the attacker does not know (?) where the real data starts in the enciphered 
stream, since Huffman is variable-length. 

c) it is sufficient to ensure that not (p >> n). This is easily satistifed if 
the expectation of n is in the order of one block size, since at most p < 
block_size. 

> > > Does the idea still sound sane to you?
> > I hope so; what is your opinion ?
> I doubt it.  Maybe with a statistical encoding or even with block
> sorting followed by statistical encoding, you increase the complexity
> by much more than 8.  But without changes, the idea looks pretty
> futile.
Could you detail what you mean with statistical encoding ? Thank you in 
advance, Guillaume.

