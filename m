Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030585AbWHIImM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030585AbWHIImM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 04:42:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030582AbWHIImL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 04:42:11 -0400
Received: from mail.gmx.net ([213.165.64.20]:48289 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1030586AbWHIImI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 04:42:08 -0400
X-Authenticated: #271361
Date: Wed, 9 Aug 2006 10:41:59 +0200
From: Edgar Toernig <froese@gmx.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Chase Venters <chase.venters@clientec.com>,
       Pekka Enberg <penberg@cs.helsinki.fi>, Pavel Machek <pavel@ucw.cz>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       akpm@osdl.org, viro@zeniv.linux.org.uk, tytso@mit.edu,
       tigran@veritas.com
Subject: Re: [RFC/PATCH] revoke/frevoke system calls V2
Message-Id: <20060809104159.1f1737d3.froese@gmx.de>
In-Reply-To: <1155039338.5729.21.camel@localhost.localdomain>
References: <Pine.LNX.4.58.0607271722430.4663@sbz-30.cs.Helsinki.FI>
	<20060805122936.GC5417@ucw.cz>
	<20060807101745.61f21826.froese@gmx.de>
	<84144f020608070251j2e14e909v8a18f62db85ff3d4@mail.gmail.com>
	<20060807224144.3bb64ac4.froese@gmx.de>
	<Pine.LNX.4.64.0608071720510.29055@turbotaz.ourhouse>
	<1155039338.5729.21.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
>
> Ar Llu, 2006-08-07 am 17:24 -0500, ysgrifennodd Chase Venters:
> > implementation is crude. "EBADF" is not something that applications are 
> > taught to expect. Someone correct me if I'm wrong, but I can think of no 
> > situation under which a file descriptor currently gets yanked out from 
> > under your feet -- you should always have to formally abandon it with 
> > close().
> 
> The file descriptor is not pulled from under you, the access to it is.
> This is exactly what occurs today when a tty is hung up.

If I read the code correctly, the behaviour for hung up ttys is completely
different: read returns EOF, write returns EIO, select/poll/epoll return
ready, close works.  As rather boring but totally sane behaviour for an fd.

But after revoke you get EBADF for any operation, even select or close.
The fd becomes nearly indistinguishable from a really closed fd (the only
difference is that the fd-number won't be reused (potentional DoS)).
And IMHO that's insane that a regular user may close fds in someone else's
processes (or munmap some of its memory).  I already see people trying
to exploit bugs in system services:

	for (;;) revoke("index.html");
	for (;;) revoke("some_print_job");
	for (;;) revoke("some_mail");

Ciao, ET.
