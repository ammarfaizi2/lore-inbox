Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271921AbRIIITl>; Sun, 9 Sep 2001 04:19:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271926AbRIIITc>; Sun, 9 Sep 2001 04:19:32 -0400
Received: from mandrakesoft.mandrakesoft.com ([216.71.84.35]:20795 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S271921AbRIIITW>; Sun, 9 Sep 2001 04:19:22 -0400
Date: Sun, 9 Sep 2001 04:19:20 -0400 (EDT)
From: Francis Galiegue <fg@mandrakesoft.com>
To: <linux-kernel@vger.kernel.org>
cc: <alan@redhat.com>, <damien.clermonte@free.fr>
Subject: [PATCH] 2.4.9-ac10 but not only, locks_alloc_lock()
Message-ID: <Pine.LNX.4.30.0109090339060.4681-200000@toy.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463800575-1742948922-1000021617=:4681"
Content-ID: <Pine.LNX.4.30.0109090413230.4681@toy.mandrakesoft.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---1463800575-1742948922-1000021617=:4681
Content-Type: TEXT/PLAIN; CHARSET=iso-8859-1
Content-Transfer-Encoding: 8BIT
Content-ID: <Pine.LNX.4.30.0109090413231.4681@toy.mandrakesoft.com>


Also affects: 2.4.7, 2.4.9-ac{4,6,9}, probably others.

Problem: in locks_mandatory_area(), fcntl_setlk(), fcntl_setlk64(), no
check whether locks_alloc_lock() succeeds. Attached patch fixes that.

Not sure about one thing, though: what error code to return for
locks_mandatory_area() on failure. It's invoked from some of the
{do,sys}_*{read,write}*() routines and nowhere else AFAICT. I set it to
-ENOMEM, maybe this is not the right thing to do.

Patch follows and is attached. Made over 2.4.9-ac10, applies cleanly
over -ac's mentioned above and with offests (1 to 3 lines) on 2.4.7 and
2.4.9.


diff -urN linux-old/fs/locks.c linux/fs/locks.c
--- linux-old/fs/locks.c	Sun Sep  9 09:00:06 2001
+++ linux/fs/locks.c	Sun Sep  9 09:21:07 2001
@@ -698,6 +698,9 @@
 	struct file_lock *new_fl = locks_alloc_lock(0);
 	int error;

+	if (new_fl == NULL)
+		return -ENOMEM;
+
 	new_fl->fl_owner = current->files;
 	new_fl->fl_pid = current->pid;
 	new_fl->fl_file = filp;
@@ -1411,6 +1414,9 @@
 	struct inode *inode;
 	int error;

+	if (file_lock == NULL)
+		return -ENOLCK;
+
 	/*
 	 * This might block, so we do it before checking the inode.
 	 */
@@ -1563,6 +1569,9 @@
 	struct flock64 flock;
 	struct inode *inode;
 	int error;
+
+	if (file_lock == NULL)
+		return -ENOLCK;

 	/*
 	 * This might block, so we do it before checking the inode.

-- 
Francis Galiegue, fg@mandrakesoft.com - Normand et fier de l'être
"Programming is a race between programmers, who try and make more and more
idiot-proof software, and universe, which produces more and more remarkable
idiots. Until now, universe leads the race"  -- R. Cook

---1463800575-1742948922-1000021617=:4681
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; NAME="patch-2.4.9-ac10-locks_allock_check"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.30.0109090346570.4681@toy.mandrakesoft.com>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME="patch-2.4.9-ac10-locks_allock_check"

ZGlmZiAtdXJOIGxpbnV4LW9sZC9mcy9sb2Nrcy5jIGxpbnV4L2ZzL2xvY2tz
LmMNCi0tLSBsaW51eC1vbGQvZnMvbG9ja3MuYwlTdW4gU2VwICA5IDA5OjAw
OjA2IDIwMDENCisrKyBsaW51eC9mcy9sb2Nrcy5jCVN1biBTZXAgIDkgMDk6
MjE6MDcgMjAwMQ0KQEAgLTY5OCw2ICs2OTgsOSBAQA0KIAlzdHJ1Y3QgZmls
ZV9sb2NrICpuZXdfZmwgPSBsb2Nrc19hbGxvY19sb2NrKDApOw0KIAlpbnQg
ZXJyb3I7DQogDQorCWlmIChuZXdfZmwgPT0gTlVMTCkNCisJCXJldHVybiAt
RU5PTUVNOw0KKw0KIAluZXdfZmwtPmZsX293bmVyID0gY3VycmVudC0+Zmls
ZXM7DQogCW5ld19mbC0+ZmxfcGlkID0gY3VycmVudC0+cGlkOw0KIAluZXdf
ZmwtPmZsX2ZpbGUgPSBmaWxwOw0KQEAgLTE0MTEsNiArMTQxNCw5IEBADQog
CXN0cnVjdCBpbm9kZSAqaW5vZGU7DQogCWludCBlcnJvcjsNCiANCisJaWYg
KGZpbGVfbG9jayA9PSBOVUxMKQ0KKwkJcmV0dXJuIC1FTk9MQ0s7DQorDQog
CS8qDQogCSAqIFRoaXMgbWlnaHQgYmxvY2ssIHNvIHdlIGRvIGl0IGJlZm9y
ZSBjaGVja2luZyB0aGUgaW5vZGUuDQogCSAqLw0KQEAgLTE1NjMsNiArMTU2
OSw5IEBADQogCXN0cnVjdCBmbG9jazY0IGZsb2NrOw0KIAlzdHJ1Y3QgaW5v
ZGUgKmlub2RlOw0KIAlpbnQgZXJyb3I7DQorDQorCWlmIChmaWxlX2xvY2sg
PT0gTlVMTCkNCisJCXJldHVybiAtRU5PTENLOw0KIA0KIAkvKg0KIAkgKiBU
aGlzIG1pZ2h0IGJsb2NrLCBzbyB3ZSBkbyBpdCBiZWZvcmUgY2hlY2tpbmcg
dGhlIGlub2RlLg0K
---1463800575-1742948922-1000021617=:4681--
