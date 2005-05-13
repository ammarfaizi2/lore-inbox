Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262515AbVEMUGJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262515AbVEMUGJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 16:06:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262474AbVEMUGI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 16:06:08 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:53895 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S262530AbVEMUAY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 16:00:24 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc64-dev@ozlabs.org
Subject: [PATCH 8/8] ppc64: add spufs user library
Date: Fri, 13 May 2005 21:32:32 +0200
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
       Anton Blanchard <anton@samba.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <200505132117.37461.arnd@arndb.de>
In-Reply-To: <200505132117.37461.arnd@arndb.de>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200505132132.33772.arnd@arndb.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a user space library as a counterpart to the kernel side spufs.
Since the hardware is not available yet, this is mostly for documenting
the spufs API and is not intended for merging into mainline.

As the API matures, libspu will become a separate package.

From: Dirk Herrendörfer <herrend@de.ibm.com>
Signed-off-by: Arnd Bergmann <arndb@de.ibm.com>

--- linux-cg.orig/Documentation/bpa/libspu/Makefile	1969-12-31 19:00:00.000000000 -0500
+++ linux-cg/Documentation/bpa/libspu/Makefile	2005-05-13 11:37:31.481923136 -0400
@@ -0,0 +1,41 @@
+#*
+#* libbpathread - A wrapper library to adapt the JSRE SPU usage model to SPUFS 
+#* Copyright (C) 2005 IBM Corp. 
+#*
+#* This library is free software; you can redistribute it and/or modify it
+#* under the terms of the GNU Lesser General Public License as published by 
+#* the Free Software Foundation; either version 2.1 of the License, 
+#* or (at your option) any later version.
+#*
+#*  This library is distributed in the hope that it will be useful, but 
+#*  WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY 
+#*  or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public 
+#*  License for more details.
+#*
+#*   You should have received a copy of the GNU Lesser General Public License 
+#*   along with this library; if not, write to the Free Software Foundation, 
+#*   Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+#*
+
+CC := gcc
+CTAGS = ctags
+
+CFLAGS := -O2 -m32 -Wall -I. -Iinclude -DDEBUG -g \
+
+libspu_OBJS := elf_loader.o bpathread.o
+OBJS := libbpathread.a $(libspu_OBJS)
+
+all: $(OBJS)
+
+libbpathread.a: $(libspu_OBJS)
+	ar -r $@ $(libspu_OBJS)
+
+tests: 
+	make -C test/start-stop
+
+tags:
+	$(CTAGS) -R .
+
+clean: 
+	rm -f $(OBJS) *~ tags
+	make -C test/start-stop clean
--- linux-cg.orig/Documentation/bpa/libspu/README	1969-12-31 19:00:00.000000000 -0500
+++ linux-cg/Documentation/bpa/libspu/README	2005-05-13 11:37:31.482922984 -0400
@@ -0,0 +1,7 @@
+This is an example of how to use the SPEs in applications. It is by
+no means complete or perfect - it is meant as a reference of how to
+use the SPUFS implementation in linux.
+As more and more features of SPUFS become available, this code will
+be extended too.
+
+D.Herrendoerfer <herrend@de.ibm.com>
--- linux-cg.orig/Documentation/bpa/libspu/bpathread.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-cg/Documentation/bpa/libspu/bpathread.c	2005-05-13 11:37:31.483922832 -0400
@@ -0,0 +1,314 @@
+/*
+ * libbpathread - A wrapper library to adapt the JSRE SPU usage model to SPUFS
+ * Copyright (C) 2005 IBM Corp.
+ *
+ * This library is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU Lesser General Public License as published by
+ * the Free Software Foundation; either version 2.1 of the License,
+ * or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful, but
+ *  WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
+ *  or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public
+ *  License for more details.
+ *
+ *   You should have received a copy of the GNU Lesser General Public License
+ *   along with this library; if not, write to the Free Software Foundation,
+ *   Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+
+#include <elf.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <pthread.h>
+#include <signal.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+
+#include <sys/ioctl.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+
+#include <bpathread.h>
+#include <elf_loader.h>
+#include <spe_exec.h>
+
+#define __PRINTF(fmt, args...) { fprintf(stderr,fmt , ## args); }
+#ifdef DEBUG
+#define DEBUG_PRINTF(fmt, args...) __PRINTF(fmt , ## args)
+#else
+#define DEBUG_PRINTF(fmt, args...)
+#endif
+
+
+int thread_num = 0;
+
+/*
+ * Helpers
+ *
+ * */
+
+struct thread_start_info
+{
+	char pathname[40];	/* */
+	int thread_num;		/* */
+};
+
+struct thread_store
+{
+	pthread_t spe_thread;
+	int thread_return_value;
+	int fd_mbox;
+	unsigned int state;
+};
+
+static struct thread_store spe_thread_store[1024];
+
+/*
+ * int spe_ldr[]:
+ * SPE code that performs the actual parameter setting:
+ */
+static int spe_ldr[] = {
+	0x30fff083,
+	0x30fff284,
+	0x30fff485,
+	0x30fff686,
+	0x30fff000,
+	0x35000000,
+	0x00000000,
+	0x00000000
+};
+
+/**
+ * Library API
+ * 
+ */
+
+speid_t
+spe_create_thread (int gid, void *start, void *argp, void *envp, int mask,
+		   int flags)
+{
+	int rc, memfd;
+	addr64 argp64, envp64;
+	pthread_t thread;
+	char memname[40], pathname[40];
+	void *spe_ld_buf;
+	ssize_t count = 0, num = 0;
+	struct spe_ld_info ld_info;
+	struct thread_start_info *thread_info;
+	struct spe_exec_params spe_params __attribute__ ((aligned (4096)));
+
+	DEBUG_PRINTF ("spe_create_thread(0x%x, %p, %p, %p, 0x%x, 0x%x)\n",
+		      gid, start, argp, envp, mask, flags);
+
+	argp64.ull = (unsigned long long) (unsigned long) argp;
+	envp64.ull = (unsigned long long) (unsigned long) envp;
+
+	/* Make the SPU Directory */
+
+	sprintf (pathname, "/spu/bpathread-%i-%i", getpid (), thread_num);
+
+	DEBUG_PRINTF ("mkdir %s\n", pathname);
+
+	rc = mkdir (pathname, S_IRUSR | S_IWUSR | S_IXUSR);
+	if (rc < 0)
+	  {
+		  DEBUG_PRINTF ("Could not make dir %s\n", pathname);
+		  return -1;
+	  }
+
+	sprintf (memname, "%s/mem", pathname);
+
+	/* Check SPE */
+
+	memfd = open (memname, O_CREAT | O_RDWR, S_IRUSR | S_IWUSR);
+	if (memfd < 0)
+	  {
+		  DEBUG_PRINTF ("Could not open SPE mem file.\n");
+		  return -1;
+	  }
+
+	/* Prepare Loader */
+
+	spe_ld_buf = malloc (LS_SIZE);
+	thread_info = malloc (sizeof (*thread_info));
+
+	if (!spe_ld_buf || !thread_info)
+	  {
+		  DEBUG_PRINTF ("Could not allocate SPE memory. \n");
+		  errno = ENOMEM;
+		  return -1;
+	  }
+
+	memset(spe_ld_buf, 0, LS_SIZE);
+
+	rc = load_spe_elf (start, spe_ld_buf, &ld_info);
+	if (rc != 0)
+	  {
+		  DEBUG_PRINTF ("Load SPE ELF failed..\n");
+		  return -1;
+	  }
+
+	/* Add SPE exec program */
+
+	DEBUG_PRINTF ("Add exec prog dst:0x%04x size:0x%04x\n",
+		      SPE_LDR_START, sizeof (spe_ldr));
+	memcpy (spe_ld_buf + SPE_LDR_START, &spe_ldr, sizeof (spe_ldr));
+
+	/* Add SPE exec parameters */
+
+	spe_params.entry = ld_info.entry;
+	spe_params.gpr4[0] = argp64.ui[0];
+	spe_params.gpr4[1] = argp64.ui[1];
+	spe_params.gpr5[0] = envp64.ui[0];
+	spe_params.gpr5[1] = envp64.ui[1];
+
+	DEBUG_PRINTF ("Add exec param dst:0x%04x size:0x%04x\n",
+		      SPE_PARAM_START, sizeof (spe_params));
+	memcpy (spe_ld_buf + SPE_PARAM_START, &spe_params,
+		sizeof (spe_params));
+
+	/* Copy SPE image to SPUfs */
+	do
+	  {
+		  num = write (memfd, spe_ld_buf + count, LS_SIZE - count);
+		  if (num == -1)
+		    {
+			    DEBUG_PRINTF ("Transfer SPE ELF failed..\n");
+			    return -1;
+		    }
+
+		  count += num;
+	  }
+	while (count < LS_SIZE && num);
+	close (memfd);
+
+	/* Free the SPE Buffer */
+	free (spe_ld_buf);
+
+	strcpy (thread_info->pathname, pathname);
+	thread_info->thread_num = thread_num;
+
+	spe_thread_store[thread_num].state = BPA_THREAD_START;
+
+	rc = pthread_create (&thread, NULL, spe_thread, thread_info);
+
+	rc = thread_num;
+
+	while (spe_thread_store[thread_num].state != BPA_THREAD_IDLE)
+	  {
+		  thread_num++;
+	  }
+
+	spe_thread_store[rc].spe_thread = thread;
+
+	return rc;
+}
+
+int
+spe_wait (speid_t speid, int *status, int options)
+{
+	int rc;
+
+	DEBUG_PRINTF ("spu_wait(0x%x, %p, 0x%x)\n", speid, status, options);
+
+	rc = pthread_join (spe_thread_store[speid].spe_thread,
+			   (void **) status);
+
+	spe_thread_store[speid].state = BPA_THREAD_IDLE;
+
+	DEBUG_PRINTF ("Thread ended.\n");
+	return rc;
+}
+
+int
+spe_kill (speid_t speid, int sig)
+{
+	int rc;
+
+	rc = pthread_kill (spe_thread_store[speid].spe_thread, sig);
+
+	return rc;
+}
+
+/*
+ * Thread Code
+ * 
+ * */
+
+void *
+spe_thread (void *ptr)
+{
+	char runname[40], mboxname[40], pathname[40];
+	int runfd, mboxfd;
+	int num;
+	struct thread_start_info *thread_info;
+
+	struct spufs_run_arg
+	{
+		unsigned npc;	/* inout: Next Program Counter */
+		unsigned short code;	/* out:   SPU status */
+		unsigned short status;
+	};
+	struct spufs_run_arg arg = { SPE_LDR_PROG_start, };
+
+	DEBUG_PRINTF ("In thread\n");
+
+	thread_info = (struct thread_start_info *) ptr;
+
+	num = thread_info->thread_num;
+	strcpy (pathname, thread_info->pathname);
+
+	free (thread_info);
+
+	DEBUG_PRINTF ("thread: %i.\n", num);
+	DEBUG_PRINTF ("pathname: %s.\n", pathname);
+
+	sprintf (runname, "%s/run", pathname);
+	runfd = open (runname, O_RDONLY);
+	if (runfd < 0)
+	  {
+		  DEBUG_PRINTF ("Could not open SPU run file.\n");
+		  spe_thread_store[num].thread_return_value = -EINVAL;
+		  pthread_exit ((void *) spe_thread_store[num].
+				thread_return_value);
+	  }
+
+	sprintf (mboxname, "%s/m_box", pathname);
+	mboxfd = open (mboxname, O_RDONLY);
+	if (mboxfd < 0)
+	  {
+		  DEBUG_PRINTF ("Could not open SPE mailbox file.\n");
+		  spe_thread_store[num].thread_return_value = -EINVAL;
+		  pthread_exit ((void *) spe_thread_store[num].
+				thread_return_value);
+	  }
+	else
+	  {
+		  spe_thread_store[num].fd_mbox = mboxfd;
+	  }
+
+	spe_thread_store[num].state = BPA_THREAD_RUNNING;
+
+	int ret = ioctl (runfd, _IOWR ('s', 0, struct spufs_run_arg), &arg)
+		& 0xff;
+	if (ret < 0)
+	  {
+		  DEBUG_PRINTF ("Could not ioctl() on SPE run file.\n");
+		  spe_thread_store[num].thread_return_value = -EINVAL;
+		  pthread_exit ((void *) spe_thread_store[num].
+				thread_return_value);
+	  }
+
+	close (runfd);
+
+	spe_thread_store[num].state = BPA_THREAD_ENDED;
+
+	DEBUG_PRINTF ("SPE thread result: %08x:%04x:%04x\n", arg.npc,
+		      arg.code, arg.status);
+
+	spe_thread_store[num].thread_return_value = arg.code;
+	return ((void *) spe_thread_store[num].thread_return_value);
+}
--- linux-cg.orig/Documentation/bpa/libspu/bpathread.h	1969-12-31 19:00:00.000000000 -0500
+++ linux-cg/Documentation/bpa/libspu/bpathread.h	2005-05-13 11:37:31.484922680 -0400
@@ -0,0 +1,47 @@
+/*
+ * libbpathread - A wrapper library to adapt the JSRE SPU usage model to SPUFS 
+ * Copyright (C) 2005 IBM Corp. 
+ *
+ * This library is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU Lesser General Public License as published by 
+ * the Free Software Foundation; either version 2.1 of the License, 
+ * or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful, but 
+ *  WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY 
+ *  or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public 
+ *  License for more details.
+ *
+ *   You should have received a copy of the GNU Lesser General Public License 
+ *   along with this library; if not, write to the Free Software Foundation, 
+ *   Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+#ifndef _bpathread_h_
+#define _bpathread_h_
+
+typedef int speid_t;
+
+/* APIs for SPE threads.
+ */
+
+extern speid_t spe_create_thread (int gid, void *start,
+				  void *argp, void *envp,
+				  int mask, int flags);
+
+extern int spe_wait (speid_t speid, int *status, int options);
+
+extern int spe_kill (speid_t speid, int sig);
+
+
+/* SPE-thread internals
+ */
+
+void *spe_thread (void *ptr);
+
+#define BPA_THREAD_IDLE     0
+#define BPA_THREAD_START    1
+#define BPA_THREAD_RUNNING  2
+#define BPA_THREAD_ENDED    3
+
+
+#endif
--- linux-cg.orig/Documentation/bpa/libspu/elf_loader.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-cg/Documentation/bpa/libspu/elf_loader.c	2005-05-13 11:37:31.484922680 -0400
@@ -0,0 +1,130 @@
+/* libbpathread - A wrapper library to adapt the JSRE SPU usage model to SPUFS
+ * Copyright (C) 2005 IBM Corp.
+ * This library is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU Lesser General Public License as published by
+ * the Free Software Foundation; either version 2.1 of the License,
+ * or (at your option) any later version.
+ *  This library is distributed in the hope that it will be useful, but
+ *  WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
+ *  or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public
+ *  License for more details.
+ *   You should have received a copy of the GNU Lesser General Public License
+ *   along with this library; if not, write to the Free Software Foundation,
+ *   Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+
+#include <stdlib.h>
+#include <stdio.h>
+#include <sys/mman.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <string.h>
+#include <malloc.h>
+#include <errno.h>
+#include <elf.h>
+#include <elf_loader.h>
+
+#define __PRINTF(fmt, args...) { fprintf(stderr,fmt , ## args); }
+#ifdef DEBUG
+#define DEBUG_PRINTF(fmt, args...) __PRINTF(fmt , ## args)
+#else
+#define DEBUG_PRINTF(fmt, args...)
+#endif
+
+int
+load_spe_elf (void *elf_start, void *ld_buffer, struct spe_ld_info *ld_info)
+{
+	Elf32_Ehdr *ehdr;
+	static const unsigned char expected[EI_PAD] = {
+		[EI_MAG0] = ELFMAG0,
+		[EI_MAG1] = ELFMAG1,
+		[EI_MAG2] = ELFMAG2,
+		[EI_MAG3] = ELFMAG3,
+		[EI_CLASS] = ELFCLASS32,
+		[EI_DATA] = ELFDATA2MSB,
+		[EI_VERSION] = EV_CURRENT,
+		[EI_OSABI] = ELFOSABI_SYSV,
+		[EI_ABIVERSION] = 0
+	};
+	Elf32_Phdr *phdr;
+	Elf32_Phdr *ph;
+	int num_load_seg = 0;
+
+	DEBUG_PRINTF ("load_spe_elf(%p, %p)\n", elf_start, ld_buffer);
+	ehdr = (Elf32_Ehdr *) elf_start;
+
+	/* Validate ELF */
+	if (memcmp (ehdr->e_ident, expected, EI_PAD) != 0)
+	  {
+		  DEBUG_PRINTF ("invalid ELF header.\n");
+		  DEBUG_PRINTF ("expected 0x%016llX != 0x%016llX\n",
+				*(long long *) expected, *(long long *) ehdr);
+		  errno = EINVAL;
+		  return -errno;
+	  }
+
+	/* Validate the machine type */
+	if (ehdr->e_machine != 0x17)
+	  {
+		  DEBUG_PRINTF ("not an SPE ELF object");
+		  errno = EINVAL;
+		  return -errno;
+	  }
+
+	/* Validate ELF object type. */
+	if (ehdr->e_type != ET_EXEC)
+	  {
+		  DEBUG_PRINTF ("invalid SPE ELF type.\n");
+		  DEBUG_PRINTF ("SPU type %d != %d\n", ehdr->e_type, ET_EXEC);
+		  errno = EINVAL;
+		  DEBUG_PRINTF ("parse_spu_elf(): errno=%d.\n", errno);
+		  return -errno;
+	  }
+
+	/* Start processing headers */
+	phdr = (Elf32_Phdr *) ((char *) ehdr + ehdr->e_phoff);
+
+	/*
+	 * Load all PT_LOAD segments onto the SPU local store buffer.
+	 */
+	DEBUG_PRINTF ("Segments: 0x%x\n", ehdr->e_phnum);
+	for (ph = phdr; ph < &phdr[ehdr->e_phnum]; ++ph)
+	  {
+		  switch (ph->p_type)
+		    {
+		    case PT_LOAD:
+			    /* DEBUG_PRINTF ("PT_LOAD)\n"); */
+			    /* Only LOAD non-zero segments. */
+			    if (ph->p_filesz)
+			      {
+				      num_load_seg++;
+
+				      DEBUG_PRINTF
+					      ("SPE_LOAD %p (0x%x) -> %p (0x%x) (%i bytes)\n",
+					       ld_buffer + ph->p_vaddr,
+					       ph->p_vaddr,
+					       elf_start + ph->p_paddr,
+					       ph->p_paddr, ph->p_filesz);
+				      memcpy (ld_buffer + ph->p_vaddr,
+					      elf_start + ph->p_paddr,
+					      ph->p_filesz);
+			      }
+			    break;
+		    }
+	  }
+	if (num_load_seg == 0)
+	  {
+		  DEBUG_PRINTF ("no segments to load");
+		  errno = EINVAL;
+		  return -errno;
+	  }
+
+	/* Remember where the code wants to be started */
+	ld_info->entry = ehdr->e_entry;
+	DEBUG_PRINTF ("entry = 0x%x\n", ehdr->e_entry);
+
+	return 0;
+
+}
--- linux-cg.orig/Documentation/bpa/libspu/elf_loader.h	1969-12-31 19:00:00.000000000 -0500
+++ linux-cg/Documentation/bpa/libspu/elf_loader.h	2005-05-13 11:37:31.485922528 -0400
@@ -0,0 +1,40 @@
+/*
+ * libbpathread - A wrapper library to adapt the JSRE SPU usage model to SPUFS
+ * Copyright (C) 2005 IBM Corp.
+ *
+ * This library is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU Lesser General Public License as published by
+ * the Free Software Foundation; either version 2.1 of the License,
+ * or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful, but
+ *  WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
+ *  or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public
+ *  License for more details.
+ *
+ *   You should have received a copy of the GNU Lesser General Public License
+ *   along with this library; if not, write to the Free Software Foundation,
+ *   Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+
+#define LS_SIZE                       0x40000	/* 256K (in bytes) */
+
+#define SPE_LDR_PROG_start    (LS_SIZE - 512)	// location of spu_ld.so prog
+#define SPE_LDR_PARAMS_start  (LS_SIZE - 128)	// location of spu_ldr_params
+
+typedef union
+{
+	unsigned long long ull;
+	unsigned int ui[2];
+} addr64;
+
+struct spe_ld_info
+{
+	unsigned int entry;	/* Entry point of SPU image                 */
+};
+
+/*
+ * Global API : */
+
+int load_spe_elf (void *elf_start, void *ld_buffer,
+		  struct spe_ld_info *ld_info);
--- linux-cg.orig/Documentation/bpa/libspu/spe_exec.h	1969-12-31 19:00:00.000000000 -0500
+++ linux-cg/Documentation/bpa/libspu/spe_exec.h	2005-05-13 11:37:31.485922528 -0400
@@ -0,0 +1,43 @@
+/*
+ * libbpathread - A wrapper library to adapt the JSRE SPU usage model to SPUFS
+ * Copyright (C) 2005 IBM Corp.
+ *
+ * This library is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU Lesser General Public License as published by
+ * the Free Software Foundation; either version 2.1 of the License,
+ * or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful, but
+ *  WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
+ *  or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public
+ *  License for more details.
+ *
+ *   You should have received a copy of the GNU Lesser General Public License
+ *   along with this library; if not, write to the Free Software Foundation,
+ *   Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+
+#ifndef _spe_exec_h_
+#define _spe_exec_h_
+
+#define SPE_LDR_START 0x0003fe00
+#define SPE_PARAM_START 0x0003ff80
+
+
+/*
+ * struct spe_exec_params:
+ *
+ * Holds the (per thread) parameters for the spe program
+*/
+
+struct spe_exec_params
+{
+	unsigned int entry;	/* entry point for application. */
+	unsigned int gpr3[4];	/* initial setting for $3 */
+	unsigned int gpr4[4];	/* initial setting for $4 */
+	unsigned int gpr5[4];	/* initial setting for $5 */
+	unsigned int gpr6[4];	/* initial setting for $6 */
+
+};
+
+#endif
--- linux-cg.orig/Documentation/bpa/libspu/test/start-stop/Makefile	1969-12-31 19:00:00.000000000 -0500
+++ linux-cg/Documentation/bpa/libspu/test/start-stop/Makefile	2005-05-13 11:37:31.486922376 -0400
@@ -0,0 +1,43 @@
+#*
+#* libbpathread - A wrapper library to adapt the JSRE SPU usage model to SPUFS
+#* Copyright (C) 2005 IBM Corp.
+#*
+#* This library is free software; you can redistribute it and/or modify it
+#* under the terms of the GNU Lesser General Public License as published by
+#* the Free Software Foundation; either version 2.1 of the License,
+#* or (at your option) any later version.
+#*
+#*  This library is distributed in the hope that it will be useful, but
+#*  WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
+#*  or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public
+#*  License for more details.
+#*
+#*   You should have received a copy of the GNU Lesser General Public License
+#*   along with this library; if not, write to the Free Software Foundation,
+#*   Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+#*
+
+CC := gcc
+SPECC := spu-gcc
+CTAGS = ctags
+
+CFLAGS := -O2 -m32 -Wall -I../.. -I../../include -g
+SPECFLAGS := -O2 -Wall -I../../include
+
+LDFLAGS := -m32
+LIBS := -L../.. -l bpathread -l pthread
+
+SPE_OBJS := spe-start-stop
+OBJS := ppe-start-stop
+
+all: $(OBJS) $(SPE_OBJS)
+
+clean:
+	rm -f $(OBJS) $(SPE_OBJS)
+
+ppe-start-stop: ppe-start-stop.c
+	$(CC) -o $@ $< $(CFLAGS) $(LDFLAGS) $(LIBS)
+
+spe-start-stop: spe-start-stop.c
+	$(SPECC) $(SPECFLAGS) -o $@ $<
+
--- linux-cg.orig/Documentation/bpa/libspu/test/start-stop/ppe-start-stop.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-cg/Documentation/bpa/libspu/test/start-stop/ppe-start-stop.c	2005-05-13 11:37:31.487922224 -0400
@@ -0,0 +1,89 @@
+/*
+ * libbpathread - A wrapper library to adapt the JSRE SPU usage model to SPUFS
+ * Copyright (C) 2005 IBM Corp.
+ *
+ * This library is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU Lesser General Public License as published by
+ * the Free Software Foundation; either version 2.1 of the License,
+ * or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful, but
+ *  WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
+ *  or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public
+ *  License for more details.
+ *
+ *   You should have received a copy of the GNU Lesser General Public License
+ *   along with this library; if not, write to the Free Software Foundation,
+ *   Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+
+#include <fcntl.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+
+#include <sys/types.h>
+#include <sys/stat.h>
+
+#include <bpathread.h>
+
+
+void *load_binary(char *bin)
+{
+	int binfd;
+	struct stat statbuf;
+	int ret;
+	void *buf;
+	void *pos;
+	off_t size;
+
+	binfd = open(bin, O_RDONLY);	
+	if (binfd < 0)
+		return NULL;
+
+	ret = fstat(binfd, &statbuf);
+	if (ret < 0)
+		return NULL;
+
+	buf = malloc(statbuf.st_size + 16);
+	if (!buf)
+		return NULL;
+
+	buf = (void *)(((unsigned long)buf + 16) & ~15);
+	pos = buf;
+	size = statbuf.st_size;
+
+	do {
+		ret = read(binfd, pos, size);
+		if (ret > 0) {
+			pos += ret;
+			size -= ret;
+		}
+		if (ret < 0)
+			return NULL;
+	} while (size > 0 && ret);
+
+	return buf;
+}
+
+int main(int argc, char* argv[])
+{
+	char *binary;
+	int threadnum,status;
+	
+	if (argc != 2) {
+		printf("usage: pu spu-executable\n");
+		exit(1);
+	}
+		
+	binary = load_binary(argv[1]);
+	if (!binary)
+		exit(2);
+	
+        threadnum = spe_create_thread(0, binary, NULL, NULL, 0, 0);
+
+	spe_wait(threadnum,&status,0);
+
+	printf("Thread returned status: %04x\n",status);
+	return 0;
+}
--- linux-cg.orig/Documentation/bpa/libspu/test/start-stop/spe-start-stop.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-cg/Documentation/bpa/libspu/test/start-stop/spe-start-stop.c	2005-05-13 11:37:31.487922224 -0400
@@ -0,0 +1,23 @@
+/*
+ * libbpathread - A wrapper library to adapt the JSRE SPU usage model to SPUFS
+ * Copyright (C) 2005 IBM Corp.
+ *
+ * This library is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU Lesser General Public License as published by
+ * the Free Software Foundation; either version 2.1 of the License,
+ * or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful, but
+ *  WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
+ *  or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public
+ *  License for more details.
+ *
+ *   You should have received a copy of the GNU Lesser General Public License
+ *   along with this library; if not, write to the Free Software Foundation,
+ *   Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+
+int main(void)
+{
+	return 0;
+}
--- linux-cg.orig/Documentation/bpa/libspu/tools/README	1969-12-31 19:00:00.000000000 -0500
+++ linux-cg/Documentation/bpa/libspu/tools/README	2005-05-13 11:37:31.487922224 -0400
@@ -0,0 +1,8 @@
+Contents of this Directory
+
+elfspe-register:
+Script to register a SPE-ELF loading app with binfmt_misc.
+
+embedspu:
+Script to attach a SPE-ELF object to an executable.
+
--- linux-cg.orig/Documentation/bpa/libspu/tools/elfspe-register	1969-12-31 19:00:00.000000000 -0500
+++ linux-cg/Documentation/bpa/libspu/tools/elfspe-register	2005-05-13 11:37:31.488922072 -0400
@@ -0,0 +1,4 @@
+#!/bin/sh
+
+echo ':spu:M::\x7fELF\x01\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x17::/home/uweigand/runspu:' > /proc/sys/fs/binfmt_misc/register
+
--- linux-cg.orig/Documentation/bpa/libspu/tools/embedspu	1969-12-31 19:00:00.000000000 -0500
+++ linux-cg/Documentation/bpa/libspu/tools/embedspu	2005-05-13 11:37:31.488922072 -0400
@@ -0,0 +1,56 @@
+#/bin/sh 
+
+#
+# Embed SPE ELF executable into PPE object file, and define a
+# global pointer variable refering to the embedded file.
+#
+# Usage: embedspu [flags] symbol_name input_filename output_filename
+#
+#        input_filename:  SPE ELF executable to be embedded
+#        output_filename: Resulting PPE object file
+#        symbol_name:     Name of global pointer variable to be defined
+#        flags:           GCC flags defining PPE object file format
+#                         (e.g. -m32 or -m64)
+#
+
+# Argument parsing
+SYMBOL=
+INFILE=
+OUTFILE=
+FLAGS=
+
+while [ -n "$1" ]; do
+  case $1 in
+    -*) FLAGS="${FLAGS} $1"
+	shift ;;
+    *)  if [ -z $SYMBOL ]; then
+	  SYMBOL=$1
+	elif [ -z $INFILE ]; then
+	  INFILE=$1
+	elif [ -z $OUTFILE ]; then
+	  OUTFILE=$1
+	fi
+	shift ;;
+  esac
+done
+
+if [ -z "$SYMBOL" -o -z "$INFILE" -o -z "$OUTFILE" ]; then
+  echo "Usage: $0 [symbol_name] [input_filename] [output_filename]"
+  exit 1
+fi
+
+# The section name as defined by the SPU ABI
+SECTION=.spuelf.${INFILE}
+
+# Build object file holding pointer to embedded section
+gcc ${FLAGS} -x c -c -o ${OUTFILE} - <<EOF || exit 1
+static char __section__[] __attribute__((section("${SECTION}"), aligned(128))) = { };
+void *${SYMBOL} = __section__;
+EOF
+
+# Add embedded section contents into object file
+objcopy --add-section ${SECTION}=${INFILE} \
+        --set-section-flags ${SECTION}=alloc,load,readonly,data,contents \
+        --strip-unneeded ${OUTFILE} \
+  || rm -f ${OUTFILE}
+
