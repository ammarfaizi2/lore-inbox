Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262800AbRFIRw6>; Sat, 9 Jun 2001 13:52:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263866AbRFIRws>; Sat, 9 Jun 2001 13:52:48 -0400
Received: from adsl-64-109-89-110.chicago.il.ameritech.net ([64.109.89.110]:46414
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id <S262800AbRFIRwk>; Sat, 9 Jun 2001 13:52:40 -0400
Message-Id: <200106091752.NAA02515@localhost.localdomain>
X-Mailer: exmh version 2.1.1 10/15/1999
To: linux-kernel@vger.kernel.org
Subject: NFS PANIC and FIX in 2.4
Mime-Version: 1.0
Content-Type: multipart/mixed ;
	boundary="==_Exmh_-3134433920"
Date: Sat, 09 Jun 2001 13:52:33 -0400
From: James Bottomley <James.Bottomley@SteelEye.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multipart MIME message.

--==_Exmh_-3134433920
Content-Type: text/plain; charset=us-ascii

Hi All,

I get this panic running RedHat 2.4.3-6:

Unable to handle kernel NULL pointer dereference at virtual address 00000004
c014b13d
Oops: 0002
CPU:    0
EIP:    0010:[<c014b13d>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000000   ebx: c4a6dcc0   ecx: c4a6dce8   edx: 00000000
esi: c0256ed8   edi: c59197a0   ebp: c4ba79e8   esp: c4ba78a0
ds: 0018   es: 0018   ss: 0018
Process nfsd (pid: 3230, stackpage=c4ba7000)
Stack: c1239148 c4a6d9e8 c4a6dcc0 c4a6d9c0 c4a6dcc0 c4a6d9c0 c68af335 c4a6dcc0 
       c4a6d9c0 00000000 c4ba79e8 c4a6d9c0 c59197a0 c68af59a c4a6d9c0 c59197a0 
       c4ba79e8 00000000 00706d74 c5e07d80 c1e9ec00 c014d972 c1e9ec00 00007458 
Call Trace: [<c68af335>] [<c68af59a>] [<c014d972>] [<c016bf17>] [<c015fa28>] 
   [<c02275a0>] [<c015fa51>] [<c014d972>] [<c015fbfd>] [<c014b0b4>] [<c68af887>
]
[...]
>>EIP; c014b13d <dput+ad/180>   <=====
Trace; c68af335 <[nfsd]d_splice+e5/160>
Trace; c68af59a <[nfsd]splice+ea/140>
Trace; c014d972 <iget4+52/100>
Trace; c016bf17 <ll_rw_block+167/1b0>
[...]
Code;  c014b13d <dput+ad/180>
00000000 <_EIP>:
Code;  c014b13d <dput+ad/180>   <=====
   0:   89 50 04                  mov    %edx,0x4(%eax)   <=====
Code;  c014b140 <dput+b0/180>
   3:   89 02                     mov    %eax,(%edx)
Code;  c014b142 <dput+b2/180>
   5:   c7 43 28 00 00 00 00      movl   $0x0,0x28(%ebx)
Code;  c014b149 <dput+b9/180>
   c:   c7 41 04 00 00 00 00      movl   $0x0,0x4(%ecx)
Code;  c014b150 <dput+c0/180>
  13:   8b 00                     mov    (%eax),%eax


This is in dcache.c here:

kill_it: {
		struct dentry *parent;
		list_del(&dentry->d_child);
		^^^^^^^^^^^^^^^^^^^^^^^^^^
		/* drops the lock, at that point nobody can reach this dentry */
		dentry_iput(dentry);

The problem is pretty specific to 2.4.3-6 because it has code in list_del() to 
null out the prev and next pointers (I don't know where they picked it up, but 
its gone in 2.4.5).   However, it exposes a bug in NFS, namely that d_splice() 
also calls list_del() on tdentry->d_child.  This shouldn't be done because it 
makes the d_child list invalid, so any subsequent call to list_del on d_child 
could panic.  I think the correct fix (attached below) is to change the NFS 
list_del to list_del_init.

James Bottomley
Steeleye technology.


--==_Exmh_-3134433920
Content-Type: text/plain ; name="nfsd-2.4-list_del_problem.diff"; charset=us-ascii
Content-Description: nfsd-2.4-list_del_problem.diff
Content-Disposition: attachment; filename="nfsd-2.4-list_del_problem.diff"

Index: linux/2.4/fs/nfsd/nfsfh.c
diff -u linux/2.4/fs/nfsd/nfsfh.c:1.1.1.8.4.1 linux/2.4/fs/nfsd/nfsfh.c:1.1.1.8.4.2
--- linux/2.4/fs/nfsd/nfsfh.c:1.1.1.8.4.1	Wed May  9 11:08:54 2001
+++ linux/2.4/fs/nfsd/nfsfh.c	Fri Jun  8 16:18:33 2001
@@ -238,7 +238,7 @@
 	 * make it an IS_ROOT instead
 	 */
 	spin_lock(&dcache_lock);
-	list_del(&tdentry->d_child);
+	list_del_init(&tdentry->d_child);
 	tdentry->d_parent = tdentry;
 	spin_unlock(&dcache_lock);
 	d_rehash(target);

--==_Exmh_-3134433920--


