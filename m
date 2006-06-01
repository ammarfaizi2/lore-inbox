Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965121AbWFAURJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965121AbWFAURJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 16:17:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965290AbWFAURJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 16:17:09 -0400
Received: from ns2.suse.de ([195.135.220.15]:51110 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S965121AbWFAURI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 16:17:08 -0400
From: Chris Mason <mason@suse.com>
To: Olaf Hering <olh@suse.de>
Subject: Re: [PATCH] cramfs corruption after BLKFLSBUF on loop device
Date: Thu, 1 Jun 2006 16:17:01 -0400
User-Agent: KMail/1.9.3
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Al Viro <viro@ftp.linux.org.uk>
References: <20060529214011.GA417@suse.de> <20060530182453.GA8701@suse.de> <20060601184938.GA31376@suse.de>
In-Reply-To: <20060601184938.GA31376@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606011617.03166.mason@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 01 June 2006 14:49, Olaf Hering wrote:
> This script will cause cramfs decompression errors, on SMP at least:
>
> #!/bin/bash
> while :;do blockdev --flushbufs /dev/loop0;done </dev/null &>/dev/null&
> while :;do ps faxs  </dev/null &>/dev/null&done </dev/null &>/dev/null&
> while :;do dmesg    </dev/null &>/dev/null&done </dev/null &>/dev/null&
> while :;do find /mounts/instsys -type f -print0|xargs -0 cat
> &>/dev/null;done

It looks as though:

* cramfs_readpage is synchronous
* cramfs_readpage always returns an up to date page
* cramfs data doesn't change
* read_cache_page as called by cramfs will always return a page that was 
up to date at one time, or an error.

I think this will work (but have not tested it).  Another option is to create 
a read_cache_page that pins the page via a page flag 
that invalidate_mapping_pages will honor.

-chris

diff -r a1a07af2d0cd fs/cramfs/inode.c
--- a/fs/cramfs/inode.c	Thu Jun 01 10:45:04 2006 -0400
+++ b/fs/cramfs/inode.c	Thu Jun 01 15:04:39 2006 -0400
@@ -190,18 +190,6 @@ static void *cramfs_read(struct super_bl
 		pages[i] = page;
 	}
 
-	for (i = 0; i < BLKS_PER_BUF; i++) {
-		struct page *page = pages[i];
-		if (page) {
-			wait_on_page_locked(page);
-			if (!PageUptodate(page)) {
-				/* asynchronous error */
-				page_cache_release(page);
-				pages[i] = NULL;
-			}
-		}
-	}
-
 	buffer = next_buffer;
 	next_buffer = NEXT_BUFFER(buffer);
 	buffer_blocknr[buffer] = blocknr;

