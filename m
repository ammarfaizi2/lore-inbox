Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132226AbRDJPdA>; Tue, 10 Apr 2001 11:33:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132281AbRDJPcu>; Tue, 10 Apr 2001 11:32:50 -0400
Received: from chiara.elte.hu ([157.181.150.200]:46607 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S132226AbRDJPcb>;
	Tue, 10 Apr 2001 11:32:31 -0400
Date: Tue, 10 Apr 2001 16:31:15 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alexander Viro <viro@math.psu.edu>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: [patch] ext2-fs filesystem corruption since 2.4.0-test6, fix
Message-ID: <Pine.LNX.4.30.0104101610450.4659-200000@elte.hu>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="655616-1717260262-986913075=:4659"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--655616-1717260262-986913075=:4659
Content-Type: TEXT/PLAIN; charset=US-ASCII


the attached patch fixes the ext2-fs filesystem corruption that initially
showed up during stress-tests running on Red Hat's internal testsystems,
and which bug kept us busy for a long time. We suspect that a number of
filesystem corruption bugs reported to l-k were caused by this bug too.

after lots of bug-hunting and bug-finding, the main bug turned out to be
this one: a block that might still (or already) be allocated by ext2fs was
bforgot()ten by ext2_get_block(). The (incorrect) assumption of the code
was that this rare case can only happen in case of a parallel truncate()
to this inode. In reality there might be enough delay to this particular
process in which window this same block might have gotten reallocated and
dirtied again. Thus the bforget() discards possibly valid metadata, most
commonly indirect blocks, causing filesystem corruption.

via customized Cerberus testruns the bug used to trigger within 20 minutes
on SMP systems, and within a couple of hours on UP systems. (initially it
was very hard to trigger the bug, it tooks days of nonstop high-load tests
for the corruption to trigger.) Alex Romosan's report to l-k looks
suspiciously similar to the failures we've been getting.

The corruption has been introduced in 2.4.0-test6. With this patch applied
we've been unable to reproduce any kind of filesystem corruption under the
most extreme 'enterprise' loads. The attached patch applies to 2.4.4-pre1
cleanly and compiles, boots just fine. There is a sister-bug in minix-fs
as well, the patch fixes that bug too. The patch also includes two
inode-dirtying fixes, which bugs never caused any filesystem corruptions
but were incorrect nevertheless.

	Ingo

--655616-1717260262-986913075=:4659
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="ext2fs-corruption-2.4.4-A0"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.30.0104101631150.4659@elte.hu>
Content-Description: 
Content-Disposition: attachment; filename="ext2fs-corruption-2.4.4-A0"

LS0tIGxpbnV4L2ZzL2V4dDIvaW5vZGUuYy5vcmlnCVR1ZSBBcHIgMTAgMTk6
MDA6MzUgMjAwMQ0KKysrIGxpbnV4L2ZzL2V4dDIvaW5vZGUuYwlUdWUgQXBy
IDEwIDE5OjA2OjI1IDIwMDENCkBAIC01NjgsNyArNTY4LDcgQEANCiANCiBj
aGFuZ2VkOg0KIAl3aGlsZSAocGFydGlhbCA+IGNoYWluKSB7DQotCQliZm9y
Z2V0KHBhcnRpYWwtPmJoKTsNCisJCWJyZWxzZShwYXJ0aWFsLT5iaCk7DQog
CQlwYXJ0aWFsLS07DQogCX0NCiAJZ290byByZXJlYWQ7DQpAQCAtNzk5LDgg
Kzc5OSw4IEBADQogCQkJCS8qIFdyaXRlcjogLT5pX2Jsb2NrcyAqLw0KIAkJ
CQlpbm9kZS0+aV9ibG9ja3MgLT0gYmxvY2tzICogY291bnQ7DQogCQkJCS8q
IFdyaXRlcjogZW5kICovDQotCQkJCWV4dDJfZnJlZV9ibG9ja3MgKGlub2Rl
LCBibG9ja190b19mcmVlLCBjb3VudCk7DQogCQkJCW1hcmtfaW5vZGVfZGly
dHkoaW5vZGUpOw0KKwkJCQlleHQyX2ZyZWVfYmxvY2tzIChpbm9kZSwgYmxv
Y2tfdG9fZnJlZSwgY291bnQpOw0KIAkJCWZyZWVfdGhpczoNCiAJCQkJYmxv
Y2tfdG9fZnJlZSA9IG5yOw0KIAkJCQljb3VudCA9IDE7DQpAQCAtODExLDgg
KzgxMSw4IEBADQogCQkvKiBXcml0ZXI6IC0+aV9ibG9ja3MgKi8NCiAJCWlu
b2RlLT5pX2Jsb2NrcyAtPSBibG9ja3MgKiBjb3VudDsNCiAJCS8qIFdyaXRl
cjogZW5kICovDQotCQlleHQyX2ZyZWVfYmxvY2tzIChpbm9kZSwgYmxvY2tf
dG9fZnJlZSwgY291bnQpOw0KIAkJbWFya19pbm9kZV9kaXJ0eShpbm9kZSk7
DQorCQlleHQyX2ZyZWVfYmxvY2tzIChpbm9kZSwgYmxvY2tfdG9fZnJlZSwg
Y291bnQpOw0KIAl9DQogfQ0KIA0K
--655616-1717260262-986913075=:4659--
