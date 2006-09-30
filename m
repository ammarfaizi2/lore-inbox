Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751400AbWI3WC5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751400AbWI3WC5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 18:02:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751403AbWI3WC5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 18:02:57 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:60575 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751400AbWI3WC4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 18:02:56 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH -mm 1/3] swsusp: Add ioctl for swap files support
Date: Sun, 1 Oct 2006 00:04:58 +0200
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
References: <200609290005.17616.rjw@sisk.pl> <200609302158.03692.rjw@sisk.pl> <200609302237.22086.arnd@arndb.de>
In-Reply-To: <200609302237.22086.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200610010004.58984.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, 30 September 2006 22:37, Arnd Bergmann wrote:
> Am Saturday 30 September 2006 21:58 schrieb Rafael J. Wysocki:
> > > Your definition looks wrong, '_IOW(SNAPSHOT_IOC_MAGIC, 13, void *)' means
> > > your ioctl passes a pointer to a 'void *'.
> > >
> > > You probably mean
> > >
> > > #define SNAPSHOT_SET_SWAP_AREA _IOW(SNAPSHOT_IOC_MAGIC, 13, \
> > >                                               struct resume_swap_area)
> >
> > No.  I mean the ioctl passes a pointer, the size of which is sizeof(void *).
> 
> That's a very bad thing to do. It means that the ioctl number is different
> between 32 and 64 bit and you need to write a conversion handler that
> first reads your pointer and then then writes the real data.

Ouch, I meant exactly what you said above, sorry.

Now that means some other ioctl definitions in kernel/power/power.h are
wrong, but I'm not sure what I should do.

I think I'll just change the new definition and let the others stay as they
are which is done in the appended patch.

Thanks,
Rafael


---
Fix the SNAPSHOT_SET_SWAP_AREA ioctl definition.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
---
 kernel/power/power.h |   23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

Index: linux-2.6.18-mm2/kernel/power/power.h
===================================================================
--- linux-2.6.18-mm2.orig/kernel/power/power.h
+++ linux-2.6.18-mm2/kernel/power/power.h
@@ -106,6 +106,16 @@ extern int snapshot_write_next(struct sn
 extern void snapshot_write_finalize(struct snapshot_handle *handle);
 extern int snapshot_image_loaded(struct snapshot_handle *handle);
 
+/*
+ * This structure is used to pass the values needed for the identification
+ * of the resume swap area from a user space to the kernel via the
+ * SNAPSHOT_SET_SWAP_AREA ioctl
+ */
+struct resume_swap_area {
+	loff_t offset;
+	u_int32_t dev;
+} __attribute__((packed));
+
 #define SNAPSHOT_IOC_MAGIC	'3'
 #define SNAPSHOT_FREEZE			_IO(SNAPSHOT_IOC_MAGIC, 1)
 #define SNAPSHOT_UNFREEZE		_IO(SNAPSHOT_IOC_MAGIC, 2)
@@ -119,19 +129,10 @@ extern int snapshot_image_loaded(struct 
 #define SNAPSHOT_SET_SWAP_FILE		_IOW(SNAPSHOT_IOC_MAGIC, 10, unsigned int)
 #define SNAPSHOT_S2RAM			_IO(SNAPSHOT_IOC_MAGIC, 11)
 #define SNAPSHOT_PMOPS			_IOW(SNAPSHOT_IOC_MAGIC, 12, unsigned int)
-#define SNAPSHOT_SET_SWAP_AREA		_IOW(SNAPSHOT_IOC_MAGIC, 13, void *)
+#define SNAPSHOT_SET_SWAP_AREA		_IOW(SNAPSHOT_IOC_MAGIC, 13, \
+							struct resume_swap_area)
 #define SNAPSHOT_IOC_MAXNR	13
 
-/*
- * This structure is used to pass the values needed for the identification
- * of the resume swap area from a user space to the kernel via the
- * SNAPSHOT_SET_SWAP_AREA ioctl
- */
-struct resume_swap_area {
-	loff_t offset;
-	u_int32_t dev;
-} __attribute__((packed));
-
 #define PMOPS_PREPARE	1
 #define PMOPS_ENTER	2
 #define PMOPS_FINISH	3
