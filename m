Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932158AbVLJNUk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932158AbVLJNUk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Dec 2005 08:20:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932331AbVLJNUk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Dec 2005 08:20:40 -0500
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:55760 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S932158AbVLJNUj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Dec 2005 08:20:39 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@suse.cz>, Stefan Seyfried <seife@suse.de>
Subject: [RFC/RFT] swsusp: image size tunable (was: Re: [PATCH][mm] swsusp: limit image size)
Date: Sat, 10 Dec 2005 14:21:57 +0100
User-Agent: KMail/1.9
Cc: LKML <linux-kernel@vger.kernel.org>, Andy Isaacson <adi@hexapodia.org>
References: <200512072246.06222.rjw@sisk.pl> <20051209191735.GB4658@elf.ucw.cz> <200512092308.19644.rjw@sisk.pl>
In-Reply-To: <200512092308.19644.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512101421.57918.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Friday, 9 December 2005 23:08, Rafael J. Wysocki wrote:
}-- snip --{
> > > 
> > > This would at least give us a chance for a second try. I know that Pavel
> > > dislikes userspace tunables, but i dislike failing suspends ;-)
> > 
> > Can we do that when we start seeing failed suspends? I think it will
> > not happen. If we have reasonably-sized swap partition, it should be
> > ok.
> 
> Yes.  Moreover, we can do something like that without a userspace
> tunable, if we check for the free swap before we try to shrink memory.
> This would take some time to implement, though, and I'd rather
> like to do the userland interface first.
> 
> The tunable may be useful to people who'd like to achieve the
> maximum efficiency of suspend/resume and it would be a nice
> feature to have, I think, but let's say we'll try to implement it
> in the future, if still needed/wanted.

Actually the tunable turned out to be quite easy to implement and I think
I'll need it for userspace swsusp (the suspend-handling userspace
process will need to tell the kernel how much space there is for the
image).

Please give it a try.

Greetings,
Rafael


Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

 kernel/power/disk.c   |   25 +++++++++++++++++++++++++
 kernel/power/power.h  |    6 ++++--
 kernel/power/swsusp.c |    4 +++-
 3 files changed, 32 insertions(+), 3 deletions(-)

Index: linux-2.6.15-rc5-mm1/kernel/power/disk.c
===================================================================
--- linux-2.6.15-rc5-mm1.orig/kernel/power/disk.c	2005-12-10 13:12:18.000000000 +0100
+++ linux-2.6.15-rc5-mm1/kernel/power/disk.c	2005-12-10 13:20:38.000000000 +0100
@@ -367,9 +367,34 @@
 
 power_attr(resume);
 
+static ssize_t image_size_show(struct subsystem * subsys, char *buf)
+{
+	return sprintf(buf, "%u\n", image_size);
+}
+
+static ssize_t image_size_store(struct subsystem * subsys, const char * buf, size_t n)
+{
+	int len;
+	char *p;
+	unsigned int size;
+
+	p = memchr(buf, '\n', n);
+	len = p ? p - buf : n;
+
+	if (sscanf(buf, "%u", &size) == 1) {
+		image_size = size < MAX_IMAGE_SIZE ? size : MAX_IMAGE_SIZE;
+		return n;
+	}
+
+	return -EINVAL;
+}
+
+power_attr(image_size);
+
 static struct attribute * g[] = {
 	&disk_attr.attr,
 	&resume_attr.attr,
+	&image_size_attr.attr,
 	NULL,
 };
 
Index: linux-2.6.15-rc5-mm1/kernel/power/power.h
===================================================================
--- linux-2.6.15-rc5-mm1.orig/kernel/power/power.h	2005-12-10 13:12:18.000000000 +0100
+++ linux-2.6.15-rc5-mm1/kernel/power/power.h	2005-12-10 13:20:46.000000000 +0100
@@ -53,10 +53,12 @@
 extern struct pbe *pagedir_nosave;
 
 /*
- * Preferred image size in MB (set it to zero to get the smallest
+ * Maximum image size in MB (set it to zero to get the smallest
  * image possible)
  */
-#define IMAGE_SIZE	500
+#define MAX_IMAGE_SIZE	500
+
+extern unsigned int image_size;
 
 extern asmlinkage int swsusp_arch_suspend(void);
 extern asmlinkage int swsusp_arch_resume(void);
Index: linux-2.6.15-rc5-mm1/kernel/power/swsusp.c
===================================================================
--- linux-2.6.15-rc5-mm1.orig/kernel/power/swsusp.c	2005-12-10 13:12:18.000000000 +0100
+++ linux-2.6.15-rc5-mm1/kernel/power/swsusp.c	2005-12-10 13:20:42.000000000 +0100
@@ -69,6 +69,8 @@
 
 #include "power.h"
 
+unsigned int image_size = MAX_IMAGE_SIZE;
+
 #ifdef CONFIG_HIGHMEM
 unsigned int count_highmem_pages(void);
 int save_highmem(void);
@@ -647,7 +649,7 @@
 			if (!tmp)
 				return -ENOMEM;
 			pages += tmp;
-		} else if (size > (IMAGE_SIZE * 1024 * 1024) / PAGE_SIZE) {
+		} else if (size > (image_size * 1024 * 1024) / PAGE_SIZE) {
 			tmp = shrink_all_memory(SHRINK_BITE);
 			pages += tmp;
 		}
