Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264365AbUATEIp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 23:08:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264405AbUATEIo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 23:08:44 -0500
Received: from gw.mgpenguin.net ([150.101.216.218]:40324 "EHLO
	mail.mgpenguin.net") by vger.kernel.org with ESMTP id S264365AbUATEIa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 23:08:30 -0500
Message-Id: <5.1.0.14.2.20040120150620.02e18a30@mail.mgpenguin.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Tue, 20 Jan 2004 15:08:27 +1100
To: Greg KH <greg@kroah.com>
From: Kieran Morrissey <linux@mgpenguin.net>
Subject: [PATCH] 2.6.1: Fix gen-devlist.c to truncate names cleanly,
  increase device name length
Cc: Martin Mares <mj@ucw.cz>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/mixed; x-avg-checked=avg-ok-5B2467C; boundary="=======3C6539C======="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=======3C6539C=======
Content-Type: text/plain; x-avg-checked=avg-ok-5B2467C; charset=us-ascii
Content-Transfer-Encoding: 8bit

At 05:30 PM 19/01/2004 -0800, you wrote:
>On Sat, Jan 17, 2004 at 11:39:00AM +0100, Martin Mares wrote:
>> Hello!
>> 
>> > * Updates pci.ids with a snapshot from http://pciids.sourceforge.net/ as at 
>> > 14 Jan 04.
>> > * Fixes gen-devlist.c to truncate long device names rather than reject the 
>> > whole database
>> >   (previously the latest databases had some devices that were too long and 
>> > caused a kernel with the latest db to fail to compile)
>> 
>> I think it would be better to increase the name length limit, the long entries
>> really have useful information at the end :)
>
>That's probably a good idea.  Kieran, care to make up a patch to do
>this?
>
>thanks,
>
>greg k-h

Sure, here it is. This patch is against the 2.6.1 kernel.org tree, ie not one patched with changes previously made by me to gen-devlist.c:

To limit volume of data on this list, the included patch doesn't include an update to pci.ids. There's a patch that applies these changes, and installs a new pci.ids database at http://digital.mgpenguin.net/linux/

* Updates gen-devlist.c to truncate device names neatly rather than crashing out
* Changes PCI_NAME_SIZE to 96 (and PCI_NAME_HALF to 43)
* Modifies gen-devlist.c to truncate at 89 characters rather than 79 - allows for two digit instance numbers to be added to the name as well while staying within the 96 characters allocated.
   No names in the current pci.ids are any longer than this.
* Modifies names.c to no longer limit device name length when displaying both vendor and device name; the truncation is done by gen-devlist.c.

The attached code-only patch is against the distributed 2.6.1 tree (will not work on a tree already patched with my previous modifications to gen-devlist.c). But at least it's not line-wrapped this time. :)

diff -urN -X dontdiff a/drivers/pci/gen-devlist.c b/drivers/pci/gen-devlist.c
--- a/drivers/pci/gen-devlist.c 2003-12-18 13:58:49.000000000 +1100
+++ b/drivers/pci/gen-devlist.c 2004-01-20 13:56:49.889616464 +1100
@@ -7,12 +7,13 @@
 #include <stdio.h>
 #include <string.h>
 
-#define MAX_NAME_SIZE 79
+#define MAX_NAME_SIZE 89
 
 static void
-pq(FILE *f, const char *c)
+pq(FILE *f, const char *c, int len)
 {
-       while (*c) {
+       int i = 1;
+       while (*c && i != len) {
                if (*c == '"')
                        fprintf(f, "\\\"");
                else {
@@ -23,6 +24,7 @@
                        }
                }
                c++;
+               i++;
        }
 }
 
@@ -72,13 +74,13 @@
                                                if (bra && bra > c && bra[-1] == ' ')
                                                        bra[-1] = 0;
                                                if (vendor_len + strlen(c) + 1 > MAX_NAME_SIZE) {
-                                                       fprintf(stderr, "Line %d: Device name too long\n", lino);
+                                                       fprintf(stderr, "Line %d: Device name too long. Name truncated.\n", lino);
                                                        fprintf(stderr, "%s\n", c);
-                                                       return 1;
+                                                       /*return 1;*/
                                                }
                                        }
                                        fprintf(devf, "\tDEVICE(%s,%s,\"", vend, line+1);
-                                       pq(devf, c);
+                                       pq(devf, c, MAX_NAME_SIZE - vendor_len - 1);
                                        fputs("\")\n", devf);
                                } else goto err;
                                break;
@@ -107,7 +109,7 @@
                                return 1;
                        }
                        fprintf(devf, "VENDOR(%s,\"", vend);
-                       pq(devf, c);
+                       pq(devf, c, 0);
                        fputs("\")\n", devf);
                        mode = 1;
                } else {
diff -urN -X dontdiff a/drivers/pci/names.c b/drivers/pci/names.c
--- a/drivers/pci/names.c       2003-12-18 13:58:08.000000000 +1100
+++ b/drivers/pci/names.c       2004-01-20 13:29:37.000000000 +1100
@@ -86,8 +86,7 @@
 
                /* Full match */
                match_device: {
-                       char *n = name + sprintf(name, "%." PCI_NAME_HALF
-                                       "s %." PCI_NAME_HALF "s",
+                       char *n = name + sprintf(name, "%s %s",
                                        vendor_p->name, device_p->name);
                        int nr = device_p->seen + 1;
                        device_p->seen = nr;
diff -urN -X dontdiff a/include/linux/pci.h b/include/linux/pci.h
--- a/include/linux/pci.h       2004-01-14 15:23:00.000000000 +1100
+++ b/include/linux/pci.h       2004-01-20 13:29:37.000000000 +1100
@@ -425,8 +425,8 @@
        unsigned int    transparent:1;  /* Transparent PCI bridge */
        unsigned int    multifunction:1;/* Part of multi-function device */
 #ifdef CONFIG_PCI_NAMES
-#define PCI_NAME_SIZE  50
-#define PCI_NAME_HALF  __stringify(20) /* less than half to handle slop */
+#define PCI_NAME_SIZE  96
+#define PCI_NAME_HALF  __stringify(43) /* less than half to handle slop */
        char            pretty_name[PCI_NAME_SIZE];     /* pretty name for users to see */
 #endif
 };


--=======3C6539C=======--

