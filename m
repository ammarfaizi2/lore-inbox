Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263673AbUDPXzT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 19:55:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263895AbUDPXzT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 19:55:19 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:19891 "EHLO
	MTVMIME02.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S263673AbUDPXzO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 19:55:14 -0400
Date: Sat, 17 Apr 2004 00:55:10 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: Jamie Lokier <jamie@shareable.org>, <linux-kernel@vger.kernel.org>
Subject: Re: msync() needed before munmap() when writing to shared mapping?
In-Reply-To: <20040416154652.7ab27e79.akpm@osdl.org>
Message-ID: <Pine.LNX.4.44.0404170046370.14939-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Apr 2004, Andrew Morton wrote:
> Jamie Lokier <jamie@shareable.org> wrote:
> >
> > I've followed the logic from do_munmap() and it looks good:
> > unmap_vmas->zap_pte_range->page_remove_rmap->set_page_dirty.
> > 
> > Can someone confirm this is correct, please?
> 
> yup, zap_pte_range() transfers pte dirtiness into pagecache dirtiness when
> tearing down the mapping, leaving the dirty page floating about in
> pagecache for kupdate/kswapd/fsync to catch.  Longstanding behaviour.

May I add a clarification?  Jamie has focussed on the set_page_dirty
in page_remove_rmap: that's a special for s390, on everything else the
"page_test_and_clear_dirty" preceding it evaluates to 0.  For most
arches it is indeed the set_page_dirty actually in zap_pte_range
which smears the dirt from pte to page.  (Please don't ask me
to explain the s390 case, I'm no expert.)

Hugh

