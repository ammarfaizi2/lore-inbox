Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261814AbTDURtH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 13:49:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261809AbTDURtH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 13:49:07 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:62474 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S261783AbTDURtG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 13:49:06 -0400
Date: Mon, 21 Apr 2003 11:01:21 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Roman Zippel <zippel@linux-m68k.org>
cc: "David S. Miller" <davem@redhat.com>, <Andries.Brouwer@cwi.nl>,
       <hch@infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] new system call mknod64
In-Reply-To: <Pine.LNX.4.44.0304211354280.12110-100000@serv>
Message-ID: <Pine.LNX.4.44.0304211056210.3101-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 21 Apr 2003, Roman Zippel wrote:
> 
> May I ask what advantage it has to split that number?
> Everywhere it's just a simple number, only when we present that number to 
> the user, we create some kind of illusion that this split has any meaning.

Oh, the split has huge meaning inside the kernel. We split the number 
every time we open the device, and use that split to look up the result.

There's another issue, though, which may or may not be a good thing. If we 
split and re-create the device number, that will always force the "dev_t" 
to be in "canonical form", ie if the major and minor both fit in 8 bits, 
then we will always fit the whole dev_t in 16 bits. 

This shows up as a difference in the two approaches: if you consider the 
user-supplied number as a unsplit binary "dev_t", then the user can supply 
a 64-bit number like 0x00000001000000001, and we will actually use that as 
the dev_t. However, if we split it up, and the user supplies <1,1>, then 
we will always generate 0x0000000000000101 as the 64-bit dev_t, and there 
is never any way to generate the "non-canonical" form.

Does it matter? Probably not. I actually think it's slightly preferable to 
alway shave things in the canonical form, and the networked filesystems 
will generally canonicalize it anyway since they usually split it up into 
major/minor. But it _is_ potentially a user-visible difference.

		Linus

