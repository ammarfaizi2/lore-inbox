Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265097AbRGCQ56>; Tue, 3 Jul 2001 12:57:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265277AbRGCQ5s>; Tue, 3 Jul 2001 12:57:48 -0400
Received: from bbnmg1.net.external.hp.com ([192.6.76.73]:8196 "HELO
	bbnmg1.net.external.hp.com") by vger.kernel.org with SMTP
	id <S265097AbRGCQ5k>; Tue, 3 Jul 2001 12:57:40 -0400
Message-ID: <E14281810E5FD411B9DC00D0B7752F20027E64D6@busch.grc.hp.com>
From: "HEUER,JOCHEN (HP-Germany,ex2)" <jochen_heuer@hp.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Cc: "HEUER,JOCHEN (HP-Germany,ex2)" <jochen_heuer@hp.com>,
        "'jogi@planetzork.ping.de'" <jogi@planetzork.ping.de>
Subject: Kernel oops 2.4.2
Date: Tue, 3 Jul 2001 18:57:33 +0200 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

I got the following oops on a HP Netserver (single CPU) running Linux
version
2.4.2-SGI_XFS_1.0 compiled with gcc version egcs-2.91.66 19990314/Linux
(egcs-1.1.2 release)

with two modifications:

--- v2.4.4/linux/fs/nfsd/nfsfh.c        Fri Feb  9 11:29:44 2001
+++ linux/fs/nfsd/nfsfh.c       Sat May 19 17:47:55 2001
@@ -244,6 +245,11 @@
         */
        pdentry = child->d_inode->i_op->lookup(child->d_inode, tdentry);
        d_drop(tdentry); /* we never want ".." hashed */
+       if (!pdentry && tdentry->d_inode == NULL) {
+               /* File system cannot find ".." ... sad but possible */
+               dput(tdentry);
+               pdentry = ERR_PTR(-EINVAL);
+       }
        if (!pdentry) {
                /* I don't want to return a ".." dentry.
                 * I would prefer to return an unconnected "IS_ROOT" dentry,

Without this patch the machine would cause an oops with NULL pointer
dereference (probably looking up ../).
Furthermore the megaraid driver 1.14b is used in this kernel.


kernel BUG at dcache.c:128!
invalid operand: 0000
CPU:    0
EIP:    0010:[dput+40/376]
EIP:    0010:[<c01450b8>]
EFLAGS: 00013286
eax: 0000001c   ebx: de98e1e0   ecx: 00000000   edx: ffffffff
esi: de98e1e0   edi: de98e6e0   ebp: de98e6e0   esp: deecdebc
ds: 0018   es: 0018   ss: 0018
Process nfsd (pid: 749, stackpage=deecd000)
Stack: c02ca5cb c02ca66b 00000080 ffffffea de98e1e0 c0172ddc de98e1e0
00000000 
       0503317e c0173176 de98e6e0 00000000 deedbe14 11270000 deedbe04
c0113638 
       ef5619e0 deecc000 ffffff8c 00000000 c0173504 ef561800 0503317e
00000000 
Call Trace: [error_table+41059/44824] [error_table+41219/44824]
[nfsd_findparent+212/220] [find_fh_dentry+582/880] [schedule+736/1080]
[fh_verify+612/1128] [nfsd3_proc_getattr+149/160] 
Call Trace: [<c02ca5cb>] [<c02ca66b>] [<c0172ddc>] [<c0173176>] [<c0113638>]
[<c0173504>] [<c0179799>] 
       [nfsd_dispatch+203/360] [svc_process+684/1348] [nfsd+401/760]
[kernel_thread+35/48] 
       [<c01714c3>] [<c02ad0d8>] [<c0171291>] [<c010752f>] 

Code: 0f 0b 83 c4 0c 8d 76 00 ff 0b 0f 94 c0 84 c0 0f 84 35 01 00


This oops is more or less reproduce. Several HP-UX machines mount a
directory from this Linux machine via NFS. Running 'ls -lR' + some
filemanager actions make this oops happen.

What could be causing this problem? A bug in the knfsd or is it related
to SGI's XFS? nfs-utils-0.3.1-5 from RedHat are used. If further infos
are required just send me an email ...


Kind regards,

   Jochen Heuer
