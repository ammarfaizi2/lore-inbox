Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263895AbUGIEae@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263895AbUGIEae (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 00:30:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263923AbUGIEae
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 00:30:34 -0400
Received: from fw.osdl.org ([65.172.181.6]:52379 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263895AbUGIEac (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 00:30:32 -0400
Date: Thu, 8 Jul 2004 21:29:23 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, mason@suse.com
Subject: Re: writepage fs corruption fixes
Message-Id: <20040708212923.406135f0.akpm@osdl.org>
In-Reply-To: <20040709040151.GB20947@dualathlon.random>
References: <20040709040151.GB20947@dualathlon.random>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> wrote:
>
> 1) The major one (the only one I believe that was triggering [only on
>  ext2 due the fact mpage is working only there]) is the marking of the bh
>  clean despite we could still run into the "confused" path. After that
>  the confused path really becomes confused and it writes nothing and fs
>  corruption triggers silenty (the reugular writepage only writes bh that
>  are marked dirty, it never attempts to submit_bh anything marked clean).
>  The mpage-writepage code must never mark the bh clean as far as it
>  wants to still fallback in the regular writepage which depends on the bh
>  to be dirty (i.e. the "goto confused" path). This could only triggers
>  with memory pressure (it also needs buffer_heads_over_limit == 0, and
>  that is frequent under mm pressure).

ooh, nasty, yes.  You must be testing the crap out if it.

>  3) Third bug is in the regular writepage, the nr_underway == 0 code was
>  walking buffers on an unlocked page without keeping the bh pinned, and
>  in turn the bh could be released under it by the VM. Fix is to delay the
>  put_bh loop. (this might have triggered but it's not certain)

PG_writeback protects the page from truncate, from invalidate and from page
reclaim.  pagevec_strip() won't touch the buffers due to the
PageWriteback() test in try_to_release_page().  So I think we're OK in
there.  I can add a couple more coment fixes for this.
