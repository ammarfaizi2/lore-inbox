Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261615AbTJWOb6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 10:31:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263587AbTJWOb6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 10:31:58 -0400
Received: from fw.osdl.org ([65.172.181.6]:54233 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261615AbTJWOb4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 10:31:56 -0400
Date: Thu, 23 Oct 2003 07:31:46 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Mikael Pettersson <mikpe@csd.uu.se>
cc: "M.H.VanLeeuwen" <vanl@megsinet.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <marcelo.tosatti@cyclades.com>
Subject: Re: [BUG somewhere] 2.6.0-test8 irq.c, IRQ_INPROGRESS ?
In-Reply-To: <16279.48084.668213.169062@alkaid.it.uu.se>
Message-ID: <Pine.LNX.4.44.0310230729000.6753-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 23 Oct 2003, Mikael Pettersson wrote:
> 
> It seems 2.4.23-pre8 included something like this apparently broken
> change (see diff from -pre7 below). Should it be reverted?

No, that one is correct. IRQ_INPROGRESS should indeed be cleared when the 
first handler is installed. It's only clearing it at enable_irq() that is 
wrong.

Also, the "disable_irq()" function _should_ look something like this:

	void disable_irq(unsigned int irq)
	{
	        irq_desc_t *desc = irq_desc + irq;
	        disable_irq_nosync(irq);
	        if (desc->action)
	                synchronize_irq(irq);
	}

ie it should only do synchronize_irq() if a handler exists. That fixes a
potential problem with drivers doing multiple disable_irq()/enable_irq()  
while no handler has been assigned yet.

		Linus

