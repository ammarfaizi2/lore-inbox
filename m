Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267338AbUIOTyL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267338AbUIOTyL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 15:54:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267346AbUIOTyL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 15:54:11 -0400
Received: from fw.osdl.org ([65.172.181.6]:5321 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267338AbUIOTx6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 15:53:58 -0400
Date: Wed, 15 Sep 2004 12:53:51 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Greg KH <greg@kroah.com>
cc: J?rn Engel <joern@wohnheim.fh-wedel.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Being more anal about iospace accesses..
In-Reply-To: <20040915193414.GA24131@kroah.com>
Message-ID: <Pine.LNX.4.58.0409151251060.2333@ppc970.osdl.org>
References: <Pine.LNX.4.58.0409081543320.5912@ppc970.osdl.org>
 <Pine.LNX.4.58.0409150737260.2333@ppc970.osdl.org>
 <Pine.LNX.4.58.0409150859100.2333@ppc970.osdl.org> <20040915165450.GD6158@wohnheim.fh-wedel.de>
 <Pine.LNX.4.58.0409151004370.2333@ppc970.osdl.org> <20040915173236.GE6158@wohnheim.fh-wedel.de>
 <Pine.LNX.4.58.0409151045530.2333@ppc970.osdl.org> <20040915193414.GA24131@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 15 Sep 2004, Greg KH wrote:
> 
> Currently a few drivers do:
> 	status = readl(&regs.status);

I assume that's "&regs->status", since regs had better be a pointer..

> which causes sparse warnings.
> 
> How should that code be changed to prevent this?  Convert them all to
> ioread32()?  Or figure out a way to supress the warning for readl()?

Just make sure that you annotate "regs" as a pointer to IO space.

Ie if you have

	struct xxxx __iomem *regs;

then everything will be fine - sparse knows that "regs" is a IO pointer,
and that obviously makes "&regs->member" _also_ an IO pointer.

You'll need that __iomem annotation anyway, since otherwise sparse would
complain when you do the assignment from the "ioremap()" call (and the
thing had better come from ioremap() some way, or it's not valid in the
first place to do "readl()" on it).

		Linus
