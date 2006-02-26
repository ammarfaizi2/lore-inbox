Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751431AbWBZXkA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751431AbWBZXkA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 18:40:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751427AbWBZXkA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 18:40:00 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:39337 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751424AbWBZXj7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 18:39:59 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC/RFT][PATCH -mm] swsusp: improve memory shrinking
Date: Mon, 27 Feb 2006 00:32:24 +0100
User-Agent: KMail/1.9.1
Cc: Nigel Cunningham <ncunningham@cyclades.com>, linux-kernel@vger.kernel.org
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602261627.18012.rjw@sisk.pl> <20060226185319.GB2055@elf.ucw.cz>
In-Reply-To: <20060226185319.GB2055@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602270032.25324.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sunday 26 February 2006 19:53, Pavel Machek wrote:
> > > > > I did try shrink_all_memory() five times, with .5 second delay between
> > > > > them, and it freed more memory at later tries.
> > > > 
> > > > I wonder if the delays are essential or if so, whether they may be shorter
> > > > than .5 sec.
> > > 
> > > I was using this with some success... (Warning, against old
> > > kernel). But, as I said, I consider it ugly, and it would be better to
> > > fix shrink_all_memory.
> > 
> > Appended is a patch against the current -mm.
> >   [It also makes
> > swsusp_shrink_memory() behave as documented for image_size = 0.
> > Currently, if it states there's enough free RAM to suspend, it won't bother
> > to free a single page.]
> 
> Could we get bugfix part separately?

Sure.  Appended is the bugfix (I haven't tested it separately yet, but I think
it's simple enough) ...

---
Make swsusp_shrink_memory() behave as documented when image_size = 0.


Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 kernel/power/swsusp.c |   15 ++++++++-------
 1 files changed, 8 insertions(+), 7 deletions(-)

Index: linux-2.6.16-rc4-mm2/kernel/power/swsusp.c
===================================================================
--- linux-2.6.16-rc4-mm2.orig/kernel/power/swsusp.c	2006-02-26 15:12:04.000000000 +0100
+++ linux-2.6.16-rc4-mm2/kernel/power/swsusp.c	2006-02-27 00:25:34.000000000 +0100
@@ -194,14 +194,15 @@ int swsusp_shrink_memory(void)
 		for_each_zone (zone)
 			if (!is_highmem(zone))
 				tmp -= zone->free_pages;
-		if (tmp > 0) {
-			tmp = shrink_all_memory(SHRINK_BITE);
-			if (!tmp)
+		if (tmp > 0 || size > image_size / PAGE_SIZE) {
+			long freed = shrink_all_memory(SHRINK_BITE);
+
+			if (freed > 0) {
+				pages += freed;
+				tmp = freed;
+			} else if (tmp > 0) {
 				return -ENOMEM;
-			pages += tmp;
-		} else if (size > image_size / PAGE_SIZE) {
-			tmp = shrink_all_memory(SHRINK_BITE);
-			pages += tmp;
+			}
 		}
 		printk("\b%c", p[i++%4]);
 	} while (tmp > 0);

