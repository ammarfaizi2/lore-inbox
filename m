Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264461AbUEKMmn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264461AbUEKMmn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 08:42:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264671AbUEKMmn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 08:42:43 -0400
Received: from [212.209.10.220] ([212.209.10.220]:41909 "EHLO
	miranda.se.axis.com") by vger.kernel.org with ESMTP id S264461AbUEKMmi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 08:42:38 -0400
Date: Tue, 11 May 2004 14:57:40 +0200 (CEST)
From: Bjorn Wesen <bjorn.wesen@axis.com>
X-X-Sender: <bjornw@godzilla.se.axis.com>
To: <marcelo.tosatti@cyclades.com>
cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH] bug in 2.4.26 mm/memory.c:map_user_kiobuf
Message-ID: <Pine.LNX.4.33.0405111431560.3073-200000@godzilla.se.axis.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="218787593-1054744317-1084280260=:3073"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--218787593-1054744317-1084280260=:3073
Content-Type: TEXT/PLAIN; charset=US-ASCII

Hi,

get_user_pages can in some circumstances return less than a complete 
mapping, without giving an error code. This fools map_user_kiobuf which 
loops over the assumed number of pages in the mapping, calling 
flush_dcache_page on all of them, which is not very good if the maplist is 
not fully populated. It also fools drivers using map_user_kiobuf and which 
also assume that you get a complete mapping (or an error code). Actually, 
iobuf->nr_pages is reduced to reflect the incomplete mapping, but 
iobuf->length is not, so I don't really know what the desired behaviour is
in the kernel<->driver communication.

Anyway, the flush loop is incorrect, and it probably doesn't hurt to 
restrict map_user_kiobuf so it returns -ENOMEM if get_user_pages can't 
return the full amount of pages, to avoid surprises downstream. 

get_user_pages seem to behave in this way during severe memory-shortage, but 
also (and more importantly) when a page-limited tmpfs is used as a substrate 
for an mmap and map_user_kiobuf and the page/size limit is hit.

/Bjorn

--- linux-2.4.26/mm/memory.c    2003-11-28 19:26:21.000000000 +0100
+++ linux-2.4.26/mm/memory-2.c  2004-05-11 13:48:10.000000000 +0200
@@ -563,12 +563,19 @@
        err = get_user_pages(current, mm, va, pgcount,
                        (rw==READ), 0, iobuf->maplist, NULL);
        up_read(&mm->mmap_sem);
-       if (err < 0) {
+       /* get_user_pages returns the amount of mapped pages,
+        * which can be less than the amount of requested pages
+        * in some cases. To avoid surprises downstream, we
+        * unmap and return an error in those cases.  -bjornw
+        */
+       if(err > 0)
+               iobuf->nr_pages = err;
+       if (err < pgcount) {
+               /* unmap depends on nr_pages being set at this point */
                unmap_kiobuf(iobuf);
                dprintk ("map_user_kiobuf: end %d\n", err);
-               return err;
+               return err < 0 ? err : -ENOMEM;
        }
-       iobuf->nr_pages = err;
        while (pgcount--) {
                /* FIXME: flush superflous for rw==READ,
                 * probably wrong function for rw==WRITE

--218787593-1054744317-1084280260=:3073
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="memoryfix.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.33.0405111457400.3073@godzilla.se.axis.com>
Content-Description: 
Content-Disposition: attachment; filename="memoryfix.patch"

LS0tIGxpbnV4LTIuNC4yNi9tbS9tZW1vcnkuYwkyMDAzLTExLTI4IDE5OjI2
OjIxLjAwMDAwMDAwMCArMDEwMA0KKysrIGxpbnV4LTIuNC4yNi9tbS9tZW1v
cnktMi5jCTIwMDQtMDUtMTEgMTM6NDg6MTAuMDAwMDAwMDAwICswMjAwDQpA
QCAtNTYzLDEyICs1NjMsMTkgQEANCiAJZXJyID0gZ2V0X3VzZXJfcGFnZXMo
Y3VycmVudCwgbW0sIHZhLCBwZ2NvdW50LA0KIAkJCShydz09UkVBRCksIDAs
IGlvYnVmLT5tYXBsaXN0LCBOVUxMKTsNCiAJdXBfcmVhZCgmbW0tPm1tYXBf
c2VtKTsNCi0JaWYgKGVyciA8IDApIHsNCisJLyogZ2V0X3VzZXJfcGFnZXMg
cmV0dXJucyB0aGUgYW1vdW50IG9mIG1hcHBlZCBwYWdlcywNCisJICogd2hp
Y2ggY2FuIGJlIGxlc3MgdGhhbiB0aGUgYW1vdW50IG9mIHJlcXVlc3RlZCBw
YWdlcw0KKwkgKiBpbiBzb21lIGNhc2VzLiBUbyBhdm9pZCBzdXJwcmlzZXMg
ZG93bnN0cmVhbSwgd2UNCisJICogdW5tYXAgYW5kIHJldHVybiBhbiBlcnJv
ciBpbiB0aG9zZSBjYXNlcy4gIC1iam9ybncNCisJICovDQorCWlmKGVyciA+
IDApDQorCQlpb2J1Zi0+bnJfcGFnZXMgPSBlcnI7DQorCWlmIChlcnIgPCBw
Z2NvdW50KSB7DQorCQkvKiB1bm1hcCBkZXBlbmRzIG9uIG5yX3BhZ2VzIGJl
aW5nIHNldCBhdCB0aGlzIHBvaW50ICovDQogCQl1bm1hcF9raW9idWYoaW9i
dWYpOw0KIAkJZHByaW50ayAoIm1hcF91c2VyX2tpb2J1ZjogZW5kICVkXG4i
LCBlcnIpOw0KLQkJcmV0dXJuIGVycjsNCisJCXJldHVybiBlcnIgPCAwID8g
ZXJyIDogLUVOT01FTTsNCiAJfQ0KLQlpb2J1Zi0+bnJfcGFnZXMgPSBlcnI7
DQogCXdoaWxlIChwZ2NvdW50LS0pIHsNCiAJCS8qIEZJWE1FOiBmbHVzaCBz
dXBlcmZsb3VzIGZvciBydz09UkVBRCwNCiAJCSAqIHByb2JhYmx5IHdyb25n
IGZ1bmN0aW9uIGZvciBydz09V1JJVEUNCg==
--218787593-1054744317-1084280260=:3073--
