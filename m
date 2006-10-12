Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750761AbWJLSqR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750761AbWJLSqR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 14:46:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750846AbWJLSqR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 14:46:17 -0400
Received: from smtp109.sbc.mail.mud.yahoo.com ([68.142.198.208]:10146 "HELO
	smtp109.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750842AbWJLSqQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 14:46:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=f4m7/IoE2bLq3BFvW5fYMFMb27cO/cU1ptGwSyUVDGlBH0+hDUajaSB6B9rwh3UAPHqzvUBL+a4pXMArzx9pUtNo2gyhumPQ7b2sn7LcEPHbA29OY4NKLzJypgkr2DCOdy+XO4Y+nG5Lz1QwIeeY9iLqX1CRGGDJT7mcocSXuF4=  ;
From: David Brownell <david-b@pacbell.net>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] SPI: improve sysfs compiler complaint handling
Date: Thu, 12 Oct 2006 11:46:08 -0700
User-Agent: KMail/1.7.1
Cc: Jeff Garzik <jeff@garzik.org>, LKML <linux-kernel@vger.kernel.org>
References: <20061012014920.GA13000@havoc.gtf.org> <200610121108.59727.david-b@pacbell.net> <20061012112449.e9bb7e12.akpm@osdl.org>
In-Reply-To: <20061012112449.e9bb7e12.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610121146.09229.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 12 October 2006 11:24 am, Andrew Morton wrote:
> On Thu, 12 Oct 2006 11:08:59 -0700
> David Brownell <david-b@pacbell.net> wrote:
> 
> > On Wednesday 11 October 2006 6:49 pm, Jeff Garzik wrote:
> > 
> > > The compiler complains, even with the "(void)".
> > 
> > > -	(void) device_for_each_child(master->cdev.dev, NULL, __unregister);
> > 
> > Sure seems like a compiler bug to me.
> 
> Seems like a kernel bug to me.  Look at device_del() and weep.  It calls
> eighty eight things which can fail, some of which randomly return void but
> shouldn't, then drops the overall result on the floor.

That's an isssue too, but it's separate from the one I was describing
(wherein warnings are wrongly issued in the long-established idiom of
"casting into the void").  That compiler bug is causing lots of crap
to be added all over the kernel.

As you implicitly observed, the __unregister() routine really can't
do a thing with faults; it calls "void device_unregister()", which
in turn calls device_del() etc. 


> So if something failed and you come up and reinsert the device or driver
> two days later the kernel collapses in a heap and you don't have a clue
> why.
> 
> You're just a victim of all this.

Well, not me personally but "we" collectively as kernel developers.


> Who wrote all this stuff, and what were they thinking?

I suspect what they were thinking was the old "if you can't figure out
how to handle the error, don't test for it" thing.  I've never quite
agreed that so many cleanup-path routines should return void.  It's not
as if they _can't_ hit failures.  Or that some of those failures can't
be coped with by at stopping further attempts at cleanup...

- Dave

 
