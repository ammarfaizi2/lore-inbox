Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266166AbUHFDY2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266166AbUHFDY2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 23:24:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266243AbUHFDY2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 23:24:28 -0400
Received: from fw.osdl.org ([65.172.181.6]:19124 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266166AbUHFDYY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 23:24:24 -0400
Date: Thu, 5 Aug 2004 20:24:19 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: viro@parcelfarce.linux.theplanet.co.uk
cc: Gene Heskett <gene.heskett@verizon.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Possible dcache BUG
In-Reply-To: <20040806031815.GL12308@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.58.0408052022060.24588@ppc970.osdl.org>
References: <Pine.LNX.4.44.0408020911300.10100-100000@franklin.wrl.org>
 <200408042216.12215.gene.heskett@verizon.net> <Pine.LNX.4.58.0408042359460.24588@ppc970.osdl.org>
 <Pine.LNX.4.58.0408051923420.24588@ppc970.osdl.org>
 <20040806031815.GL12308@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 6 Aug 2004 viro@parcelfarce.linux.theplanet.co.uk wrote:
> 
> It doesn't even take a dput().  Look: we do list_del(), then notice that
> sucker still has positive refcount and leave it alone.  Now think what
> happens on the next pass.  That's right, we hit that dentry *again*. And
> see that list_empty() is false.  And do list_del() one more time.

Well, the sad part is that doing another list_del() won't even necessarily 
go *boom*. Most of the time it might even leave the list as-is, but often 
enough it should give list corruption.

> However, what used to be e.g. next dentry might very well be freed by
> now.  *BOOM*.

Absolutely. It does look like a rather nasty bug.

It doesn't explain what Gene sees, though, unless you can explain how we'd 
get an anon dentry without knfsd/xfs. Oh well.

I'll commit the obvious one-liner fix, since it might explain _some_ 
problems people have seen.

		Linus
