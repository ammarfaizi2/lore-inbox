Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261748AbTKCNVX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Nov 2003 08:21:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261757AbTKCNVX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Nov 2003 08:21:23 -0500
Received: from [217.30.254.203] ([217.30.254.203]:6272 "EHLO
	alpha.linuxassembly.org") by vger.kernel.org with ESMTP
	id S261748AbTKCNVV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Nov 2003 08:21:21 -0500
Date: Mon, 3 Nov 2003 16:21:59 +0300 (MSK)
From: Konstantin Boldyshev <konst@linuxassembly.org>
To: linux-kernel@vger.kernel.org
cc: marcelo.tosatti@cyclades.com
Subject: minix fs corruption fix for 2.4
Message-ID: <Pine.LNX.4.43L.0311031557480.1077-200000@alpha.linuxassembly.org>
Organization: Linux Assembly [http://linuxassembly.org]
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463747071-641386181-1067865719=:1077"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---1463747071-641386181-1067865719=:1077
Content-Type: TEXT/PLAIN; charset=US-ASCII

Hello,

Enclosed is a simple patch to fix corruption of minix filesystem
when deleting character and block device nodes (special files).
>From what I've found out the bug was introduced somehwere in 2.3
and is present in all 2.4 versions, and I guess also goes into 2.6.
Older 2.0 and 2.2 kernels do not have it - it seems that one who
was rewriting fs code for 2.4 just forgot to add the needed check.

Note that other filesystems that are rarely used nowdays may have
the same bug, especially if they used minix code as a template.


diff -urN linux-2.4.22/fs/minix/itree_common.c linux/fs/minix/itree_common.c
--- linux-2.4.22/fs/minix/itree_common.c	Thu Oct 16 11:30:27 2003
+++ linux/fs/minix/itree_common.c	Mon Nov  3 12:25:20 2003
@@ -301,6 +301,12 @@
 	int first_whole;
 	long iblock;

+	if (!(S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode) ||
+	    S_ISLNK(inode->i_mode)))
+		return;
+	if (IS_APPEND(inode) || IS_IMMUTABLE(inode))
+		return;
+
 	iblock = (inode->i_size + BLOCK_SIZE-1) >> 10;
 	block_truncate_page(inode->i_mapping, inode->i_size, get_block);


-- 
Regards,
Konstantin

---1463747071-641386181-1067865719=:1077
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="minixfs-corruption-fix.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.43L.0311031621590.1077@alpha.linuxassembly.org>
Content-Description: 
Content-Disposition: attachment; filename="minixfs-corruption-fix.patch"

ZGlmZiAtdXJOIGxpbnV4LTIuNC4yMi9mcy9taW5peC9pdHJlZV9jb21tb24u
YyBsaW51eC9mcy9taW5peC9pdHJlZV9jb21tb24uYw0KLS0tIGxpbnV4LTIu
NC4yMi9mcy9taW5peC9pdHJlZV9jb21tb24uYwlUaHUgT2N0IDE2IDExOjMw
OjI3IDIwMDMNCisrKyBsaW51eC9mcy9taW5peC9pdHJlZV9jb21tb24uYwlN
b24gTm92ICAzIDEyOjI1OjIwIDIwMDMNCkBAIC0zMDEsNiArMzAxLDEyIEBA
DQogCWludCBmaXJzdF93aG9sZTsNCiAJbG9uZyBpYmxvY2s7DQogDQorCWlm
ICghKFNfSVNSRUcoaW5vZGUtPmlfbW9kZSkgfHwgU19JU0RJUihpbm9kZS0+
aV9tb2RlKSB8fA0KKwkgICAgU19JU0xOSyhpbm9kZS0+aV9tb2RlKSkpDQor
CQlyZXR1cm47DQorCWlmIChJU19BUFBFTkQoaW5vZGUpIHx8IElTX0lNTVVU
QUJMRShpbm9kZSkpDQorCQlyZXR1cm47DQorDQogCWlibG9jayA9IChpbm9k
ZS0+aV9zaXplICsgQkxPQ0tfU0laRS0xKSA+PiAxMDsNCiAJYmxvY2tfdHJ1
bmNhdGVfcGFnZShpbm9kZS0+aV9tYXBwaW5nLCBpbm9kZS0+aV9zaXplLCBn
ZXRfYmxvY2spOw0KIA0K
---1463747071-641386181-1067865719=:1077--
