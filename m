Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270640AbUJUKxR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270640AbUJUKxR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 06:53:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270671AbUJUKvv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 06:51:51 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:28399 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S270590AbUJUKt0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 06:49:26 -0400
Message-ID: <41779431.5090104@in.ibm.com>
Date: Thu, 21 Oct 2004 16:19:21 +0530
From: Hariprasad Nellitheertha <hari@in.ibm.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Vara Prasad <varap@us.ibm.com>
Subject: Re: [PATCH][2/4] kexec: Enable co-existence of normal kexec Image
 and kexec on panic Image
References: <417792BA.8090205@in.ibm.com> <41779345.8080009@in.ibm.com>
In-Reply-To: <41779345.8080009@in.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------030303050606080100090102"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030303050606080100090102
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch, to kexec, makes it possible to separate out the 
two uses of kexec - for normal kexec usage and 
kexec-on-panic. The image for the panic case is loaded using 
the "kexec -p" option instead of "kexec -l".

Regards, Hari

--------------030303050606080100090102
Content-Type: text/plain;
 name="kexec-panic.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kexec-panic.patch"


Signed-off-by: Hariprasad Nellitheertha <hari@in.ibm.com>
---

 linux-kexec-hari/include/linux/kexec.h |    1 +
 linux-kexec-hari/kernel/kexec.c        |   13 +++++--------
 2 files changed, 6 insertions(+), 8 deletions(-)

diff -puN include/linux/kexec.h~kexec-panic include/linux/kexec.h
--- linux-kexec/include/linux/kexec.h~kexec-panic	2004-10-18 14:59:01.000000000 +0530
+++ linux-kexec-hari/include/linux/kexec.h	2004-10-18 15:00:33.000000000 +0530
@@ -52,5 +52,6 @@ extern asmlinkage long sys_kexec(unsigne
 	struct kexec_segment *segments);
 extern struct page *kimage_alloc_control_pages(struct kimage *image, unsigned int order);
 extern struct kimage *kexec_image;
+extern struct kimage *kexec_crash_image;
 #endif
 #endif /* LINUX_KEXEC_H */
diff -puN kernel/kexec.c~kexec-panic kernel/kexec.c
--- linux-kexec/kernel/kexec.c~kexec-panic	2004-10-18 14:59:01.000000000 +0530
+++ linux-kexec-hari/kernel/kexec.c	2004-10-19 14:12:33.000000000 +0530
@@ -585,6 +585,7 @@ static int kimage_load_segment(struct ki
  * that to happen you need to do that yourself.
  */
 struct kimage *kexec_image = NULL;
+struct kimage *kexec_crash_image = NULL;
 
 asmlinkage long sys_kexec_load(unsigned long entry, unsigned long nr_segments,
 	struct kexec_segment *segments, unsigned long flags)
@@ -596,13 +597,6 @@ asmlinkage long sys_kexec_load(unsigned 
 	if (!capable(CAP_SYS_BOOT))
 		return -EPERM;
 
-	/*
-	 * In case we need just a little bit of special behavior for
-	 * reboot on panic.
-	 */
-	if (flags != 0)
-		return -EINVAL;
-
 	if (nr_segments > KEXEC_SEGMENT_MAX)
 		return -EINVAL;
 
@@ -632,7 +626,10 @@ asmlinkage long sys_kexec_load(unsigned 
 		}
 	}
 
-	image = xchg(&kexec_image, image);
+	if (!flags)
+		image = xchg(&kexec_image, image);
+	else
+		image = xchg(&kexec_crash_image, image);
 
  out:
 	kimage_free(image);
_

--------------030303050606080100090102--
