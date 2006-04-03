Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964775AbWDCXwR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964775AbWDCXwR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 19:52:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964942AbWDCXwR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 19:52:17 -0400
Received: from mx1.redhat.com ([66.187.233.31]:36517 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964775AbWDCXwR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 19:52:17 -0400
Date: Mon, 3 Apr 2006 18:52:06 -0500
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: axboe@suse.de
Subject: potential null dereference in splice code.
Message-ID: <20060403235206.GA31397@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>, axboe@suse.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We can get to out: with a NULL page, which we probably
don't want to be calling page_cache_release() on.

Signed-off-by: Dave Jones <davej@redhat.com>

--- linux-2.6.16.noarch/fs/splice.c~	2006-04-03 18:47:40.000000000 -0500
+++ linux-2.6.16.noarch/fs/splice.c	2006-04-03 18:50:06.000000000 -0500
@@ -445,7 +445,7 @@ find_page:
 		ret = -ENOMEM;
 		page = find_or_create_page(mapping, index, gfp_mask);
 		if (!page)
-			goto out;
+			goto out_nomem;
 
 		/*
 		 * If the page is uptodate, it is also locked. If it isn't
@@ -507,6 +507,7 @@ out:
 		page_cache_release(page);
 		unlock_page(page);
 	}
+out_nomem:
 	buf->ops->unmap(info, buf);
 	return ret;
 }
