Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268133AbRIHJOq>; Sat, 8 Sep 2001 05:14:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268145AbRIHJOh>; Sat, 8 Sep 2001 05:14:37 -0400
Received: from mandrakesoft.mandrakesoft.com ([216.71.84.35]:19777 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S268133AbRIHJOa>; Sat, 8 Sep 2001 05:14:30 -0400
Date: Sat, 8 Sep 2001 05:14:34 -0400 (EDT)
From: Francis Galiegue <fg@mandrakesoft.com>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.9-ac9 bug + patch
Message-ID: <Pine.LNX.4.30.0109080513360.4681-200000@toy.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463800575-995472036-999940474=:4681"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---1463800575-995472036-999940474=:4681
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT


Also in 2.4.7, 2.4.9, 2.4.9-ac4, 2.4.9-ac6.

fs/locks.c, line 693:

----
int locks_mandatory_area(int read_write, struct inode *inode,
			 struct file *filp, loff_t offset,
			 size_t count)
{
	struct file_lock *fl;
	struct file_lock *new_fl = locks_alloc_lock(0);
	int error;

	new_fl->fl_owner = current->files;
[...]
----

No check on whether locks_alloc_lock() succeeds. Or do I miss something?

Patch follows:

--- fs/locks.c	Fri Sep  7 23:06:49 2001
+++ fs/locks.c.new	Sat Sep  8 01:03:50 2001
@@ -698,6 +698,9 @@
 	struct file_lock *new_fl = locks_alloc_lock(0);
 	int error;

+	if (new_fl == NULL)
+		return -ENOMEM;
+
 	new_fl->fl_owner = current->files;
 	new_fl->fl_pid = current->pid;
 	new_fl->fl_file = filp;

-- 
Francis Galiegue, fg@mandrakesoft.com - Normand et fier de l'être
"Programming is a race between programmers, who try and make more and more
idiot-proof software, and universe, which produces more and more remarkable
idiots. Until now, universe leads the race"  -- R. Cook



---1463800575-995472036-999940474=:4681
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=foo
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.30.0109080514340.4681@toy.mandrakesoft.com>
Content-Description: 
Content-Disposition: attachment; filename=foo

LS0tIGZzL2xvY2tzLmMJRnJpIFNlcCAgNyAyMzowNjo0OSAyMDAxDQorKysg
ZnMvbG9ja3MuYy5uZXcJU2F0IFNlcCAgOCAwMTowMzo1MCAyMDAxDQpAQCAt
Njk4LDYgKzY5OCw5IEBADQogCXN0cnVjdCBmaWxlX2xvY2sgKm5ld19mbCA9
IGxvY2tzX2FsbG9jX2xvY2soMCk7DQogCWludCBlcnJvcjsNCiANCisJaWYg
KG5ld19mbCA9PSBOVUxMKQ0KKwkJcmV0dXJuIC1FTk9NRU07DQorDQogCW5l
d19mbC0+Zmxfb3duZXIgPSBjdXJyZW50LT5maWxlczsNCiAJbmV3X2ZsLT5m
bF9waWQgPSBjdXJyZW50LT5waWQ7DQogCW5ld19mbC0+ZmxfZmlsZSA9IGZp
bHA7DQo=
---1463800575-995472036-999940474=:4681--
