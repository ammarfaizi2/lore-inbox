Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267574AbUBSVmj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 16:42:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267317AbUBSVmj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 16:42:39 -0500
Received: from fw.osdl.org ([65.172.181.6]:60393 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267574AbUBSVkq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 16:40:46 -0500
Date: Thu, 19 Feb 2004 13:45:32 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: viro@parcelfarce.linux.theplanet.co.uk
cc: Tridge <tridge@samba.org>, Jamie Lokier <jamie@shareable.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Eureka! (was Re: UTF-8 and case-insensitivity)
In-Reply-To: <Pine.LNX.4.58.0402191255540.1439@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.58.0402191340080.1439@ppc970.osdl.org>
References: <Pine.LNX.4.58.0402181511420.18038@home.osdl.org>
 <20040219081027.GB4113@mail.shareable.org> <Pine.LNX.4.58.0402190759550.1222@ppc970.osdl.org>
 <20040219163838.GC2308@mail.shareable.org> <Pine.LNX.4.58.0402190853500.1222@ppc970.osdl.org>
 <20040219182948.GA3414@mail.shareable.org> <Pine.LNX.4.58.0402191124080.1270@ppc970.osdl.org>
 <20040219200554.GE31035@parcelfarce.linux.theplanet.co.uk>
 <Pine.LNX.4.58.0402191217050.1439@ppc970.osdl.org>
 <Pine.LNX.4.58.0402191226240.1439@ppc970.osdl.org>
 <20040219204515.GG31035@parcelfarce.linux.theplanet.co.uk>
 <Pine.LNX.4.58.0402191255540.1439@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 19 Feb 2004, Linus Torvalds wrote:
> 
> See? Nobody actually ever sees the "raw dentry". They all go through 
> __d_lookup(), and the rule would be:
> 
>  - if "d_lookup()" sees a tentative dentry, it will just unhash it and 
>    drop it (it has the dcache lock, so it can do that)
>  - all callers of "__d_lookup()" will have to check for D_TENTATIVE, and 
>    decide what to do with it. I think there are exactly _three_ callers, 
>    and one of them is d_lookup() itself.

Actually, I've got a better setup: instead of having a D_TENTATIVE flag in 
the dentry flags, just do

	#define TENTATIVE_INODE ((struct inode *) 1)

and just have "dentry->d_inode = TENTATIVE_INODE" for the dentries that 
were filled directly from "readdir()" data.

This not only avoids using a bit in the dentry flags, but it pretty much
guarantees that everybody is forced to use them correctly. It would be
very hard to have a buggy user: the dentry will clearly not be a negative
dentry (since d_inode is not NULL), but if anybody ever uses it as a
positive dentry, you'll get a nice and immediate oops.

So we'd see very quickly if these tentative dentries were to escape 
outside of __d_lookup().

			Linus
