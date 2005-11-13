Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750772AbVKMWcd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750772AbVKMWcd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Nov 2005 17:32:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750776AbVKMWcc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Nov 2005 17:32:32 -0500
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:40855 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S1750772AbVKMWcc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Nov 2005 17:32:32 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFT][PATCH 3/3] swsusp: improve freeing of memory
Date: Sun, 13 Nov 2005 23:27:33 +0100
User-Agent: KMail/1.8.3
Cc: kernel list <linux-kernel@vger.kernel.org>
References: <200511122113.22177.rjw@sisk.pl> <200511122124.42675.rjw@sisk.pl> <20051113211409.GD2119@elf.ucw.cz>
In-Reply-To: <20051113211409.GD2119@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511132327.33877.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sunday, 13 of November 2005 22:14, Pavel Machek wrote:
> Hi!
> 
> > This patch makes swsusp free only as much memory as needed and not as much
> > as possible.
> 
> Looks okay to me. ACK, modulo few small things.
> 
> > -
> >  /* References to section boundaries */
> >  extern const void __nosave_begin, __nosave_end;
> >  
> >  extern unsigned int nr_copy_pages;
> > -extern suspend_pagedir_t *pagedir_nosave;
> > -extern suspend_pagedir_t *pagedir_save;
> > +extern struct pbe *pagedir_nosave;
> > +
> > +/*
> > + * This compilation switch determines the way in which memory will be freed
> > + * during suspend.  If defined, only as much memory will be freed as needed
> > + * to complete the suspend.  Otherwise, the largest possible amount of memory
> > + * will be freed.
> > + */
> > +#define OPPORTUNISTIC_SHRINKING		1
> 
> Can you use little less tabelators? Also shorter name for this one
> might be "FREE_ALL". 

OK

> > +/*
> > + * During suspend, on each attempt to free some more memory SHRINK_BITE
> > + * is used as the number of pages to free
> > + */
> > +#define SHRINK_BITE	10000
> 
> Does this really need this kind of visibility? There's nothing user
> should tweak here.

By setting this to a smaller value you can make swsusp free more memory
sometimes, but of course it need not be visible.  I'll move it to swsusp.c

> >  /**
> > + *	On resume it is necessary to trace and eventually free the unsafe
> > + *	pages that have been allocated, because they are needed for I/O
> > + *	(on x86-64 we likely will "eat" these pages once again while
> > + *	creating the temporary page translation tables)
> > + */
> > +
> > +struct eaten_page {
> > +	struct eaten_page	*next;
> > +	char			padding[PAGE_SIZE - sizeof(void *)];
> > +};
> 
> Less tabelators here, please...

OK

Greetings,
Rafael

