Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261276AbVAaSVP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261276AbVAaSVP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 13:21:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261296AbVAaSVP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 13:21:15 -0500
Received: from gprs214-76.eurotel.cz ([160.218.214.76]:56192 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261276AbVAaSVI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 13:21:08 -0500
Date: Mon, 31 Jan 2005 19:20:55 +0100
From: Pavel Machek <pavel@suse.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] swsusp: do not use higher order memory allocations on suspend
Message-ID: <20050131182055.GB1507@elf.ucw.cz>
References: <200501281454.23167.rjw@sisk.pl> <200501300052.55545.rjw@sisk.pl> <20050131130631.GF6279@elf.ucw.cz> <200501311510.12979.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501311510.12979.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > static inline void free_pagedir(struct pbe *pblist)
> > {
> >         struct pbe *pbe;
> > 
> >         while (pblist) {
> >                 pbe = pblist + PB_PAGE_SKIP;
> >                 pblist = pbe->next;
> >                 free_page((unsigned long)pbe);
> >         }
> >         pr_debug("free_pagedir(): done\n");
> > }
> > 
> > Should not you free_page(pblist) instead? This passes address in
> > middle of page to free_page, that seems wrong.
> 
> Certainly.  It should be something like that:
> 
> while (pblist) {
> 	pbe = pblist;
> 	pblist = (pbe + PB_PAGE_SKIP)->next;
> 	free_page((unsigned long)pbe);
> }

Hmm, I see, my "fix" leaks one page of memory during each
suspend... I've fixed it properly now and will eventually propagete it
back.

This should be right..

        while (pblist) {
                pbe = (pblist + PB_PAGE_SKIP)->next;
                free_page((unsigned long)pblist);
                pblist = pbe;
        }


								Pavel

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
