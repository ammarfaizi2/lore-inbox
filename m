Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262494AbVD2LqT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262494AbVD2LqT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 07:46:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262485AbVD2LqT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 07:46:19 -0400
Received: from mailfe03.swip.net ([212.247.154.65]:52669 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S262494AbVD2LqB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 07:46:01 -0400
X-T2-Posting-ID: jLUmkBjoqvly7NM6d2gdCg==
Subject: Re: 2.6.11.7 kernel panic on boot on AMD64
From: Alexander Nyberg <alexn@telia.com>
To: Andrew Morton <akpm@osdl.org>
Cc: ruben@puettmann.net, linux-kernel@vger.kernel.org, rddunlap@osdl.org,
       ak@suse.de
In-Reply-To: <20050429031027.62d17bfa.akpm@osdl.org>
References: <20050427140342.GG10685@puettmann.net>
	 <1114769162.874.4.camel@localhost.localdomain>
	 <20050429031027.62d17bfa.akpm@osdl.org>
Content-Type: text/plain
Date: Fri, 29 Apr 2005 13:45:59 +0200
Message-Id: <1114775159.497.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fre 2005-04-29 klockan 03:10 -0700 skrev Andrew Morton:
> Alexander Nyberg <alexn@telia.com> wrote:
> >
> > >                                                                                                            
> > > I'm trying to install linux on an HP DL385 but directly on boot I got                                           
> > > this kernel panic:
> > > 
> > >         http://www.puettmann.net/temp/panic.jpg
> > 
> > 
> > This is bogus appending stuff to the saved_command_line and at the same
> > time in Rubens case it touches the late_time_init() which breakes havoc.
> 
> -ETOOTERSE.  Do you meen that the user's command line was so long that this
> strcat wandered off the end of the buffer and corrupted late_time_init?

Yes indeed, 256 chars has now really been proven to not be long enough.

> 
> > Signed-off-by: Alexander Nyberg <alexn@telia.com>
> > 
> > Index: linux-2.6/arch/x86_64/kernel/head64.c
> > ===================================================================
> > --- linux-2.6.orig/arch/x86_64/kernel/head64.c	2005-04-26 11:41:43.000000000 +0200
> > +++ linux-2.6/arch/x86_64/kernel/head64.c	2005-04-29 11:57:46.000000000 +0200
> > @@ -93,9 +93,6 @@
> >  #ifdef CONFIG_SMP
> >  	cpu_set(0, cpu_online_map);
> >  #endif
> > -	/* default console: */
> > -	if (!strstr(saved_command_line, "console="))
> > -		strcat(saved_command_line, " console=tty0"); 
> 
> Wasn't that code there for a reason?

Appending console=tty0 is from what I can see redundant. And if it
really has a reason it needs a comment and a check to see if there
really is room in saved_command_line for it. We'll see what Andi has to
say...

btw x64 is seemingly the only architecture that actually uses
saved_command_line as the real working command line and not
command_line, this is a bit confusing.

