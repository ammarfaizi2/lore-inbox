Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269422AbUIYWJ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269422AbUIYWJ1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 18:09:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269425AbUIYWJ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 18:09:27 -0400
Received: from dp.samba.org ([66.70.73.150]:9150 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S269422AbUIYWJY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 18:09:24 -0400
Date: Sat, 25 Sep 2004 15:08:43 -0700
From: Jeremy Allison <jra@samba.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeremy Allison <jra@samba.org>,
       YOSHIFUJI Hideaki / =?utf-8?B?5ZCJ6Jek6Iux5piO?= 
	<yoshfuji@linux-ipv6.org>,
       samuel.thibault@ens-lyon.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6] smbfs & "du" illness
Message-ID: <20040925220843.GD580@jeremy1>
Reply-To: Jeremy Allison <jra@samba.org>
References: <20040925171104.GN580@jeremy1> <20040926.024131.06508879.yoshfuji@linux-ipv6.org> <20040925174406.GP580@jeremy1> <Pine.LNX.4.58.0409251054490.2317@ppc970.osdl.org> <20040925182907.GS580@jeremy1> <Pine.LNX.4.58.0409251218170.2317@ppc970.osdl.org> <20040925195256.GB580@jeremy1> <Pine.LNX.4.58.0409251317410.2317@ppc970.osdl.org> <20040925211055.GC580@jeremy1> <Pine.LNX.4.58.0409251445470.2317@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0409251445470.2317@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 25, 2004 at 02:59:08PM -0700, Linus Torvalds wrote:
> 
> So let's work out something that works well now, _and_ might have a chance 
> in hell of working in the future too.

Ok. BTW I've fixed this in the current SVN codebase
to do the right thing (return st_blocks expressed as
bytes).

> What kinds of values do different smb servers actually fill this field 
> with? And what's the value you expect future samba severs will use?

Ok, right now the only smb server that supports the UNIX
extensions is smbd (I'm working on getting NetApp to also
support them, but they don't as yet so we can get them to
do the right thing, bytes allocated, when they do), so we
know pretty much what will happen.

> Ie, will something like this DTRT in smb_decode_unix_basic():
> 
> 	u64 size = LVAL(p, 0);	/* file size */
> 	u64 blocks = LVAL(p, 8); /* pseudo-blocks */
> 	u32 real_blocks;
> 
>         fattr->f_size = size;
> 	real_blocks = (size + 511) >> 9;
> 
> 	/*
> 	 * old samba sends "bytes used on disk rounded up to 1MB",
> 	 * which is useless - ignore it. But if the low bits are
> 	 * set, maybe the value is valid..
> 	 */
> 	if (blocks & 0xfffff) {
> 		/*
> 		 * If the low 9 bits are non-zero, it can't
> 		 * be a byte count, but maybe it's a block
> 		 * count?
> 		 */
> 		if (blocks & 0x1ff) {
> 			.. use it how? ..
> 		} else {
> 			real_blocks = blocks >> 9;
> 		}
> 	}
>         fattr->f_blocks = real_blocks;
> 
> the above is ugly as hell, but what choice is there?

Not much, sorry. 

> It would be good to know what all different server implementations can 
> do, to know just _how_ defensive this code has to be. 

It has to deal with Samba sending bytes allocated on disk (from st_blocks),
rounded up to the nearest 1mb (or whatever the local admin compiled with,
but most people don't mess with that compile-time parameter) or starting
with Samba 3.0.8 it'll send the value from the server st_blocks expressed
as bytes. So it doesn't have to be too bad (I hope).

Jeremy.
