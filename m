Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261936AbVDKVJR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261936AbVDKVJR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 17:09:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261941AbVDKVJR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 17:09:17 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:9705 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261936AbVDKVIj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 17:08:39 -0400
Date: Mon, 11 Apr 2005 23:08:19 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andreas Steinmetz <ast@domdv.de>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH encrypted swsusp 1/3] core functionality
Message-ID: <20050411210819.GF23530@elf.ucw.cz>
References: <4259B474.4040407@domdv.de> <20050411110822.GA10401@elf.ucw.cz> <425AA19F.6040802@domdv.de> <200504112257.39708.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200504112257.39708.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I had no time to review your patch earlier, sorry.  I'm inlining it so that I can
> comment it:

> > @@ -72,6 +75,16 @@
> >  
> >  #include "power.h"
> >  
> > +#ifdef CONFIG_SWSUSP_ENCRYPT
> > +#include <linux/random.h>
> > +#include <linux/crypto.h>
> > +#include <asm/scatterlist.h>
> > +#endif
> > +
> > +#define CIPHER "aes"
> > +#define MAXKEY 32
> > +#define MAXIV  32
> 
> Why not to put these definitions under #ifdef?
> 
> > +
> >  /* References to section boundaries */
> >  extern const void __nosave_begin, __nosave_end;
> >  
> > @@ -104,7 +117,9 @@
> >  #define SWSUSP_SIG	"S1SUSPEND"
> >  
> >  static struct swsusp_header {
> > -	char reserved[PAGE_SIZE - 20 - sizeof(swp_entry_t)];
> 
> I would add #ifdef here as well.

I think avoiding both ifdefs is actually right thing to do. Keep the
ifdef noise down.

> > +	char reserved[PAGE_SIZE - 20 - MAXKEY - MAXIV - sizeof(swp_entry_t)];
> > +	u8 key[MAXKEY];
> > +	u8 iv[MAXIV];
> >  	swp_entry_t swsusp_info;
> >  	char	orig_sig[10];
> >  	char	sig[10];
> > @@ -112,6 +127,11 @@
> >  
> >  static struct swsusp_info swsusp_info;
> >  
> > +#ifdef CONFIG_SWSUSP_ENCRYPT
> > +static u8 key[MAXKEY];
> > +static u8 iv[MAXIV];
> > +#endif
> > +
> >  /*
> >   * XXX: We try to keep some more pages free so that I/O operations succeed
> >   * without paging. Might this be more?
> > @@ -130,6 +150,52 @@
> >  static unsigned short swapfile_used[MAX_SWAPFILES];
> >  static unsigned short root_swap;
> >  
> > +#ifdef CONFIG_SWSUSP_ENCRYPT
> > +static struct crypto_tfm *crypto_init(int mode)
> 
> I think it's better if this function returns an int error code and the
> messages are printed where it's called from.  This way, the essential
> part of the code would be easier to grasp (Pavel?).

Agreed. Actually I do not care where messages are printed, but
returning different code for different errors seems right.

							Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.
