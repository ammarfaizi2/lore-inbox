Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265246AbSLHI6Y>; Sun, 8 Dec 2002 03:58:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265247AbSLHI6Y>; Sun, 8 Dec 2002 03:58:24 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:2435
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S265246AbSLHI6W>; Sun, 8 Dec 2002 03:58:22 -0500
Date: Sun, 8 Dec 2002 04:09:01 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: rtilley <rtilley@vt.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: lilo append mem problem in 2.4.20
In-Reply-To: <3DFDE59F@zathras>
Message-ID: <Pine.LNX.4.50.0212080359340.2139-100000@montezuma.mastecende.com>
References: <3DFDE59F@zathras>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 7 Dec 2002, rtilley wrote:

> 2.4.20smp-ac1 = Dec  4 13:44:48 localhost kernel: Memory: 12700k/16384k
> available (1396k kernel code, 3168k reserved, 102k data, 240k init, 0k
> highmem)
>
> 2.4.18-18.7.xsmp = Memory: 13156k/16384k available (1269k kernel code, 2712k
> reserved, 90k data, 220k init, 0k highmem)

I think it crept in after 2.4.18 in the -ac tree, can you test the
following patch? Courtesy of JA Magallon's tree;

11-memparam.bz2
	Fix mem=XXX kernel parameter when user gives a size bigger than what
	kernel autodetected (kill a previous change)
	Author: Adrian Bunk <bunk@fs.tum.de>,
	Leonardo Gomes Figueira <sabbath@planetarium.com.br>

--- linux/arch/i386/kernel/setup.c.original	Mon Jul 22 21:44:45 2002
+++ linux/arch/i386/kernel/setup.c	Tue Jul 23 03:38:08 2002
@@ -770,21 +770,29 @@
 				userdef = 1;
 			} else {
 				/* If the user specifies memory size, we
-				 * limit the BIOS-provided memory map to
-				 * that size. exactmap can be used to specify
-				 * the exact map. mem=number can be used to
-				 * trim the existing memory map.
+				 * blow away any automatically generated
+				 * size
 				 */
 				unsigned long long start_at, mem_size;

+				if (userdef == 0) {
+					/* first time in: zap the whitelist
+					 * and reinitialize it with the
+					 * standard low-memory region.
+					 */
+					e820.nr_map = 0;
+					userdef = 1;
+					add_memory_region(0, LOWMEMSIZE(), E820_RAM);
+				}
 				mem_size = memparse(from+4, &from);
-				if (*from == '@') {
+				if (*from == '@')
 					start_at = memparse(from+1, &from);
-					add_memory_region(start_at, mem_size, E820_RAM);
-				} else {
-					limit_regions(mem_size);
+				else {
+					start_at = HIGH_MEMORY;
+					mem_size -= HIGH_MEMORY;
 					userdef=1;
 				}
+				add_memory_region(start_at, mem_size, E820_RAM);
 			}
 		}

-- 
function.linuxpower.ca
