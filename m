Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129509AbRBXRzh>; Sat, 24 Feb 2001 12:55:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129502AbRBXRzR>; Sat, 24 Feb 2001 12:55:17 -0500
Received: from mandrakesoft.mandrakesoft.com ([216.71.84.35]:2164 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S129491AbRBXRzK>; Sat, 24 Feb 2001 12:55:10 -0500
Date: Sat, 24 Feb 2001 11:55:07 -0600
From: Philipp Rumpf <prumpf@mandrakesoft.com>
To: Jeff Lessem <Jeff.Lessem@Colorado.EDU>
Cc: linux-kernel@vger.kernel.org,
        Jeff Garzik <jgarzik@mandrakesoft.mandrakesoft.com>
Subject: Re: PCI oddities on Dell Inspiron 5000e w/ 2.4.x
Message-ID: <20010224115507.B28983@mandrakesoft.mandrakesoft.com>
In-Reply-To: <200102240941.CAA09708@ibg.colorado.edu> <Pine.LNX.4.10.10102240532030.30331-100000@penguin.transmeta.com> <20010224095447.A28983@mandrakesoft.mandrakesoft.com> <200102241725.KAA19514@ibg.colorado.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
In-Reply-To: <200102241725.KAA19514@ibg.colorado.edu>; from Jeff Lessem on Sat, Feb 24, 2001 at 10:25:42AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 24, 2001 at 10:25:42AM -0700, Jeff Lessem wrote:
> In your message of: Sat, 24 Feb 2001 09:54:47 CST, you write:
> >Jeff, are you using the e820 memory map at all ?  In particular, are you
> >using grub or some other buggy bootloader that insists on specifying a
> >mem= option on the kernel command line ?  There should be a kernel command
> >line message very early on, what does that say ?
> 
> Yes, I am using grub, the buggy bootloader.  The relevant chunk of
> kernal messages are:
> 
>  BIOS-provided physical RAM map:
>   BIOS-e820: 000000000009f800 @ 0000000000000000 (usable)
>   BIOS-e820: 0000000000000800 @ 000000000009f800 (reserved)
>   BIOS-e820: 0000000000019800 @ 00000000000e6800 (reserved)
>   BIOS-e820: 0000000013ef0000 @ 0000000000100000 (usable)
>   BIOS-e820: 000000000000fc00 @ 0000000013ff0000 (ACPI data)
>   BIOS-e820: 0000000000000400 @ 0000000013fffc00 (ACPI NVS)
>   BIOS-e820: 0000000000080000 @ 00000000fff80000 (reserved)
>  On node 0 totalpages: 81904
>  zone(0): 4096 pages.
>  zone(1): 77808 pages.
>  zone(2): 0 pages.
>  Kernel command line: root=/dev/hda1 mem=327616K
> 
> You are dead on, mem= seems a bit small.  Forcing mem=320M on the
> command line fixes the problem completely.

Careful, you're overwriting ACPI data now (and using it as normal RAM).

Can you try one of a) LILO b) a fixed version of grub c) this patch ?

diff -ur linux/arch/i386/kernel/setup.c linux-prumpf/arch/i386/kernel/setup.c
--- linux/arch/i386/kernel/setup.c	Fri Feb 23 13:37:38 2001
+++ linux-prumpf/arch/i386/kernel/setup.c	Sat Feb 24 09:49:50 2001
@@ -555,30 +555,9 @@
 				e820.nr_map = 0;
 				usermem = 1;
 			} else {
-				/* If the user specifies memory size, we
-				 * blow away any automatically generated
-				 * size
-				 */
-				unsigned long start_at, mem_size;
- 
-				if (usermem == 0) {
-					/* first time in: zap the whitelist
-					 * and reinitialize it with the
-					 * standard low-memory region.
-					 */
-					e820.nr_map = 0;
-					usermem = 1;
-					add_memory_region(0, LOWMEMSIZE(), E820_RAM);
-				}
-				mem_size = memparse(from+4, &from);
+				memparse(from+4, &from);
 				if (*from == '@')
-					start_at = memparse(from+1, &from);
-				else {
-					start_at = HIGH_MEMORY;
-					mem_size -= HIGH_MEMORY;
-					usermem=0;
-				}
-				add_memory_region(start_at, mem_size, E820_RAM);
+					memparse(from+1, &from);
 			}
 		}
 		c = *(from++);
