Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266688AbSKLRul>; Tue, 12 Nov 2002 12:50:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266755AbSKLRuk>; Tue, 12 Nov 2002 12:50:40 -0500
Received: from fmr05.intel.com ([134.134.136.6]:29171 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP
	id <S266688AbSKLRui>; Tue, 12 Nov 2002 12:50:38 -0500
Message-ID: <A46BBDB345A7D5118EC90002A5072C7806CAC923@orsmsx116.jf.intel.com>
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "'Jamie Lokier'" <lk@tantalophile.demon.co.uk>
Cc: Rusty Russell <rusty@rustcorp.com.au>,
       "'mingo@redhat.com'" <mingo@redhat.com>,
       "'Mark Mielke'" <mark@mark.mielke.cc>, linux-kernel@vger.kernel.org
Subject: RE: Users locking memory using futexes
Date: Tue, 12 Nov 2002 09:57:18 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Good thing is - I just found out after reading twice - that 
> FUTEX_FD does
> > not lock the page in memory, so that is one case less to 
> worry about. 
> 
> Oh yes it does - the page isn't unpinned until wakeup or close.
> See where it says in futex_fd():
> 
> 	page = NULL;
> out:
> 	if (page)
> 		unpin_page(page);

Bang, bang, bang ... assshoooole [hearing whispers in my ears]. Great point:
Inaky 0, Jamie 1 - this will teach me to read _three_ times on Monday
evenings. I am supposed to know all that code by heart ... oh well.

> Rusty's got a good point about pipe() though.

He does; grumble, grumble ... let's see ... with pipe you have an implicit
limit that controls you, the number of open files, that you also hit with
futex_fd() (in ... get_unused_fd()) - so that is covered. OTOH, with just
futex_wait(), if you are up to use one page per futex you lock on, you are
also limited by RLIMIT_NPROC for every process you lock on [asides from
wasting a lot of memory], so looks like there is another roadblock there to
control it.

Hum ... still I want to try Ingo's approach on the ptes; that is the part I
was missing [knowing that struct page * is not invariant as the pte number
... even being as obvious as it is].

Inaky Perez-Gonzalez -- Not speaking for Intel - opinions are my own [or my
fault]

