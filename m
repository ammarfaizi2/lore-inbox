Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269873AbUJSRFk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269873AbUJSRFk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 13:05:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269838AbUJSRDS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 13:03:18 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:5262 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269761AbUJSQhH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 12:37:07 -0400
Date: Tue, 19 Oct 2004 12:35:22 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: bgagnon@coradiant.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Memory leak in 2.4.27 kernel, using mmap raw packet sockets
Message-ID: <20041019143522.GA8688@logos.cnet>
References: <OFDDC77A23.4D34536B-ON85256F2D.00514F15-85256F2D.00517F52@coradiant.com> <20041015182352.GA4937@logos.cnet> <1097980764.13226.21.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1097980764.13226.21.camel@localhost.localdomain>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 17, 2004 at 03:39:26AM +0100, Alan Cox wrote:
> On Gwe, 2004-10-15 at 19:23, Marcelo Tosatti wrote:
> > I prefer doing the "if (PageReserved(page)) put_page_testzero(page)" as
> > you propose instead of changing get_user_pages(), as there are several
> > users which rely on its behaviour.
> > 
> > I have applied your fix to the 2.4 BK tree.
> 
> That isnt sufficient. Consider anything else taking a reference to the
> page and the refcount going negative. 

You mean not going negative? The problem here as I understand here is 
we dont release the count if the PageReserved is set, but we should. 

You mean there are other codepaths which release pages? That use __free_pages
which ignores PageReserved pages.

Is the problem wider than what I think?

> And yes 2.6.x has this problem and
> far worse in some ways, but it also has the mechanism to fix it.
> 
> 2.6.x uses VM_IO as a VMA flag which tells the kernel two things
> a) get_user_pages fails on it
> b) core dumping of it is forbidden
> 
> 2.6.x is missing a whole pile of these (fixed in the 2.6.9-ac tree I'm
> putting together). I *think* remap_page_range() in 2.6.x can just set
> VM_IO, but older kernels didn't pass the vma so all the users would need
> fixing (OSS audio, media/video, usb audio, usb video, frame buffer
> etc).

All these are have codepaths which release pages using put_page()'s? 

Thanks
