Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280073AbRKITe7>; Fri, 9 Nov 2001 14:34:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280064AbRKITeu>; Fri, 9 Nov 2001 14:34:50 -0500
Received: from smtp.storageapps.com ([63.101.83.13]:59666 "EHLO
	sa-bwmail1.storageapps.com") by vger.kernel.org with ESMTP
	id <S280062AbRKITej> convert rfc822-to-8bit; Fri, 9 Nov 2001 14:34:39 -0500
Message-ID: <23D04BDBA646D411BDDD00D0B774B539046028B7@SA-BWMAIL1>
From: "Christian, Chip" <chip_christian@hp.com>
To: =?iso-8859-1?Q?=27Peter_W=E4chtler=27?= <pwaechtler@loewe-komp.de>,
        linux-xfs@oss.sgi.com
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: RE: NFS hit me (2.4.9-xfs) again
Date: Fri, 9 Nov 2001 14:31:45 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The reason that dput was dropped in 2.4.10 is that there's another one that also gets executed, causing the kernel oops right after the

	if (!pdentry) { 
	}
code block.  

I think you have a filesystem in need of repair.

RedHat ships this patch with their 2.4.9 kernels:

--- linux/fs/nfsd/nfsfh.c~      Fri Aug 17 21:30:25 2001
+++ linux/fs/nfsd/nfsfh.c       Fri Aug 17 21:30:40 2001
@@ -275,7 +275,6 @@
        d_drop(tdentry); /* we never want ".." hashed */
        if (!pdentry && tdentry->d_inode == NULL) {
                /* File system cannot find ".." ... sad but possible */
-               dput(tdentry);
                pdentry = ERR_PTR(-EINVAL);
        }
        if (!pdentry) {

-----Original Message-----
From: Peter Wächtler [mailto:pwaechtler@loewe-komp.de]
Sent: Friday, November 09, 2001 5:01
To: linux-xfs@oss.sgi.com
Cc: lkml
Subject: NFS hit me (2.4.9-xfs) again


Unable to handle kernel NULL pointer dereference at virtual address 00000000
00000000
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<00000000>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286
eax: 00000000   ebx: c9c0d7e0   ecx: 00000000   edx: c03a7b00
esi: c9c0d560   edi: c9c0d7e0   ebp: c9c0d7e0   esp: cbddde84
ds: 0018   es: 0018   ss: 0018
Process nfsd (pid: 233, stackpage=cbddd000)
Stack: c01729f4 cc97f420 c9c0d560 00000005 cdc40a00 c0172e56 c9c0d7e0 00000005
       cd390200 cd390000 cbed2000 cbdddf20 cdc40be8 cd390200 c0173199 cdc40a00
       cd390010 00000005 00000001 00000001 00000008 cbe17e00 cbee48c0 cd390200
Call Trace: [<c01729f4>] [<c0172e56>] [<c0173199>] [<c0173ad2>] [<c017843d>]
   [<c017173c>] [<c0171003>] [<c0240318>] [<c0170dab>] [<c010557f>]
Code:  Bad EIP value.
 
>>EIP; 00000000 Before first symbol
Trace; c01729f4 <nfsd_findparent+34/104>
Trace; c0172e56 <find_fh_dentry+226/34c>
Trace; c0173199 <fh_verify+21d/438>
Trace; c0173ad2 <nfsd_lookup+92/4b8>
Trace; c017843d <nfssvc_decode_diropargs+5d/d0>
Trace; c017173c <nfsd_proc_lookup+88/9c>
Trace; c0171003 <nfsd_dispatch+cb/168>
Trace; c0240318 <svc_process+2ac/544>
Trace; c0170dab <nfsd+1ab/338>
Trace; c010557f <kernel_thread+23/30>

This is not the initial crash location - the machine was dead (and no serial 
console yet). But after restarting, about 6-10 clients tried to reconnect
to NFSD and caused the crash.

The crash appears because "child->d_inode->i_op->lookup == NULL"

struct dentry *nfsd_findparent(struct dentry *child)
{
        struct dentry *tdentry, *pdentry;
        tdentry = d_alloc(child, &(const struct qstr) {"..", 2, 0});
        if (!tdentry)
                return ERR_PTR(-ENOMEM);
 
        /* I'm going to assume that if the returned dentry is different, then
         * it is well connected.  But nobody returns different dentrys do they?
         */

        /* added safety check to prevent crash - peewee */
        if (child->d_inode->i_op && child->d_inode->i_op->lookup){
                pdentry = child->d_inode->i_op->lookup(child->d_inode, tdentry);
        } else {
                printk("normally we had been crashing\n");
                printk("child: %p\n",child);
                printk("child->d_inode: %p\n",child->d_inode);
                printk("child->d_inode->i_op: %p\n",child->d_inode->i_op);
                printk("child->d_inode->i_op->lookup: %p\n",child->d_inode->i_op->lookup);
                return( ERR_PTR(-EINVAL) );
        }
        d_drop(tdentry); /* we never want ".." hashed */
        if (!pdentry && tdentry->d_inode == NULL) {
                /* File system cannot find ".." ... sad but possible */
                dput(tdentry);
          ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^  this one was removed in 2.4.10

                pdentry = ERR_PTR(-EINVAL);
        }
        if (!pdentry) {
                /* I don't want to return a ".." dentry.
                 * I would prefer to return an unconnected "IS_ROOT" dentry,
[...]

If I use 2.4.12-xfs (with nfs-utils 0.3.3), clients can't create an archive with "ar":

[ strace output of "ar" creating a lib out of several *.o]
write(5, "\0\0\1\2\0\0H\2\0\0\1\2\0\0L\2\0\0\1\2\0\0P\2\0\0\1\2\0"..., 3254) = 3
close(5)                                = 0
munmap(0x4001f000, 4096)                = 0
lstat64("lumenuila.a", {st_mode=S_IFREG|0644, st_size=8, ...}) = 0
rename("stO1wjGV", "lumenuila.a")       = -1 ESTALE (Stale NFS file handle)


My main question is: Is it possible that some interaction with xfs<->nfsd
causes this kind of trouble? Especially when lookup("..") fails - and dealing
with "disconnected dentries". Does the nfs_fh carry not enough information
( when is oldfh used, when the newer one? [ref_fh->fh_handle.fh_version == 0xca]).
So we have an inode with no proper inode_operations, huh?

I don't use NFSv3, should I?
