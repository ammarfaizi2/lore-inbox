Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135617AbREIA7V>; Tue, 8 May 2001 20:59:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135681AbREIA7M>; Tue, 8 May 2001 20:59:12 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:52490 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S135617AbREIA7F>; Tue, 8 May 2001 20:59:05 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: fermin@eup.udl.es (Fermin Molina)
Date: Wed, 9 May 2001 10:57:42 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15096.38406.177154.334592@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: nfsd from kernel 2.4.4 oops
In-Reply-To: message from Fermin Molina on Tuesday May 8
In-Reply-To: <200105081828.UAA16365@eup.udl.es>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday May 8, fermin@eup.udl.es wrote:
> Hi,
> 
> I'm using kernel 2.4.4 cvs from SGI, with xfs. I'm getting this Oops:
> 
> kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000010
> kernel:  printing eip:
> kernel: c017bfd8
> kernel: *pde = 00000000
> kernel: Oops: 0000
> kernel: CPU:    0
> kernel: EIP:    0010:[nfsd_findparent+120/236]
> kernel: EIP:    0010:[<c017bfd8>]
> kernel: EFLAGS: 00010246
> kernel: eax: 00000000   ebx: 00000000   ecx: cff8d458   edx: 00000010
> kernel: esi: cb22c6a0   edi: cb22c720   ebp: cb22c720   esp: ce4c9e54
> kernel: ds: 0018   es: 0018   ss: 0018
> kernel: Process nfsd (pid: 592, stackpage=ce4c9000)
> kernel: Stack: 00000000 1802280f c017c416 cb22c720 00000000 ce4cf814 11270000 ce4cf804
> kernel:        c03c5740 cfe3b5c8 0000000e ffffff8c 00000000 c017c7c4 cfe3b400 1802280f
> kernel:        00000000 00000000 00000001 ce4cf804 00000008 cb1fc77c ce4cfc00 ceb7b000
> kernel: Call Trace: [find_fh_dentry+598/928] [fh_verify+612/1128] [nfsd_lookup+110/1368] [nfsd3_proc_lookup+314/332] [nfs3svc_decode_diropargs+152/268] [nfsd_dispatch+203/360] [svc_process+684/1348]
> kernel: Call Trace: [<c017c416>] [<c017c7c4>] [<c017cdde>] [<c0182cbe>] [<c018498c>] [<c017a663>] [<c02df688>]
> 

nfsd_findparent+120/236 corresponds to line 257 on fs/nfsd/nfsfh.h
and the condition of the "if" statement:
		if (aliases->next != aliases) {
just after the "spin_lock(&dcache_lock)".
eax == 0 implies that &tdentry->d_inode == NULL, and hence the oops.

d_inode being NULL here implies that the "lookup" of ".." failed
to find a ".." entry, which is very odd.

I find it hard to believe that ext2fs would ever do this unless the
filesystem was corrupt.  XFS might, I don't know.

I guess nfsd should be robust against this sort of behaviour in
filesystems.

Something like:

--- nfsfh.c	2001/05/09 00:54:56	1.1
+++ nfsfh.c	2001/05/09 00:56:01
@@ -244,6 +244,10 @@
 	 */
 	pdentry = child->d_inode->i_op->lookup(child->d_inode, tdentry);
 	d_drop(tdentry); /* we never want ".." hashed */
+	if (!pdentry && tdentry->d_inode == NULL) {
+		dput(tdentry);
+		pdentry = ERR_PTR(-EINVAL);
+	}
 	if (!pdentry) {
 		/* I don't want to return a ".." dentry.
 		 * I would prefer to return an unconnected "IS_ROOT" dentry,


Is probably the best fix for knfsd, but someone should find out why
XFS isn't finding ".." when asked (If that is indeed what is
happening).

NeilBrown


> 
> It's produced very randomly. Some people (readed in xfs list) get similar error and
> tested too with a clean 2.4.4 with ext2 filesystem, and oops too. I think this is
> related to nfsd code (maybe sunrpc code), and it's not related to xfs code.
