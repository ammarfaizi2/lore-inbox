Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129026AbRBHHP6>; Thu, 8 Feb 2001 02:15:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129032AbRBHHPt>; Thu, 8 Feb 2001 02:15:49 -0500
Received: from twinlark.arctic.org ([204.107.140.52]:13331 "HELO
	twinlark.arctic.org") by vger.kernel.org with SMTP
	id <S129026AbRBHHPb>; Thu, 8 Feb 2001 02:15:31 -0500
Date: Wed, 7 Feb 2001 23:15:30 -0800 (PST)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: <linux-kernel@vger.kernel.org>
Subject: dentry cache order 7 is broken
Message-ID: <Pine.LNX.4.33.0102072302030.5947-100000@twinlark.arctic.org>
X-comment: visit http://arctic.org/~dean/legal for information regarding copyright and disclaimer.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

this looks to be a problem going back all the way to at least 2.2.

if you've got 512Mb of RAM you end up with a dentry cache of order 7 --
65536 entries.

this results in a D_HASHBITS of 16.  if you look at d_hash it contains
this code:

	hash = hash ^ (hash >> D_HASHBITS) ^ (hash >> D_HASHBITS*2);

D_HASHBITS*2 = 32, which on an x86 results in a shift of 0.  (ia32 is
defined to mask a variable shift down to the low 5 bits and use the low 5
bits.)

this results in a hash with very little perturbance at all, since the 1st
and 3rd terms of the xor are equal and cancel... and the resulting
performance is pretty abysmal.  i'm getting hash chains with well over 100
entries in them just doing a find on the kernel source tree.

if i hard code to order 8 then i get nice well distributed hash chains, 5
entries max.

also, for order > 7, was the real intention to use a shift of
(order*2)&31?

-dean

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
