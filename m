Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267135AbSLaEFq>; Mon, 30 Dec 2002 23:05:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267137AbSLaEFq>; Mon, 30 Dec 2002 23:05:46 -0500
Received: from packet.digeo.com ([12.110.80.53]:53139 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267135AbSLaEFp>;
	Mon, 30 Dec 2002 23:05:45 -0500
Message-ID: <3E11198B.EEDE0DC0@digeo.com>
Date: Mon, 30 Dec 2002 20:14:03 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.52 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Matthew Zahorik <matt@albany.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: How does the disk buffer cache work?
References: <3E10F1C7.258629F6@digeo.com> <Pine.BSF.4.43.0212302153400.370-100000@ender.tmmz.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 31 Dec 2002 04:14:04.0365 (UTC) FILETIME=[0E1AFFD0:01C2B083]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Zahorik wrote:
> 
> On Mon, 30 Dec 2002, Andrew Morton wrote:
> 
> > > [.. the next function call in read_cache_page() is lock_page(), which we
> > > hang forever on ..]
> >
> > lock_page() will sleep until the page is unlocked.  The page is unlocked
> > from end_buffer_io_sync(), which is called from within the context of
> > the disk device driver's interrupt handler.
> 
> Okay, I'll track it down there.  Probably the driver not calling
> end_buffer_io_sync() when timed out.  When the bad drive is detached,
> things work fine - leading me to believe that hardware and interrupt
> routing wise things are okay.
> 

It won't call end_buffer_io_sync() explicitly - it calls the function which
is pointed at by the relevant buffer's b_end_io vector.  Typically that
will point at end_buffer_io_aysnc() or end_buffer_io_sync()
