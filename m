Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266487AbUA2XPq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 18:15:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266490AbUA2XPq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 18:15:46 -0500
Received: from p13109-ipadfx01funabasi.chiba.ocn.ne.jp ([220.96.188.109]:6528
	"HELO achurch.org") by vger.kernel.org with SMTP id S266487AbUA2XPn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 18:15:43 -0500
From: achurch@achurch.org (Andrew Church)
To: linux-kernel@vger.kernel.org
Subject: Crypto/cryptoloop(?) bug in 2.6.1
Date: Fri, 30 Jan 2004 08:10:12 JST
Content-Type: text/plain; charset=ISO-2022-JP
X-Mailer: MMail v5.15
Message-ID: <4019941c.02327@achurch.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Note: I am not subscribed to the LKML--please CC any replies.]

     While trying unsuccessfully to get encrypted loop filesystems working
under kernel 2.6.1, I found that the crypto system is not properly copying
data to and from pages used by the cryptoloop driver (possibly only for
file-backed loop filesystems).  Using the following script with losetup
from util-linux 2.12:

---- cut here ----
yes 0000000 | head -65536c > /tmp/test
head -8c /tmp/test
losetup /dev/loop0 /tmp/test
echo 1234567 > /dev/loop0
losetup -d /dev/loop0
head -8c /tmp/test
echo abcdefgh | losetup -e aes-cbc -p 0 /dev/loop0 /tmp/test
echo 7654321 >/dev/loop0
losetup -d /dev/loop0
head -8c /tmp/test
---- cut here ----

kernel 2.4.21 with the kerneli.org and jari cryptoloop patches performs as
expected (the first head -8c outputs "1234567", while the second outputs
encrypted data), but kernel 2.6.1 outputs "1234567" both times, and
attempting to decrypt the "7654321" encrypted under 2.4.21 produces
garbage.  Inserting debug printk's shows:

cryptoloop: cipher=[aes-cbc] keysize=32 key=[6162636465666768000000000000000000000000000000000000000000000000
[[ crypt ]]
  enc=0 in=31323334 3536370A 30303030 3030300A
  in: data=ffff1000 tmp=f7c63da0 // which_buf chose ffff1000
  in: src_p is 55D8893C 24895C24 04FF1085 C074758B
  after copy:  55D8893C 24895C24 04FF1085 C074758B

i.e., the right data is being passed into crypt(), but scatterwalk_map()
isn't mapping it correctly.  Likewise, the data encrypted on write isn't
making it to the page allocated for writing by the cryptoloop driver.  The
patch below fixes the problem by bypassing the mapping completely and
directly accessing the pages passed in, but I have no idea whether this is
safe or not.

     Is this a known problem, and if so, is there a solution for it?

  --Andrew Church
    achurch@achurch.org
    http://achurch.org/

---------------------------------------------------------------------------

--- crypto/cipher.c.old	2004-01-29 12:10:00 +0900
+++ crypto/cipher.c	2004-01-29 12:49:43 +0900
@@ -98,7 +98,7 @@
 
 static void scatterwalk_map(struct scatter_walk *walk, int out)
 {
-	walk->data = crypto_kmap(walk->page, out) + walk->offset;
+	walk->data = pfn_to_kaddr(page_to_pfn(walk->page)) + walk->offset;
 }
 
 static void scatter_page_done(struct scatter_walk *walk, int out,
@@ -127,7 +127,6 @@
 
 static void scatter_done(struct scatter_walk *walk, int out, int more)
 {
-	crypto_kunmap(walk->data, out);
 	if (walk->len_this_page == 0 || !more)
 		scatter_page_done(walk, out, more);
 }
@@ -145,7 +144,6 @@
 			buf += walk->len_this_page;
 			nbytes -= walk->len_this_page;
 
-			crypto_kunmap(walk->data, out);
 			scatter_page_done(walk, out, 1);
 			scatterwalk_map(walk, out);
 		}
