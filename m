Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750782AbVKAM4w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750782AbVKAM4w (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 07:56:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750780AbVKAM4w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 07:56:52 -0500
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:45757 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S1750783AbVKAM4w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 07:56:52 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 2/3] swsusp: move snapshot-handling functions to snapshot.c
Date: Tue, 1 Nov 2005 13:57:16 +0100
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org
References: <200510301637.48842.rjw@sisk.pl> <200510312036.36335.rjw@sisk.pl> <20051031220233.GC14877@elf.ucw.cz>
In-Reply-To: <20051031220233.GC14877@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511011357.16995.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Monday, 31 of October 2005 23:02, Pavel Machek wrote:
> Hi!
> 
> > > > This patch moves the snapshot-handling functions remaining in swsusp.c
> > > > to snapshot.c (ie. it moves the code without changing the functionality).
> > > >
> > > 
> > > I'm sorry, but I acked this one too quickly. I'd prefer to keep "relocate" code where
> > > it is, and define "must not collide" as a part of interface. That will keep snapshot.c
> > > smaller/simpler,
> > 
> > Speaking of simplifications and having seen your code I hope you will agree with
> > the appended patch against vanilla 2.6.14-git3 (it reduces the duplication of code,
> > and replaces swsusp_pagedir_relocate with a simpler mechanism).
> 
> ...and also moves stuff around in a way
> 
> a) I don't like
> 
> and
> 
> b) is almost impossible to review

OK, I'll try to split it into two patches to make it cleaner.

> :-). Can you keep "relocate" code in swsusp.c, just making it simpler?

If you mean mark_unsafe_pages() and copy_backup_list(), no problem.
The rest is still there.

> 
> > @@ -997,20 +870,22 @@
> >  	int error = 0;
> >  	struct pbe *p;
> >  
> > -	if (!(p = alloc_pagedir(nr_copy_pages)))
> > +	if (!(p = alloc_pagedir(nr_copy_pages, 0)))
> >  		return -ENOMEM;
> >  
> >  	if ((error = read_pagedir(p)))
> >  		return error;
> > -
> >  	create_pbe_list(p, nr_copy_pages);
> > -
> > -	if (!(pagedir_nosave = swsusp_pagedir_relocate(p)))
> > +	mark_unsafe_pages(p);
> > +	if (!(pagedir_nosave = alloc_pagedir(nr_copy_pages, 1)))
> >  		return -ENOMEM;
> 
> Okay, this is probably better approach than copying pagedir around...

It's nice you agree here. :-)

Greetings,
Rafael
