Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263607AbTEMWtW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 18:49:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263592AbTEMWs5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 18:48:57 -0400
Received: from pixpat.austin.ibm.com ([192.35.232.241]:56767 "EHLO
	baldur.austin.ibm.com") by vger.kernel.org with ESMTP
	id S263589AbTEMWr4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 18:47:56 -0400
Date: Tue, 13 May 2003 18:00:08 -0500
From: Dave McCracken <dmccr@us.ibm.com>
To: William Lee Irwin III <wli@holomorphy.com>
cc: "Mika Penttil?" <mika.penttila@kolumbus.fi>,
       Linux Memory Management <linux-mm@kvack.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Race between vmtruncate and mapped areas?
Message-ID: <220550000.1052866808@baldur.austin.ibm.com>
In-Reply-To: <20030513224929.GX8978@holomorphy.com>
References: <154080000.1052858685@baldur.austin.ibm.com>
 <3EC15C6D.1040403@kolumbus.fi> <199610000.1052864784@baldur.austin.ibm.com>
 <20030513224929.GX8978@holomorphy.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="==========2024839384=========="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==========2024839384==========
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--On Tuesday, May 13, 2003 15:49:29 -0700 William Lee Irwin III
<wli@holomorphy.com> wrote:

> That doesn't sound like it's going to help, there isn't a unique
> mmap_sem to be taken and so we just get caught between acquisitions
> with the same problem.

Actually it does fix it.  I added code in vmtruncate_list() to do a
down_write(&vma->vm_mm->mmap_sem) around the zap_page_range(), and the
problem went away.  It serializes against any outstanding page faults on a
particular page table.  New faults will see that the page is no longer in
the file and fail with SIGBUS.  Andrew's test case stopped failing.

I've attached the patch so you can see what I did.

Can anyone think of any gotchas to this solution?

Dave McCracken

======================================================================
Dave McCracken          IBM Linux Base Kernel Team      1-512-838-3059
dmccr@us.ibm.com                                        T/L   678-3059

--==========2024839384==========
Content-Type: text/plain; charset=us-ascii; name="vmtrunc-2.5.69-mm3-1.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="vmtrunc-2.5.69-mm3-1.diff";
 size=982

--- 2.5.69-mm3/mm/memory.c	2003-05-13 10:34:56.000000000 -0500
+++ 2.5.69-mm3-test/mm/memory.c	2003-05-13 17:39:45.000000000 -0500
@@ -1085,21 +1085,21 @@ static void vmtruncate_list(struct list_
 		len = end - start;
 
 		/* mapping wholly truncated? */
-		if (vma->vm_pgoff >= pgoff) {
-			zap_page_range(vma, start, len);
-			continue;
-		}
+		if (vma->vm_pgoff < pgoff) {
 
-		/* mapping wholly unaffected? */
-		len = len >> PAGE_SHIFT;
-		diff = pgoff - vma->vm_pgoff;
-		if (diff >= len)
-			continue;
-
-		/* Ok, partially affected.. */
-		start += diff << PAGE_SHIFT;
-		len = (len - diff) << PAGE_SHIFT;
+			/* mapping wholly unaffected? */
+			len = len >> PAGE_SHIFT;
+			diff = pgoff - vma->vm_pgoff;
+			if (diff >= len)
+				continue;
+
+			/* Ok, partially affected.. */
+			start += diff << PAGE_SHIFT;
+			len = (len - diff) << PAGE_SHIFT;
+		}
+		down_write(&vma->vm_mm->mmap_sem);
 		zap_page_range(vma, start, len);
+		up_write(&vma->vm_mm->mmap_sem);
 	}
 }
 

--==========2024839384==========--

