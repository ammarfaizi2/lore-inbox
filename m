Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266878AbUITRuf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266878AbUITRuf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 13:50:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266885AbUITRuf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 13:50:35 -0400
Received: from rproxy.gmail.com ([64.233.170.202]:45128 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S266878AbUITRu1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 13:50:27 -0400
Message-ID: <8e6f9472040920105013b4e0cd@mail.gmail.com>
Date: Mon, 20 Sep 2004 13:50:25 -0400
From: Will Dyson <will.dyson@gmail.com>
Reply-To: Will Dyson <will.dyson@gmail.com>
To: James Morris <jmorris@redhat.com>
Subject: Re: [PATCH 1/6] xattr consolidation v2 - generic xattr API
Cc: Andrew Morton <akpm@osdl.org>, viro@parcelfarce.linux.theplanet.co.uk,
       Stephen Smalley <sds@epoch.ncsc.mil>,
       Christoph Hellwig <hch@infradead.org>,
       Andreas Gruenbacher <agruen@suse.de>, linux-kernel@vger.kernel.org
In-Reply-To: <Xine.LNX.4.44.0409180305300.10905-100000@thoron.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <Xine.LNX.4.44.0409180252090.10905@thoron.boston.redhat.com>
	 <Xine.LNX.4.44.0409180305300.10905-100000@thoron.boston.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Sep 2004 03:20:37 -0400 (EDT), James Morris
<jmorris@redhat.com> wrote:
> This patch consolidates common xattr handling logic into the core fs code,
> with modifications suggested by Christoph Hellwig (hang off superblock,
> remove locking, use generic code as methods), for use by ext2, ext3 and
> devpts, as well as upcoming tmpfs xattr code.

Hi James,

I'd like to raise an issue with the documentation your patch
introduces. The lack of it, actually.

While it might be obvious to someone who is familiar with the ext2 and
ext3 xattr code, I had a rather hard time understanding how a
filesystem would make use of the generic functions that your patch
introduces. While I think I have it now, that is 30 minutes of my life
that I will never get back :) . 30 minutes is not a long time (I've
spent as much thinking about this message), but this sort of thing is
an issue all throughout the generic vfs code.

When I was working on the readonly befs filesystem, I may have spent
as much as 20 percent of my time actually thinking about on-disk data
and how to use it. Most of the rest of that time was spent reading
code from the vfs layer (or other existing filesystems), trying to
figure out how I should call helper functions or how they would call
my code. Some of that code is very clever and solves complex problems,
which makes it hard to grok on the first (or third) read-through.

I don't plan on holding my breath while waiting for "The linux vfs
layer for dummies" to come out. But a quick comment to explain the
purpose and use of a block of code can make a world of difference to
someone trying to come up to speed.

For example:

/*
In order to implement different sets of xattr operations for each
xattr prefix, a filesystem should create a null-terminated array of
struct xattr_handler (one for each prefix) and hang a pointer to it
off of the s_xattr field of the superblock. The generic_fooxattr
functions will search this list for a xattr_handler with a prefix
field that matches the prefix of the xattr we are dealing with and
call the apropriate function pointer from that xattr_handler.
*/

-- 
Will Dyson - Consultant
http://www.lucidts.com/
