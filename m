Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265542AbUGGWYQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265542AbUGGWYQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 18:24:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265544AbUGGWYQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 18:24:16 -0400
Received: from fw.osdl.org ([65.172.181.6]:52405 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265542AbUGGWYP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 18:24:15 -0400
Date: Wed, 7 Jul 2004 15:27:18 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: mason@suse.com, marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org
Subject: Re: Unnecessary barrier in sync_page()?
Message-Id: <20040707152718.7623abf1.akpm@osdl.org>
In-Reply-To: <20040707220258.GV28479@dualathlon.random>
References: <20040707175724.GB3106@logos.cnet>
	<20040707182025.GJ28479@dualathlon.random>
	<20040707112953.0157383e.akpm@osdl.org>
	<20040707184202.GN28479@dualathlon.random>
	<1089233823.3956.80.camel@watt.suse.com>
	<20040707210608.GS28479@dualathlon.random>
	<20040707143015.03379d0f.akpm@osdl.org>
	<20040707220258.GV28479@dualathlon.random>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> wrote:
>
> 'm thinking, does handle_write_error() holds a ref on the inode? that's
> the VM and it finds the page without passing through the inode. I'm
> afraid the VM isn't safe calling lock_page, or am I overlooking
> something here?

Yes, that's buggy - the caller has a ref on the page, but not on the inode.

I'm not sure what's worth doing in there - maybe just trylock it and if
that fails, lose the I/O error.  Combine that with propagation of the page
error flags into the address_space within truncate_complete_page() and
invalidate_complete_page() and in shrink_list().  Does that cover
everything?

Or just kill handle_write_error() altogether and push the responsibility
for setting the address_space error bits into writepage() -
block_write_full_page() and mpage_writepage() do it already.

Let me think about it a bit.
