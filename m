Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751224AbWBZP13@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751224AbWBZP13 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 10:27:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751225AbWBZP13
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 10:27:29 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:29863 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751224AbWBZP13 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 10:27:29 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: [RFC/RFT][PATCH -mm] swsusp: improve memory shrinking
Date: Sun, 26 Feb 2006 16:27:17 +0100
User-Agent: KMail/1.9.1
Cc: Nigel Cunningham <ncunningham@cyclades.com>, linux-kernel@vger.kernel.org
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602242122.53763.rjw@sisk.pl> <20060224235548.GB1930@elf.ucw.cz>
In-Reply-To: <20060224235548.GB1930@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602261627.18012.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Saturday 25 February 2006 00:55, Pavel Machek wrote:
> > > I did try shrink_all_memory() five times, with .5 second delay between
> > > them, and it freed more memory at later tries.
> > 
> > I wonder if the delays are essential or if so, whether they may be shorter
> > than .5 sec.
> 
> I was using this with some success... (Warning, against old
> kernel). But, as I said, I consider it ugly, and it would be better to
> fix shrink_all_memory.

Appended is a patch against the current -mm.  [It also makes
swsusp_shrink_memory() behave as documented for image_size = 0.
Currently, if it states there's enough free RAM to suspend, it won't bother
to free a single page.]

If anyone please can test it on a machine with less than 128 MB of RAM
and see if it helps suspend there (in particular when X is running), 
and if changing the value of SHRINK_SLEEP to 200 (or more) makes
any difference,  I'll appreciate it very much.

Greetings,
Rafael

---
Make swsusp_shrink_memory() try harder to free more RAM if necessary or
if the anticipated size of the image is greater than image_size.


Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 kernel/power/swsusp.c |   26 ++++++++++++++++++--------
 1 files changed, 18 insertions(+), 8 deletions(-)

Index: linux-2.6.16-rc4-mm2/kernel/power/swsusp.c
===================================================================
--- linux-2.6.16-rc4-mm2.orig/kernel/power/swsusp.c	2006-02-26 15:12:04.000000000 +0100
+++ linux-2.6.16-rc4-mm2/kernel/power/swsusp.c	2006-02-26 16:06:27.000000000 +0100
@@ -175,6 +175,8 @@ void free_all_swap_pages(int swap, struc
  */
 
 #define SHRINK_BITE	10000
+#define SHRINK_RETRY	3
+#define SHRINK_SLEEP	100
 
 int swsusp_shrink_memory(void)
 {
@@ -182,6 +184,7 @@ int swsusp_shrink_memory(void)
 	struct zone *zone;
 	unsigned long pages = 0;
 	unsigned int i = 0;
+	int retry = SHRINK_RETRY;
 	char *p = "-\\|/";
 
 	printk("Shrinking memory...  ");
@@ -194,14 +197,21 @@ int swsusp_shrink_memory(void)
 		for_each_zone (zone)
 			if (!is_highmem(zone))
 				tmp -= zone->free_pages;
-		if (tmp > 0) {
-			tmp = shrink_all_memory(SHRINK_BITE);
-			if (!tmp)
-				return -ENOMEM;
-			pages += tmp;
-		} else if (size > image_size / PAGE_SIZE) {
-			tmp = shrink_all_memory(SHRINK_BITE);
-			pages += tmp;
+		if (tmp > 0 || size > image_size / PAGE_SIZE) {
+			long freed = shrink_all_memory(SHRINK_BITE);
+
+			if (freed > 0) {
+				pages += freed;
+				tmp = freed;
+				retry = SHRINK_RETRY;
+			} else {
+				if (--retry) {
+					msleep_interruptible(SHRINK_SLEEP);
+					tmp = size;
+				} else if (tmp > 0) {
+					return -ENOMEM;
+				}
+			}
 		}
 		printk("\b%c", p[i++%4]);
 	} while (tmp > 0);
