Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270816AbTHCBQY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Aug 2003 21:16:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270818AbTHCBQY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Aug 2003 21:16:24 -0400
Received: from fw.osdl.org ([65.172.181.6]:7055 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S270816AbTHCBQT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Aug 2003 21:16:19 -0400
Date: Sat, 2 Aug 2003 18:04:10 -0700
From: Andrew Morton <akpm@osdl.org>
To: Shane Shrybman <shrybman@sympatico.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test2-mm3 and mysql
Message-Id: <20030802180410.265dfe40.akpm@osdl.org>
In-Reply-To: <1059871132.2302.33.camel@mars.goatskin.org>
References: <1059871132.2302.33.camel@mars.goatskin.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shane Shrybman <shrybman@sympatico.ca> wrote:
>
> mysql doesn't start on this kernel.

That's because I'm an idiot.

--- 25/fs/mpage.c~awe-use-gfp_flags-braino	Sat Aug  2 18:03:01 2003
+++ 25-akpm/fs/mpage.c	Sat Aug  2 18:03:01 2003
@@ -568,7 +568,7 @@ confused:
 	 */
 	if (*ret == -ENOSPC)
 		set_bit(AS_ENOSPC, &mapping->flags);
-	else
+	else if (*ret)
 		set_bit(AS_EIO, &mapping->flags);
 out:
 	return bio;
@@ -673,7 +673,7 @@ mpage_writepages(struct address_space *m
 				ret = (*writepage)(page, wbc);
 				if (ret == -ENOSPC)
 					set_bit(AS_ENOSPC, &mapping->flags);
-				else
+				else if (ret)
 					set_bit(AS_EIO, &mapping->flags);
 			} else {
 				bio = mpage_writepage(bio, page, get_block,
diff -puN mm/vmscan.c~awe-use-gfp_flags-braino mm/vmscan.c
--- 25/mm/vmscan.c~awe-use-gfp_flags-braino	Sat Aug  2 18:03:01 2003
+++ 25-akpm/mm/vmscan.c	Sat Aug  2 18:03:01 2003
@@ -254,7 +254,7 @@ static void handle_write_error(struct ad
 	if (page->mapping == mapping) {
 		if (error == -ENOSPC)
 			set_bit(AS_ENOSPC, &mapping->flags);
-		else
+		else if (error)
 			set_bit(AS_EIO, &mapping->flags);
 	}
 	unlock_page(page);

_

> One last thing, I have started seeing mysql database corruption
> recently. I am not sure it is a kernel problem. And I don't know the
> exact steps to reproduce it, but I think I started seeing it with
> -test2-mm2. I haven't ever seen db corruption in the 8-12 months I have
> being playing with mysql/php.

hm, that's a worry.  No additional info available?

