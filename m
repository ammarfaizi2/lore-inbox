Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262832AbUCOWbM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 17:31:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262827AbUCOWbF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 17:31:05 -0500
Received: from citi.umich.edu ([141.211.133.111]:8468 "EHLO citi.umich.edu")
	by vger.kernel.org with ESMTP id S262789AbUCOWaY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 17:30:24 -0500
Date: Mon, 15 Mar 2004 17:30:22 -0500 (EST)
From: Chuck Lever <cel@citi.umich.edu>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Ibm Serveraid Problem with 2.4.25 (fwd)
In-Reply-To: <Pine.LNX.4.44.0403051440260.29304-100000@dmt.cyclades>
Message-ID: <Pine.BSO.4.33.0403151719560.14850-100000@citi.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

marcelo-

i think at this point the problem is:

the devices in question do NOT end on a page boundary.  readahead is
scheduling reads by page rather than by sector, so when the device ends in
the middle of a page, it causes some buffers to be scheduled past the end
of such a device.

for example, if the device is exactly 15 1K sectors long, readahead will
schedule a page read from 12K to 16K.  when it gets to that last 1K
sector, the buffer layer complains that someone is trying to read past the
end of the device.  with the old readahead logic, readahead would stop
short of the last page, so it couldn't trigger this problem.

can anyone confirm or deny this analysis?

if there isn't an easy solution to this, i suggest we simply use your
one-line fix and forget about the uncoalesced read problem in 2.4.  in
2.6, the readahead algorithm is entirely replaced, and i don't think this
is an issue.

On Fri, 5 Mar 2004, Marcelo Tosatti wrote:

>
> FYI
>
> ---------- Forwarded message ----------
> Date: Fri, 05 Mar 2004 12:15:11 -0500
> From: Enrico Demarin <enricod@videotron.ca>
> To: Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>
> Subject: Re: Ibm Serveraid Problem with 2.4.25 (fwd)
>
> Hi Marcelo,
>
> No, the problem is still there with vanilla 2.4.25 + 26-pre1 + chuck's
> patch.
>
> - Enrico
>
> On Fri, 2004-03-05 at 07:23, Marcelo Tosatti wrote:
> > Hi fellows,
> >
> > Can you please try Chuck's patch on top of 2.4.26-pre1 and check if the
> > problem goes away?
> >
> > Thanks
> >
> > ---------- Forwarded message ----------
> > Date: Tue, 2 Mar 2004 00:18:24 -0500 (EST)
> > From: Chuck Lever <cel@citi.umich.edu>
> > To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
> > Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
> > Subject: Re: Ibm Serveraid Problem with 2.4.25
> >
> > hi marcelo-
> >
> > this patch seems to address the extra read at the end of files or devices
> > that end exactly on a page boundary, while retaining the good readahead
> > characteristics of my original patch.  i'd like to hear about any testing
> > from folks who have one of:
> >
> >   mpt fusion
> >   ips (ibm serveraid)
> >   promise ata (and maybe sata too)
> >
> > this patch is against 2.4.26-pre1.
> >
> >
> > diff -X ../dont-diff -Naurp 00-stock/mm/filemap.c 01-readahead/mm/filemap.c
> > --- 00-stock/mm/filemap.c	2004-02-18 08:36:32.000000000 -0500
> > +++ 01-readahead/mm/filemap.c	2004-03-02 00:07:59.000000000 -0500
> > @@ -1285,7 +1285,8 @@ static void generic_file_readahead(int r
> >  	unsigned long raend;
> >  	int max_readahead = get_max_readahead(inode);
> >
> > -	end_index = inode->i_size >> PAGE_CACHE_SHIFT;
> > +	end_index = ((inode->i_size + ~PAGE_CACHE_MASK) >>
> > +						PAGE_CACHE_SHIFT) - 1;
> >
> >  	raend = filp->f_raend;
> >  	max_ahead = 0;
> >
> >
> > 	- Chuck Lever
> > --
> > corporate:	<cel at netapp dot com>
> > personal:	<chucklever at bigfoot dot com>
> >
> >
> >
>
>

	- Chuck Lever
--
corporate:	<cel at netapp dot com>
personal:	<chucklever at bigfoot dot com>

