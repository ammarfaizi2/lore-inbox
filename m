Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261659AbUAOUc5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 15:32:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262913AbUAOUc5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 15:32:57 -0500
Received: from ultra12.almamedia.fi ([193.209.83.38]:14998 "EHLO
	ultra12.almamedia.fi") by vger.kernel.org with ESMTP
	id S261659AbUAOUco (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 15:32:44 -0500
Message-ID: <4006F915.370357A9@users.sourceforge.net>
Date: Thu, 15 Jan 2004 22:33:25 +0200
From: Jari Ruusu <jariruusu@users.sourceforge.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.22aa1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jim Faulkner <jfaulkne@ccs.neu.edu>
Cc: James Morris <jmorris@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: AES cryptoloop corruption under recent -mm kernels
References: <Pine.GSO.4.58.0401141357410.10111@denali.ccs.neu.edu>
		 <4006C665.3065DFA1@users.sourceforge.net> <Pine.GSO.4.58.0401151215320.27227@denali.ccs.neu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jim Faulkner wrote:
> Could you give me more information about this back-door, and generally
> speaking how it would be exploited?  I want to be sure that I am affected
> by this problem.

Kerneli.org loop crypto implementation (and derived versions such as Debian,
SuSE and others) are vulnerable to optimized dictionary attacks because they
use unseeded (unsalted) and uniterated key setup. Mainline linux
implementation is equally vulnerable.

Most, if not all, file systems have known plaintext. On popular file systems
such as ext2, ext3, reiserfs and not so popular minix, first 16 bytes of
fourth 512 byte sector is such good known plaintext. Byte offset 0x600 to
0x60F of plaintext contain all zero bits. File system itself does not use
that data at all, but mkfs for file system in question puts that known
plaintext there. When encryption key setup does not include seed, there will
be direct connection from password to ciphertext. The problem is that these
ciphertexts can be precomputed in advance, and if the database is kept
sorted by ciphertext value, optimized attack is reduced to doing binary
search of precomputed ciphertext values.

You can display precomputed ciphertext with command like this:

  dd if=/dev/hda999 bs=16 skip=96 count=1 2>/dev/null | od -An -tx1 -

Here are some samples using AES256 encryption and RIPE-MD160 password hash
function, no seed, no key iteration:

precomputed ciphertext           silly password
~~~~~~~~~~~~~~~~~~~~~~           ~~~~~~~~~~~~~~
3288d92bcd29df6756fdf12804566612 FUBAR
4d0ae7ae3d261d3d26898882bc1fb2f2 mercury
521e79d1791ea67bbddb9dd9cc0b3131 password
5491b0159ac34f130804fef2ef72aed1 letmeinNOW!
6dfd1358075030c91d55038ad7f1aca4 **********
6e87eb085049906e9ecb43300f3f170d swordfish
eab19121387408bfa5d76d7cd124631f backdoored

Of course different ciphers, different key lengths and different password
hashes are going to need separate databases as precomputed ciphertects will
be different if key is set up differently.

> Also, in the loop-AES.README, this is mentioned:
> 
> "Device backed loop device can be used with journaling file systems as
> device backed loops guarantee that writes reach disk platters in
> order required by journaling file system (write caching must be disabled
> on the disk drive, of course)"
> 
> Are you talking about the "hdparm -W" flag for IDE drives?

Yes.

If you don't have UPS powered box, disabling write caching of disks is
recommended when using journaling file system.

> Would I need
> to disable write caching when using non-journaling file systems?

Probably not.

-- 
Jari Ruusu  1024R/3A220F51 5B 4B F9 BB D3 3F 52 E9  DB 1D EB E3 24 0E A9 DD
