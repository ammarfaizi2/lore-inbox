Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261248AbUCHVXE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 16:23:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261255AbUCHVXD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 16:23:03 -0500
Received: from fw.osdl.org ([65.172.181.6]:61123 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261248AbUCHVXA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 16:23:00 -0500
Date: Mon, 8 Mar 2004 13:23:05 -0800
From: Andrew Morton <akpm@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: andrea@suse.de, linux-kernel@vger.kernel.org
Subject: Re: objrmap-core-1 (rmap removal for file mappings to avoid 4:4 in
 <=16G machines)
Message-Id: <20040308132305.3c35e90a.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0403081238060.9575@ppc970.osdl.org>
References: <20040308202433.GA12612@dualathlon.random>
	<Pine.LNX.4.58.0403081238060.9575@ppc970.osdl.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:
>
> 
> Andrew,
>  I certainly prefer this to the 4:4 horrors. So it sounds worth it to put
> it into -mm if everybody else is ok with it.

Sure.  To my amazement it applies without rejects, so we get both ;)

Hopefully the regresson which this patch adds (having to search across
vma's which do not cover the pages which we're trying to unmap) will not
impact too many workloads.  It will take some time to find out.  If it
_does_ impact workloads then we have a case where 64-bit machines are
suffering because of monster highmem requirements, which needs a judgement
call.

There is an architectural concern: we're now treating anonymous pages
differently from file-backed ones.  But we already do that in some places
anyway and the implementation is pretty straightforward.

Other issues are how it will play with remap_file_pages(), and how it
impacts Ingo's work to permit remap_file_pages() to set page permissions on
a per-page basis.  This change provides large performance improvements to
UML, making it more viable for various virtual-hosting applications.  I
don't immediately see any reason why objrmap should kill that off, but if
it does we're in the position of trading off UML virtual server performance
against monster highmem viability.  That's less clear.

