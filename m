Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262090AbTELM0j (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 08:26:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262098AbTELM0j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 08:26:39 -0400
Received: from sccrmhc01.attbi.com ([204.127.202.61]:8914 "EHLO
	sccrmhc01.attbi.com") by vger.kernel.org with ESMTP id S262090AbTELM0h
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 08:26:37 -0400
Message-ID: <3EBF95F3.1090507@quark.didntduck.org>
Date: Mon, 12 May 2003 08:39:15 -0400
From: Brian Gerst <bgerst@quark.didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030313
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>, dave_matthew@yahoo.com
Subject: Re: [Bug 703] New: Security vulnerability in "ioperm" system call
References: <17400000.1052708613@[10.10.2.4]>
In-Reply-To: <17400000.1052708613@[10.10.2.4]>
Content-Type: multipart/mixed;
 boundary="------------040308020002050906070100"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040308020002050906070100
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Martin J. Bligh wrote:
> http://bugme.osdl.org/show_bug.cgi?id=703
> 
>            Summary: Security vulnerability in "ioperm" system call
>     Kernel Version: 2.5.69
>             Status: NEW
>           Severity: low
>              Owner: mbligh@aracnet.com
>          Submitter: dave_matthew@yahoo.com
> 
> 
> Problem Description:
> The "ioperm" system call allows an unprivileged user to gain read and write
> access to I/O ports on the system.  When used by a privileged process, the
> "ioperm" system call also fails to properly restrict privileges.

This patch makes sure that the ioperm bitmap in the TSS is correctly set 
up during the first ioperm() call.  Without this the TSS bitmap contains 
random garbage until the next context switch.

--
				Brian Gerst

--------------040308020002050906070100
Content-Type: text/plain;
 name="iobitmap-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="iobitmap-1"

diff -urN linux-2.5.64-bk5/arch/i386/kernel/ioport.c linux/arch/i386/kernel/ioport.c
--- linux-2.5.64-bk5/arch/i386/kernel/ioport.c	2003-02-24 14:59:03.000000000 -0500
+++ linux/arch/i386/kernel/ioport.c	2003-03-14 10:19:48.000000000 -0500
@@ -84,15 +84,17 @@
 		t->ts_io_bitmap = bitmap;
 	}
 
-	tss = init_tss + get_cpu();
-	if (bitmap)
-		tss->bitmap = IO_BITMAP_OFFSET;	/* Activate it in the TSS */
-
 	/*
 	 * do it in the per-thread copy and in the TSS ...
 	 */
 	set_bitmap(t->ts_io_bitmap, from, num, !turn_on);
-	set_bitmap(tss->io_bitmap, from, num, !turn_on);
+	tss = init_tss + get_cpu();
+	if (tss->bitmap == IO_BITMAP_OFFSET) { /* already active? */
+		set_bitmap(tss->io_bitmap, from, num, !turn_on);
+	} else {
+		memcpy(tss->io_bitmap, t->ts_io_bitmap, IO_BITMAP_BYTES);
+		tss->bitmap = IO_BITMAP_OFFSET;	/* Activate it in the TSS */
+	}
 	put_cpu();
 out:
 	return ret;

--------------040308020002050906070100--

