Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261234AbUKSCsr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261234AbUKSCsr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 21:48:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261241AbUKSCsY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 21:48:24 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:51348 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S261236AbUKSCoW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 21:44:22 -0500
Subject: Re: 2.6.10-rc2-mm2 usb storage still oopses
From: Maneesh Soni <maneesh@in.ibm.com>
Reply-To: maneesh@in.ibm.com
To: Fabio Coatti <cova@ferrara.linux.it>
Cc: Greg KH <greg@kroah.com>, Pete Zaitcev <zaitcev@redhat.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
In-Reply-To: <200411190042.41199.cova@ferrara.linux.it>
References: <200411182203.02176.cova@ferrara.linux.it>
	 <20041118133557.72f3b369.akpm@osdl.org>
	 <20041118135809.3314ce41@lembas.zaitcev.lan>
	 <200411190042.41199.cova@ferrara.linux.it>
Content-Type: text/plain
Organization: IBM Linux Technology Center
Date: Thu, 18 Nov 2004 20:41:10 -0600
Message-Id: <1100832070.15138.10.camel@chavez.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Nov 18 20:35:24 kefk kernel: Unable to handle kernel NULL pointer dereference 
> at virtual address 00000050
> Nov 18 20:35:24 kefk kernel:  printing eip:
> Nov 18 20:35:24 kefk kernel: c0186e32
> Nov 18 20:35:24 kefk kernel: *pde = 00000000
> Nov 18 20:35:24 kefk kernel: Oops: 0000 [#1]
> Nov 18 20:35:24 kefk kernel: PREEMPT SMP
> Nov 18 20:35:24 kefk kernel: Modules linked in: nls_cp850 usb_storage md5 ipv6 
> rfcomm l2cap bluetooth snd_emu10k1 snd_rawmidi snd_seq_device snd_ac97_codec
> snd_pcm snd_timer snd_page_alloc snd_util_mem snd_hwdep snd soundcore 
> ipt_REJECT iptable_filter ip_tables loop nls_utf8 ide_cd i2c_dev w83781d 
> i2c_sensor i2c_isa i2c_i801 isofs zlib_inflate e1000 parport_pc ppa parport 
> ehci_hcd usblp uhci_hcd genrtc
> Nov 18 20:35:24 kefk kernel: CPU:    0
> Nov 18 20:35:24 kefk kernel: EIP:    0060:[sysfs_hash_and_remove+174/241]    
> Not tainted VLI
> Nov 18 20:35:24 kefk kernel: EIP:    0060:[<c0186e32>]    Not tainted VLI
> Nov 18 20:35:24 kefk kernel: EFLAGS: 00010246   (2.6.10-rc2-mm2)
> Nov 18 20:35:24 kefk kernel: EIP is at sysfs_remove_dir+0x1d/0x10b
> Nov 18 20:35:24 kefk kernel: eax: f6e79988   ebx: f6e79988   ecx: c18ff480   
> edx: c1000000
> Nov 18 20:35:24 kefk kernel: esi: f78b8b00   edi: 00000000   ebp: f7bd5d24   
> esp: c1b7ddd8
> Nov 18 20:35:24 kefk kernel: ds: 007b   es: 007b   ss: 0068

The following patch should avoid the sysfs_remove_dir() oops you are
seeing while device removal. It anyway fixes the obvious error and is
needed. But it will not make any change to the first error you are
seeing while connecting the device.

Andrew, Greg, please include this.

Thanks
Maneesh


o Following patch avoids the sysfs_remove_dir() oops when it is passed
  a kobject with NULL dentry.

Signed-off-by: Maneesh Soni <maneesh@in.ibm.com>
---

 linux-2.6.10-rc2-bk3-maneesh/fs/sysfs/dir.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

diff -puN fs/sysfs/dir.c~fix-sysfs_remove_dir-oops fs/sysfs/dir.c
--- linux-2.6.10-rc2-bk3/fs/sysfs/dir.c~fix-sysfs_remove_dir-oops
2004-11-18 19:59:51.000000000 -0600
+++ linux-2.6.10-rc2-bk3-maneesh/fs/sysfs/dir.c	2004-11-18
20:01:11.000000000 -0600
@@ -268,7 +268,7 @@ void sysfs_remove_subdir(struct dentry *
 void sysfs_remove_dir(struct kobject * kobj)
 {
 	struct dentry * dentry = dget(kobj->dentry);
-	struct sysfs_dirent * parent_sd = dentry->d_fsdata;
+	struct sysfs_dirent * parent_sd;
 	struct sysfs_dirent * sd, * tmp;
 
 	if (!dentry)
@@ -276,6 +276,7 @@ void sysfs_remove_dir(struct kobject * k
 
 	pr_debug("sysfs %s: removing dir\n",dentry->d_name.name);
 	down(&dentry->d_inode->i_sem);
+	parent_sd = dentry->d_fsdata;
 	list_for_each_entry_safe(sd, tmp, &parent_sd->s_children, s_sibling) {
 		if (!sd->s_element || !(sd->s_type & SYSFS_NOT_PINNED))
 			continue;
_



