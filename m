Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262288AbTJGMdk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 08:33:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262304AbTJGMdk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 08:33:40 -0400
Received: from gate.perex.cz ([194.212.165.105]:58290 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id S262288AbTJGMdi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 08:33:38 -0400
Date: Tue, 7 Oct 2003 14:33:21 +0200 (CEST)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@pnote.perex-int.cz
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, andrea@suse.com,
       riel@redhat.com, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>
Subject: Re: [PATCH] memory counting fix
In-Reply-To: <Pine.LNX.4.44.0310070844030.1494-100000@logos.cnet>
Message-ID: <Pine.LNX.4.53.0310071427510.1357@pnote.perex-int.cz>
References: <Pine.LNX.4.44.0310070844030.1494-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Oct 2003, Marcelo Tosatti wrote:

>
> I dont see why reserved pages shouldnt be counted in the processes RSS.
>
> What I'm missing here, Jaroslav?

Note that zap_pte_range() in mm/memory.c does not free the reserved pages:

                        if (VALID_PAGE(page) && !PageReserved(page))
                                freed ++;

I think that the drivers should not take care about correcting the mm->rss
counter itself and we have exactly same patch in 2.6.

						Jaroslav

> On Tue, 30 Sep 2003, Jaroslav Kysela wrote:
>
> > Hi,
> >
> > 	this fixes rss pages counting for drivers which returns a reserved
> > page from the nopage callback (like ALSA). Thank you for applying to the
> > 2.4 tree.
> >
> > ===== memory.c 1.56 vs edited =====
> > --- 1.56/mm/memory.c	Fri Apr  5 20:06:57 2002
> > +++ edited/memory.c	Tue Sep 30 13:10:20 2003
> > @@ -1287,7 +1287,8 @@
> >  	 */
> >  	/* Only go through if we didn't race with anybody else... */
> >  	if (pte_none(*page_table)) {
> > -		++mm->rss;
> > +		if (!PageReserved(new_page))
> > +			++mm->rss;
> >  		flush_page_to_ram(new_page);
> >  		flush_icache_page(vma, new_page);
> >  		entry = mk_pte(new_page, vma->vm_page_prot);
>
> I dont see why
>
>

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs
