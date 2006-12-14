Return-Path: <linux-kernel-owner+w=401wt.eu-S1751936AbWLNBl6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751936AbWLNBl6 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 20:41:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751941AbWLNBl6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 20:41:58 -0500
Received: from smtp.osdl.org ([65.172.181.25]:38384 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751936AbWLNBl5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 20:41:57 -0500
Date: Wed, 13 Dec 2006 17:41:48 -0800
From: Andrew Morton <akpm@osdl.org>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [PATCH] nfs: fix NR_FILE_DIRTY underflow
Message-Id: <20061213174148.6197c91a.akpm@osdl.org>
In-Reply-To: <20061213172921.0c4a2809.akpm@osdl.org>
References: <1166011958.32332.97.camel@twins>
	<1166012781.5695.18.camel@lade.trondhjem.org>
	<1166022082.32332.126.camel@twins>
	<1166031601.9127.1.camel@lade.trondhjem.org>
	<1166035714.32332.159.camel@twins>
	<20061213172921.0c4a2809.akpm@osdl.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Dec 2006 17:29:21 -0800
Andrew Morton <akpm@osdl.org> wrote:

> a) we're now calling try_to_release_page() with a potentially-dirty
>    page, whereas it was previously clean.
> 
>    I wouldn't expect ->releasepage() implementations to go looking at
>    PG_Dirty, because that's not what they're suppoed to be interested in. 
>    But they might do, dunno.

Still an issue, probably minor.

> b) If invalidate_complete_page2() failed due to, say, dirty buffer_heads
>    then we now have a clean page with dirty buffers.  That is an illegal
>    state and the page will leak permanently.
>
>    I _think_ that's what the was_dirty logic is in there for: to
>    preserve the correct page-vs-buffers dirtiness coherency.  But I'd need
>    to do some 2.5.x changelog-dumpster-diving to be sure.

no, that's bs.  The patch looks OK from that POV: try_to_release_page()
will be able to clear clean buffers from a dirty page.

And in fact if it did that, it will then clean the page for us (see
test_clear_page_dirty() in try_to_free_buffers()).

But we still need the clear_page_dirty() in invalidate_complete_page2() in
case we didn't call try_to_release_page() at all.

> Trond, please define precisely and completely and without reference to
> the existing implementation: what behaviour does NFS want?

But this would be nice.
