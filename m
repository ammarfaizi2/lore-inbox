Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262477AbUCCPSq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 10:18:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262478AbUCCPSp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 10:18:45 -0500
Received: from 104.engsoc.carleton.ca ([134.117.69.104]:41871 "EHLO
	quickman.certainkey.com") by vger.kernel.org with ESMTP
	id S262477AbUCCPSl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 10:18:41 -0500
Date: Wed, 3 Mar 2004 10:06:47 -0500
From: Jean-Luc Cooke <jlcooke@certainkey.com>
To: dean gaudet <dean-list-linux-kernel@arctic.org>
Cc: James Morris <jmorris@redhat.com>, Christophe Saout <christophe@saout.de>,
       Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: dm-crypt, new IV and standards
Message-ID: <20040303150647.GC1586@certainkey.com>
References: <20040220172237.GA9918@certainkey.com> <Xine.LNX.4.44.0402201624030.7335-100000@thoron.boston.redhat.com> <20040221164821.GA14723@certainkey.com> <Pine.LNX.4.58.0403022352080.12846@twinlark.arctic.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <Pine.LNX.4.58.0403022352080.12846@twinlark.arctic.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03, 2004 at 12:35:07AM -0800, dean gaudet wrote:
> On Sat, 21 Feb 2004, Jean-Luc Cooke wrote:
> 
> > Well, CTR mode is not recommended for encrypted file systems because it is very
> > easy to corrupt single bits, bytes, blocks, etc without an integrity check.
> > If we add a MAC, then any mode of operation except ECB can be used for
> > encrypted file systems.
> 
> what does "easy to corrupt" mean?  i haven't really seen disks generate
> bit errors ever.  this MAC means you'll need to write integrity data for
> every real write.  that really doesn't seem worth it...

The difference between "$1,000,000" and "$8,000,000" is 1 bit.  If an
attacker knew enough about the layout of the filesystem (modify times on blocks,
etc) they could flip a single bit and change your $1Mil purchase order
approved by your boss to a $8Mil order.

Extraneous example to be sure.  But this is why you want MACs.  CBC mode is
more difficult to tamper with, but not immune.

> it seems like a block is either right, or it isn't -- the only thing the
> MAC is telling you is that the block isn't right... it doesn't tell you
> how to fix it.  that's a total waste of write bandwidth -- you might as
> well return the bogus decrypted block.

A block cipher can be viewed as a huge lookup table.  Converting a 128 bit
block of data (in the case of AES) into another using a single key as the
rule-set for this transformation.  This alone is not secure (think of the
attacks on ECB which does exactly this for all your data).  That's why we
have 6 modes of operation in common use in the industry.

ECB, CBC : block-mode
CFB, OFB : stream-moe
CTR      : block- and/mode stream-mode
OMAC     : 128bit keyed Message Authentication Code
CCM      : CTR + CBC-MAC defined by IEEE 802.11i 

> > [3] Why not use IV == block number or IV == firstIV + block number?
> > Certain modes of operation (like CTR) begin to leak information about the
> > plaintext if you ever use the same Key-IV pair for your data.
> > The IV will need to be updated every time you update the block.
> > The IV generation does need not be from a cryptographicly strong PRNG,
> > it need only be different from the previous IV.
> > So incrementing the IV by 1 mod 2^128 every time you write to the block will
> > suffice.
> 
> is CTR the only mode which is weak with simple IV / block number
> relationships?

CTR, ECB, and CFB are vulnerable.

> if you absolutely need this IV update for every write then you should
> consider a disk layout which mixes IV (or IV+MAC) blocks so that they are
> grouped near their data blocks, to reduce seek overhead.
> 
> i.e. 1 block containing 15 IV+MAC, followed by 15 data blocks, followed by
> IV+MAC, followed by 15 data...

CBC mode doesn't absolutely need macs.  But the IV changes *are* required for
all modes of operation. Christophe and I's scheme of IV = firstIV + blockNum
for initial setup and IV = IV + 2^64 for IV updates will work fine as long as
there are less then 2^(128-64) block in the file system and less then 2^64
updates to any one block.  This scheme will keep CBC, OFB, CTR, and CCM modes
secure from eavesdropping but not Necessarily[1~[1~ from tampering.

JLC

-- 
http://www.certainkey.com
Suite 4560 CTTC
1125 Colonel By Dr.
Ottawa ON, K1S 5B6
