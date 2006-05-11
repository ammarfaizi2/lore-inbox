Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965196AbWEKHpR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965196AbWEKHpR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 03:45:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965198AbWEKHpQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 03:45:16 -0400
Received: from mx1.suse.de ([195.135.220.2]:43738 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S965196AbWEKHpP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 03:45:15 -0400
Message-ID: <4462EC05.8060705@suse.de>
Date: Thu, 11 May 2006 09:47:17 +0200
From: Gerd Hoffmann <kraxel@suse.de>
User-Agent: Thunderbird 1.5.0.2 (X11/20060411)
MIME-Version: 1.0
To: Zachary Amsden <zach@vmware.com>
Cc: Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>,
       xen-devel@lists.xensource.com, linux-kernel@vger.kernel.org,
       Ian Pratt <ian.pratt@xensource.com>
Subject: Re: [Xen-devel] Re: [RFC PATCH 07/35] Make LOAD_OFFSET defined by
 subarch
References: <20060509084945.373541000@sous-sol.org>	<20060509085150.509458000@sous-sol.org> <44627733.4010305@vmware.com>
In-Reply-To: <44627733.4010305@vmware.com>
Content-Type: multipart/mixed;
 boundary="------------020103010703090501090501"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020103010703090501090501
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit

Zachary Amsden wrote:
> Chris Wright wrote:
>> Change LOAD_OFFSET so that the kernel has virtual addresses in the elf
>> header fields.
>>
>> Unlike bare metal kernels, Xen kernels start with virtual address
>> management turned on and thus the addresses to load to should be
>> virtual addresses.
> 
> This patch interferes with using a traditional bootloader.  The loader
> for Xen should be smarter - it already has VIRT_BASE from the xen_guest
> section, and can simply add the relocation to these header fields.  This
> is unnecessary, and one of the many reasons a Xen kernel can't run in a
> normal environment.

I fully agree.  Attached below is a patch (against xen unstable
mercurial tree) which does exactly that ;)

cheers,

  Gerd

-- 
Gerd Hoffmann <kraxel@suse.de>
Erst mal heiraten, ein, zwei Kinder, und wenn alles läuft
geh' ich nach drei Jahren mit der Familie an die Börse.
http://www.suse.de/~kraxel/julika-dora.jpeg

--------------020103010703090501090501
Content-Type: text/x-patch;
 name="load-offset-submit.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="load-offset-submit.diff"

diff -r 1e3977e029fd linux-2.6-xen-sparse/include/asm-i386/mach-xen/asm/page.h
--- a/linux-2.6-xen-sparse/include/asm-i386/mach-xen/asm/page.h	Mon May  8 18:21:41 2006
+++ b/linux-2.6-xen-sparse/include/asm-i386/mach-xen/asm/page.h	Thu May 11 09:10:41 2006
@@ -289,10 +289,6 @@
 #endif
 #define __KERNEL_START		(__PAGE_OFFSET + __PHYSICAL_START)
 
-#undef LOAD_OFFSET
-#define LOAD_OFFSET		0
-
-
 #define PAGE_OFFSET		((unsigned long)__PAGE_OFFSET)
 #define VMALLOC_RESERVE		((unsigned long)__VMALLOC_RESERVE)
 #define MAXMEM			(__FIXADDR_TOP-__PAGE_OFFSET-__VMALLOC_RESERVE)
diff -r 1e3977e029fd linux-2.6-xen-sparse/include/asm-x86_64/mach-xen/asm/page.h
--- a/linux-2.6-xen-sparse/include/asm-x86_64/mach-xen/asm/page.h	Mon May  8 18:21:41 2006
+++ b/linux-2.6-xen-sparse/include/asm-x86_64/mach-xen/asm/page.h	Thu May 11 09:10:41 2006
@@ -260,9 +260,6 @@
 #define __PAGE_OFFSET           0xffff880000000000
 #endif /* !__ASSEMBLY__ */
 
-#undef LOAD_OFFSET
-#define LOAD_OFFSET		0
-
 /* to align the pointer to the (next) page boundary */
 #define PAGE_ALIGN(addr)	(((addr)+PAGE_SIZE-1)&PAGE_MASK)
 
