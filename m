Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311533AbSCTEEi>; Tue, 19 Mar 2002 23:04:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311520AbSCTEDD>; Tue, 19 Mar 2002 23:03:03 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:45839 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S311504AbSCTECR>; Tue, 19 Mar 2002 23:02:17 -0500
Message-ID: <3C980970.A542A4D@zip.com.au>
Date: Tue, 19 Mar 2002 20:00:48 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: aa-150-read_write_tweaks
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



- Don't do flush_page_to_ram() on the page fault-in path.  That's
  handled in mm/memory.c, and filemap.c doesn't need to do it.

- In generic_file_write(), only set the page's Referenced bit once,
  when the write touches the start of the page.  This is a
  microoptimisation.  Seemingly a buggy one too - lseek exists...


=====================================

--- 2.4.19-pre3/mm/filemap.c~aa-150-read_write_tweaks	Tue Mar 19 19:49:02 2002
+++ 2.4.19-pre3-akpm/mm/filemap.c	Tue Mar 19 19:49:02 2002
@@ -1968,7 +1968,6 @@ success:
 	 * and possibly copy it over to another page..
 	 */
 	mark_page_accessed(page);
-	flush_page_to_ram(page);
 	return page;
 
 no_cached_page:
@@ -3089,8 +3088,15 @@ generic_file_write(struct file *file,con
 		}
 unlock:
 		kunmap(page);
+
+		/*
+		 * Mark the page accessed if we wrote the
+		 * beginning or we just did an lseek.
+		 */
+		if (!offset || !file->f_reada)
+			SetPageReferenced(page);
+
 		/* Mark it unlocked again and drop the page.. */
-		SetPageReferenced(page);
 		UnlockPage(page);
 		page_cache_release(page);
 


-
