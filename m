Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262104AbULQSOT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262104AbULQSOT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 13:14:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262101AbULQSOT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 13:14:19 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:62678 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S262110AbULQSKf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 13:10:35 -0500
Message-Id: <200412171810.iBHIAQP3026387@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.1 10/11/2004 with nmh-1.1-RC3
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.10-rc3-mm1-V0.7.33-03 and NVidia wierdness, with workaround... 
In-Reply-To: Your message of "Fri, 17 Dec 2004 12:03:31 EST."
             <1103303011.12664.58.camel@localhost.localdomain> 
From: Valdis.Kletnieks@vt.edu
References: <200412161626.iBGGQ5CI020770@turing-police.cc.vt.edu> <1103300362.12664.53.camel@localhost.localdomain>
            <1103303011.12664.58.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_36811946P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 17 Dec 2004 13:10:26 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_36811946P
Content-Type: multipart/mixed ;
	boundary="==_Exmh_283789910"

This is a multipart MIME message.

--==_Exmh_283789910
Content-Type: text/plain; charset=us-ascii

On Fri, 17 Dec 2004 12:03:31 EST, Steven Rostedt said:

> Update: I just tried some of my fixes to the rc3-mm1 kernel, and that
> worked without a problem.  But I still didn't get by the sleep problem
> in Ingo's RT patch.  Did you get further, and did you make fixes to both
> the nvidia module as well as the kernel?

I have to admit I haven't *hit* a sleep problem specific to Ingo's code, unless
you have a different config/hardware and my BKL wierdness and your sleep are
2 different manifestations of the same problem.  Or maybe they're 2 different
bugs... ;)

I'm running Ingo's patch and the nvidia 6629 drivers as I'm typing this. Given
you had to fool with pgd_offset_k and friends, you're probably trying an older
driver (6111?) and should upgrade - the 6629 picked up a *bunch* of 2.6-related
fixes.  Maybe 6629 fixed your sleep issue?

I needed to make 1 small patch to the nvidia code to support the 4-level
page table code in -mm, and one small kernel patch from Zander at NVidia to work
around another issue.  Both attached.  You apparently already have the GPL-export
fix.  If you're not running Ingo's patch, you'll need the non-NVidia-related
patch to fix the ioctl-cleanup.patch breakage (Ingo rolled that one into -RT),
but if you got it to come up at all in -rc3-mm1, you have that one too (but those
of you playing along at home will need it)...

Modulo those patches, the only thing I've hit since 2.6.10-rc1-mm1 or so is
this BKL strangeness, and that only bites me in -RT with one configuration...

YMMV, binary modules are evil, Works For Me with 6629 on my Dell laptop, and
all that. If this isn't enough to get it working for you, your best bet is
probably to wander over to

http://www.nvnews.net/vbulletin/forumdisplay.php?s=&forumid=14

and see if Zander has new words of wisdom (that's where I found the VM-IO patch).


--==_Exmh_283789910
Content-Type: text/plain ; name="VM_IO.diff"; charset=us-ascii
Content-Description: VM_IO.diff
Content-Disposition: attachment; filename="VM_IO.diff"

--- linux-2.6.10-rc2-mm2/mm/mmap.c.nvidia	2004-11-18 22:10:39.259326934 -0500
+++ linux-2.6.10-rc2-mm2/mm/mmap.c	2004-11-18 22:22:46.877972513 -0500
@@ -1026,7 +1026,8 @@ out:	
 	__vm_stat_account(mm, vm_flags, file, len >> PAGE_SHIFT);
 	if (vm_flags & VM_LOCKED) {
 		mm->locked_vm += len >> PAGE_SHIFT;
-		make_pages_present(addr, addr + len);
+		if (!(vm_flags & VM_IO))
+			make_pages_present(addr, addr + len);
 	}
 	if (flags & MAP_POPULATE) {
 		up_write(&mm->mmap_sem);

--==_Exmh_283789910
Content-Type: text/plain ; name="nv.diff"; charset=us-ascii
Content-Description: nv.diff
Content-Disposition: attachment; filename="nv.diff"

diff -upr NVIDIA-Linux-x86-1.0-6629-pkg1/usr/src/nv/nv.c ../src/NVIDIA-Linux-x86-1.0-6629-pkg1/usr/src/nv/nv.c
--- NVIDIA-Linux-x86-1.0-6629-pkg1/usr/src/nv/nv.c	2004-11-03 16:53:00.000000000 -0500
+++ ../src/NVIDIA-Linux-x86-1.0-6629-pkg1/usr/src/nv/nv.c	2004-11-10 16:18:29.000000000 -0500
@@ -2492,6 +2492,7 @@ _get_phys_address(
 )
 {
     struct mm_struct *mm;
+    pml4_t *pg_l4_dir;
     pgd_t *pg_dir;
     pmd_t *pg_mid_dir;
     pte_t *pte;
@@ -2500,10 +2501,15 @@ _get_phys_address(
     mm = (kern) ? &init_mm : current->mm;
     spin_lock(&mm->page_table_lock);
 
-    if (kern) pg_dir = pgd_offset_k(address);
-    else pg_dir = pgd_offset(mm, address);
+    if (kern) pg_l4_dir = pml4_offset_k(address);
+    else pg_l4_dir = pml4_offset(mm, address);
 
-    if (!pg_dir || pgd_none(*pg_dir))
+    if (!pg_l4_dir || pml4_none(*pg_l4_dir))
+        goto failed;
+
+    pg_dir = pml4_pgd_offset_k(pg_l4_dir,address);
+
+    if (pgd_none(*pg_dir))
         goto failed;
 
     NV_PMD_OFFSET(address, pg_dir, pg_mid_dir);

--==_Exmh_283789910--


--==_Exmh_36811946P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFBwyEScC3lWbTT17ARAkKpAKCF9j4XSk7CGCLY8Niqe3saF8RpwwCgghg4
DFQXSzn0V8UwCIUGCkpl4MQ=
=9jHK
-----END PGP SIGNATURE-----

--==_Exmh_36811946P--
