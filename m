Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269127AbUICPJZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269127AbUICPJZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 11:09:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269075AbUICPJY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 11:09:24 -0400
Received: from the-village.bc.nu ([81.2.110.252]:12948 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S269335AbUICPHj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 11:07:39 -0400
Subject: Re: PATCH: fix the barrier IDE detection logic
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: bzolnier@milosz.na.pl
Cc: Alan Cox <alan@redhat.com>, torvalds@osdl.org, axboe@suse.dk,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, akpm@osdl.org
In-Reply-To: <200409031554.31057.bzolnier@elka.pw.edu.pl>
References: <20040831165046.GA6928@devserv.devel.redhat.com>
	 <200409031554.31057.bzolnier@elka.pw.edu.pl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1094220315.7923.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 03 Sep 2004 15:05:16 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2004-09-03 at 14:54, Bartlomiej Zolnierkiewicz wrote:
> I think that logic is reversed here, I guess it should be: enable barrier
> if user enables wcache and disable it if user disables wcache.

Thinking about it from the drive side. If the drive wcache is off then
you have barrier semantics anyway. 

So the logic is something like

has-flush	cache-on		barrier semantics
no-flush	cache-on		random semantics
no-flush	cache-off		barrier semantics
					(the barrier itself is a nop)

> > +	/* Now we have barrier awareness we can be properly conservative
> > +	   by default with other drives. We turn off write caching when
> > +	   barrier is not available. Users can adjust this at runtime if
> 
> This is not true because there is a check for flush cache in write_cache().
> 
> I agree that disabling write cache by default is a good thing but user
> should be informed about this fact (ideally there also should be easily
> available FAQ somewhere) otherwise we will get a lot of bogus bugreports
> about decreased performance...

Agreed. Unfortunately a lot of users are getting burned by journalling
fs's and IDE write caching. As the caches get bigger the risk gets
bigger. SCSI turns it off (and prints a message) so I'd rather see the
write_cache() changed to something like "write_cache_verbose()" and the
printk done than the issue ignored for longer.

Alan


