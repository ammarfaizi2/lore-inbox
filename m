Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285978AbRLHVmc>; Sat, 8 Dec 2001 16:42:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285981AbRLHVmW>; Sat, 8 Dec 2001 16:42:22 -0500
Received: from nc-ashvl-66-169-84-151.charternc.net ([66.169.84.151]:51072
	"EHLO orp.orf.cx") by vger.kernel.org with ESMTP id <S285978AbRLHVmM>;
	Sat, 8 Dec 2001 16:42:12 -0500
Message-Id: <200112082142.fB8LgAb02089@orp.orf.cx>
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0.4
From: Leigh Orf <orf@mailbag.com>
To: linux-kernel@vger.kernel.org
Cc: Ken Brownfield <brownfld@irridia.com>, Andrew Morton <akpm@zip.com.au>
Organization: Department of Tesselating Kumquats
X-URL: http://orf.cx
X-face: "(Qpt_9H~41JFy=C&/h^zmz6Dm6]1ZKLat1<W!0bNwz2!LxG-lZ=r@4Me&uUvG>-r\?<DcDb+Y'p'sCMJ
Subject: Re: 2.4.16 memory badness (reproducible) 
In-Reply-To: Your message of "Sat, 08 Dec 2001 15:04:40 EST."
             <200112082004.fB8K4eQ02110@orp.orf.cx> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 08 Dec 2001 16:42:10 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've noticed a couple more things with the memory allocation problem
with large buffer and cache allocation. Some applications will fail
with ENOMEM *even if* there is a considerable amount (say, 62 MB as
below) of "truly" free memory.

The second thing I've noticed is that all these apps that die with
ENOMEM pretty much have the same strace output towards the end. What
is strange is "display *.tif" dies while "ee *.tif" and "gimp *.tif"
does not. Piping the strace output of commands that *don't* cause this
behavior and grepping for modify_ldt shows that modify_ldt is *not*
being called for apps that *don't* die.

So I don't know if it's a symptom or a cause, but modify_ldt seems to be
triggering the problem. Not being a kernel hacker, I leave the analysis
of this to those who are.

Leigh Orf

home[1029]:/home/orf% free
             total       used       free     shared    buffers     cached
Mem:       1029772     967096      62676          0     443988      98312
-/+ buffers/cache:     424796     604976
Swap:      2064344          0    2064344

home[1026]:/home/orf% strace xmms 2>&1   | tail
old_mmap(NULL, 1291080, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x40316000
mprotect(0x40448000, 37704, PROT_NONE)  = 0
old_mmap(0x40448000, 24576, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x131000) = 0x40448000
old_mmap(0x4044e000, 13128, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x4044e000
close(3)                                = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40452000
munmap(0x40018000, 72129)               = 0
modify_ldt(0x1, 0xbffff1fc, 0x10)       = -1 ENOMEM (Cannot allocate memory)
--- SIGSEGV (Segmentation fault) ---
+++ killed by SIGSEGV +++

home[1027]:/home/orf% strace nautilus 2>&1   | tail    
old_mmap(NULL, 1291080, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x40958000
mprotect(0x40a8a000, 37704, PROT_NONE)  = 0
old_mmap(0x40a8a000, 24576, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x131000) = 0x40a8a000
old_mmap(0x40a90000, 13128, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x40a90000
close(3)                                = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40a94000
munmap(0x40018000, 72129)               = 0
modify_ldt(0x1, 0xbffff1fc, 0x10)       = -1 ENOMEM (Cannot allocate memory)
--- SIGSEGV (Segmentation fault) ---
+++ killed by SIGSEGV +++

home[1028]:/home/orf% strace display *.tif 2>&1   | tail
old_mmap(NULL, 1291080, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x404ff000
mprotect(0x40631000, 37704, PROT_NONE)  = 0
old_mmap(0x40631000, 24576, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x131000) = 0x40631000
old_mmap(0x40637000, 13128, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x40637000
close(3)                                = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x4063b000
munmap(0x401a8000, 72129)               = 0
modify_ldt(0x1, 0xbfffefac, 0x10)       = -1 ENOMEM (Cannot allocate memory)
--- SIGSEGV (Segmentation fault) ---
+++ killed by SIGSEGV +++



Leigh Orf wrote:

|   
|   No change - identical behavior.
|   
|   Leigh Orf
|   
|   Andrew Morton wrote:
|   
|   |   Leigh Orf wrote:
|   |   > 
|   |   > Ken Brownfield wrote:
|   |   > 
|   |   > |   This parallels what I'm seeing -- perhaps inode/dentry cache
|   |   > |   bloat is causing the memory issue (which mimics if not _is_
|   |   > |   a memory leak) _and_ my kswapd thrashing?  It fits both the
|   |   > |   situation you report and what I'm seeing with I/O across a
|   |   > |   large number of files (inodes) -- updatedb, smb, NFS, etc.
|   |   > |
|   |   > |   I think Andrea was on to this issue, so I'm hoping his work
|   |   > |   will help.  Have you tried an -aa kernel or an aa patch onto
|   |   > |   a 2.4.17-pre4 to see how the kernel's behavior changes?
|   |   > |
|   |   > |   --
|   |   > |   Ken.
|   |   > |   brownfld@irridia.com
|   |   > 
|   |   > I get the exact same behavior with 2.4.17-pre4-aa1 - many applications
|   |   > abort with ENOMEM after updatedb (filling the buffer and cache). Is
|   |   > there another kernel/patch I should try?
|   |   > 
|   |   
|   |   Just for interest's sake:
|   |   
|   |   --- linux-2.4.17-pre6/mm/memory.c	Fri Dec  7 15:39:52 2001
|   |   +++ linux-akpm/mm/memory.c	Sat Dec  8 11:13:30 2001
|   |   @@ -1184,6 +1184,7 @@ static int do_anonymous_page(struct mm_s
|   |    		flush_page_to_ram(page);
|   |    		entry = pte_mkwrite(pte_mkdirty(mk_pte(page, vma->vm_page_prot)));
|   |    		lru_cache_add(page);
|   |   +		activate_page(page);
|   |    	}
|   |    
|   |    	set_pte(page_table, entry);

