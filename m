Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261370AbUCARYG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 12:24:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261372AbUCARYG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 12:24:06 -0500
Received: from citi.umich.edu ([141.211.133.111]:44725 "EHLO citi.umich.edu")
	by vger.kernel.org with ESMTP id S261370AbUCARYC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 12:24:02 -0500
Date: Mon, 1 Mar 2004 12:24:01 -0500 (EST)
From: Chuck Lever <cel@citi.umich.edu>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Alain Fauconnet <alain@ait.ac.th>, Jo Christian Buvarp <jcb@svorka.no>,
       Enrico Demarin <enricod@videotron.ca>, <linux-kernel@vger.kernel.org>
Subject: Re: Ibm Serveraid Problem with 2.4.25
In-Reply-To: <Pine.LNX.4.44.0403011242580.4148-100000@dmt.cyclades>
Message-ID: <Pine.BSO.4.33.0403011215410.6255-100000@citi.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi marcelo-

your "fix" will break readahead again for NFS.  with the ">=" as you
propose, the read ahead code will never be able to read the last page of
the file as a coalesced read, it will always be a separate 4KB read.

the problem is not the readahead code, it is the driver code that tries
to read beyond the end of the device.  my change merely exposed this
misbehavior.

so there is a broken assumption somewhere about how the index of the last
page of a file/device is computed.  i think it is a problem when the file
ends exactly on a page boundary.

alain, if you don't use the NFS client, marcelo's fix should work just
fine for you.  but i believe that in general it is incorrect.


On Mon, 1 Mar 2004, Marcelo Tosatti wrote:

>
> On Mon, 1 Mar 2004, Alain Fauconnet wrote:
>
> > Please followup to the list when you've drawn conclusions  about  this
> > issue.
> > I'm holding a 2.4.25 upgrade of a busy mail server because of this.
>
> We found out the guilty part, its the readahead modifications done by
> Chuck Lever in -pre1.
>
> The error is harmless though, you can safely move your server to 2.4.25.
> Its just trying to readahead a page beyond the end device.
>
> The following untested patch on top of 2.4.25 should fix it:
>
> --- mm/filemap.c.orig	2004-03-01 12:47:41.000000000 -0300
> +++ mm/filemap.c	2004-03-01 12:48:30.000000000 -0300
> @@ -1346,7 +1346,7 @@
>  	while (ahead < max_ahead) {
>  		unsigned long ra_index = raend + ahead + 1;
>
> -		if (ra_index > end_index)
> +		if (ra_index >= end_index)
>  			break;
>  		if (page_cache_read(filp, ra_index) < 0)
>  			break;
>
>

	- Chuck Lever
--
corporate:	<cel at netapp dot com>
personal:	<chucklever at bigfoot dot com>

