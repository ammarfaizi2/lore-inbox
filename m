Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317592AbSHTXpI>; Tue, 20 Aug 2002 19:45:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317597AbSHTXpI>; Tue, 20 Aug 2002 19:45:08 -0400
Received: from fyserv1.fy.chalmers.se ([129.16.110.66]:50396 "EHLO
	fyserv1.fy.chalmers.se") by vger.kernel.org with ESMTP
	id <S317592AbSHTXoi>; Tue, 20 Aug 2002 19:44:38 -0400
Message-ID: <3D62D578.F2DA59B1@fy.chalmers.se>
Date: Wed, 21 Aug 2002 01:49:12 +0200
From: Andy Polyakov <appro@fy.chalmers.se>
X-Mailer: Mozilla 4.79 [en] (Windows NT 5.0; U)
X-Accept-Language: en,sv,ru
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: data corruption in 2.4.19/drivers/scsi/sg.c
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

As subject suggests generic scsi module from 2.4.19 corrupts data.
Backing back to 2.4.18 code [as suggested below] fixes the problem.
>From the attached patch it's not clear what's causing the problem
as the code appears equivalent. Corruption occurs if you break out
the inner loop few lines later:

		if (ksglen > usglen) {
		    ...
		    p += usglen;
		    ksglen -= usglen;
		    break;
		}

and reenter it. Then ksglen and p are reset which results in some
duplicate data injection.

Cheers. Andy.

--- ./drivers/scsi/sg.c.orig	Sat Aug  3 02:39:44 2002
+++ ./drivers/scsi/sg.c	Wed Aug 21 00:44:16 2002
@@ -1884,11 +1884,16 @@
 	    res = sg_u_iovec(hp, iovec_count, j, 1, &usglen, &up);
 	    if (res) return res;
 
+#if 0
 	    for (; k < schp->k_use_sg; ++k, ++sclp) {
 		ksglen = (int)sclp->length;
 		p = sclp->address;
 		if (NULL == p)
 		    break;
+#else
+	    for (; (k < schp->k_use_sg) && p;
+		++k, ++sclp, ksglen = (int)sclp->length, p = sclp->address) {
+#endif
 		ok = (SG_USER_MEM != mem_src_arr[k]);
 		if (usglen <= 0)
 		    break;
@@ -2040,11 +2045,16 @@
 	    res = sg_u_iovec(hp, iovec_count, j, 0, &usglen, &up);
 	    if (res) return res;
 
+#if 0
 	    for (; k < schp->k_use_sg; ++k, ++sclp) {
 		ksglen = (int)sclp->length;
 		p = sclp->address;
 		if (NULL == p)
 		    break;
+#else
+	    for (; (k < schp->k_use_sg) && p;
+		++k, ++sclp, ksglen = (int)sclp->length, p = sclp->address) {
+#endif
 		ok = (SG_USER_MEM != mem_src_arr[k]);
 		if (usglen <= 0)
 		    break;
