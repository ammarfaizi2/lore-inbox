Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262164AbTLIA5k (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 19:57:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262174AbTLIA5k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 19:57:40 -0500
Received: from relay-2v.club-internet.fr ([194.158.96.113]:26065 "EHLO
	relay-2v.club-internet.fr") by vger.kernel.org with ESMTP
	id S262164AbTLIA5h convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 19:57:37 -0500
From: pinotj@club-internet.fr
To: torvalds@osdl.org, nathans@sgi.com
Cc: neilb@cse.unsw.edu.au, manfred@colorfullife.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: Re: [Oops]  i386 mm/slab.c (cache_flusharray)
Date: Tue,  9 Dec 2003 01:57:35 CET
Mime-Version: 1.0
X-Mailer: Medianet/v2.0
Message-Id: <mnet2.1070931455.23402.pinotj@club-internet.fr>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Results about testing on test11 this week-end.
Things didn't go exactly as expected, unfortunately, but there are interesting results.
First, I confirm that use of patch-xfs with patch-slab (and without CONFIG_DEBUG_SLAB) makes my system boot normaly.
I don't mention it after, but I always used the patch-printk to get more verbosity in case of slab oops.

I. Test on "small" kernel (http://cercle-daejeon.homelinux.org/misc/config-small2.txt except in first part of A.2.)

 A. With XFS (and without Ext3)

  1. no patch
  I couldn't reproduce the oops and I have no explanation at this time. I changed some parameters in the config (mostly debug to have same config for all kernels) but even with the config I used before, I didn't succeed to trigger the oops again. I first thought it was CONFIG_DEBUG_SLAB that may be the main problem of this story (and explain last tests) but I got same non-oops with CONFIG_DEBUG_SLAB=y. It doesn't mean that config change corrects the problem, though. Previous test with CONFIG_PREEMPT=y/n
shown that it could be very tricky to get the oops sometimes. More tests are needed here.

  2. patch-xfs & patch-slab
  Oops during first compile. The first test, it was kswapd who complained. I thought it could be a side effect of my config (CONFIG_SWAP=n) and not enough RAM, even if it looked strange. That's why I decided to use config-small2.txt for all the tests (that I remade). In this case, I got a very similar oops, from `ld`:

  ---
  ld: page allocation failure. order:0, mode:0x8d0
  Unable to handle kernel NULL pointer dereference at virtual address 00000074
  c01d4cbd
  *pde = 00000000
  Oops: 0002 [#1]
  CPU:    0
  EIP:    0060:[_xfs_trans_alloc+149/160]    Not tainted
  EIP:    0060:[<c01d4cbd>]    Not tainted
  ---

  Full oops: http://cercle-daejeon.homelinux.org/misc/oops-small2-xfs-patched.txt
  First config used: http://cercle-daejeon.homelinux.org/misc/config-small.txt
   and oops of kswapd http://cercle-daejeon.homelinux.org/misc/oops-small-xfs-patched.txt

  3. patch-bio
  No oops triggered

 B. With Ext3 (and without XFS)

  1. no patch
  same as I.A.1
  2. patch-xfs & patch-slab
  Compilations looked good but I got a lot of errors in my logs:

  ---
  kernel: ld: page allocation failure. order:0, mode:0x50
  last message repeated 31 times
  klogd: page allocation failure. order:0, mode:0x50
  last message repeated 63 times
  kswapd0: page allocation failure. order:0, mode:0x50
  ENOMEM in journal_alloc_journal_head, retrying.
  ion failure. order:0, mode:0x50
  kswapd0: page allocation failure. order:0, mode:0x50
  last message repeated 291 times
  ---

  Full log: http://cercle-daejeon.homelinux.org/misc/error-small2-ext3-patched.txt
  NB: I made a `swapoff -a && mkswap /dev/hda3 && swapon -a` a few days before, so swap should be clean

  3. patch-bio
  As A.3, no oops triggered

II. Tests on "big" kernel, support for XFS and Ext3 (http://cercle-daejeon.homelinux.org/misc/config-big.txt)

 A. no patch
 Same as I.A.1

 B. patch-xfs & patch-slab
 Oops very similar with I.A.2
 Full oops: http://cercle-daejeon.homelinux.org/misc/oops-big-patched.txt

 C. patch-bio
 Here is the interesting thing. Till now, I didn't saw any problem with patch bio, but this time, very easily, I got kind of double triple Lutz, starting by the infamous "BUG at mm/slab.c". There is almost 800 lines.
 Full oops: http://cercle-daejeon.homelinux.org/misc/oops-big-patch-bio-full.txt
 Oops via ksymoops: Full oops: http://cercle-daejeon.homelinux.org/misc/oops-big-patch-bio.txt

III. Conclusion

Well, it's not really easy to find a pattern here. Change in configuration can modify behavior of the oops but we can not correlate these with one setting. I will try to get back the oops by changing config.
Tests in I. confirm that it's not an XFS-only problem but seems to affect page allocation for fs in general.
I hope these oops will be clearer to you. I still have no problem with test9.

Jerome Pinot
(Hope it missed nothing)

