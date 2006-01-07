Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030412AbWAGLSm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030412AbWAGLSm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 06:18:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030413AbWAGLSm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 06:18:42 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:11782 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1030412AbWAGLSl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 06:18:41 -0500
Date: Sat, 7 Jan 2006 12:18:27 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: linux-sparse@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: sparse triggers OOM killer
Message-ID: <20060107111827.GA16133@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="T4sUOijqQbZv57TR"
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I have played a little with attached patch.
It teach kbuild to check all files in one go in a directory when
sparsing the kernel.

I did a make allmodconfig and then ran:
make fs/xfs/ C=A

On my machine with 1 GB RAM it started a swap storm and later the OOM
triggered.
xfs is one of the bigger modules but still I was suprised to see it
causing such dramatic effect on my box.
[amd64 3.7 GHz  UP  1 GB RAM]

There was no oops or similar and sparse just exited after a while with
an errorcode (137).
Now I wonder if I have hit a bug in sparse or this is what I should
expect.

An easy way to try it out would be to run the sparse command from
attached file (it's long..).
If I can do anything to find out if this is a sparse bug or just
expected behaviour please say so.

	Sam

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index c33e62b..7e1b40a 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -85,16 +85,23 @@ __build: $(if $(KBUILD_BUILTIN),$(builti
 	@:
 
 # Linus' kernel sanity checking tool
-ifneq ($(KBUILD_CHECKSRC),0)
-  ifeq ($(KBUILD_CHECKSRC),2)
-    quiet_cmd_force_checksrc = CHECK   $<
-          cmd_force_checksrc = $(CHECK) $(CHECKFLAGS) $(c_flags) $< ;
-  else
-      quiet_cmd_checksrc     = CHECK   $<
-            cmd_checksrc     = $(CHECK) $(CHECKFLAGS) $(c_flags) $< ;
-  endif
+ifeq ($(KBUILD_CHECKSRC),1)
+  quiet_cmd_checksrc     = CHECK   $<
+        cmd_checksrc     = $(CHECK) $(CHECKFLAGS) $(c_flags) $< ;
+endif
+ifeq ($(KBUILD_CHECKSRC),2)
+  quiet_cmd_force_checksrc = CHECK   $<
+        cmd_force_checksrc = $(CHECK) $(CHECKFLAGS) $(c_flags) $< ;
+endif
+ifeq ($(KBUILD_CHECKSRC),A)
+  all-c-files = $(wildcard $(patsubst %.o, %.c, $(real-objs-y) $(real-objs-m)))
+  all-o-files = $(patsubst %.c, %.o, $(all-c-files))
+  all-o-flags = $(strip $(foreach o, $(all-o-files), $(CFLAGS_$(notdir $(o)))))
+  quiet_cmd_sparse-all = CHECK $(notdir $(all-c-files))
+        cmd_sparse-all = $(CHECK) $(CHECKFLAGS) \
+                                  $(c_flags) $(all-o-flags) $(all-c-files)
+  sparse-all = $(call cmd,sparse-all)
 endif
-
 
 # Compile C sources (.c)
 # ---------------------------------------------------------------------------
@@ -256,6 +263,7 @@ cmd_link_o_target = $(if $(strip $(obj-y
 		      rm -f $@; $(AR) rcs $@)
 
 $(builtin-target): $(obj-y) FORCE
+	$(call sparse-all)
 	$(call if_changed,link_o_target)
 
 targets += $(builtin-target)

--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=sparse-xfs
Content-Transfer-Encoding: quoted-printable

sparse -D__linux__ -Dlinux -D__STDC__ -Dunix -D__unix__ -Wbitwise -D__x86_6=
4__ -m64 -nostdinc -isystem /usr/lib/gcc/x86_64-pc-linux-gnu/3.4.4/include =
-Wp,-MD,fs/xfs/.built-in.o.d -nostdinc -isystem /usr/lib/gcc/x86_64-pc-linu=
x-gnu/3.4.4/include -D__KERNEL__ -Iinclude -include include/linux/autoconf.=
h -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fn=
o-common -ffreestanding -Os -fno-omit-frame-pointer -fno-optimize-sibling-c=
alls -g -march=3Dk8 -mno-red-zone -mcmodel=3Dkernel -pipe -fno-reorder-bloc=
ks -Wno-sign-compare -funit-at-a-time -mno-sse -mno-mmx -mno-sse2 -mno-3dno=
w -Wdeclaration-after-statement -Ifs/xfs -Ifs/xfs/linux-2.6 -funsigned-char=
 -DKBUILD_STR(s)=3D#s -DKBUILD_BASENAME=3DKBUILD_STR(built_in) -DKBUILD_MOD=
NAME=3DKBUILD_STR(built_in) fs/xfs/quota/xfs_dquot.c fs/xfs/quota/xfs_dquot=
_item.c fs/xfs/quota/xfs_trans_dquot.c fs/xfs/quota/xfs_qm_syscalls.c fs/xf=
s/quota/xfs_qm_bhv.c fs/xfs/quota/xfs_qm.c fs/xfs/quota/xfs_qm_stats.c fs/x=
fs/xfs_rtalloc.c fs/xfs/xfs_acl.c fs/xfs/linux-2.6/xfs_stats.c fs/xfs/linux=
-2.6/xfs_sysctl.c fs/xfs/linux-2.6/xfs_ioctl32.c fs/xfs/linux-2.6/xfs_expor=
t.c fs/xfs/xfs_alloc.c fs/xfs/xfs_alloc_btree.c fs/xfs/xfs_attr.c fs/xfs/xf=
s_attr_leaf.c fs/xfs/xfs_behavior.c fs/xfs/xfs_bit.c fs/xfs/xfs_bmap.c fs/x=
fs/xfs_bmap_btree.c fs/xfs/xfs_btree.c fs/xfs/xfs_buf_item.c fs/xfs/xfs_da_=
btree.c fs/xfs/xfs_dir.c fs/xfs/xfs_dir2.c fs/xfs/xfs_dir2_block.c fs/xfs/x=
fs_dir2_data.c fs/xfs/xfs_dir2_leaf.c fs/xfs/xfs_dir2_node.c fs/xfs/xfs_dir=
2_sf.c fs/xfs/xfs_dir_leaf.c fs/xfs/xfs_error.c fs/xfs/xfs_extfree_item.c f=
s/xfs/xfs_fsops.c fs/xfs/xfs_ialloc.c fs/xfs/xfs_ialloc_btree.c fs/xfs/xfs_=
iget.c fs/xfs/xfs_inode.c fs/xfs/xfs_inode_item.c fs/xfs/xfs_iocore.c fs/xf=
s/xfs_iomap.c fs/xfs/xfs_itable.c fs/xfs/xfs_dfrag.c fs/xfs/xfs_log.c fs/xf=
s/xfs_log_recover.c fs/xfs/xfs_mount.c fs/xfs/xfs_rename.c fs/xfs/xfs_trans=
=2Ec fs/xfs/xfs_trans_ail.c fs/xfs/xfs_trans_buf.c fs/xfs/xfs_trans_extfree=
=2Ec fs/xfs/xfs_trans_inode.c fs/xfs/xfs_trans_item.c fs/xfs/xfs_utils.c fs=
/xfs/xfs_vfsops.c fs/xfs/xfs_vnodeops.c fs/xfs/xfs_rw.c fs/xfs/xfs_dmops.c =
fs/xfs/xfs_qmops.c fs/xfs/linux-2.6/kmem.c fs/xfs/linux-2.6/xfs_aops.c fs/x=
fs/linux-2.6/xfs_buf.c fs/xfs/linux-2.6/xfs_file.c fs/xfs/linux-2.6/xfs_fs_=
subr.c fs/xfs/linux-2.6/xfs_globals.c fs/xfs/linux-2.6/xfs_ioctl.c fs/xfs/l=
inux-2.6/xfs_iops.c fs/xfs/linux-2.6/xfs_lrw.c fs/xfs/linux-2.6/xfs_super.c=
 fs/xfs/linux-2.6/xfs_vfs.c fs/xfs/linux-2.6/xfs_vnode.c fs/xfs/support/deb=
ug.c fs/xfs/support/move.c fs/xfs/support/uuid.c

--T4sUOijqQbZv57TR--
