Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311948AbSDIW3b>; Tue, 9 Apr 2002 18:29:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312031AbSDIW3a>; Tue, 9 Apr 2002 18:29:30 -0400
Received: from winds.org ([209.115.81.9]:21522 "EHLO winds.org")
	by vger.kernel.org with ESMTP id <S311948AbSDIW32>;
	Tue, 9 Apr 2002 18:29:28 -0400
Date: Tue, 9 Apr 2002 18:24:14 -0400 (EDT)
From: Byron Stanoszek <gandalf@winds.org>
To: linux-kernel@vger.kernel.org
Subject: Using video memory as system memory
Message-ID: <Pine.LNX.4.44.0204091816380.13516-100000@winds.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have an old 586 that has low memory and no ability for further upgrades.
I had an idea to use the framebuffer memory of a 32MB video card lying around
the office as system memory and implemented the following patch:

--- linux/arch/i386/kernel/setup.bak	Tue Apr  9 02:52:19 2002
+++ linux/arch/i386/kernel/setup.c	Tue Apr  9 03:04:38 2002
@@ -722,6 +722,8 @@
 		 * to <mem>, overriding the bios size.
 		 * "mem=XXX[KkmM]@XXX[KkmM]" defines a memory region from
 		 * <start> to <start>+<mem>, overriding the bios size.
+		 * "mem=+start-end" appends a new memory region from <start>
+		 * to <end>. Values can be prepended with '0x'.
 		 */
 		if (c == ' ' && !memcmp(from, "mem=", 4)) {
 			if (to != command_line)
@@ -733,6 +735,14 @@
 				from += 8+4;
 				e820.nr_map = 0;
 				usermem = 1;
+			} else if(*(from+4) == '+') {
+				unsigned long long start, end;
+
+				start = simple_strtoull(from+5, &from, 0);
+				if(*from == '-') {
+					end = simple_strtoull(from+1, &from, 0);
+					add_memory_region(start, end-start, E820_RAM);
+				}
 			} else {
 				/* If the user specifies memory size, we
 				 * blow away any automatically generated

Size text uses the first 256KB of video ram, and the framebuffer address
started at 0xfc000000, I tried the following option to effectively double
system RAM:

 mem=+0xfa040000-0xfc000000 

The first time I booted, the kernel said I should compile in HIGHMEM support
and everything booted with the normal memory maps. When compiling with HIGHMEM,
the computer stopped after displaying 'Uncompressing the kernel...done',
probably in a loop dealing with the memory table, since it stopped before
printing out the table.

Does the kernel support noncontiguous main memory like this, or is it just
plain impossible to use PCI-mapped memory as main memory?

Thanks,
 -Byron

-- 
Byron Stanoszek                         Ph: (330) 644-3059
Systems Programmer                      Fax: (330) 644-8110
Commercial Timesharing Inc.             Email: byron@comtime.com


