Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264527AbUAOD2g (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 22:28:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264598AbUAOD2g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 22:28:36 -0500
Received: from gw.mgpenguin.net ([150.101.216.218]:43999 "EHLO
	mail.mgpenguin.net") by vger.kernel.org with ESMTP id S264527AbUAOD2d
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 22:28:33 -0500
Message-Id: <5.1.0.14.2.20040115140515.00af1318@mail.mgpenguin.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Thu, 15 Jan 2004 14:28:39 +1100
To: greg KH <greg@kroah.com>
From: Kieran Morrissey <linux@mgpenguin.net>
Subject: [PATCH] 2.6.1: Update PCI Name database, fix gen-devlist.c for
  long device names.
Cc: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/mixed; x-avg-checked=avg-ok-1D05283B; boundary="=======235370B7======="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=======235370B7=======
Content-Type: text/plain; x-avg-checked=avg-ok-1D05283B; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 8bit

Hi all and sundry..

Although /proc/pci and by extension the name database is allegedly legacy 
and therefore deprecated, some (including myself) still use it for things 
such as phpSysInfo, and the still-widespread usage of it is obvious in the 
regularity of slight patches to pci.ids. So, this is an all-inclusive patch 
to bring things up to date:

* Updates pci.ids with a snapshot from http://pciids.sourceforge.net/ as at 
14 Jan 04.
* Fixes gen-devlist.c to truncate long device names rather than reject the 
whole database
   (previously the latest databases had some devices that were too long and 
caused a kernel with the latest db to fail to compile)

I've included the (minor) changes to gen-devlist.c in this email if anyone 
cares to discuss them, but since the pci database changes aren't really 
that worthy of discussion on the list and the patch is 83kb, THE COMPLETE 
PATCH has been posted on the web:

http://digital.mgpenguin.net/linux/patch-2.6.1.pci-db/patch.2.6.1.pci-db.diff

or http://digital.mgpenguin.net/linux/ for bzipped versions if you're that 
way inclined..

Cheers,

	Kieran Morrissey


diff -urN -X dontdiff a/drivers/pci/gen-devlist.c b/drivers/pci/gen-devlist.c
--- a/drivers/pci/gen-devlist.c	2003-12-18 13:58:49.000000000 +1100
+++ b/drivers/pci/gen-devlist.c	2004-01-15 13:30:54.929783941 +1100
@@ -10,9 +10,10 @@
  #define MAX_NAME_SIZE 79

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
+							fprintf(stderr, "Line %d: Device name too long. Name truncated.\n", 
lino);
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

--=======235370B7=======--