diff -r 1e3977e029fd tools/libxc/xc_load_elf.c
--- a/tools/libxc/xc_load_elf.c	Mon May  8 18:21:41 2006
+++ b/tools/libxc/xc_load_elf.c	Thu May 11 09:10:41 2006
@@ -59,6 +59,7 @@
     Elf_Phdr *phdr;
     Elf_Shdr *shdr;
     unsigned long kernstart = ~0UL, kernend=0UL;
+    unsigned long sstart, send;
     const char *shstrtab;
     char *guestinfo=NULL, *p;
     int h;
@@ -132,6 +133,8 @@
         }
         if ( (strstr(guestinfo, "PAE=yes") != NULL) )
             dsi->pae_kernel = 1;
+        if ( (p = strstr(guestinfo, "VIRT_BASE=")) != NULL )
+            dsi->virt_base = strtoul(p+10, &p, 0);
 
         break;
     }
@@ -153,11 +156,30 @@
         phdr = (Elf_Phdr *)(image + ehdr->e_phoff + (h*ehdr->e_phentsize));
         if ( !is_loadable_phdr(phdr) )
             continue;
-        if ( phdr->p_paddr < kernstart )
-            kernstart = phdr->p_paddr;
-        if ( (phdr->p_paddr + phdr->p_memsz) > kernend )
-            kernend = phdr->p_paddr + phdr->p_memsz;
-    }
+        sstart = phdr->p_paddr;
+        send   = phdr->p_paddr + phdr->p_memsz;
+        /*
+         * bug comparibility alert: old linux kernels used to have
+         * virtual addresses in the paddr headers, whereas newer ones
+         * (since kexec merge, around 2.6.14) correctly use physical
+         * addresses.
+         *
+         * As we want to be able to boot both kinds of kernels we'll
+         * do some guesswork here: If paddr is greater than virt_base
+         * we assume it is a old kernel and use it as-is.  Otherwise
+         * we'll add virt_base to get the correct address.
+         */
+        if (sstart < dsi->virt_base) {
+            sstart += dsi->virt_base;
+            send   += dsi->virt_base;
+        }
+        if ( sstart < kernstart )
+            kernstart = sstart;
+        if ( send > kernend )
+            kernend = send;
+    }
+    if (dsi->virt_base > 0 && ehdr->e_entry < dsi->virt_base)
+	ehdr->e_entry += dsi->virt_base;
 
     if ( (kernstart > kernend) ||
          (ehdr->e_entry < kernstart) ||
@@ -204,7 +226,11 @@
 
         for ( done = 0; done < phdr->p_filesz; done += chunksz )
         {
-            pa = (phdr->p_paddr + done) - dsi->v_start;
+            /* bug compatibility alert, see above */
+            pa = phdr->p_paddr + done;
+            if (pa > dsi->virt_base)
+                pa -= dsi->virt_base;
+
             va = xc_map_foreign_range(
                 xch, dom, PAGE_SIZE, PROT_WRITE, parray[pa>>PAGE_SHIFT]);
             chunksz = phdr->p_filesz - done;
@@ -217,7 +243,11 @@
 
         for ( ; done < phdr->p_memsz; done += chunksz )
         {
-            pa = (phdr->p_paddr + done) - dsi->v_start;
+            /* bug compatibility alert, see above */
+            pa = phdr->p_paddr + done;
+            if (pa > dsi->virt_base)
+                pa -= dsi->virt_base;
+
             va = xc_map_foreign_range(
                 xch, dom, PAGE_SIZE, PROT_WRITE, parray[pa>>PAGE_SHIFT]);
             chunksz = phdr->p_memsz - done;
diff -r 1e3977e029fd tools/libxc/xg_private.h
--- a/tools/libxc/xg_private.h	Mon May  8 18:21:41 2006
+++ b/tools/libxc/xg_private.h	Thu May 11 09:10:41 2006
@@ -135,6 +135,7 @@
     unsigned long v_kernstart;
     unsigned long v_kernend;
     unsigned long v_kernentry;
+    unsigned long virt_base;
 
     unsigned int  load_symtab;
     unsigned int  pae_kernel;
diff -r 1e3977e029fd xen/common/elf.c
--- a/xen/common/elf.c	Mon May  8 18:21:41 2006
+++ b/xen/common/elf.c	Thu May 11 09:10:41 2006
@@ -24,6 +24,7 @@
     Elf_Phdr *phdr;
     Elf_Shdr *shdr;
     unsigned long kernstart = ~0UL, kernend=0UL;
+    unsigned long sstart, send;
     char *shstrtab, *guestinfo=NULL, *p;
     char *elfbase = (char *)dsi->image_addr;
     int h;
@@ -76,6 +77,8 @@
             return -EINVAL;
         }
 
+        if ( (p = strstr(guestinfo, "VIRT_BASE=")) != NULL )
+            dsi->virt_base = simple_strtoul(p+10, &p, 0);
         break;
     }
 
@@ -86,11 +89,40 @@
         phdr = (Elf_Phdr *)(elfbase + ehdr->e_phoff + (h*ehdr->e_phentsize));
         if ( !is_loadable_phdr(phdr) )
             continue;
-        if ( phdr->p_paddr < kernstart )
-            kernstart = phdr->p_paddr;
-        if ( (phdr->p_paddr + phdr->p_memsz) > kernend )
-            kernend = phdr->p_paddr + phdr->p_memsz;
-    }
+        sstart = phdr->p_paddr;
+        send   = phdr->p_paddr + phdr->p_memsz;
+        /*
+         * bug comparibility alert: old linux kernels used to have
+         * virtual addresses in the paddr headers, whereas newer ones
+         * (since kexec merge, around 2.6.14) correctly use physical
+         * addresses.
+         *
+         * As we want to be able to boot both kinds of kernels we'll
+         * do some guesswork here: If paddr is greater than virt_base
+         * we assume it is a old kernel and use it as-is.  Otherwise
+         * we'll add virt_base to get the correct address.
+         */
+        if (sstart < dsi->virt_base) {
+            sstart += dsi->virt_base;
+            send   += dsi->virt_base;
+        }
+        printk("%s: program hdr: %08lx (=vaddr)  "
+               "paddr: %08lx  filesz: %08lx  memsz: %08lx  =>  %08lx-%08lx\n",
+               __FUNCTION__,
+               (unsigned long)phdr->p_vaddr,
+               (unsigned long)phdr->p_paddr,
+               (unsigned long)phdr->p_filesz,
+               (unsigned long)phdr->p_memsz,
+               sstart, send);
+        if ( sstart < kernstart )
+            kernstart = sstart;
+        if ( send > kernend )
+            kernend = send;
+    }
+    if (dsi->virt_base > 0 && ehdr->e_entry < dsi->virt_base)
+	ehdr->e_entry += dsi->virt_base;
+    printk("%s: entry point: %08lx\n", __FUNCTION__,
+           (unsigned long)ehdr->e_entry);
 
     if ( (kernstart > kernend) || 
          (ehdr->e_entry < kernstart) || 
@@ -126,6 +158,7 @@
     char *elfbase = (char *)dsi->image_addr;
     Elf_Ehdr *ehdr = (Elf_Ehdr *)dsi->image_addr;
     Elf_Phdr *phdr;
+    unsigned long vaddr;
     int h;
   
     for ( h = 0; h < ehdr->e_phnum; h++ ) 
@@ -133,11 +166,15 @@
         phdr = (Elf_Phdr *)(elfbase + ehdr->e_phoff + (h*ehdr->e_phentsize));
         if ( !is_loadable_phdr(phdr) )
             continue;
+        vaddr = phdr->p_paddr;
+        if (vaddr < dsi->virt_base)
+            vaddr += dsi->virt_base;
         if ( phdr->p_filesz != 0 )
-            memcpy((char *)phdr->p_paddr, elfbase + phdr->p_offset, 
+            memcpy((char *)vaddr,
+                   elfbase + phdr->p_offset, 
                    phdr->p_filesz);
         if ( phdr->p_memsz > phdr->p_filesz )
-            memset((char *)phdr->p_paddr + phdr->p_filesz, 0, 
+            memset((char *)phdr->p_vaddr + phdr->p_filesz, 0, 
                    phdr->p_memsz - phdr->p_filesz);
     }
 
diff -r 1e3977e029fd xen/include/xen/sched.h
--- a/xen/include/xen/sched.h	Mon May  8 18:21:41 2006
+++ b/xen/include/xen/sched.h	Thu May 11 09:10:41 2006
@@ -172,6 +172,7 @@
     unsigned long v_kernstart;
     unsigned long v_kernend;
     unsigned long v_kernentry;
+    unsigned long virt_base;
     /* Initialised by loader: Private. */
     unsigned int  load_symtab;
     unsigned long symtab_addr;

--------------020103010703090501090501--
