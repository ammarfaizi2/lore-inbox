Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265504AbUAPOVu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 09:21:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265510AbUAPOVu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 09:21:50 -0500
Received: from ms-smtp-03-smtplb.ohiordc.rr.com ([65.24.5.137]:65166 "EHLO
	ms-smtp-03-eri0.ohiordc.rr.com") by vger.kernel.org with ESMTP
	id S265504AbUAPOVo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 09:21:44 -0500
Message-ID: <4007F360.50905@borgerding.net>
Date: Fri, 16 Jan 2004 09:21:20 -0500
From: Mark Borgerding <mark@borgerding.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: AES cryptoloop corruption under recent -mm kernels
References: <Pine.GSO.4.58.0401141357410.10111@denali.ccs.neu.edu>		 <4006C665.3065DFA1@users.sourceforge.net> <Pine.GSO.4.58.0401151215320.27227@denali.ccs.neu.edu> <4006F915.370357A9@users.sourceforge.net>
In-Reply-To: <4006F915.370357A9@users.sourceforge.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You've demonstrated a good case for why salted passwords are a good
idea.  They *help* to protect against bad passwords.  Still a bad
password is still a bad password, no matter how you slice (or salt) it.

A dictionary attack only helps if you are attacking multiple volumes.
For a dedicated attack, there is no meet-in-the-middle.  The only
difference speed-wise is the extra time it takes to hash the salt as
well as the password, which is not inconsequential.

I agree with you that salted password hashes would be better. Iterated &
salted hashes would be better still. For S&I hashes, the key is
hash(salt+pw+salt+pw+ ... + pw).  Some add zero padding as well.

It's worth noting that a iterated and/or salted hash is just as slow for
Alice as it is for Mallory -- the benefit comes from the fact that Alice
only has to perform the operation once when she authenticates. Mallory
has to do it zillions of times to get the right key.


However, I think that calling this lack of salt a backdoor is inflammatory.
It would be more accurate to say that these crypto impl. are weak
against dictionary attack.


A backdoor is a very negative term usually reserved for an intentionally
weak mode that subverts the normal operation.  For example, a web
browser that allows a remote web page to execute programs that its
authors claim are trustworthy (adware anyone?).


(How) does your version of aes crypto solve the problems of salt, IVs, &
HMACs?

I am new crypto over a loopback device, but not new to crypto.
I would appreciate any pointers to whitepapers about how cryptoloopback
devices works.
I've been looking through the code, but it would be nice to have
something higher level for analysis.

 From looking through the cryptoloop code, it looks like the IV for CBC
mode is always the sector index.  It seems this could be weak against
chosen plaintext attacks, as well as allowing an attacker to know which
cipher blocks started any changes between two snapshots of the
ciphertext.  I discuss ECB, since I wouldn't consider using it.

What are the limitations on block size of a loopack device wrt. the
underlying file?
Is it possible to have the loopback device use a smaller blocksize than
the underlying file's?

If so, then one could really increase the security by storing each block
in the file as an individual ciphertext message.
For example, with a file blocksize == 4096, the loop's blocksize could
be 4096 - len(IV) - len(hmac) - len(salt).

HMACs would be great, but authenticity could also be handled by signing
the enciphered file after umount and verifying before mount, or by using
md5/sha1sums inside whatever filesystem is put on the cryptoloop device.


I've rambled long enough.  Time for work.

Ragards,
Mark Borgerding


Jari Ruusu wrote:

>Jim Faulkner wrote:
>  
>
>>Could you give me more information about this back-door, and generally
>>speaking how it would be exploited?  I want to be sure that I am affected
>>by this problem.
>>    
>>
>
>Kerneli.org loop crypto implementation (and derived versions such as Debian,
>SuSE and others) are vulnerable to optimized dictionary attacks because they
>use unseeded (unsalted) and uniterated key setup. Mainline linux
>implementation is equally vulnerable.
>
>Most, if not all, file systems have known plaintext. On popular file systems
>such as ext2, ext3, reiserfs and not so popular minix, first 16 bytes of
>fourth 512 byte sector is such good known plaintext. Byte offset 0x600 to
>0x60F of plaintext contain all zero bits. File system itself does not use
>that data at all, but mkfs for file system in question puts that known
>plaintext there. When encryption key setup does not include seed, there will
>be direct connection from password to ciphertext. The problem is that these
>ciphertexts can be precomputed in advance, and if the database is kept
>sorted by ciphertext value, optimized attack is reduced to doing binary
>search of precomputed ciphertext values.
>
>You can display precomputed ciphertext with command like this:
>
>  dd if=/dev/hda999 bs=16 skip=96 count=1 2>/dev/null | od -An -tx1 -
>
>Here are some samples using AES256 encryption and RIPE-MD160 password hash
>function, no seed, no key iteration:
>
>precomputed ciphertext           silly password
>~~~~~~~~~~~~~~~~~~~~~~           ~~~~~~~~~~~~~~
>3288d92bcd29df6756fdf12804566612 FUBAR
>4d0ae7ae3d261d3d26898882bc1fb2f2 mercury
>521e79d1791ea67bbddb9dd9cc0b3131 password
>5491b0159ac34f130804fef2ef72aed1 letmeinNOW!
>6dfd1358075030c91d55038ad7f1aca4 **********
>6e87eb085049906e9ecb43300f3f170d swordfish
>eab19121387408bfa5d76d7cd124631f backdoored
>
>Of course different ciphers, different key lengths and different password
>hashes are going to need separate databases as precomputed ciphertects will
>be different if key is set up differently.
>
>  
>
>>Also, in the loop-AES.README, this is mentioned:
>>
>>"Device backed loop device can be used with journaling file systems as
>>device backed loops guarantee that writes reach disk platters in
>>order required by journaling file system (write caching must be disabled
>>on the disk drive, of course)"
>>
>>Are you talking about the "hdparm -W" flag for IDE drives?
>>    
>>
>
>Yes.
>
>If you don't have UPS powered box, disabling write caching of disks is
>recommended when using journaling file system.
>
>  
>
>>Would I need
>>to disable write caching when using non-journaling file systems?
>>    
>>
>
>Probably not.
>
>  
>



