Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317972AbSGWGtO>; Tue, 23 Jul 2002 02:49:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317973AbSGWGtO>; Tue, 23 Jul 2002 02:49:14 -0400
Received: from terra.planetarium.com.br ([200.196.32.31]:62478 "HELO
	terra.planetarium.com.br") by vger.kernel.org with SMTP
	id <S317972AbSGWGtN>; Tue, 23 Jul 2002 02:49:13 -0400
Message-ID: <3D3CFC29.60006@planetarium.com.br>
Date: Tue, 23 Jul 2002 03:48:09 -0300
From: Leonardo Gomes Figueira <sabbath@planetarium.com.br>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: pt-br, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@fs.tum.de>
CC: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: Memory detection problem in 2.4.19-rc2
References: <Pine.NEB.4.44.0207201806350.16962-100000@mimas.fachschaften.tu-muenchen.de>
Content-Type: multipart/mixed;
 boundary="------------060408010808010202080403"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060408010808010202080403
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Adrian Bunk wrote:

> It seems that the change Christoph introduced (from Red Hat's tree) in the
> lines around 810 (line number in -rc3) in arch/i386/kernel/setup.c didn't
> consider the case that someone want's to _in_crease the size of the memory
> by using the "mem="  parameter.
> 
> It's the following Changeset:
> 
> <--  snip  -->
> 
>    Changeset details for 1.383.2.25
> 
>    ChangeSet@1.383.2.25  2002-04-15 23:18:40-03:00  hch@infradead.org
>    all diffs
>    [PATCH] mem= command lines fixes.
>    Another patch from Red Hat's tree:
>      mem= command-line adapts itself to existing e820 values.
>      without this patch mem=xxxM ignores bios-reserved areas and uses
>      them as RAM. This patch makes the kernel skip these areas
>    arch/i386/kernel/setup.c@1.38  2001-04-05
>    21:19:09-03:00  hch@infradead.org
> 
> <--  snip  -->

Thanks for your help. I changed the code to the way it was before and it 
worked fine. I'm running 2.4.19-rc3 now. :-)

I created a patch to undo this modification in case anyone has the same 
problem, it's attached in this message.

Bye,

   Léo


  Leonardo Gomes Figueira
  sabbath@planetarium.com.br

--------------060408010808010202080403
Content-Type: text/plain;
 name="patch-memparam-2.4.19-rc3"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-memparam-2.4.19-rc3"

--- linux/arch/i386/kernel/setup.c.original	Mon Jul 22 21:44:45 2002
+++ linux/arch/i386/kernel/setup.c	Tue Jul 23 03:38:08 2002
@@ -808,21 +808,29 @@
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
 

--------------060408010808010202080403--

