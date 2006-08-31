Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751261AbWHaIJc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751261AbWHaIJc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 04:09:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751275AbWHaIJb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 04:09:31 -0400
Received: from nz-out-0102.google.com ([64.233.162.203]:19933 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751261AbWHaIJb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 04:09:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=LrpJ0ADsqxORoA2NLUKjliWtBR6aSQWbFOlZHrZvLyMevYQ6aB7lNSm15JwiY4XY0qa+9L2VwgjC0KWUWqZ6B+FcLG3a7lpm/ou7iyk5bXduJUqtCsfXIyR0p2slyLIzjofc50mlf3mB6Vf7s75blwrlg0sGAFXPmyaNBDTJudQ=
Message-ID: <4e5ebad50608310109l489f39c0te466cfc3dbe3dc13@mail.gmail.com>
Date: Thu, 31 Aug 2006 16:09:30 +0800
From: "Sonic Zhang" <sonic.adi@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Check if start address is in vma region in NOMMU function get_user_pages().
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

In NOMMU arch, if run "cat /proc/self/mem", data from physical address
0 are read. This behavior is different from MMU arch.  In IA32,
message "cat: /proc/self/mem: Input/output error" is reported.

This issue is rootcaused by not validate the start address in NOMMU
function get_user_pages(). Following patch solves this issue.

Thanks

Sonic Zhang


Signed-off-by: Sonic Zhang <sonic.adi@gmail.com>

--- linux-2.6.x/mm/nommu.c	2006-08-31 15:53:09.269952304 +0800
+++ linux-2.6.x/mm/nommu.c	2006-08-31 15:49:58.634933232 +0800
@@ -138,16 +138,20 @@
 	struct page **pages, struct vm_area_struct **vmas)
 {
 	int i;
-	static struct vm_area_struct dummy_vma;
+	struct vm_area_struct *vma;

 	for (i = 0; i < len; i++) {
+		vma = find_vma(mm, start);
+		if(!vma)
+			return i ? : -EFAULT;
+		
 		if (pages) {
 			pages[i] = virt_to_page(start);
 			if (pages[i])
 				page_cache_get(pages[i]);
 		}
 		if (vmas)
-			vmas[i] = &dummy_vma;
+			vmas[i] = vma;
 		start += PAGE_SIZE;
 	}
 	return(i);
