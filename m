Return-Path: <linux-kernel-owner+w=401wt.eu-S965241AbXAKFuz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965241AbXAKFuz (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 00:50:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965249AbXAKFuz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 00:50:55 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:50857 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965241AbXAKFuy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 00:50:54 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JThNQRQkfupORM0ngucQxZw042PyKrcBJUl+rZXEQIr6lECYOm6F0L8Q3Vmil9MYaHXWyuzp2QJYQvaeRexd3Dmbi/bYYYpGs/J1N/xOcmLuiIfnLBxjKm6/Smw/U6/d8klry4kDfbu7Gggi3TaTcXafS7ONWVnqSLptk4LEDRg=
Message-ID: <6d6a94c50701102150w4c3b46d0w6981267e2b873d37@mail.gmail.com>
Date: Thu, 11 Jan 2007 13:50:53 +0800
From: Aubrey <aubreylee@gmail.com>
To: "Linus Torvalds" <torvalds@osdl.org>
Subject: Re: O_DIRECT question
Cc: "Hua Zhong" <hzhong@gmail.com>, "Hugh Dickins" <hugh@veritas.com>,
       linux-kernel@vger.kernel.org, hch@infradead.org,
       kenneth.w.chen@intel.com, akpm@osdl.org, mjt@tls.msk.ru
In-Reply-To: <Pine.LNX.4.64.0701101902270.3594@woody.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <6d6a94c50701101857v2af1e097xde69e592135e54ae@mail.gmail.com>
	 <Pine.LNX.4.64.0701101902270.3594@woody.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Firstly I want to say I'm working on no-mmu arch and uClinux.
After much of file operations VFS cache eat up all of the memory.
At this time, if an application request memory which order > 3, the
kernel will report failure.

uClinux use a memory mapped MTD driver to store rootfs, of course it's
in the ram,
So I don't need VFS cache to improve performance. And when order > 3,
__alloc_page() even doesn't try to shrunk cache and slab, just report
failure.

So my thought is remove cache, or limit it. But currently there seems
to be no way in the kernel to do it.  So I want to try to use
O_DIRECT. But it seems not to be a right way.

Thanks for your suggestion about my case.

Regards,
-Aubrey

On 1/11/07, Linus Torvalds <torvalds@osdl.org> wrote:
>
>
> On Thu, 11 Jan 2007, Aubrey wrote:
> >
> > Now, my question is, is there a existing way to mount a filesystem
> > with O_DIRECT flag? so that I don't need to change anything in my
> > system. If there is no option so far, What is the right way to achieve
> > my purpose?
>
> The right way to do it is to just not use O_DIRECT.
>
> The whole notion of "direct IO" is totally braindamaged. Just say no.
>
>         This is your brain: O
>         This is your brain on O_DIRECT: .
>
>         Any questions?
>
> I should have fought back harder. There really is no valid reason for EVER
> using O_DIRECT. You need a buffer whatever IO you do, and it might as well
> be the page cache. There are better ways to control the page cache than
> play games and think that a page cache isn't necessary.
>
> So don't use O_DIRECT. Use things like madvise() and posix_fadvise()
> instead.
>
>                 Linus
>
