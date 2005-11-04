Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750818AbVKDWqV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750818AbVKDWqV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 17:46:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750951AbVKDWqV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 17:46:21 -0500
Received: from smtp.osdl.org ([65.172.181.4]:52680 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750818AbVKDWqU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 17:46:20 -0500
Date: Fri, 4 Nov 2005 14:46:32 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [PATCH] uml: fix hardcoded ZONE_* constants in zone setup
Message-Id: <20051104144632.55b92ea4.akpm@osdl.org>
In-Reply-To: <20051101203721.26156.11021.stgit@zion.home.lan>
References: <20051101170633.GB6448@ccure.user-mode-linux.org>
	<20051101203721.26156.11021.stgit@zion.home.lan>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it> wrote:
>
> From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
> 
> Remove usage of hardcoded constants in paging_init().
> 
> By chance I spotted a bug in zones_setup involving a change to ZONE_* constants,
> due to the ZONE_DMA32 patch from Andi Kleen (which is in -mm). So, possibly,
> instead of zones_size[2] you will find zones_size[3] in the code, but that
> change is wrong and this patch is still correct.
> 
> Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
> ---
> 
>  arch/um/kernel/mem.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/um/kernel/mem.c b/arch/um/kernel/mem.c
> --- a/arch/um/kernel/mem.c
> +++ b/arch/um/kernel/mem.c
> @@ -234,8 +234,8 @@ void paging_init(void)
>  	empty_bad_page = (unsigned long *) alloc_bootmem_low_pages(PAGE_SIZE);
>  	for(i=0;i<sizeof(zones_size)/sizeof(zones_size[0]);i++) 
>  		zones_size[i] = 0;
> -	zones_size[0] = (end_iomem >> PAGE_SHIFT) - (uml_physmem >> PAGE_SHIFT);
> -	zones_size[2] = highmem >> PAGE_SHIFT;
> +	zones_size[ZONE_DMA] = (end_iomem >> PAGE_SHIFT) - (uml_physmem >> PAGE_SHIFT);
> +	zones_size[ZONE_HIGHMEM] = highmem >> PAGE_SHIFT;

An earlier patch from Jeff (below) already changed this code.

Jeff's change looks rather wrong:



#define MAX_NR_ZONES            3       /* Sync this with ZONES_SHIFT */
	
        unsigned long zones_size[MAX_NR_ZONES]

	...

	zones_size[3] = highmem >> PAGE_SHIFT;

which overindexes the local array.

The above change is unmentioned in Jeff's changelog and I'll just drop that
part.  Please confirm.

There are other parts of this patch whci are unchangelogged.  Please
double-check the whole thing.


From: Jeff Dike <jdike@addtoit.com>

A number of fixes to improve behavior when large physical memory sizes
are specified:

- libc files need -D_FILE_OFFSET_BITS=64 because there are unavoidable uses
  of non-64 interfaces in libc

- some %d need to be %u

Signed-off-by: Jeff Dike <jdike@addtoit.com>
Cc: Paolo Giarrusso <blaisorblade@yahoo.it>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 arch/um/Makefile            |    2 +-
 arch/um/include/mem_user.h  |    2 +-
 arch/um/include/os.h        |    2 +-
 arch/um/kernel/mem.c        |    2 +-
 arch/um/kernel/physmem.c    |    4 ++--
 arch/um/kernel/um_arch.c    |   10 +++++-----
 arch/um/os-Linux/mem.c      |    6 +++---
 arch/um/os-Linux/start_up.c |    2 +-
 8 files changed, 15 insertions(+), 15 deletions(-)

diff -puN arch/um/include/mem_user.h~uml-big-memory-fixes arch/um/include/mem_user.h
--- devel/arch/um/include/mem_user.h~uml-big-memory-fixes	2005-10-31 17:43:54.000000000 -0800
+++ devel-akpm/arch/um/include/mem_user.h	2005-10-31 17:43:54.000000000 -0800
@@ -57,7 +57,7 @@ extern int init_maps(unsigned long physm
 		     unsigned long highmem);
 extern unsigned long get_vm(unsigned long len);
 extern void setup_physmem(unsigned long start, unsigned long usable,
-			  unsigned long len, unsigned long highmem);
+			  unsigned long len, unsigned long long highmem);
 extern void add_iomem(char *name, int fd, unsigned long size);
 extern unsigned long phys_offset(unsigned long phys);
 extern void unmap_physmem(void);
