Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263865AbTF3Nid (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 09:38:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263894AbTF3Nid
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 09:38:33 -0400
Received: from ns2.uk.superh.com ([193.128.105.170]:33454 "EHLO
	ns2.uk.superh.com") by vger.kernel.org with ESMTP id S263865AbTF3Nic
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 09:38:32 -0400
Date: Mon, 30 Jun 2003 14:52:33 +0100
From: Richard Curnow <Richard.Curnow@superh.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Paul Mundt <lethal@linux-sh.org>,
       Ben Gaster <Benedict.Gaster@superh.com>,
       Sean McGoogan <sean.mcgoogan@superh.com>,
       Boyd Moffat <boyd.moffat@superh.com>
Subject: NFS structure allocation alignment patch
Message-ID: <20030630135233.GN5586@malvern.uk.w2k.superh.com>
Mail-Followup-To: Trond Myklebust <trond.myklebust@fys.uio.no>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Paul Mundt <lethal@linux-sh.org>,
	Ben Gaster <Benedict.Gaster@superh.com>,
	Sean McGoogan <sean.mcgoogan@superh.com>,
	Boyd Moffat <boyd.moffat@superh.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-OS: Linux 2.4.19 i686
X-OriginalArrivalTime: 30 Jun 2003 13:53:04.0522 (UTC) FILETIME=[ED9F06A0:01C33F0E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Trond, Marcelo,

Below is a patch against 2.4.21 to tidy up the allocation of two
structures in nfs3_proc_unlink_setup.  We need this change for NFS to
work on the sh64 architecture, which has just been merged into 2.4 in
the last couple of days.  Otherwise, 'res' is 4-byte aligned but not
necessarily 8-byte aligned, but struct nfs_attr contains fields that are
8 bytes wide.  This leads to alignment exceptions on loads and stores
into that structure.

Can you consider this for inclusion before 2.4.22 please?

[BTW this is the same fix we discussed about 3 months ago; I didn't get
around to re-submitting the fix at the time].

Regards,
Richard Curnow

--- fs/nfs/nfs3proc.c   Thu Nov 28 23:53:15 2002
+++ ../sh5linux-16062003/fs/nfs/nfs3proc.c      Mon Jun 30 11:43:14 2003
@@ -300,11 +300,16 @@
 {
        struct nfs3_diropargs   *arg;
        struct nfs_fattr        *res;
+       struct unlinkxdr {
+               struct nfs3_diropargs   arg;
+               struct nfs_fattr        res;
+       } *ptr;
 
-       arg = (struct nfs3_diropargs *)kmalloc(sizeof(*arg)+sizeof(*res), GFP_KERNEL);
-       if (!arg)
+       ptr = (struct unlinkxdr *) kmalloc(sizeof(struct unlinkxdr), GFP_KERNEL);
+       if (!ptr)
                return -ENOMEM;
-       res = (struct nfs_fattr*)(arg + 1);
+       arg = &ptr->arg;
+       res = &ptr->res;
        arg->fh = NFS_FH(dir->d_inode);
        arg->name = name->name;
        arg->len = name->len;

-- 
Richard \\\ SuperH Core+Debug Architect /// .. At home ..
  P.    /// richard.curnow@superh.com  ///  rc@rc0.org.uk
Curnow  \\\ http://www.superh.com/    ///  www.rc0.org.uk
