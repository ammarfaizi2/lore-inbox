Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266505AbUA3BtN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 20:49:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266530AbUA3Bec
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 20:34:32 -0500
Received: from mail.kroah.org ([65.200.24.183]:6108 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266505AbUA3Bb6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 20:31:58 -0500
Subject: Re: [PATCH] PCI Update for 2.6.2-rc2
In-Reply-To: <10754263103006@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 29 Jan 2004 17:31:50 -0800
Message-Id: <10754263101353@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1522, 2004/01/29 17:12:59-08:00, kieran@mgpenguin.net

[PATCH] PCI: name length change

- Changes gen-devlist.c to truncate long device names rather than reject
  the database
- Changes PCI_NAME_SIZE to 96 (and PCI_NAME_HALF to 43) to allow all
  current pci.ids names to fit
- Modifies gen-devlist.c to truncate at 89 characters rather than 79 -
  allows for two digit instance numbers to be added to the name as well
  while staying within the 96 characters allocated. No names in the
  current pci.ids are any longer than this.
- Modifies names.c to no longer limit device name length when displaying
  both vendor and device name; the truncation is done by gen-devlist.c.


 drivers/pci/gen-devlist.c |   16 +++++++++-------
 drivers/pci/names.c       |    3 +--
 include/linux/pci.h       |    4 ++--
 3 files changed, 12 insertions(+), 11 deletions(-)


diff -Nru a/drivers/pci/gen-devlist.c b/drivers/pci/gen-devlist.c
--- a/drivers/pci/gen-devlist.c	Thu Jan 29 17:23:52 2004
+++ b/drivers/pci/gen-devlist.c	Thu Jan 29 17:23:52 2004
@@ -7,12 +7,13 @@
 #include <stdio.h>
 #include <string.h>
 
-#define MAX_NAME_SIZE 79
+#define MAX_NAME_SIZE 89
 
 static void
-pq(FILE *f, const char *c)
+pq(FILE *f, const char *c, int len)
 {
-	while (*c) {
+	int i = 1;
+	while (*c && i != len) {
 		if (*c == '"')
 			fprintf(f, "\\\"");
 		else {
@@ -23,6 +24,7 @@
 			}
 		}
 		c++;
+		i++;
 	}
 }
 
@@ -72,13 +74,13 @@
 						if (bra && bra > c && bra[-1] == ' ')
 							bra[-1] = 0;
 						if (vendor_len + strlen(c) + 1 > MAX_NAME_SIZE) {
-							fprintf(stderr, "Line %d: Device name too long\n", lino);
+							fprintf(stderr, "Line %d: Device name too long. Name truncated.\n", lino);
 							fprintf(stderr, "%s\n", c);
-							return 1;
+							/*return 1;*/
 						}
 					}
 					fprintf(devf, "\tDEVICE(%s,%s,\"", vend, line+1);
-					pq(devf, c);
+					pq(devf, c, MAX_NAME_SIZE - vendor_len - 1);
 					fputs("\")\n", devf);
 				} else goto err;
 				break;
@@ -107,7 +109,7 @@
 				return 1;
 			}
 			fprintf(devf, "VENDOR(%s,\"", vend);
-			pq(devf, c);
+			pq(devf, c, 0);
 			fputs("\")\n", devf);
 			mode = 1;
 		} else {
diff -Nru a/drivers/pci/names.c b/drivers/pci/names.c
--- a/drivers/pci/names.c	Thu Jan 29 17:23:52 2004
+++ b/drivers/pci/names.c	Thu Jan 29 17:23:52 2004
@@ -86,8 +86,7 @@
 
 		/* Full match */
 		match_device: {
-			char *n = name + sprintf(name, "%." PCI_NAME_HALF
-					"s %." PCI_NAME_HALF "s",
+			char *n = name + sprintf(name, "%s %s",
 					vendor_p->name, device_p->name);
 			int nr = device_p->seen + 1;
 			device_p->seen = nr;
diff -Nru a/include/linux/pci.h b/include/linux/pci.h
--- a/include/linux/pci.h	Thu Jan 29 17:23:52 2004
+++ b/include/linux/pci.h	Thu Jan 29 17:23:52 2004
@@ -425,8 +425,8 @@
 	unsigned int	transparent:1;	/* Transparent PCI bridge */
 	unsigned int	multifunction:1;/* Part of multi-function device */
 #ifdef CONFIG_PCI_NAMES
-#define PCI_NAME_SIZE	50
-#define PCI_NAME_HALF	__stringify(20)	/* less than half to handle slop */
+#define PCI_NAME_SIZE	96
+#define PCI_NAME_HALF	__stringify(43)	/* less than half to handle slop */
 	char		pretty_name[PCI_NAME_SIZE];	/* pretty name for users to see */
 #endif
 };

