Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262705AbSIPQAI>; Mon, 16 Sep 2002 12:00:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262716AbSIPQAI>; Mon, 16 Sep 2002 12:00:08 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:44256 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S262705AbSIPQAE>; Mon, 16 Sep 2002 12:00:04 -0400
Message-ID: <3D8600DD.1010707@us.ibm.com>
Date: Mon, 16 Sep 2002 09:03:41 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (compatible; MSIE5.5; Windows 98;
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Samuel Flory <sflory@rackable.com>, Stephen Lord <lord@sgi.com>,
       Austin Gonyou <austin@coremetrics.com>,
       Christian Guggenberger 
	<christian.guggenberger@physik.uni-regensburg.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>, linux-xfs@oss.sgi.com
Subject: Re: 2.4.20pre5aa2
References: <20020911201602.A13655@pc9391.uni-regensburg.de> <1031768655.24629.23.camel@UberGeek.coremetrics.com> <20020911184111.GY17868@dualathlon.random> <3D81235B.6080809@rackable.com> <20020913002316.GG11605@dualathlon.random> <1031878070.1236.29.camel@snafu> <20020913005440.GJ11605@dualathlon.random> <3D8149F6.9060702@rackable.com> <20020913125345.GO11605@dualathlon.random>
X-Enigmail-Version: 0.65.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig55ED74C752FF075D8DF4EEE1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig55ED74C752FF075D8DF4EEE1
Content-Type: multipart/mixed;
 boundary="------------010502070400000809040600"

This is a multi-part message in MIME format.
--------------010502070400000809040600
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Andrea Arcangeli wrote:
 > On Thu, Sep 12, 2002 at 07:14:14PM -0700, Samuel Flory wrote:
 >
 >>Andrea Arcangeli wrote:
 >>
 >>>On Thu, Sep 12, 2002 at 07:47:48PM -0500, Stephen Lord wrote:
 >>>
 >>>>How much memory is in the machine by the way? And Andrea, is the
 >>>>vmalloc space size reduced in the 3G user space configuration?
 >>>
 >>>it's not reduced, it's the usual 128m.
 >>>
 >>>BTW, I forgot to say that to really take advantage of CONFIG_2G one
 >>>should increase __VMALLOC_RESERVE too, it's not directly in function of
 >>>the CONFIG_2G.
 >>>
 >>
 >>So how much do you recommend increasing it?   Currently it's:
 >>include/asm-i386/page.h:#define __VMALLOC_RESERVE       (128 << 20)
 >>include/asm/page.h:#define __VMALLOC_RESERVE    (128 << 20)
 >
 >
 > you can try to compile with CONFIG_3G and to set __VMALLOC_RESERVE to
 > (512 << 20) and see if it helps. If it only happens a bit later then
 > it's most probably an address space leak, should be easy to track down
 > some debugging instrumentation.

I just produced this little patch for 2.5.  It should provide a bit of the extra
information that you were looking for.  It adds some entries to /proc/meminfo
that look like this:

VMalTotal:	92123 kB
VmalUsed:	 1264 kB
VMalChunk:	80315 kB

Total available, total used, and largest chunk available.

It is simple enough that a backport shouldn't be any problem at all.  Anybody
interested?

-- 
Dave Hansen
haveblue@us.ibm.com

--------------010502070400000809040600
Content-Type: text/plain;
 name="vmalloc-stats-2.5.34-mm4-2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="vmalloc-stats-2.5.34-mm4-2.patch"

diff -ur linux-2.5.34-mm4/fs/proc/proc_misc.c linux-2.5.34-mm4-vmalloc-stats/fs/proc/proc_misc.c
--- linux-2.5.34-mm4/fs/proc/proc_misc.c	Sat Sep 14 21:23:54 2002
+++ linux-2.5.34-mm4-vmalloc-stats/fs/proc/proc_misc.c	Sat Sep 14 22:38:12 2002
@@ -38,6 +38,7 @@
 #include <linux/smp_lock.h>
 #include <linux/seq_file.h>
 #include <linux/times.h>
+#include <linux/vmalloc.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
@@ -128,6 +129,40 @@
 	return proc_calc_metrics(page, start, off, count, eof, len);
 }
 
+struct vmalloc_info {
+	unsigned long used;
+	unsigned long largest_chunk;
+};
+
+static struct vmalloc_info get_vmalloc_info(void)
+{
+	unsigned long prev_end = VMALLOC_START;
+	struct vm_struct* vma;
+	struct vmalloc_info vmi;
+	vmi.used = 0;
+
+	read_lock(&vmlist_lock);
+	
+	if(!vmlist) 
+		vmi.largest_chunk = (VMALLOC_END-VMALLOC_START);
+	else 
+		vmi.largest_chunk = 0;
+	
+	for (vma = vmlist; vma; vma = vma->next) {
+		unsigned long free_area_size = 
+			(unsigned long)vma->addr - prev_end;
+		vmi.used += vma->size;
+		if (vmi.largest_chunk < free_area_size ) 
+			vmi.largest_chunk = free_area_size;
+		prev_end = vma->size + (unsigned long)vma->addr;
+	}
+	if(VMALLOC_END-prev_end > vmi.largest_chunk)
+		vmi.largest_chunk = VMALLOC_END-prev_end;
+	
+	read_unlock(&vmlist_lock);
+	return vmi;
+}
+
 extern atomic_t vm_committed_space;
 
 static int meminfo_read_proc(char *page, char **start, off_t off,
@@ -138,6 +173,8 @@
 	struct page_state ps;
 	unsigned long inactive;
 	unsigned long active;
+	unsigned long vmtot;
+	struct vmalloc_info vmi;
 
 	get_page_state(&ps);
 	get_zone_counts(&active, &inactive);
@@ -150,6 +187,11 @@
 	si_swapinfo(&i);
 	committed = atomic_read(&vm_committed_space);
 
+	vmtot = (VMALLOC_END-VMALLOC_START)>>10;
+	vmi = get_vmalloc_info();
+	vmi.used >>= 10;
+	vmi.largest_chunk >>= 10;
+
 	/*
 	 * Tagged format, for easy grepping and expansion.
 	 */
@@ -174,7 +216,10 @@
 		"Slab:         %8lu kB\n"
 		"Committed_AS: %8u kB\n"
 		"PageTables:   %8lu kB\n"
-		"ReverseMaps:  %8lu\n",
+		"ReverseMaps:  %8lu\n"
+		"VmalTotal:    %8lu kB\n"
+		"VmalUsed:     %8lu kB\n"
+		"VmalChunk:    %8lu kB\n",
 		K(i.totalram),
 		K(i.freeram),
 		K(i.sharedram),
@@ -195,7 +240,10 @@
 		K(ps.nr_slab),
 		K(committed),
 		K(ps.nr_page_table_pages),
-		ps.nr_reverse_maps
+		ps.nr_reverse_maps,
+		vmtot,
+		vmi.used,
+		vmi.largest_chunk
 		);
 
 #ifdef CONFIG_HUGETLB_PAGE

--------------010502070400000809040600--

--------------enig55ED74C752FF075D8DF4EEE1
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9hgDgzEzj1xe3kRwRAnnSAJ9k24P5uAG4Vt4clXIAoJIaXStaJwCfbGOX
fYjGEmkIOfEBLzm5wtbktWA=
=BQRo
-----END PGP SIGNATURE-----

--------------enig55ED74C752FF075D8DF4EEE1--

