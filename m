Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129231AbQLFRuc>; Wed, 6 Dec 2000 12:50:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129408AbQLFRuW>; Wed, 6 Dec 2000 12:50:22 -0500
Received: from lowell.missioncriticallinux.com ([208.51.139.16]:61303 "EHLO
	dai.lowell.mclinux.com") by vger.kernel.org with ESMTP
	id <S129231AbQLFRuN>; Wed, 6 Dec 2000 12:50:13 -0500
Message-ID: <3A2E7756.979988E8@mclinux.com>
Date: Wed, 06 Dec 2000 12:28:54 -0500
From: Peng Dai <dai@mclinux.com>
X-Mailer: Mozilla 4.61 [en] (X11; U; Linux 2.2.16-22SAPenterprise i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Larry Woodman <woodman@missioncriticallinux.com>,
        David Winchell <winchell@mclinux.com>
Subject: Fixing random corruption in raw IO on 2.2.x kernel with bigmem enabled
Content-Type: multipart/mixed;
 boundary="------------C2F997F2542282663BF4E687"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------C2F997F2542282663BF4E687
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi,

This patch fixes a subtle corruption when doing raw IO on the 2.2.x
kernel
with bigmem enabled. The problem was first reported by Markus Döhr while

running SAP DB on a variation of the 2.2.16 kernel with among others the

following patches installed,

> linux-2.2.16-rawio.patch
> linux-2.2.16-raw-fixup.patch
> linux-2.2.16-raw-fixup2.patch
> linux-2.2.16-bigmem.patch
> linux-2.2.16-bigmem-raw.patch
> linux-2.2.16-bigmem-dcache.patch
> linux-2.2.16-bigmem-initrd.patch

See http://marc.theaimsgroup.com/?l=linux-kernel&m=97038067229365&w=2
for the original description.

The corruption is caused by a bug in kiobuf_copy_bounce in fs/iobuf.c -
the
bigmem page containing the user data is not always copied to its
associated
bounce buffer. This would occur when an array of pages (>1) are passed
to
kiobuf_copy_bounce and a normal page happens to appear before a bigmem
page in the array, which in turn leads to the writing of uninitialized
(garbage)
pages to the raw device.

The corruption happens rather infrequently. It has been reproduced both
with
the SAP DB and without. It appears that intense paging activity
increases its
chance of occurrence.

Regards,

Peng Dai
Kernel Engineering                                          Tel:
978-446-9166 ext. 276
Mission Critical Linux Inc.                              Fax:
978-446-9470
100 Foot of John                                               Email:
dai@missioncriticallinux.com
Lowell, MA 01852


--------------C2F997F2542282663BF4E687
Content-Type: text/plain; charset=us-ascii;
 name="iobuf.c.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="iobuf.c.patch"

--- linux/fs/iobuf.c.orig	Tue Nov 28 13:54:26 2000
+++ linux/fs/iobuf.c	Tue Nov 28 13:55:17 2000
@@ -213,10 +213,10 @@
 		unsigned long kin, kout;
 		int pagelen = length;
 		
-		if (bounce_page) {
-			if ((pagelen+offset) > PAGE_SIZE)
-				pagelen = PAGE_SIZE - offset;
-		
+		if ((pagelen+offset) > PAGE_SIZE)
+			pagelen = PAGE_SIZE - offset;
+
+		if (bounce_page) {		
 			if (direction == COPY_TO_BOUNCE) {
 				kin  = kmap(page, KM_READ);
 				kout = kmap(bounce_page, KM_WRITE);

--------------C2F997F2542282663BF4E687--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
