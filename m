Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264265AbUEIDyO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264265AbUEIDyO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 May 2004 23:54:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264266AbUEIDyO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 May 2004 23:54:14 -0400
Received: from fw.osdl.org ([65.172.181.6]:18655 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264265AbUEIDyM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 May 2004 23:54:12 -0400
Date: Sat, 8 May 2004 20:53:57 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: "David S. Miller" <davem@redhat.com>
cc: akpm@osdl.org, dipankar@in.ibm.com, manfred@colorfullife.com,
       davej@redhat.com, wli@holomorphy.com, linux-kernel@vger.kernel.org,
       maneesh@in.ibm.com
Subject: Re: dentry bloat.
In-Reply-To: <20040508201215.24f0d239.davem@redhat.com>
Message-ID: <Pine.LNX.4.58.0405082039510.1592@ppc970.osdl.org>
References: <409B1511.6010500@colorfullife.com> <20040508012357.3559fb6e.akpm@osdl.org>
 <20040508022304.17779635.akpm@osdl.org> <20040508031159.782d6a46.akpm@osdl.org>
 <Pine.LNX.4.58.0405081019000.3271@ppc970.osdl.org> <20040508120148.1be96d66.akpm@osdl.org>
 <Pine.LNX.4.58.0405081208330.3271@ppc970.osdl.org>
 <Pine.LNX.4.58.0405081216510.3271@ppc970.osdl.org> <20040508204239.GB6383@in.ibm.com>
 <20040508135512.15f2bfec.akpm@osdl.org> <20040508211920.GD4007@in.ibm.com>
 <20040508171027.6e469f70.akpm@osdl.org> <Pine.LNX.4.58.0405081947290.1592@ppc970.osdl.org>
 <20040508201215.24f0d239.davem@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 8 May 2004, David S. Miller wrote:
> 
> FWIW this patch does not change the dentry size on sparc64.
> It's 256 bytes both before and after.  But of course the
> inline string length is larger.

Yup. I tested it on ppc64, that was part of the reason for the increase in 
the inline string size ("reclaim the lost space" rather than "make the 
dentry shrink from 256 bytes to 248 bytes").

That shows how broken the old setup was, btw: on 64-bit architectures, the 
old code resulted in the inline string size being 16 bytes, while on a P4 
it would be something like 120 bytes. That makes no sense.

Btw, the cacheline alignment was actually likely to guarantee the 
_worst_ possible cache behaviour on a P4: the fields we access on lookup 
are:

 - d_hash	(pointer *2)
 - d_bucket	(pointer)
 - d_move_count	(unsigned long)
 - d_name.hash	(part of a struct with 1 pointer + 2 ints)
 - d_parent	(pointer)

and they were all close together, but I think "d_bucket" was guaranteed to 
be in another cacheline exactly because of the thing always being aligned. 
So removing the alignment is likely to cause more of the lookups to only 
need one cacheline instead of two like it was before.

I think. Maybe I counted the offsets wrong.

		Linus
