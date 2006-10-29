Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932430AbWJ2TKl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932430AbWJ2TKl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 14:10:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932431AbWJ2TKl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 14:10:41 -0500
Received: from mx2.netapp.com ([216.240.18.37]:8207 "EHLO mx2.netapp.com")
	by vger.kernel.org with ESMTP id S932430AbWJ2TKk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 14:10:40 -0500
X-IronPort-AV: i="4.09,369,1157353200"; 
   d="scan'208"; a="422592006:sNHT20910088"
Subject: Re: [PATCH] nfs: Fix nfs_readpages() error path
From: Trond Myklebust <Trond.Myklebust@netapp.com>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <877iyjundz.fsf@duaron.myhome.or.jp>
References: <877iyjundz.fsf@duaron.myhome.or.jp>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Network Appliance Inc
Date: Sun, 29 Oct 2006 14:10:38 -0500
Message-Id: <1162149038.5545.37.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
X-OriginalArrivalTime: 29 Oct 2006 19:11:02.0748 (UTC) FILETIME=[F9DB09C0:01C6FB8D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-10-30 at 00:56 +0900, OGAWA Hirofumi wrote:
> I've got the following oops.
> 
> ------------[ cut here ]------------
> kernel BUG at /devel/linux/works/linux-2.6/mm/readahead.c:315!
> invalid opcode: 0000 [#1]
> SMP
> 
> [...]
> 
> EFLAGS: 00210283   (2.6.19-rc3 #3)
> EIP is at __do_page_cache_readahead+0x1a4/0x1b7
> eax: f260db64   ebx: f8f9aa18   ecx: 00000001   edx: f7710594
> esi: f6042b94   edi: f6042b84   ebp: f260db78   esp: f260db0c
> ds: 007b   es: 007b   ss: 0068
> Process emacs (pid: 3694, ti=f260d000 task=f670caa0 task.ti=f260d000)
> Stack: 00000001 000001ac f25dd88c 0000085e 0000001e 00000001 00001000 d7f4a48c
>        d7f4a50c d7f4a50c 00001000 d7f4a50c f260db60 00200246 00000001 22222222
>        22222222 d7f4a50c d7f4a50c 00001000 d7f4a48c f260db68 c13cb9f8 c13cb9f8
> Call Trace:
>  [<c0140a3a>] do_page_cache_readahead+0x43/0x4d
>  [<c013ce9b>] filemap_nopage+0x14e/0x328
>  [<c0145b8e>] __handle_mm_fault+0x146/0x7b6
>  [<c01463cc>] get_user_pages+0x1ce/0x293
>  [<c017f0a8>] elf_core_dump+0xa05/0xba5
>  [<c015b8a7>] do_coredump+0x565/0x5d1
>  [<c0123acb>] get_signal_to_deliver+0x701/0x758
>  [<c010246b>] do_notify_resume+0x8b/0x6c4
>  [<c0102ede>] work_notifysig+0x13/0x19
> 
> The a_ops->readpages() is nfs_readpages(), and it seems to don't free
> pages list in error path. So, it hit the
> BUG_ON(!list_empty(&page_pool)) in __do_page_cache_readahead.

Wait. Why do we have this insane cleanup semantic anyway? I've just
grepped through the various readpages() methods out there. None of them
do anything more sophisticated than to call put_pages_list() in case of
error, and several of them get that wrong (including NFS, and CIFS).

Instead of the BUG_ON(), why can't we just stick a put_pages_list() into
__do_page_cache_readahead() and then get rid of all that duplicated
error handling in mpage_readpages(), nfs_readpages(), fuse_readpages(),
etc?

Cheers,
  Trond