diff -puN arch/um/include/os.h~uml-big-memory-fixes arch/um/include/os.h
--- devel/arch/um/include/os.h~uml-big-memory-fixes	2005-10-31 17:43:54.000000000 -0800
+++ devel-akpm/arch/um/include/os.h	2005-10-31 17:43:54.000000000 -0800
@@ -167,7 +167,7 @@ extern int can_do_skas(void);
 #endif
 
 /* mem.c */
-extern int create_mem_file(unsigned long len);
+extern int create_mem_file(unsigned long long len);
 
 /* process.c */
 extern unsigned long os_process_pc(int pid);
diff -puN arch/um/kernel/mem.c~uml-big-memory-fixes arch/um/kernel/mem.c
--- devel/arch/um/kernel/mem.c~uml-big-memory-fixes	2005-10-31 17:43:54.000000000 -0800
+++ devel-akpm/arch/um/kernel/mem.c	2005-10-31 17:43:54.000000000 -0800
@@ -235,7 +235,7 @@ void paging_init(void)
 	for(i=0;i<sizeof(zones_size)/sizeof(zones_size[0]);i++) 
 		zones_size[i] = 0;
 	zones_size[0] = (end_iomem >> PAGE_SHIFT) - (uml_physmem >> PAGE_SHIFT);
-	zones_size[2] = highmem >> PAGE_SHIFT;
+	zones_size[3] = highmem >> PAGE_SHIFT;
 	free_area_init(zones_size);
 
 	/*
diff -puN arch/um/kernel/physmem.c~uml-big-memory-fixes arch/um/kernel/physmem.c
--- devel/arch/um/kernel/physmem.c~uml-big-memory-fixes	2005-10-31 17:43:54.000000000 -0800
+++ devel-akpm/arch/um/kernel/physmem.c	2005-10-31 17:43:54.000000000 -0800
@@ -246,7 +246,7 @@ int is_remapped(void *virt)
 /* Changed during early boot */
 unsigned long high_physmem;
 
