Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269419AbUIYV7X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269419AbUIYV7X (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 17:59:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269421AbUIYV7X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 17:59:23 -0400
Received: from fw.osdl.org ([65.172.181.6]:64202 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269419AbUIYV7V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 17:59:21 -0400
Date: Sat, 25 Sep 2004 14:59:08 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jeremy Allison <jra@samba.org>
cc: YOSHIFUJI Hideaki / =?utf-8?B?5ZCJ6Jek6Iux5piO?= 
	<yoshfuji@linux-ipv6.org>,
       samuel.thibault@ens-lyon.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6] smbfs & "du" illness
In-Reply-To: <20040925211055.GC580@jeremy1>
Message-ID: <Pine.LNX.4.58.0409251445470.2317@ppc970.osdl.org>
References: <20040917205422.GD2685@bouh.is-a-geek.org>
 <Pine.LNX.4.58.0409250929030.2317@ppc970.osdl.org> <20040925171104.GN580@jeremy1>
 <20040926.024131.06508879.yoshfuji@linux-ipv6.org> <20040925174406.GP580@jeremy1>
 <Pine.LNX.4.58.0409251054490.2317@ppc970.osdl.org> <20040925182907.GS580@jeremy1>
 <Pine.LNX.4.58.0409251218170.2317@ppc970.osdl.org> <20040925195256.GB580@jeremy1>
 <Pine.LNX.4.58.0409251317410.2317@ppc970.osdl.org> <20040925211055.GC580@jeremy1>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 25 Sep 2004, Jeremy Allison wrote:
> 
> Right now (Samba 3.0.7) you are correct. But the intent is
> to fix it going forward, so that in non-broken server implementations
> (yes the Samba implementation is broken right now) then it
> will be correct (ie. follow the intent of the spec).
> 
> Sorry, can't fix the past, I can only fix the future :-).

So let's work out something that works well now, _and_ might have a chance 
in hell of working in the future too.

What kinds of values do different smb servers actually fill this field 
with? And what's the value you expect future samba severs will use?

Ie, will something like this DTRT in smb_decode_unix_basic():

	u64 size = LVAL(p, 0);	/* file size */
	u64 blocks = LVAL(p, 8); /* pseudo-blocks */
	u32 real_blocks;

        fattr->f_size = size;
	real_blocks = (size + 511) >> 9;

	/*
	 * old samba sends "bytes used on disk rounded up to 1MB",
	 * which is useless - ignore it. But if the low bits are
	 * set, maybe the value is valid..
	 */
	if (blocks & 0xfffff) {
		/*
		 * If the low 9 bits are non-zero, it can't
		 * be a byte count, but maybe it's a block
		 * count?
		 */
		if (blocks & 0x1ff) {
			.. use it how? ..
		} else {
			real_blocks = blocks >> 9;
		}
	}
        fattr->f_blocks = real_blocks;

the above is ugly as hell, but what choice is there?

It would be good to know what all different server implementations can 
do, to know just _how_ defensive this code has to be. 

		Linus
