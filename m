Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129431AbQLGAj7>; Wed, 6 Dec 2000 19:39:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129429AbQLGAjt>; Wed, 6 Dec 2000 19:39:49 -0500
Received: from hugin.diku.dk ([130.225.96.144]:55558 "HELO hugin.diku.dk")
	by vger.kernel.org with SMTP id <S129431AbQLGAje>;
	Wed, 6 Dec 2000 19:39:34 -0500
Date: Thu, 7 Dec 2000 01:09:06 +0100 (CET)
From: Jesper Dangaard Brouer <hawk@diku.dk>
To: linux-kernel@vger.kernel.org, jgarzik@mandrakesoft.com
cc: tulip-devel@lists.sourceforge.net, tulip-users@lists.sourceforge.net
Subject: [PATCH] tulip driver, 2.4.0-test11 kernel, media type
Message-ID: <Pine.LNX.4.21.0012070102330.10746-200000@quark.diku.dk>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-511536032-1209483767-976147746=:10746"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---511536032-1209483767-976147746=:10746
Content-Type: TEXT/PLAIN; charset=US-ASCII


Error/bug in the "tulip" network driver from the 2.4.0-test11 kernel, when
detecting media type.
 
The bug is quite simple.  When detecting the media type, it's possible to
access data outside/beyond the array "medianame[]".  This leads to an
kernel panic Oops.
 
I detected the bug, when using the netcard:
   Phobos P430 Quad port (4 port card)

The card reports it's media type ("leaf->media") to be "17".  And the
array "medianame" only contains 16 entries (0-15).

 
This patch only assures that we don't access elements beyond the static
size of the array (defensive coding).

We should of course expand the array "medianame" with the appropriate
entries.  Note, that Donald Beckers version of the tulip driver have 8
extra elements in this array.

   Jesper Brouer <hawk@diku.dk>

-------------------------------------------------------------------
System Administrator
Dept. of Computer Science, University of Copenhagen
E-mail: hawk@diku.dk, Direct Tel.: 353 21375
-------------------------------------------------------------------

The patch:

--- linux-2.4.0-test11/drivers/net/tulip/eeprom.c	Mon Jun 19 22:42:39 2000
+++ linux/drivers/net/tulip/eeprom.c	Wed Dec  6 23:03:10 2000
@@ -236,7 +236,8 @@
 			}
 			printk(KERN_INFO "%s:  Index #%d - Media %s (#%d) described "
 				   "by a %s (%d) block.\n",
-				   dev->name, i, medianame[leaf->media], leaf->media,
+				   dev->name, i, 
+				   leaf->media < 16 ? medianame[leaf->media] : "UNKNOWN", leaf->media,
 				   block_name[leaf->type], leaf->type);
 		}
 		if (new_advertise)

---511536032-1209483767-976147746=:10746
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="tulip.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.21.0012070109060.10746@quark.diku.dk>
Content-Description: 
Content-Disposition: attachment; filename="tulip.patch"

LS0tIGxpbnV4LTIuNC4wLXRlc3QxMS9kcml2ZXJzL25ldC90dWxpcC9lZXBy
b20uYwlNb24gSnVuIDE5IDIyOjQyOjM5IDIwMDANCisrKyBsaW51eC9kcml2
ZXJzL25ldC90dWxpcC9lZXByb20uYwlXZWQgRGVjICA2IDIzOjAzOjEwIDIw
MDANCkBAIC0yMzYsNyArMjM2LDggQEANCiAJCQl9DQogCQkJcHJpbnRrKEtF
Uk5fSU5GTyAiJXM6ICBJbmRleCAjJWQgLSBNZWRpYSAlcyAoIyVkKSBkZXNj
cmliZWQgIg0KIAkJCQkgICAiYnkgYSAlcyAoJWQpIGJsb2NrLlxuIiwNCi0J
CQkJICAgZGV2LT5uYW1lLCBpLCBtZWRpYW5hbWVbbGVhZi0+bWVkaWFdLCBs
ZWFmLT5tZWRpYSwNCisJCQkJICAgZGV2LT5uYW1lLCBpLCANCisJCQkJICAg
bGVhZi0+bWVkaWEgPCAxNiA/IG1lZGlhbmFtZVtsZWFmLT5tZWRpYV0gOiAi
VU5LTk9XTiIsIGxlYWYtPm1lZGlhLA0KIAkJCQkgICBibG9ja19uYW1lW2xl
YWYtPnR5cGVdLCBsZWFmLT50eXBlKTsNCiAJCX0NCiAJCWlmIChuZXdfYWR2
ZXJ0aXNlKQ0K
---511536032-1209483767-976147746=:10746--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
