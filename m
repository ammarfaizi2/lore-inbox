Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261641AbULNUQD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261641AbULNUQD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 15:16:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261642AbULNUQD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 15:16:03 -0500
Received: from fw.osdl.org ([65.172.181.6]:6796 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261641AbULNUPN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 15:15:13 -0500
Date: Tue, 14 Dec 2004 12:15:13 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Matthew Wilcox <matthew@wil.cx>
cc: linux-kernel@vger.kernel.org
Subject: Re: Question about memcpy_fromio prototype
In-Reply-To: <20041214195855.GU27199@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.58.0412141209150.3279@ppc970.osdl.org>
References: <20041214195855.GU27199@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 14 Dec 2004, Matthew Wilcox wrote:
> 
> Hi Linus.  On x86 and ia64, memcpy_fromio is protoyped as:
> 
> static inline void memcpy_fromio(void *dst, volatile void __iomem *src, int count)
> 
> ALSA does this (except on x86 and sparc32, so you don't see it):
> 
> int copy_to_user_fromio(void __user *dst, const void __iomem *src, size_t count)
> [...]
>                 memcpy_fromio(buf, src, c);
> 
> which provokes a warning from gcc that we're discarding a qualifier (the
> 'const') from src.  Is ALSA just wrong?  Or is the 'volatile' wrong?

Neither. The right thing for a read-only IO pointer is actually

	const volatile void __iomem *

which looks funny ("const volatile"?) but makes sense for prototypes,
exactly because a "const volatile" pointer is the most permissive kind of
pointer there is. And it actually does describe the thing perfectly: it is
"const" because we don't write to it ("const" in C does not mean that the
thing is constant, and never has, confusing name and some C++ semantic
changes aside) and obviously as an IO area it's both "volatile" and
"__iomem".

On x86, readb/w/l already gets that right, so I'll just fix
memcpy_fromio(). Other architectures can sort out themselves (ppc64 is
already correct, at least for eeh).

		Linus
