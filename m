Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262018AbVDFA4I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262018AbVDFA4I (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 20:56:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262045AbVDFA4I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 20:56:08 -0400
Received: from fire.osdl.org ([65.172.181.4]:10698 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262018AbVDFA4E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 20:56:04 -0400
Date: Tue, 5 Apr 2005 17:56:00 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Barry K. Nathan" <barryn@pobox.com>
Cc: barryn@pobox.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc2-mm1
Message-Id: <20050405175600.644e2453.akpm@osdl.org>
In-Reply-To: <20050405141445.GA5170@ip68-4-98-123.oc.oc.cox.net>
References: <20050405000524.592fc125.akpm@osdl.org>
	<20050405134408.GB10733@ip68-4-98-123.oc.oc.cox.net>
	<20050405141445.GA5170@ip68-4-98-123.oc.oc.cox.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Barry K. Nathan" <barryn@pobox.com> wrote:
>
> On Tue, Apr 05, 2005 at 06:44:08AM -0700, Barry K. Nathan wrote:
> > swsusp: reading slkf;jalksfsadflkjas;dlfasdfkl (12345 pages): 34%
> > [sorry, I just got up so my short-term memory isn't working that well
> > yet]
> > 
> > takes 10-30 minutes (depending on whether it's closer to 11000 pages or
> > 20000) rather than the 5-10 seconds or so that it takes under 2.6.11-ac5
> > (or mainline 2.6.11 if I remember correctly).

Odd.

> [snip]
> > I'll try to do some more testing to see (a) when this problem started
> > and (b) whether it still exists in 2.6.12-rc2 or later. This is going to
> > be ridiculously difficult for me to fit into my schedule right now, but
> > I'll try....
> 
> 2.6.11-bk9 works (actually it takes under 2 seconds, not 5-10).
> 2.6.11-bk10 has the weird slowdown.

Unfortunately that's a pretty bug diff (2 megs).

The only thing I can see in the memory reclaim area is this:

--- b/mm/vmscan.c	2005-03-10 00:39:02 -08:00
+++ b/mm/vmscan.c	2005-03-13 15:29:39 -08:00
@@ -313,8 +313,20 @@
 	 */
 	if (!is_page_cache_freeable(page))
 		return PAGE_KEEP;
-	if (!mapping)
+	if (!mapping) {
+		/*
+		 * Some data journaling orphaned pages can have
+		 * page->mapping == NULL while being dirty with clean buffers.
+		 */
+		if (PageDirty(page) && PagePrivate(page)) {
+			if (try_to_free_buffers(page)) {
+				ClearPageDirty(page);
+				printk("%s: orphaned page\n", __FUNCTION__);
+				return PAGE_CLEAN;
+			}
+		}
 		return PAGE_KEEP;
+	}
 	if (mapping->a_ops->writepage == NULL)
 		return PAGE_ACTIVATE;
 	if (!may_write_to_queue(mapping->backing_dev_info))

but you'd be getting a printk storm if that was triggering.

> I'll see if I can isolate it any further.

Please, that would help.
