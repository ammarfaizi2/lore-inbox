Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262604AbVCDKVy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262604AbVCDKVy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 05:21:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262623AbVCDKVy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 05:21:54 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:23257 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262604AbVCDKVn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 05:21:43 -0500
Date: Fri, 4 Mar 2005 11:21:21 +0100
From: Pavel Machek <pavel@suse.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: rjw@sisk.pl, linux-kernel@vger.kernel.org, hugang@soulinfo.com
Subject: Re: swsusp: use non-contiguous memory on resume
Message-ID: <20050304102121.GG1345@elf.ucw.cz>
References: <20050304095934.GA1731@elf.ucw.cz> <20050304021347.1b3e0122.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050304021347.1b3e0122.akpm@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Subject: non-contiguous pagedir for resume
> > 
> >  This fixes problem where we could have enough memory but not in
> >  continuous chunk, and resume would fail.
> 
> It seems to do more that that?  What's all the assembly stuff?
> 
> General point: this changlog entry doesn't describe the problem and it
> doesn't describe how the patch fixes that problem.  It's a model
> how-not-to ;)

Sorry.

Problem is that pagedir is allocated as order-8 allocation on resume
in -mmX (and linus). Unfortunately, order-8 allocation sometimes
fails, and for some people (Rafael, seife :-) it fails way too often.

Solution is to change format of pagedir from table to linklist,
avoiding high-order alocation. Unfortunately that means changes to
assembly, too, as assembly walks the pagedir.

[Is it better now?]

> >  --- linux-mm/kernel/power/swsusp.c	2005-02-28 01:14:08.000000000 +0100
> >  +++ linux.middle/kernel/power/swsusp.c	2005-02-28 21:29:06.000000000 +0100
> >  @@ -241,7 +241,7 @@
> >   	swp_entry_t entry;
> >   	int error = 0;
> >   
> >  -	entry = get_swap_page(NULL, swp_offset(*loc));
> >  +	entry = get_swap_page();
> 
> Something's gone wrong here.  In -mm, get_swap_page() takes two args and in
> -linus it takes zero args.

Aha, okay, I guess I'll have to wait for resync between submitting
these. Forget the resume-from-initramfs patch...

(Or maybe Rafael is willing to create -mm version and submit it
himself?)

								Pavel

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
