Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264463AbUA0SRU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 13:17:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264477AbUA0SRU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 13:17:20 -0500
Received: from ultra12.almamedia.fi ([193.209.83.38]:31728 "EHLO
	ultra12.almamedia.fi") by vger.kernel.org with ESMTP
	id S264463AbUA0SRJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 13:17:09 -0500
Message-ID: <4016AB1F.9EF8F42@users.sourceforge.net>
Date: Tue, 27 Jan 2004 20:17:03 +0200
From: Jari Ruusu <jariruusu@users.sourceforge.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.22aa1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
Cc: Michael A Halcrow <mahalcro@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: Encrypted Filesystem
References: <OFA97B290B.67DE842E-ON87256E27.0061728C-86256E27.0061BB0E@us.ibm.com.suse.lists.linux.kernel> <p73znc9s724.fsf@nielsen.suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> Better use a stacking file system or somesuch. Technically this
> has the advantage that you don't need to cache the data twice (crypto
> loop keeps both unencrypted and crypted data in the page cache)

Not true for device backed loops. At least on device backed loops on
loop-AES implementation encrypted data in not stored in page cache.

> The biggest shortcomming in crypto loop is that you cannot change the
> password easily. Doing so would require reencryption of the whole
> volume and it is hard to do so in a crash safe way (or you risk loss
> of the volume when the machine crashes during reencryption)

Not true with loop-AES where changing password is either:

  gpg --decrypt </root/fskey1.gpg | ( sleep 60; gpg --symmetric >/etc/fskey2.gpg )
  mv /etc/fskey2.gpg /etc/fskey1.gpg

or:

  gpg --edit-key "myname"
  Command> passwd

depending on how gpg key file was encrypted.

> Another
> problem is that using the user key makes it easy to use dictionary
> attacks using known plain text. For example the first block on a ext2
> file system is always zero and can be easily used to do a dictionary
> attack based on a weak user password.

Not true. loop-AES solved this dictionary attack problem in 2001. Mainline
and kerneli.org versions are vulnerable as always.

> The standard crypto loop uses
> fixed IVs too which do not help against this.

Not true. Mainline uses simple sector IV. SuSE twofish uses fixed IV which
is even more vulnerable than mainline. Loop-AES 2.x versions use more secure
MD5 IV, but they are also compatible with old setups for backward
compatibility sake.

> Not directly related to the file system, but in a bigger picture the
> biggest problem with using cryptography regularly in Linux is that
> there is no nice way for users to prevent pages from being swapped out
> to disk.  Always when you decrypt a file you risk it ending up
> unencrypted on the swap partition.  This means even when your file
> system encrypts great you still risk your data when reading it.

That is what encrypted swap is for. Loop-AES version of loop was rewritten
in 2001 to be compatible with encrypted swap. That work included removing
all runtime memory allocations from device backed loops.

Quote from loop-AES README file:

First, run "swapoff -a" to turn off swap devices in your /etc/fstab file.
Second, add "loop=/dev/loop?" and "encryption=AES128" options to swap lines 
in your /etc/fstab file. Example:

 /dev/hda666   none   swap   sw,loop=/dev/loop6,encryption=AES128   0   0
                                ^^^^^^^^^^^^^^^ ^^^^^^^^^^^^^^^^^
Third, there may be old unencrypted data on your swap devices, in which case
you can try to overwrite that data with command like this:

    dd if=/dev/zero of=/dev/hda666 bs=64k conv=notrunc
    mkswap /dev/hda666

Fourth, run "swapon -a" and "rm -rf /var/log/ksymoops" and you are done.

> While it would be possible to encrypt swap too I'm not sure this is a
> good idea: e.g. it requires global key management, which is probably
> bad.

"swapon -a" reads some random bits from /dev/urandom and recycles old
encrypted swap data while it generates 64 new random swap keys for each loop
device that it uses to encrypt swap partitions. No 'global key management'
problem whatsoever. Encrypted swap has worked fine since 2001.

> And it could cause performance problems.

Optimized assembler implementation of AES cipher works fast enough here.

-- 
Jari Ruusu  1024R/3A220F51 5B 4B F9 BB D3 3F 52 E9  DB 1D EB E3 24 0E A9 DD
