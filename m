Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132429AbRCaP7L>; Sat, 31 Mar 2001 10:59:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132433AbRCaP7B>; Sat, 31 Mar 2001 10:59:01 -0500
Received: from bacchus.veritas.com ([204.177.156.37]:38864 "EHLO
	bacchus-int.veritas.com") by vger.kernel.org with ESMTP
	id <S132429AbRCaP6t>; Sat, 31 Mar 2001 10:58:49 -0500
Date: Sat, 31 Mar 2001 16:07:13 +0100 (BST)
From: Mark Hemment <markhe@veritas.com>
To: Jens Axboe <axboe@suse.de>, eric@andante.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Possible SCSI + block-layer bugs
Message-ID: <Pine.LNX.4.21.0103311505130.4246-200000@alloc>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="168455872-618132454-986051233=:4246"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--168455872-618132454-986051233=:4246
Content-Type: TEXT/PLAIN; charset=US-ASCII

Hi,

  I've never seen these trigger, but they look theoretically possible.

  When processing the completion of a SCSI request in a bottom-half,
__scsi_end_request() can find all the buffers associated with the request
haven't been completed (ie. leftovers).

  One question is; can this ever happen?
  If it can't then the code should be removed from __scsi_end_request(),
if it can happen then there appears to be a few problems;

  The request is re-queued to the block layer via 
scsi_queue_next_request(), which uses the "special" pointer in the request
structure to remember the Scsi_Cmnd associated with the request.  The SCSI
request function is then called, but doesn't guarantee to immediately
process the re-queued request even though it was added at the head (say,
the queue has become plugged).  This can trigger two possible bugs.

  The first is that __scsi_end_request() doesn't decrement the
hard_nr_sectors count in the request.  As the request is back on the
queue, it is possible for newly arriving buffer-heads to merge with the
heads already hanging off the request.  This merging uses the
hard_nr_sectors when calculating both the merged hard_nr_sectors and
nr_sectors counts.
  As the request is at the head, only back-merging can occur, but if
__scsi_end_request() triggers another uncompleted request to be re-queued,
it is possible to get front merging as well.

  The merging of a re-queued request looks safe, except for the
hard_nr_sectors.  This patch corrects the hard_nr_sectors accounting.


  The second bug is from request merging in attempt_merge().

  For a re-queued request, the request structure is the one embedded in
the Scsi_Cmnd (which is a copy of the request taken in the 
scsi_request_fn).
  In attempt_merge(), q->merge_requests_fn() is called to see the requests
are allowed to merge.  __scsi_merge_requests_fn() checks number of
segments, etc, but doesn't check if one of the requests is a re-queued one
(ie. no test against ->special).
  This can lead to attempt_merge() releasing the embedded request
structure (which, as an extract copy, has the ->q set, so to
blkdev_release_request() it looks like a request which originated from
the block layer).  This isn't too healthy.

  The fix here is to add a check in __scsi_merge_requests_fn() to check
for ->special being non-NULL.

  The attached patch is against 2.4.3.

  Jens, Eric, anyone, comments?

Mark

--168455872-618132454-986051233=:4246
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="scsi.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.21.0103311607130.4246@alloc>
Content-Description: scsi.patch
Content-Disposition: attachment; filename="scsi.patch"

ZGlmZiAtdXJOIC1YIGRvbnRkaWZmIGxpbnV4LTIuNC4zL2RyaXZlcnMvc2Nz
aS9zY3NpX2xpYi5jIG1hcmtoZS0yLjQuMy9kcml2ZXJzL3Njc2kvc2NzaV9s
aWIuYw0KLS0tIGxpbnV4LTIuNC4zL2RyaXZlcnMvc2NzaS9zY3NpX2xpYi5j
CVNhdCBNYXIgIDMgMDI6Mzg6MzkgMjAwMQ0KKysrIG1hcmtoZS0yLjQuMy9k
cml2ZXJzL3Njc2kvc2NzaV9saWIuYwlTYXQgTWFyIDMxIDE2OjU2OjMxIDIw
MDENCkBAIC0zNzcsMTIgKzM3NywxNSBAQA0KIAkJCW5zZWN0ID0gYmgtPmJf
c2l6ZSA+PiA5Ow0KIAkJCWJsa19maW5pc2hlZF9pbyhuc2VjdCk7DQogCQkJ
cmVxLT5iaCA9IGJoLT5iX3JlcW5leHQ7DQotCQkJcmVxLT5ucl9zZWN0b3Jz
IC09IG5zZWN0Ow0KLQkJCXJlcS0+c2VjdG9yICs9IG5zZWN0Ow0KIAkJCWJo
LT5iX3JlcW5leHQgPSBOVUxMOw0KIAkJCXNlY3RvcnMgLT0gbnNlY3Q7DQog
CQkJYmgtPmJfZW5kX2lvKGJoLCB1cHRvZGF0ZSk7DQogCQkJaWYgKChiaCA9
IHJlcS0+YmgpICE9IE5VTEwpIHsNCisJCQkJcmVxLT5oYXJkX3NlY3RvciAr
PSBuc2VjdDsNCisJCQkJcmVxLT5oYXJkX25yX3NlY3RvcnMgLT0gbnNlY3Q7
DQorCQkJCXJlcS0+c2VjdG9yICs9IG5zZWN0Ow0KKwkJCQlyZXEtPm5yX3Nl
Y3RvcnMgLT0gbnNlY3Q7DQorDQogCQkJCXJlcS0+Y3VycmVudF9ucl9zZWN0
b3JzID0gYmgtPmJfc2l6ZSA+PiA5Ow0KIAkJCQlpZiAocmVxLT5ucl9zZWN0
b3JzIDwgcmVxLT5jdXJyZW50X25yX3NlY3RvcnMpIHsNCiAJCQkJCXJlcS0+
bnJfc2VjdG9ycyA9IHJlcS0+Y3VycmVudF9ucl9zZWN0b3JzOw0KZGlmZiAt
dXJOIC1YIGRvbnRkaWZmIGxpbnV4LTIuNC4zL2RyaXZlcnMvc2NzaS9zY3Np
X21lcmdlLmMgbWFya2hlLTIuNC4zL2RyaXZlcnMvc2NzaS9zY3NpX21lcmdl
LmMNCi0tLSBsaW51eC0yLjQuMy9kcml2ZXJzL3Njc2kvc2NzaV9tZXJnZS5j
CUZyaSBGZWIgIDkgMTk6MzA6MjMgMjAwMQ0KKysrIG1hcmtoZS0yLjQuMy9k
cml2ZXJzL3Njc2kvc2NzaV9tZXJnZS5jCVNhdCBNYXIgMzEgMTY6Mzg6Mjcg
MjAwMQ0KQEAgLTU5Nyw2ICs1OTcsMTMgQEANCiAJU2NzaV9EZXZpY2UgKlNE
cG50Ow0KIAlzdHJ1Y3QgU2NzaV9Ib3N0ICpTSHBudDsNCiANCisJLyoNCisJ
ICogRmlyc3QgY2hlY2sgaWYgdGhlIGVpdGhlciBvZiB0aGUgcmVxdWVzdHMg
YXJlIHJlLXF1ZXVlZA0KKwkgKiByZXF1ZXN0cy4gIENhbid0IG1lcmdlIHRo
ZW0gaWYgdGhleSBhcmUuDQorCSAqLw0KKwlpZiAocmVxLT5zcGVjaWFsIHx8
IG5leHQtPnNwZWNpYWwpDQorCQlyZXR1cm4gMDsNCisNCiAJU0RwbnQgPSAo
U2NzaV9EZXZpY2UgKikgcS0+cXVldWVkYXRhOw0KIAlTSHBudCA9IFNEcG50
LT5ob3N0Ow0K
--168455872-618132454-986051233=:4246--
