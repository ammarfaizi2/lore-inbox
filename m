Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261541AbUBUQ5h (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Feb 2004 11:57:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261580AbUBUQ5f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Feb 2004 11:57:35 -0500
Received: from 104.engsoc.carleton.ca ([134.117.69.104]:19080 "EHLO
	quickman.certainkey.com") by vger.kernel.org with ESMTP
	id S261577AbUBUQ5b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Feb 2004 11:57:31 -0500
Date: Sat, 21 Feb 2004 11:48:21 -0500
From: Jean-Luc Cooke <jlcooke@certainkey.com>
To: James Morris <jmorris@redhat.com>
Cc: Christophe Saout <christophe@saout.de>,
       Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: dm-crypt, new IV and standards
Message-ID: <20040221164821.GA14723@certainkey.com>
References: <20040220172237.GA9918@certainkey.com> <Xine.LNX.4.44.0402201624030.7335-100000@thoron.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Xine.LNX.4.44.0402201624030.7335-100000@thoron.boston.redhat.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 20, 2004 at 04:26:04PM -0500, James Morris wrote:
> On Fri, 20 Feb 2004, Jean-Luc Cooke wrote:
> 
> > If others on the list care to do this, I'll give recommendation on how to 
> > implement the security (hmac, salt, iteration counts, etc).  But I think
> > this may break backward compatibility.  Can anyone speak to this?
> 
> Please focus your recommendations on security, not backward compatibility
> with something that is new to the kernel tree, broken and maintainerless.

Ah!  Ok.  :)  Here are my recommendations.

Well, CTR mode is not recommended for encrypted file systems because it is very
easy to corrupt single bits, bytes, blocks, etc without an integrity check.
If we add a MAC, then any mode of operation except ECB can be used for
encrypted file systems.

Also, current encrypted loop back FS's don't have integrity checks.  So we'll
need a place to store this information and update it every time a block is
updated.  For this we'll need to implement the OMAC authentication mode of
operation (I will do this now).  This will slow down the encryption process
of scatter-lists since we will now need to process the data twice (once for
confidentiality, and a second time to compute the message authentication code
- MAC).

At the head of the file system we'll need to store the following:
 - what block cipher is used
 - what mode of operation is used (ECB, OFB, CFB, CBC, CTR)
 - what password hashing algorithm is used, not MD5 (see [4])
 - what the password salt value is - 128 bit in length (see [1])
 - how many HMAC iterations are used to generate the key from the
   salt+password - 32 bit (see [2])

Some data will need to be stored with each block (or at least accessible
every time you encrypt/decrypt a block):
 - the IV - 128 bit in length (see [3])
 - the OMAC value - 128 bit in length

The hash algorithm:    Hash(data)
The HMAC algorithm:    HMAC(key, data)
The Encrypt algorithm: Enc(key, data)
The Decrypt algorithm: Dec(key, data)

Here is how I propose we compute the key (see [1][2]):
 K = HMAC(salt, password):
 for (i=0; i<iteration; i++)
   K = HMAC(salt, K);

Here is how I propose we compute the IV (see [3]):
 Reading a block:
  thisIV = readFromBlock(blockNum);
  /* ... decrypt the block with thisIV ... */

 Writing a block:
  thisIV = readFromBlock(blockNum);
  nextIV = INCMODP128(thisIV); /* nextIV = (thisIV + 1) mod 2^128 */
  /* ... encrypt the block with nextIV ... */

I'm sure there are implementation issues here, please let me know what they
are and we'll see what we can do.

I'll start writing OMAC now.

JLC

[1] Why have a salt?
You want to have salt of adequate size to make precomputing a dictionary of
Hash(...) outputs and thus quickly find the password.  This is common
practice in things like /etc/shadow so I shouldn't get much argument of this
implementation.
Adding a N-bit salt increases the space complexity of an attack by 2^N.

[2] Why iterate the password so many time?
If an attack requires 1 day to iterate though all 8 alphanumeric passwords,
adding a N-iteration hashing will push the attackers time complexity out by a
factor of N.  A iteration value of 2^16 (65536) should be adequate for our
purposes.

[3] Why not use IV == block number or IV == firstIV + block number?
Certain modes of operation (like CTR) begin to leak information about the
plaintext if you ever use the same Key-IV pair for your data.
The IV will need to be updated every time you update the block.
The IV generation does need not be from a cryptographicly strong PRNG,
it need only be different from the previous IV.
So incrementing the IV by 1 mod 2^128 every time you write to the block will
suffice.

[4] What not MD5?
MD5 has been deprecated by every cryptographer of good repute because it is not
being cryptographicly secure against collision attacks (read www.md5crk.com for
more information - shameless plug I know).  Though in this case we're using salted
HMACs, there is no exposure to collision attacks.  It's just good to push people
to use forward-looking algorithms since it's so easy to do so.

-- 
http://www.certainkey.com
Suite 4560 CTTC
1125 Colonel By Dr.
Ottawa ON, K1S 5B6
