Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286557AbSAFAru>; Sat, 5 Jan 2002 19:47:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286584AbSAFArk>; Sat, 5 Jan 2002 19:47:40 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:54434 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S286557AbSAFAra>; Sat, 5 Jan 2002 19:47:30 -0500
Date: Sat, 5 Jan 2002 17:47:04 -0700
Message-Id: <200201060047.g060l4p08166@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Jason Thomas <jason@topic.com.au>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, marcelo@conectiva.com.br
Subject: Re: oops in devfs
In-Reply-To: <20020103224744.GB29846@topic.com.au>
In-Reply-To: <20020103014507.GB19702@topic.com.au>
	<200201030724.g037ONj04041@vindaloo.ras.ucalgary.ca>
	<20020103224744.GB29846@topic.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jason Thomas writes:
> Okay same thing.
> 
> On Thu, Jan 03, 2002 at 12:24:23AM -0700, Richard Gooch wrote:
> > Grab devfs-patch-v199.6 from your local kernel.org mirror site and try
> > again. If you still have the same problem, send the new ksymoops
> > output as well as *complete* kernel boot logs.
> 
> they are attached.
[...]
> LVM version 1.0.1-rc4(ish)(03/10/2001)

Ah! You're using LVM! There are known bugs in LVM which cause memory
corruptions. I told Heinz about this on 16-DEC, but it appears the CVS
tree hasn't been updated yet. So grab the latest CVS tree (which fixes
some bugs) and then apply the appended patch (which fixes more
bugs). You definately need both. The patch should be applied in the
drivers/md directory.

I'm afraid that you will need to manually apply this patch, because
the LVM CVS tree has a pile of #ifdef CONFIG_DEVFS_FS's in it, whereas
the LVM code in the kernel tree (which is what I generated the patch
against) has these #ifdef's stripped.

I've offered to Marcelo to take the current LVM CVS, apply my fixes
and send him a patch. That would avoid this problem coming up again
(and again). I haven't had a response yet. Perhaps he's still
recovering from his holiday. I hope so, because that probably means he
enjoyed himself :-)

Marcelo: will you accept such a patch?

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca

--- lvm-fs.c~	Sun Nov 11 11:09:32 2001
+++ lvm-fs.c	Sun Dec 16 17:37:32 2001
@@ -30,6 +30,7 @@
  *    04/10/2001 - corrected devfs_register() call in lvm_init_fs()
  *    11/04/2001 - don't devfs_register("lvm") as user-space always does it
  *    10/05/2001 - show more of PV name in /proc/lvm/global
+ *    16/12/2001 - fix devfs unregister order and prevent duplicate unreg (REG)
  *
  */
 
@@ -138,7 +139,7 @@
 	int i;
 
 	devfs_unregister(ch_devfs_handle[vg_ptr->vg_number]);
-	devfs_unregister(vg_devfs_handle[vg_ptr->vg_number]);
+	ch_devfs_handle[vg_ptr->vg_number] = NULL;
 
 	/* remove lv's */
 	for(i = 0; i < vg_ptr->lv_max; i++)
@@ -148,6 +149,10 @@
 	for(i = 0; i < vg_ptr->pv_max; i++)
 		if(vg_ptr->pv[i]) lvm_fs_remove_pv(vg_ptr, vg_ptr->pv[i]);
 
+	/* must not remove directory before leaf nodes */
+	devfs_unregister(vg_devfs_handle[vg_ptr->vg_number]);
+	vg_devfs_handle[vg_ptr->vg_number] = NULL;
+
 	if(vg_ptr->vg_dir_pde) {
 		remove_proc_entry(LVM_LV_SUBDIR, vg_ptr->vg_dir_pde);
 		vg_ptr->lv_subdir_pde = NULL;
@@ -189,6 +194,7 @@
 
 void lvm_fs_remove_lv(vg_t *vg_ptr, lv_t *lv) {
 	devfs_unregister(lv_devfs_handle[MINOR(lv->lv_dev)]);
+	lv_devfs_handle[MINOR(lv->lv_dev)] = NULL;
 
 	if(vg_ptr->lv_subdir_pde) {
 		const char *name = _basename(lv->lv_name);
