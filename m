Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264186AbUD0Ph6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264186AbUD0Ph6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 11:37:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264184AbUD0Ph5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 11:37:57 -0400
Received: from dh132.citi.umich.edu ([141.211.133.132]:45955 "EHLO
	lade.trondhjem.org") by vger.kernel.org with ESMTP id S264186AbUD0Pgv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 11:36:51 -0400
Subject: Re: 2.6.6-rc{1,2} bad VM/NFS interaction in case of dirty page
	writeback
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Andrew Morton <akpm@osdl.org>
Cc: sgoel01@yahoo.com, linux-kernel@vger.kernel.org
In-Reply-To: <20040426225834.7035d2c1.akpm@osdl.org>
References: <20040427011237.33342.qmail@web12824.mail.yahoo.com>
	 <20040426191512.69485c42.akpm@osdl.org>
	 <1083035471.3710.65.camel@lade.trondhjem.org>
	 <20040426205928.58d76dbc.akpm@osdl.org>
	 <1083043386.3710.201.camel@lade.trondhjem.org>
	 <20040426225834.7035d2c1.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1083080207.2616.31.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 27 Apr 2004 11:36:47 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-04-27 at 01:58, Andrew Morton wrote:

> > Currently, we use this on virtually anything that trigggers writepage()
> > with the wbc->for_reclaim flag set.
> 
> Why?  Sorry, I still do not understand the effect which you're trying to
> achieve?  I thought it was an efficiency thing: send more traffic via
> writepages().  But your other comments seem to indicate that this is not
> the primary reason.

That is the primary reason. Under NFS, writing is a 2 stage process:

 - Stage 1: "schedule" the page for writing. Basically this entails
creating an nfs_page struct for each dirty page and putting this on the
NFS private list of dirty pages.
 - Stage 2: "flush" the NFS private list of dirty pages. This involves
coalescing contiguous nfs_page structs into chunks of size "wsize", and
actually putting them on the wire in the form of RPC requests.

writepage() only deals with one page at a time, so it will work fine for
doing stage 1.
If you also try force it to do stage 2, then you will end up with chunks
of size <= PAGE_CACHE_SIZE because there will only be 1 page on the NFS
private list of dirty pages. In practice this again means that you
usually have to send 8 times as many RPC requests to the server in order
to process the same amount of data.

This is why I'd like to try to leave stage 2) to writepages().

Now normally, that is not a problem, since the actual calls to
writepage() are in fact made by means of a call to generic_writepages()
from within nfs_writepages(), so I can do all the correct things once
I'm done with generic_writepages().

However shrink_cache() (where the MM calls writepage() directly) needs
to be treated specially, since that is not wrapped by a writepages()
call. In that case, we return WRITEPAGE_ACTIVATE and wait for pdflush to
call writepages().

Cheers,
  Trond
