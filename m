Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261991AbUD1UAP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261991AbUD1UAP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 16:00:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261205AbUD1T7e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 15:59:34 -0400
Received: from fw.osdl.org ([65.172.181.6]:24017 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261162AbUD1THv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 15:07:51 -0400
Date: Wed, 28 Apr 2004 12:07:15 -0700
From: Andrew Morton <akpm@osdl.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: trond.myklebust@fys.uio.no, sgoel01@yahoo.com,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-rc{1,2} bad VM/NFS interaction in case of dirty page
 writeback
Message-Id: <20040428120715.68bc51dd.akpm@osdl.org>
In-Reply-To: <20040428173811.A1505@infradead.org>
References: <20040427011237.33342.qmail@web12824.mail.yahoo.com>
	<20040426191512.69485c42.akpm@osdl.org>
	<1083035471.3710.65.camel@lade.trondhjem.org>
	<20040426205928.58d76dbc.akpm@osdl.org>
	<1083043386.3710.201.camel@lade.trondhjem.org>
	<20040426225834.7035d2c1.akpm@osdl.org>
	<1083080207.2616.31.camel@lade.trondhjem.org>
	<20040428062942.A27705@infradead.org>
	<1083169062.2856.36.camel@lade.trondhjem.org>
	<20040428173811.A1505@infradead.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> wrote:
>
> I'm not yet sure where I'm heading with revamping xfs_aops.c, but what
>  I'd love to see in the end is more or less xfs implementing only
>  writepages and some generic implement writepage as writepages wrapper.

That might make sense.  One problem is that writepage expects to be passed
a locked page whereas writepages() does not.

Any code which implements writearound-inside-writepage should be targetted
at a generic implementation, not an fs-specific one if poss.  We could go
look at the ->vm_writeback() a_op which was in in 2.5.20 or thereabouts. 
it was causing problems and had no discernable benefits so I ripped it out.

A writearound-within-writepage implementation would need to decide whether
it's goign to use lock_page() or TryLockPage().  I expect lock_page() will
be OK - we only call in there for __GFP_FS allocators.

