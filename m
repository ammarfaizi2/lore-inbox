Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267689AbTBPWNF>; Sun, 16 Feb 2003 17:13:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267687AbTBPWNF>; Sun, 16 Feb 2003 17:13:05 -0500
Received: from packet.digeo.com ([12.110.80.53]:21472 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267689AbTBPWNE>;
	Sun, 16 Feb 2003 17:13:04 -0500
Date: Sun, 16 Feb 2003 14:23:46 -0800
From: Andrew Morton <akpm@digeo.com>
To: Steve French <smfrench@austin.rr.com>
Cc: tmolina@cox.net, linux-kernel@vger.kernel.org
Subject: Re: compile problem with 2.5.61-bk
Message-Id: <20030216142346.08aa3150.akpm@digeo.com>
In-Reply-To: <3E4FF2CE.60208@austin.rr.com>
References: <3E4FF2CE.60208@austin.rr.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 16 Feb 2003 22:22:55.0978 (UTC) FILETIME=[F43244A0:01C2D609]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steve French <smfrench@austin.rr.com> wrote:
>
> Those two functions are not exported (see e.g. ksyms.c) so are not 
> available for modules to access but work when built as part of the kernel.
> For the time being this means the CIFS VFS can not be built as a module.
> Looks like I will have to figure out an alternate way to get at those two
> functions either directly by exporting them or preferably by calling them 
> indirectly

I think exporting them makes sense.  In fact, given that ->readpages() is an
address_space op, filesystems do have to be able to add these pages to pagecache.

It might be simpler to just use add_to_page_cache_lru(), and to export that
instead.  But that is a little more lock-intensive, and is equivalent to
exporting add_to_page_cache() and __pagevec_lru_add().

btw, cifs_copy_cache_pages() can use the more efficient kmap_atomic(KM_USER0)
in place of the kmap().

