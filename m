Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267330AbTAGHmg>; Tue, 7 Jan 2003 02:42:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267331AbTAGHmf>; Tue, 7 Jan 2003 02:42:35 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:26632 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267330AbTAGHme>; Tue, 7 Jan 2003 02:42:34 -0500
Date: Mon, 6 Jan 2003 23:45:55 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jeremy Fitzhardinge <jeremy@goop.org>
cc: Neil Brown <neilb@cse.unsw.edu.au>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Define hash_mem in lib/hash.c to apply hash_long to an
 arbitraty piece of memory.
In-Reply-To: <1041924803.27637.3.camel@ixodes.goop.org>
Message-ID: <Pine.LNX.4.44.0301062341210.1394-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 6 Jan 2003, Jeremy Fitzhardinge wrote:
> 
> I think they have a different set of design requirements.  They're both
> designed to not only generate hashes, but make the hashes
> cryptographically strong (ie, impossible to generate collisions with
> less effort than brute force).  They're naturally slower than a simple
> hash, so you'd only use them if you need the stronger requirements.

The filesystem hashes also have another design criteria: they need to 
reliably give the _same_ hash on different machines.

In particular, the suggested hash_mem() thing is endian-unsafe, meaning
that it will give different answers on an x86 than on a sparc CPU, for
example. Which can be ok if the only thing you care about is some
temporary hash, but is unacceptable for a lot of uses. The filesystem
hashes (well, at least some of them) are also designed to hash out files
on the disk, which means that they _have_ to be the same regardless of
architecture, or you can't move disks between machines.

Quite frankly, I think the suggested hash_mem() is too special-cased to
make any sense as a generic function. The endian problems means that it
_isn't_ really generic anyway, and as such it might as well just be some
internal nfs helper function rather than something in <linux/string.h>

		Linus


