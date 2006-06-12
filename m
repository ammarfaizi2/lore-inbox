Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751248AbWFLDns@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751248AbWFLDns (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jun 2006 23:43:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751249AbWFLDns
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jun 2006 23:43:48 -0400
Received: from smtp.osdl.org ([65.172.181.4]:23274 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751248AbWFLDnr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jun 2006 23:43:47 -0400
Date: Sun, 11 Jun 2006 20:43:18 -0700
From: Andrew Morton <akpm@osdl.org>
To: Wu Fengguang <wfg@mail.ustc.edu.cn>
Cc: mjt@tls.msk.ru, ioe-lkml@rameria.de, linux-kernel@vger.kernel.org,
       axboe@suse.de
Subject: Re: [PATCH 4/5] readahead: backoff on I/O error
Message-Id: <20060611204318.ebc42608.akpm@osdl.org>
In-Reply-To: <350074764.23563@ustc.edu.cn>
References: <20060609080801.741901069@localhost.localdomain>
	<349840680.03819@ustc.edu.cn>
	<200606102033.46844.ioe-lkml@rameria.de>
	<448B221D.3080907@tls.msk.ru>
	<350074764.23563@ustc.edu.cn>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Jun 2006 09:12:45 +0800
Wu Fengguang <wfg@mail.ustc.edu.cn> wrote:

> Andrew:
> I was a bit afraid about that because I have no CDROM to try it out.
> But since Michael has tested it OK, it should be OK for the stable kernel.

hm.  It's a problem, but not a terribly huge one.



It's nice to print the filename, but we shouldn't use d_iname because long
filenames aren't stored there.  And if the file was unlinked after open
then I don't think we'll oops, but the filename isn't very meaningful.


So...


--- devel/mm/filemap.c~readahead-backoff-on-i-o-error-tweaks	2006-06-11 20:40:52.000000000 -0700
+++ devel-akpm/mm/filemap.c	2006-06-11 20:41:05.000000000 -0700
@@ -804,8 +804,7 @@ static void shrink_readahead_size_eio(st
 		return;
 
 	ra->ra_pages /= 4;
-	printk(KERN_WARNING "Retracting readahead size of %s to %luK\n",
-			filp->f_dentry->d_iname,
+	printk(KERN_WARNING "Reducing readahead size to %luK\n",
 			ra->ra_pages << (PAGE_CACHE_SHIFT - 10));
 }
 
_

