Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268686AbUIMVDI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268686AbUIMVDI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 17:03:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268929AbUIMVDI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 17:03:08 -0400
Received: from fw.osdl.org ([65.172.181.6]:32153 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268686AbUIMVB7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 17:01:59 -0400
Date: Mon, 13 Sep 2004 14:00:02 -0700
From: Andrew Morton <akpm@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@borntraeger.net, linux-kernel@vger.kernel.org,
       hch@infradead.org
Subject: Re: Linux 2.6.9-rc2 : oops
Message-Id: <20040913140002.6e5fa076.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0409131318320.2378@ppc970.osdl.org>
References: <Pine.LNX.4.58.0409130937050.4094@ppc970.osdl.org>
	<200409132203.08286.linux-kernel@borntraeger.net>
	<Pine.LNX.4.58.0409131318320.2378@ppc970.osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:
>
>  Looks like somebody is trying to free an invalid address. Sadly, your 
>  traceback doesn't show _who_, because it's hidden in the buffering.

yes, I doubt if we get synchronous notification of a double-free without
CONFIG_DEBUG_SLAB.

There's a known double-free in the isofs filesystem.  Christian, were you
using CDROMs at the time?

>  The only changes to slab itself have been by Christoph lately, I don't 
>  think that matters. Can you enable slab debugging? That should catch it 
>  much earlier..

Yup.  Enable CONFIG_DEBUG_SLAB.



Invalidate this pointer so it doesn't get freed twice.

Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/fs/isofs/rock.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN fs/isofs/rock.c~rock-fix fs/isofs/rock.c
--- 25/fs/isofs/rock.c~rock-fix	2004-09-10 01:47:00.135392480 -0700
+++ 25-akpm/fs/isofs/rock.c	2004-09-10 01:47:00.139391872 -0700
@@ -62,7 +62,7 @@
 }                                     
 
 #define MAYBE_CONTINUE(LABEL,DEV) \
-  {if (buffer) kfree(buffer); \
+  {if (buffer) { kfree(buffer); buffer = NULL; } \
   if (cont_extent){ \
     int block, offset, offset1; \
     struct buffer_head * pbh; \
_

