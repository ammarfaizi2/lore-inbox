Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751424AbWBZXkB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751424AbWBZXkB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 18:40:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751427AbWBZXkB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 18:40:01 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:39593 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751424AbWBZXkA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 18:40:00 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC/RFT][PATCH -mm] swsusp: improve memory shrinking
Date: Mon, 27 Feb 2006 00:38:40 +0100
User-Agent: KMail/1.9.1
Cc: Nigel Cunningham <ncunningham@cyclades.com>, linux-kernel@vger.kernel.org
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <20060226185319.GB2055@elf.ucw.cz> <200602270032.25324.rjw@sisk.pl>
In-Reply-To: <200602270032.25324.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602270038.41287.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 27 February 2006 00:32, Rafael J. Wysocki wrote:
> On Sunday 26 February 2006 19:53, Pavel Machek wrote:
> > > > > > I did try shrink_all_memory() five times, with .5 second delay between
> > > > > > them, and it freed more memory at later tries.
> > > > > 
> > > > > I wonder if the delays are essential or if so, whether they may be shorter
> > > > > than .5 sec.
> > > > 
> > > > I was using this with some success... (Warning, against old
> > > > kernel). But, as I said, I consider it ugly, and it would be better to
> > > > fix shrink_all_memory.
> > > 
> > > Appended is a patch against the current -mm.
> > >   [It also makes
> > > swsusp_shrink_memory() behave as documented for image_size = 0.
> > > Currently, if it states there's enough free RAM to suspend, it won't bother
> > > to free a single page.]
> > 
> > Could we get bugfix part separately?
> 
> Sure.  Appended is the bugfix (I haven't tested it separately yet, but I think
> it's simple enough) ...

... and this is the workaround of the "shrink_all_memory() returns 0 prematurely"
problem (not tested separately yet).  [Together these patches make my box
actually free more memory when image_size = 0.]

---
Make swsusp_shrink_memory() try harder to free more RAM if necessary or
if the anticipated size of the image is greater than image_size.


Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 kernel/power/swsusp.c |   13 +++++++++++--
 1 files changed, 11 insertions(+), 2 deletions(-)

Index: linux-2.6.16-rc4-mm2/kernel/power/swsusp.c
===================================================================
--- linux-2.6.16-rc4-mm2.orig/kernel/power/swsusp.c	2006-02-27 00:25:34.000000000 +0100
+++ linux-2.6.16-rc4-mm2/kernel/power/swsusp.c	2006-02-27 00:28:58.000000000 +0100
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
@@ -200,8 +203,14 @@ int swsusp_shrink_memory(void)
 			if (freed > 0) {
 				pages += freed;
 				tmp = freed;
-			} else if (tmp > 0) {
-				return -ENOMEM;
+				retry = SHRINK_RETRY;
+			} else {
+				if (--retry) {
+					msleep_interruptible(SHRINK_SLEEP);
+					tmp = size;
+				} else if (tmp > 0) {
+					return -ENOMEM;
+				}
 			}
 		}
 		printk("\b%c", p[i++%4]);
