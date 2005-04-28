Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262032AbVD1LBD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262032AbVD1LBD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 07:01:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262012AbVD1LBD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 07:01:03 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:17881 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S262032AbVD1LAa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 07:00:30 -0400
Message-ID: <4270C256.2080905@in.ibm.com>
Date: Thu, 28 Apr 2005 16:30:38 +0530
From: Hariprasad Nellitheertha <hari@in.ibm.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][i386] Comma parsing for the memmap= kernel command line
 option
References: <425F5BA3.3050001@in.ibm.com> <20050415173040.GK50241@muc.de> <4270C213.80408@in.ibm.com>
In-Reply-To: <4270C213.80408@in.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------060302030807070208070606"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060302030807070208070606
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Regards, Hari

--------------060302030807070208070606
Content-Type: text/plain;
 name="i386-memmap-comma-parsing.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="i386-memmap-comma-parsing.patch"


This patch adds comma parsing ability to the i386
memmap= kernel command line option. With this, multiple
entries to memmap can be separated by a comma instead of
separate entries.

For example, memmap=exactmap,640k@0M,1024M@1M

Signed-off-by: Hariprasad Nellitheertha <hari@in.ibm.com>
---

 linux-2.6.12-rc2-hari/arch/i386/kernel/setup.c |   79 +++++++++++++------------
 1 files changed, 43 insertions(+), 36 deletions(-)

diff -puN arch/i386/kernel/setup.c~i386-memmap-comma-parsing arch/i386/kernel/setup.c
--- linux-2.6.12-rc2/arch/i386/kernel/setup.c~i386-memmap-comma-parsing	2005-04-27 16:30:05.000000000 +0530
+++ linux-2.6.12-rc2-hari/arch/i386/kernel/setup.c	2005-04-28 15:04:42.000000000 +0530
@@ -716,45 +716,52 @@ static void __init parse_cmdline_early (
 		}
 
 		else if (!memcmp(from, "memmap=", 7)) {
-			if (to != command_line)
-				to--;
-			if (!memcmp(from+7, "exactmap", 8)) {
+			from += 7;
+			do {
+				if (to != command_line)
+					to--;
+				if (!memcmp(from, "exactmap", 8)) {
 #ifdef CONFIG_CRASH_DUMP
-				/* If we are doing a crash dump, we
-				 * still need to know the real mem
-				 * size before original memory map is
-				 * reset.
-				 */
-				find_max_pfn();
-				saved_max_pfn = max_pfn;
-#endif
-				from += 8+7;
-				e820.nr_map = 0;
-				userdef = 1;
-			} else {
-				/* If the user specifies memory size, we
-				 * limit the BIOS-provided memory map to
-				 * that size. exactmap can be used to specify
-				 * the exact map. mem=number can be used to
-				 * trim the existing memory map.
-				 */
-				unsigned long long start_at, mem_size;
- 
-				mem_size = memparse(from+7, &from);
-				if (*from == '@') {
-					start_at = memparse(from+1, &from);
-					add_memory_region(start_at, mem_size, E820_RAM);
-				} else if (*from == '#') {
-					start_at = memparse(from+1, &from);
-					add_memory_region(start_at, mem_size, E820_ACPI);
-				} else if (*from == '$') {
-					start_at = memparse(from+1, &from);
-					add_memory_region(start_at, mem_size, E820_RESERVED);
+					/* If we are doing a crash dump, we
+					 * still need to know the real mem
+					 * size before original memory map is
+					 * reset.
+					 */
+					find_max_pfn();
+					saved_max_pfn = max_pfn;
+#endif
+					from += 8;
+					e820.nr_map = 0;
+					userdef = 1;
 				} else {
-					limit_regions(mem_size);
-					userdef=1;
+					/* If the user specifies memory size, we
+					 * limit the BIOS-provided memory map to
+					 * that size. exactmap can be used to specify
+					 * the exact map. mem=number can be used to
+					 * trim the existing memory map.
+					 */
+					unsigned long long start_at, mem_size;
+
+					mem_size = memparse(from, &from);
+					if (*from == '@') {
+						start_at = memparse(from+1, &from);
+						add_memory_region(start_at, mem_size, E820_RAM);
+					} else if (*from == '#') {
+						start_at = memparse(from+1, &from);
+						add_memory_region(start_at, mem_size, E820_ACPI);
+					} else if (*from == '$') {
+						start_at = memparse(from+1, &from);
+						add_memory_region(start_at, mem_size, E820_RESERVED);
+					} else {
+						limit_regions(mem_size);
+						userdef=1;
+					}
 				}
-			}
+				if (*from != ',')
+					break;
+				else
+					from += 1;
+			} while(1);
 		}
 
 		else if (!memcmp(from, "noexec=", 7))
_

--------------060302030807070208070606--
