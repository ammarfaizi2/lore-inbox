Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261788AbTEVMWk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 08:22:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261801AbTEVMWk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 08:22:40 -0400
Received: from [62.112.80.35] ([62.112.80.35]:58050 "EHLO ipc1.karo")
	by vger.kernel.org with ESMTP id S261788AbTEVMWh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 08:22:37 -0400
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="wN58/edQMs"
Content-Transfer-Encoding: 7bit
Message-ID: <16076.50160.67366.435042@ipc1.karo>
Date: Thu, 22 May 2003 14:34:56 +0200
From: LW@KARO-electronics.de
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@transmeta.com>,
       <linux-arm-kernel@lists.arm.linux.org.uk>
Subject: [patch] cache flush bug in mm/filemap.c (all kernels >= 2.5.30(at least))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--wN58/edQMs
Content-Type: text/plain; charset=us-ascii
Content-Description: message body text
Content-Transfer-Encoding: 7bit

Hi,

in file 'mm/filemap.c' a call to 'flush_dcache_page' is missing as a
replacement for the obsoleted 'flush_page_to_ram' call that was
present there in older kernels.

This missing macro call produces data errors when randomly reading an
'mmap'ed file (e.g. leading to segfaults, when a program is executed).

In kernels < 2.5.46 the deprecated macro call was still present
(defined to do nothing), while in later kernels the call has been
removed.

Below are two patches generated against kernel versions 2.5.30 and
2.5.68 which should also be applicable to other kernels (with a hunk
offset).


Lothar Wassmann

--wN58/edQMs
Content-Type: text/plain
Content-Description: patch for kernel 2.5.30
Content-Disposition: inline;
	filename="filemap.patch_2.5.30"
Content-Transfer-Encoding: 7bit

--- linux-2.5.30/mm/filemap.c	2002-08-14 19:04:09.000000000 +0200
+++ work-2.5.30_config/mm/filemap.c	2003-05-22 12:50:14.000000000 +0200
@@ -1260,7 +1260,7 @@
 	 * and possibly copy it over to another page..
 	 */
 	mark_page_accessed(page);
-	flush_page_to_ram(page);
+	flush_dcache_page(page);
 	return page;
 
 no_cached_page:

--wN58/edQMs
Content-Type: text/plain
Content-Description: patch for kernels >= 2.5.46
Content-Disposition: inline;
	filename="filemap.patch_2.5.68"
Content-Transfer-Encoding: 7bit

--- linux-2.5.68/mm/filemap.c	2003-04-29 11:39:40.000000000 +0200
+++ work-2.5.68/mm/filemap.c	2003-05-22 12:22:31.000000000 +0200
@@ -1011,6 +1011,7 @@
 	 * Found the page and have a reference on it.
 	 */
 	mark_page_accessed(page);
+	//flush_dcache_page(page);
 	return page;
 
 no_cached_page:

--wN58/edQMs
Content-Type: text/plain
Content-Description: Readme
Content-Disposition: inline;
	filename="Readme"
Content-Transfer-Encoding: 7bit

In older kernels (< 2.5.46) used to be a call to 'flush_page_to_ram'
in the function 'filemap_nopage()' in 'mm/filemap.c'. This macro has
been obsoleted and has been replaced in other places by appropriate
'flush_dcache_page', 'flush_icache_page', 'copy_user_page', or
'clear_user_page' calls.

But in 'mm/filemap.c' it has been removed without replacement.
In fact a call to 'flush_dcache_page' should be in place there.

This missing macro call produces data errors when randomly reading an
'mmap'ed file (like it happens, when a program is executed).

I stumbled over this bug when I tried to execute a program from a
freshly mounted IDE CF card. The first call would segfault while
subsequent calls worked. This behaviour recurred when the disk was
unmounted between calls.

It also helped to copy the file (to /dev/null) before executing it
(from CF disk).
Digging into the problem I wrote a simple program that created a large
file (e.g. 1 MiB size), umounted and remounted the disk where it had
been created to flush all buffers and subsequently 'mmap'ed the file
and checked the contents from the file end to the start.
Upon error the program simply read the same word over and over again
until the correct data appeared after some time.


In kernels < 2.5.46 the deprecated macro call was still present in
filemap.c (though the macro was defined to do nothing), while in later
kernel versions that call was removed.

The accompanied patches are generated against kernel versions 2.5.30
and 2.5.68 but should also be applicable to other kernels (with a hunk
offset).

--wN58/edQMs--
