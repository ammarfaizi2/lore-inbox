Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261570AbVEZPnS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261570AbVEZPnS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 11:43:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261571AbVEZPnS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 11:43:18 -0400
Received: from fire.osdl.org ([65.172.181.4]:41156 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261570AbVEZPnO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 11:43:14 -0400
Date: Thu, 26 May 2005 08:44:37 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Robin Holt <holt@sgi.com>
cc: Simon Derr <Simon.Derr@bull.net>, Paul Jackson <pj@sgi.com>,
       Andrew Morton <akpm@osdl.org>, Dinakar Guniguntala <dino@in.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.12-rc4] cpuset exit NULL dereference fix
In-Reply-To: <20050526120859.GD29852@lnx-holt.americas.sgi.com>
Message-ID: <Pine.LNX.4.58.0505260840470.2307@ppc970.osdl.org>
References: <20050526082508.927.67614.sendpatchset@tomahawk.engr.sgi.com>
 <Pine.LNX.4.61.0505261050480.11050@openx3.frec.bull.fr>
 <20050526120859.GD29852@lnx-holt.americas.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 26 May 2005, Robin Holt wrote:
> 
> Why not change the atomic into a lock and a refcount.  Grab the lock before
> each increment/decrement of the refcount and only continue with the removal
> code when the refcount reaches 0.

For this, there is a nice 

	atomic_dec_and_lock()

function that is the same as "atomic_dec_and_test()", except it grabs the 
lock if the count decrements to zero.

I'm surprised people haven't picked up on it - it's been around for a
while, the VFS layer uses it for some quite fundamental data structures
(inode and dcache refcounts), and it's even documented in "atomic_ops.txt"

And it's _designed_ for refcountign things like this.

Basic rule of kernel programming: if a globally visible object does not 
have a refcount, IT IS A BUG.

		Linus
