Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965457AbWJ2Uku@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965457AbWJ2Uku (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 15:40:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965458AbWJ2Uku
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 15:40:50 -0500
Received: from mail.parknet.jp ([210.171.160.80]:7687 "EHLO parknet.jp")
	by vger.kernel.org with ESMTP id S965457AbWJ2Uku (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 15:40:50 -0500
X-AuthUser: hirofumi@parknet.jp
To: Trond Myklebust <Trond.Myklebust@netapp.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       cluster-devel@redhat.com
Subject: Re: [PATCH] nfs: Fix nfs_readpages() error path
References: <877iyjundz.fsf@duaron.myhome.or.jp>
	<1162149038.5545.37.camel@lade.trondhjem.org>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Mon, 30 Oct 2006 05:40:42 +0900
In-Reply-To: <1162149038.5545.37.camel@lade.trondhjem.org> (Trond Myklebust's message of "Sun\, 29 Oct 2006 14\:10\:38 -0500")
Message-ID: <87pscaua7p.fsf@duaron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust <Trond.Myklebust@netapp.com> writes:

> On Mon, 2006-10-30 at 00:56 +0900, OGAWA Hirofumi wrote:
>> ------------[ cut here ]------------
>> kernel BUG at /devel/linux/works/linux-2.6/mm/readahead.c:315!
>> 
>> The a_ops->readpages() is nfs_readpages(), and it seems to don't free
>> pages list in error path. So, it hit the
>> BUG_ON(!list_empty(&page_pool)) in __do_page_cache_readahead.
>
> Wait. Why do we have this insane cleanup semantic anyway? I've just
> grepped through the various readpages() methods out there. None of them
> do anything more sophisticated than to call put_pages_list() in case of
> error, and several of them get that wrong (including NFS, and CIFS).
>
> Instead of the BUG_ON(), why can't we just stick a put_pages_list() into
> __do_page_cache_readahead() and then get rid of all that duplicated
> error handling in mpage_readpages(), nfs_readpages(), fuse_readpages(),
> etc?

Yes, I thought it too. Probably, author thought passed pages's owner
is readpages side, and owner can use that list with favorite way.

Well, both seems right things for me. So, the patch was done by
minimum change for -rc. If you want it, I'll do.


BTW, umm.. now I think, gfs2_readpages() seems to have a bug in error
path by different way. unlock_page() is really needed?
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
