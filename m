Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262578AbVBYAqY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262578AbVBYAqY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 19:46:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262602AbVBYApI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 19:45:08 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:24829 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S262558AbVBYAk4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 19:40:56 -0500
Message-ID: <421E74B5.3040701@us.ibm.com>
Date: Thu, 24 Feb 2005 16:43:33 -0800
From: Darren Hart <dvhltc@us.ibm.com>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "lkml, " <linux-kernel@vger.kernel.org>
Subject: [PATCH] vm: mlock superfluous variable
Content-Type: multipart/mixed;
 boundary="------------020902010901010301050703"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020902010901010301050703
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

The were a couple long standing (since at least 2.4.21) superfluous 
variables and two unnecessary assignments in do_mlock().  The intent of 
the resulting code is also more obvious.

Tested on a 4 way x86 box running a simple mlock test program.  No 
problems detected.

Signed-off-by: Darren Hart <dvhltc@us.ibm.com>n

--------------020902010901010301050703
Content-Type: text/plain;
 name="mlock"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mlock"

diff -purN -X /home/dvhart/.diff.exclude /home/linux/views/linux-2.6.11-rc5/mm/mlock.c 2.6.11-rc5-mlock/mm/mlock.c
--- /home/linux/views/linux-2.6.11-rc5/mm/mlock.c	2004-12-24 15:26:12.000000000 -0800
+++ 2.6.11-rc5-mlock/mm/mlock.c	2005-02-24 13:57:38.000000000 -0800
@@ -58,8 +58,8 @@ out:
 
 static int do_mlock(unsigned long start, size_t len, int on)
 {
-	unsigned long nstart, end, tmp;
-	struct vm_area_struct * vma, * next;
+	unsigned long nstart, end;
+	struct vm_area_struct * vma;
 	int error;
 
 	len = PAGE_ALIGN(len);
@@ -86,13 +86,11 @@ static int do_mlock(unsigned long start,
 			break;
 		}
 
-		tmp = vma->vm_end;
-		next = vma->vm_next;
-		error = mlock_fixup(vma, nstart, tmp, newflags);
+		error = mlock_fixup(vma, nstart, vma->vm_end, newflags);
 		if (error)
 			break;
-		nstart = tmp;
-		vma = next;
+		nstart = vma->vm_end;
+		vma = vma->vm_next;
 		if (!vma || vma->vm_start != nstart) {
 			error = -ENOMEM;
 			break;

--------------020902010901010301050703--
