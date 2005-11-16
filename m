Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030414AbVKPSeb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030414AbVKPSeb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 13:34:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030428AbVKPSeb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 13:34:31 -0500
Received: from pat.uio.no ([129.240.130.16]:64687 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1030414AbVKPSeb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 13:34:31 -0500
Subject: Re: mmap over nfs leads to excessive system load
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Andrew Morton <akpm@osdl.org>
Cc: theonetruekenny@yahoo.com, linux-kernel@vger.kernel.org
In-Reply-To: <20051116100053.44d81ae2.akpm@osdl.org>
References: <20051116150141.29549.qmail@web34113.mail.mud.yahoo.com>
	 <1132163057.8811.15.camel@lade.trondhjem.org>
	 <20051116100053.44d81ae2.akpm@osdl.org>
Content-Type: text/plain
Date: Wed, 16 Nov 2005 13:34:22 -0500
Message-Id: <1132166062.8811.30.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.854, required 12,
	autolearn=disabled, AWL 1.15, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-11-16 at 10:00 -0800, Andrew Morton wrote:

> That will fix it, but the PageWriteback accounting is still wrong.
> 
> Is it not possible to use set_page_writeback()/end_page_writeback()?

Not really. The pages aren't flushed at this time. We the point is to
gather several pages and coalesce them into one over-the-wire RPC call.
That means we cannot really do it from inside ->writepage().

We do start the actual RPC calls in ->writepages(), though.

> Are these pages marked "unstable" at this time?

No. "unstable" means that the RPC call to send the pages to the server
has completed, but the pages have not been flushed to disk by the
server. In this case we haven't even sent the pages to the server.

Instead the pages are accounted for in nr_dirty, and are tracked by the
internal NFS 'dirty request' lists. We also mark the inode as being
dirty in order to ensure that pdflush will kick off the actual RPC calls
if nobody else does so first.

Cheers,
  Trond

