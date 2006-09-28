Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751623AbWI1HA1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751623AbWI1HA1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 03:00:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751622AbWI1HA1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 03:00:27 -0400
Received: from smtp.osdl.org ([65.172.181.4]:26334 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751285AbWI1HA0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 03:00:26 -0400
Date: Thu, 28 Sep 2006 00:00:19 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andi Kleen <ak@muc.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Put the BUG __FILE__ and __LINE__ info out of line
Message-Id: <20060928000019.3fb4b317.akpm@osdl.org>
In-Reply-To: <451B708D.20505@goop.org>
References: <451B64E3.9020900@goop.org>
	<20060927233509.f675c02d.akpm@osdl.org>
	<451B708D.20505@goop.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Sep 2006 23:49:49 -0700
Jeremy Fitzhardinge <jeremy@goop.org> wrote:

> Andrew Morton wrote:
> > hm.  Bigger vmlinux, smaller .text.
> >   
> 
> Yep.
> 
> > It means that we'll hit handle_BUG with that extra EIP pushed on the stack.
> >  What does that do to the stack trace, and to the unwinder?
> >   
> Dunno.  I was hoping Andi would pop up with the appropriate CFI gunk, if 
> necessary.  But the reason for making it a call was to make it as 
> unwindable as possible.
> 
> > It'll also muck up the displayed EIP, not that that matters a lot (well, it
> > might matter a bit if the BUG is in an inlined function).
> >
> > We could get the correct EIP by fishing it off the stack (and subtracting
> > five from it?)
> >   
> 
> Yes, that's possible.
> 
> > Or we could assume that BUG doesn't return (it doesn't) and make that call
> > a jmp.  But then we'd really lose the EIP.
> 
> Right.  Or it could save the EIP along with the line and filename.
> 

Plan #17 is to just put the BUG inline and then put the EIP+file*+line into
a separate section, then search that section at BUG time to find the record
whose EIP points back at this ud2a.

It's a bit messy for modules, but it minimises the .text impact and keeps
disassembly happy, no?

And if done right it can probably be used by other architectures.
