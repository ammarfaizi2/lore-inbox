Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262708AbTJPFRS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 01:17:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262709AbTJPFRS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 01:17:18 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:59525 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S262708AbTJPFRQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 01:17:16 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Patrick Mau <mau@oscar.ping.de>
Date: Thu, 16 Oct 2003 15:17:02 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16270.10702.689027.346924@notabene.cse.unsw.edu.au>
Cc: Malte =?iso-8859-1?Q?Schr=F6der?= <MalteSch@gmx.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PROBLEM] [2.6.0-test6] Stale NFS file handle
In-Reply-To: message from Patrick Mau on Sunday September 28
References: <200309282031.54043.MalteSch@gmx.de>
	<20030928204753.GA28255@oscar.prima.de>
X-Mailer: VM 7.17 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday September 28, mau@oscar.ping.de wrote:
> 
> I stumbled over the following lines of code in fs/nfsd/nfsfh.c:
> 
> int nfsd_acceptable(void *expv, struct dentry *dentry)
> {
>         struct svc_export *exp = expv;
>         int rv;
>         struct dentry *tdentry;
>         struct dentry *parent;
> 
>         if (exp->ex_flags & NFSEXP_NOSUBTREECHECK)
>                 return 1;
> 
>         tdentry = dget(dentry);
>         while (tdentry != exp->ex_dentry && ! IS_ROOT(tdentry)) {
>                 /* make sure parents give x permission to user */
>                 int err;
>                 parent = dget_parent(tdentry);
>                 err = permission(parent->d_inode, S_IXOTH, NULL);
>                                                   ^^^^^^^ <- !!!!
>                 if (err < 0) {
>                         dput(parent);
>                         break;
>                 }
> 
> First, nfsd_acceptable always returns success if subtree_checks are
> diabled. Second, I think, the line marked above is not correct.
> 
> The comment says "give x permission to user", but the call looks
> suspiciously wrong.

I think it is correct, though arguably it should be "MAY_EXEC" rather
than "S_IXOTH" (both of which are '1').
The permission call checks if the current user (which is computed from
the rpc credentials) has eXecute access to the directories.

> 
> You can also make the error disappear by allowing setting all x bits
> for "other" from your mount-point down to the directory where the error
> appears.

Have you actually tried this or are you just assuming?

> 
> Echoing "32767" to /proc/sys/sunrpx/nfs_debug helped me a great deal
> to find that error.

Presumably you got lots of "nfsd_acceptable failed at ....".  Is that
correct? 

I guess I need to do some testing with "subtree_check" set and see if
I can reproduce it.

NeilBrown
