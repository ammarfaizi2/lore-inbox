Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266839AbTBXLuk>; Mon, 24 Feb 2003 06:50:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266859AbTBXLuk>; Mon, 24 Feb 2003 06:50:40 -0500
Received: from bi-01pt1.bluebird.ibm.com ([129.42.208.186]:51636 "EHLO
	bigbang.in.ibm.com") by vger.kernel.org with ESMTP
	id <S266839AbTBXLuh>; Mon, 24 Feb 2003 06:50:37 -0500
Date: Mon, 24 Feb 2003 17:44:42 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: Andrew Morton <akpm@digeo.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       Dipankar Sarma <dipankar@in.ibm.com>, trond.myklebust@fys.uio.no,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: Oops in rpc_depopulate with 2.5.62
Message-ID: <20030224121442.GA1103@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <25140000.1045901377@[10.10.2.4]> <20030222004930.0240738b.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030222004930.0240738b.akpm@digeo.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 22, 2003 at 12:49:30AM -0800, Andrew Morton wrote:
> 
> Maneesh and Dipankar may be able to plug this one.  I've looked,
> and apart from a seemingly-unneeded test for !d_unhashed I can't
> see the problem.
> 
> Perhaps the problem lies with a different part of the code.
> 
> I cannot reproduce the crash.

Same with me also. Surprisingly I am getting same oops on 2.5.61.
Can send .config and ksymoops output if required.

rpc_rmdir does lookup_hash(), which may return a negative dentry. 
If a negative dentry is possible at this point then  testing for d_inode 
in rpc_rmdir() fixes this problem. Like we have in rpc_unlink().
Probably Trond knows better. 

Following patch fixes the oops I am seeing in 2.5.61 and should fix
the oops seen on 2.5.62 also.


diff -urN linux-2.5.62-bk6/net/sunrpc/rpc_pipe.c linux-2.5.62-bk6-rpc_depopulate/net/sunrpc/rpc_pipe.c
--- linux-2.5.62-bk6/net/sunrpc/rpc_pipe.c	2003-02-24 16:06:46.000000000 +0530
+++ linux-2.5.62-bk6-rpc_depopulate/net/sunrpc/rpc_pipe.c	2003-02-24 16:57:14.000000000 +0530
@@ -665,8 +665,10 @@
 		error = PTR_ERR(dentry);
 		goto out_release;
 	}
-	rpc_depopulate(dentry);
-	error = __rpc_rmdir(dir, dentry);
+	if (dentry->d_inode) {
+		rpc_depopulate(dentry);
+		error = __rpc_rmdir(dir, dentry);
+	}
 	dput(dentry);
 out_release:
 	up(&dir->i_sem);



Regards
Maneesh

> "Martin J. Bligh" <mbligh@aracnet.com> wrote:
> >
> > Getting rpc/nfs bugs on at least two different machines I've seen
> > and reports of a third from Zwane - all look similar. Anyone got
> > any bright ideas?
> > 
> > M.
> > 
> > Unable to handle kernel NULL pointer dereference at virtual address 0000006c
> >  printing eip:
> > c03415e2
> > *pde = 358d2001
> > *pte = 00000000
> > Oops: 0002
> > CPU:    1
> > EIP:    0060:[<c03415e2>]    Not tainted
> > EFLAGS: 00010206
> > EIP is at rpc_depopulate+0x22/0xf0
> > eax: 00000000   ebx: f5133680   ecx: 0000006c   edx: f50afc1c
> > esi: f50afbf4   edi: f50afbf4   ebp: f50afc08   esp: f50afbec
> > ds: 007b   es: 007b   ss: 0068
> > Process mount (pid: 1166, threadinfo=f50ae000 task=f5766d80)
> > Stack: c01562f0 00000000 f50afbf4 f50afbf4 f5133680 f5133680 f51c1e00 f50afc40 
> >        c0341af5 f5133680 f5117880 f7ff9800 f50afcec 00000000 f50afc34 00000010 
> >        00000001 00000000 f5982680 f50afcec 00000000 f50afc50 c0333066 f5982714 
> > Call Trace:
> >  [<c01562f0>] lookup_hash+0x70/0xa0
> >  [<c0341af5>] rpc_rmdir+0x55/0x90
> >  [<c0333066>] rpc_destroy_client+0x46/0x70
> >  [<c03330db>] rpc_release_client+0x4b/0x60
> >  [<c0337bc7>] rpc_release_task+0x1a7/0x1d0
> >  [<c033754b>] __rpc_execute+0x35b/0x370
> >  [<c011a980>] default_wake_function+0x0/0x20
> >  [<c0333274>] rpc_call_sync+0x64/0xa0
> >  [<c0333287>] rpc_call_sync+0x77/0xa0
> >  [<c03366b0>] rpc_run_timer+0x0/0xa0
> >  [<c033e5fb>] rpc_register+0xcb/0x100
> >  [<c0110000>] mask_and_ack_8259A+0x10/0xf0
> >  [<c0339d24>] svc_register+0x94/0x100
> >  [<c0339944>] svc_create+0xd4/0xe0
> >  [<c01c1fb8>] lockd_up+0x58/0x110
> >  [<c01a63f4>] nfs_fill_super+0x374/0x3a0
> >  [<c01a7e90>] nfs_get_sb+0x1f0/0x230
> >  [<c0150052>] do_kern_mount+0x42/0xa0
> >  [<c01631e6>] do_add_mount+0x76/0x150
> >  [<c0133596>] __alloc_pages+0x76/0x2c0
> >  [<c01634d7>] do_mount+0x147/0x160
> >  [<c0163908>] sys_mount+0xa8/0x110
> >  [<c010ae7b>] syscall_call+0x7/0xb
> > 
> > Code: f0 ff 48 6c 0f 88 70 09 00 00 f0 fe 0d 00 d2 44 c0 0f 88 6d 
> > 
> > Seems to be crashing on the  deference of:
> > 
> >         down(&dir->i_sem);
> > 
> > in rpc_depopulate. But there's a big comment just above saying:
> > 
> > -----------------------
> > /*
> >  * FIXME: This probably has races.
> >  */
> > static void
> > rpc_depopulate(struct dentry *parent)
> > {
> >         struct inode *dir = parent->d_inode;
> >         LIST_HEAD(head);
> >         struct list_head *pos, *next;
> >         struct dentry *dentry;
> > 
> >         down(&dir->i_sem);
> > 
> > ------------------
> > 
> > Looks like dir is NULL here ... might be dcache_rcu (a recent dcache_rcu
> > patch fixed the same file) or a race brought out by the changes.
> > 
> > 
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/

-- 
Maneesh Soni
IBM Linux Technology Center, 
IBM India Software Lab, Bangalore.
Phone: +91-80-5044999 email: maneesh@in.ibm.com
http://lse.sourceforge.net/
