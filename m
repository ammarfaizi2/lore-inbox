Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932352AbWJGFxC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932352AbWJGFxC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 01:53:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932422AbWJGFxB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 01:53:01 -0400
Received: from mail01.verismonetworks.com ([164.164.99.228]:9666 "EHLO
	mail01.verismonetworks.com") by vger.kernel.org with ESMTP
	id S932352AbWJGFxA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 01:53:00 -0400
Subject: Re: [PATCH 1/5] ioremap balanced with iounmap for
	drivers/char/epca.c
From: Amol Lad <amol@verismonetworks.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20061006133516.c5cbf43b.akpm@osdl.org>
References: <1160110625.19143.83.camel@amol.verismonetworks.com>
	 <20061006133516.c5cbf43b.akpm@osdl.org>
Content-Type: text/plain
Date: Sat, 07 Oct 2006 11:26:21 +0530
Message-Id: <1160200581.19143.169.camel@amol.verismonetworks.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-10-06 at 13:35 -0700, Andrew Morton wrote:
> On Fri, 06 Oct 2006 10:27:05 +0530
> Amol Lad <amol@verismonetworks.com> wrote:
> 
> > ioremap must be balanced by an iounmap and failing to do so can result
> > in a memory leak.
> > 
> > Tested (compilation only):
> > - using allmodconfig
> > - making sure the files are compiling without any warning/error due to
> > new changes
> > 
> > Signed-off-by: Amol Lad <amol@verismonetworks.com>
> > ---
> >  epca.c |    5 ++++-
> >  1 files changed, 4 insertions(+), 1 deletion(-)
> > ---
> > diff -uprN -X linux-2.6.19-rc1-orig/Documentation/dontdiff linux-2.6.19-rc1-orig/drivers/char/epca.c linux-2.6.19-rc1/drivers/char/epca.c
> > --- linux-2.6.19-rc1-orig/drivers/char/epca.c	2006-10-05 14:00:42.000000000 +0530
> > +++ linux-2.6.19-rc1/drivers/char/epca.c	2006-10-05 14:50:00.000000000 +0530
> > @@ -1474,8 +1474,11 @@ static void post_fep_init(unsigned int c
> >  	if ((bd->type == PCXEVE || bd->type == PCXE) && (readw(memaddr + XEPORTS) < 3))
> >  		shrinkmem = 1;
> >  	if (bd->type < PCIXEM)
> > -		if (!request_region((int)bd->port, 4, board_desc[bd->type]))
> > +		if (!request_region((int)bd->port, 4, board_desc[bd->type])) {
> > +			iounmap(bd->re_map_membase);
> > +			bd->re_map_membase = NULL;
> >  			return;		
> > +		}
> >  	memwinon(bd, 0);
> >  
> 
> I think this will do the wrong thing if (bd->type >= PCIXEM).  Maybe it's
> OK, but it's not immediately obvious from a quick reading.

A laymans thought here. As ioremap was done for bd->type < PCIXEM, so
iounmap should also be done for the same case.

But as you see the function is void and not handling errors, so this
change can have side effects... well.. it can misbehave even without
this change in the failure case..

> 
> Plus a lot of them are just plain badly coded, so extra care is needed to
> understand the tricks which they're playing.

I think module owner should take responsibility for this. One more
example of badly coded driver is drivers/char/cyclades.c. I was not at
all able to do ioremap balance with iounmap for this one.

