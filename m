Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265767AbSL1UDF>; Sat, 28 Dec 2002 15:03:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266578AbSL1UDF>; Sat, 28 Dec 2002 15:03:05 -0500
Received: from h-64-105-35-45.SNVACAID.covad.net ([64.105.35.45]:49538 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S265767AbSL1UDD>; Sat, 28 Dec 2002 15:03:03 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Sat, 28 Dec 2002 12:11:17 -0800
Message-Id: <200212282011.MAA02207@adam.yggdrasil.com>
To: James.Bottomley@steeleye.com, manfred@colorfulllife.com
Subject: Re: [RFT][PATCH] generic device DMA implementation
Cc: david-b@pacbell.net, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Regarding the problem of multiple users of inconsistent
streaming memory potentially sharing the same cache line, I suspect
that the number of places that need to be fixed (or even just ought to
be commented) is probably small.

	First of all, I believe it is sufficient if we just ensure
that the memory used for device --> cpu do not share a cache line (at
least now with anything that the CPU may write to), as that is the
only direction which involves invalidating data in the CPU cache.

	So, for network packets, we should only concerned about
inbound ones, in which case the maximum packet size has usually been
allocated anyhow.

	I believe all of the current block device IO generators
generate transfers that are aligned and sized in units of at least 512
(although struct bio_vec does not require this), which I think is a
multiple of cache line size of all current architectures.

	I haven't checked, but I would suspect that even for the remaining
non-network non-block devices that do large amount of input via DMA,
such as scanners (typically via SCSI or USB) that the input buffers
allocated for these transfers happen to be a multiple of cache line
size, just because they're large and because programmers like to use
powers of two and the memory allocators usually end up aligning them
on such a power of two.

	Just to be clear: I'm only talking about corruption due to
streaming mappings overlapping other data in the same CPU cache line.
I am not talking about using inconsistent memory to map control
structures on architectures that lack consistent memory.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