-extern unsigned long physmem_size;
+extern unsigned long long physmem_size;
 
 int init_maps(unsigned long physmem, unsigned long iomem, unsigned long highmem)
 {
@@ -321,7 +321,7 @@ void map_memory(unsigned long virt, unsi
 extern int __syscall_stub_start, __binary_start;
 
 void setup_physmem(unsigned long start, unsigned long reserve_end,
-		   unsigned long len, unsigned long highmem)
+		   unsigned long len, unsigned long long highmem)
 {
 	unsigned long reserve = reserve_end - start;
 	int pfn = PFN_UP(__pa(reserve_end));
diff -puN arch/um/kernel/um_arch.c~uml-big-memory-fixes arch/um/kernel/um_arch.c
--- devel/arch/um/kernel/um_arch.c~uml-big-memory-fixes	2005-10-31 17:43:54.000000000 -0800
+++ devel-akpm/arch/um/kernel/um_arch.c	2005-10-31 17:43:54.000000000 -0800
@@ -137,7 +137,7 @@ static char *argv1_end = NULL;
 
 /* Set in early boot */
 static int have_root __initdata = 0;
-long physmem_size = 32 * 1024 * 1024;
+long long physmem_size = 32 * 1024 * 1024;
 
 void set_cmdline(char *cmd)
 {
@@ -402,7 +402,7 @@ int linux_main(int argc, char **argv)
 #ifndef CONFIG_HIGHMEM
 		highmem = 0;
 		printf("CONFIG_HIGHMEM not enabled - physical memory shrunk "
-		       "to %ld bytes\n", physmem_size);
+		       "to %lu bytes\n", physmem_size);
 #endif
 	}
 
@@ -414,8 +414,8 @@ int linux_main(int argc, char **argv)
 
 	setup_physmem(uml_physmem, uml_reserved, physmem_size, highmem);
 	if(init_maps(physmem_size, iomem_size, highmem)){
-		printf("Failed to allocate mem_map for %ld bytes of physical "
-		       "memory and %ld bytes of highmem\n", physmem_size,
+		printf("Failed to allocate mem_map for %lu bytes of physical "
+		       "memory and %lu bytes of highmem\n", physmem_size,
 		       highmem);
 		exit(1);
 	}
@@ -426,7 +426,7 @@ int linux_main(int argc, char **argv)
 	end_vm = start_vm + virtmem_size;
 
 	if(virtmem_size < physmem_size)
-		printf("Kernel virtual memory size shrunk to %ld bytes\n",
+		printf("Kernel virtual memory size shrunk to %lu bytes\n",
 		       virtmem_size);
 
   	uml_postsetup();
diff -puN arch/um/Makefile~uml-big-memory-fixes arch/um/Makefile
--- devel/arch/um/Makefile~uml-big-memory-fixes	2005-10-31 17:43:54.000000000 -0800
+++ devel-akpm/arch/um/Makefile	2005-10-31 17:43:54.000000000 -0800
@@ -60,7 +60,7 @@ AFLAGS += $(ARCH_INCLUDE)
 
 USER_CFLAGS := $(patsubst -I%,,$(CFLAGS))
 USER_CFLAGS := $(patsubst -D__KERNEL__,,$(USER_CFLAGS)) $(ARCH_INCLUDE) \
-	$(MODE_INCLUDE)
+	$(MODE_INCLUDE) -D_FILE_OFFSET_BITS=64
 
 # -Derrno=kernel_errno - This turns all kernel references to errno into
 # kernel_errno to separate them from the libc errno.  This allows -fno-common
diff -puN arch/um/os-Linux/mem.c~uml-big-memory-fixes arch/um/os-Linux/mem.c
--- devel/arch/um/os-Linux/mem.c~uml-big-memory-fixes	2005-10-31 17:43:54.000000000 -0800
+++ devel-akpm/arch/um/os-Linux/mem.c	2005-10-31 17:43:54.000000000 -0800
@@ -88,7 +88,7 @@ int make_tempfile(const char *template, 
  * This proc is used in start_up.c
  * So it isn't 'static'.
  */
-int create_tmp_file(unsigned long len)
+int create_tmp_file(unsigned long long len)
 {
 	int fd, err;
 	char zero;
@@ -121,7 +121,7 @@ int create_tmp_file(unsigned long len)
 	return(fd);
 }
 
-static int create_anon_file(unsigned long len)
+static int create_anon_file(unsigned long long len)
 {
 	void *addr;
 	int fd;
@@ -144,7 +144,7 @@ static int create_anon_file(unsigned lon
 
 extern int have_devanon;
 
-int create_mem_file(unsigned long len)
+int create_mem_file(unsigned long long len)
 {
 	int err, fd;
 
diff -puN arch/um/os-Linux/start_up.c~uml-big-memory-fixes arch/um/os-Linux/start_up.c
--- devel/arch/um/os-Linux/start_up.c~uml-big-memory-fixes	2005-10-31 17:43:54.000000000 -0800
+++ devel-akpm/arch/um/os-Linux/start_up.c	2005-10-31 17:43:54.000000000 -0800
@@ -296,7 +296,7 @@ static void __init check_ptrace(void)
 	check_sysemu();
 }
 
-extern int create_tmp_file(unsigned long len);
+extern int create_tmp_file(unsigned long long len);
 
 static void check_tmpexec(void)
 {
_

