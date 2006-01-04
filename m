Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965198AbWADFeM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965198AbWADFeM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 00:34:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965201AbWADFeM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 00:34:12 -0500
Received: from terminus.zytor.com ([192.83.249.54]:8341 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S965198AbWADFeM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 00:34:12 -0500
Message-ID: <43BB5E22.2010306@zytor.com>
Date: Tue, 03 Jan 2006 21:33:22 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@zytor.com>
CC: Linus Torvalds <torvalds@osdl.org>, Ulrich Drepper <drepper@redhat.com>,
       Andi Kleen <ak@suse.de>, "Viro, Al" <viro@ftp.linux.org.uk>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Limit sendfile() to 2^31-PAGE_CACHE_SIZE bytes without error
References: <43BB348F.3070108@zytor.com> <200601040451.20411.ak@suse.de> <Pine.LNX.4.64.0601032051300.3668@g5.osdl.org> <43BB5646.2040504@zytor.com>
In-Reply-To: <43BB5646.2040504@zytor.com>
Content-Type: multipart/mixed;
 boundary="------------080506090603020102080301"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080506090603020102080301
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

sendfile() has a limit of 2^31-1 bytes even on 64-bit platforms.  Linus 
wants to maintain it in order to avoid potential future security bugs 
(always a good thing.)

This patch changes the behaviour from returning EINVAL when this limit 
is exceeded to returning a short count.  This means that a 
properly-written userspace program will simply loop around and continue; 
  it will expose bugs in improperly-written userspace programs, which is 
also a good thing.  Additionally, the limit becomes an issue that is 
completely contained within the kernel, and not encoded in the kernel 
ABI, so it can be changed in the future.

(I set the limit to 2^31-PAGE_CACHE_SIZE so that a transfer that starts 
at the beginning of the file will continue to be page-aligned.)

The

Signed-off-by: H. Peter Anvin <hpa@zytor.com>

--------------080506090603020102080301
Content-Type: text/x-patch;
 name="sendfile.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sendfile.patch"

diff --git a/fs/read_write.c b/fs/read_write.c
index a091ee4..3712886 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -9,6 +9,7 @@
 #include <linux/fcntl.h>
 #include <linux/file.h>
 #include <linux/uio.h>
+#include <linux/pagemap.h>
 #include <linux/smp_lock.h>
 #include <linux/fsnotify.h>
 #include <linux/security.h>
@@ -631,6 +632,9 @@ static ssize_t do_sendfile(int out_fd, i
 	ssize_t retval;
 	int fput_needed_in, fput_needed_out;
 
+	/* Avoid potential security holes.  User space will get a short count and should loop. */
+	count = min(count, (size_t)0x80000000-PAGE_CACHE_SIZE);
+
 	/*
 	 * Get input file, and verify that it is ok..
 	 */

--------------080506090603020102080301--
