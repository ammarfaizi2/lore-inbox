Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279790AbRKIKAr>; Fri, 9 Nov 2001 05:00:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279797AbRKIKAi>; Fri, 9 Nov 2001 05:00:38 -0500
Received: from mail.loewe-komp.de ([62.156.155.230]:64521 "EHLO
	mail.loewe-komp.de") by vger.kernel.org with ESMTP
	id <S279790AbRKIKAY>; Fri, 9 Nov 2001 05:00:24 -0500
Message-ID: <3BEBA93F.80B0A7E1@loewe-komp.de>
Date: Fri, 09 Nov 2001 11:00:31 +0100
From: Peter =?iso-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>
Organization: LOEWE. Hannover
X-Mailer: Mozilla 4.76 [de] (X11; U; Linux 2.4.9-ac3 i686)
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux-xfs@oss.sgi.com
CC: lkml <linux-kernel@vger.kernel.org>
Subject: NFS hit me (2.4.9-xfs) again
In-Reply-To: <1005258455.4701.4.camel@itspec.amoa.org> 
		<1005258497.9075.22.camel@jen.americas.sgi.com> 
		<1005259546.5742.9.camel@itspec.amoa.org> <1005261542.9077.29.camel@jen.americas.sgi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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
