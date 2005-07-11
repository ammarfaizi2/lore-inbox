Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261188AbVGKS3Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261188AbVGKS3Q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 14:29:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261509AbVGKS3E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 14:29:04 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:5586 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261393AbVGKS2O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 14:28:14 -0400
Subject: Re: Dirty page tracking patch
From: Arjan van de Ven <arjan@infradead.org>
To: Kimball Murray <kmurray@redhat.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <42D2B774.5080409@redhat.com>
References: <20050711131531.8257.62845.sendpatchset@dhcp83-73.boston.redhat.com>
	 <1121088959.3177.24.camel@laptopd505.fenrus.org>
	 <42D2B774.5080409@redhat.com>
Content-Type: text/plain
Date: Mon, 11 Jul 2005 20:28:09 +0200
Message-Id: <1121106489.3177.36.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 2.9 (++)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (2.9 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	2.8 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> >
> >is the stratus code entirely open source/GPL ? (I assume it is since you
> >EXPORT_SYMBOL_GPL and also use other similar stuff). If so.. could you
> >post an URL to that? It's customary to do so when you post interface
> >patches for review so that the users of the interfaces can be seen, and
> >thus the interface better reviewed.
> >
> I don't have access to a Stratus web server where I could post the code, 
> since I'm currently sitting at a Redhat desk :)  So if you'll indulge 
> me, I'll attach the harvest code to this note.  The harvest code is one 
> component of a GPL'd kernel module.  The harvest component is the only 
> one that interacts with the dirty page tracking patch.  Other parts of 
> the module do PCI-hotplug related things that are specific to our platform.

ok so your entire kernel side stack is GPL? Good.
> >
> >+#define mm_track(ptep)
> >
> >you have to make that a do { ; } while (0) define as per kernel
> >convention/need
> >
> >also you now make set_pte() and co more than trivial assignments, please
> >convert them to inlines so that typechecking is performed and no double
> >evaluation of arguments is done!
> >(this is a real problem for code that would do set_pte(pte++, value) in
> >a loop or so)
> >
> thanks,  I'll make those changes and re-build/re-test/re-post.
> 
> >-       if (!pte_dirty(*ptep))
> >-               return 0;
> >-       return test_and_clear_bit(_PAGE_BIT_DIRTY, &ptep->pte_low);
> >+       mm_track(ptep);
> >+               return (test_and_clear_bit(_PAGE_BIT_DIRTY,
> >&ptep->pte_low) |
> >+               test_and_clear_bit(_PAGE_BIT_SOFTDIRTY,
> >&ptep->pte_low));
> > }
> >
> >
> >are you sure you're not introducing a race condition there?
> >and if you're sure, why do you need 2 atomic ops in sequence?
> >
> I think we're OK there. That code only appears in the sys_msync path
> (sync_page_range), after the page table lock is taken.  The only code
> that moves hardware dirty bits to software dirty bits is in the harvest
> itself (attached).  And that code runs with all other cpus parked.

then you didn't answer my question about why the lock; atomic bit is
needed ;)


