Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262723AbTI1UsG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 16:48:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262724AbTI1UsG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 16:48:06 -0400
Received: from pD9FFBA7B.dip.t-dialin.net ([217.255.186.123]:44444 "EHLO
	oscar.local.net") by vger.kernel.org with ESMTP id S262723AbTI1UsB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 16:48:01 -0400
Date: Sun, 28 Sep 2003 22:47:53 +0200
From: Patrick Mau <mau@oscar.ping.de>
To: Malte =?iso-8859-1?Q?Schr=F6der?= <MalteSch@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PROBLEM] [2.6.0-test6] Stale NFS file handle
Message-ID: <20030928204753.GA28255@oscar.prima.de>
Reply-To: Patrick Mau <mau@oscar.ping.de>
References: <200309282031.54043.MalteSch@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200309282031.54043.MalteSch@gmx.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 28, 2003 at 08:30:50PM +0200, Malte Schröder wrote:
> Hi,
> since 2.6.0-test6 I get "Stale NFS file handle" when transferring
> huge amounts of data from a nfs-server which is running on -test6.
> The client also runs -test6. Transfers from a server running kernel 2.4.22 
> work flawless.
> 
> I use the nfs-kernel-server 1.0.6 on Debian/sid.

Hallo Malte,
Hallo list-members,

my solution for getting a reliable NFS Server with 2.5 kernels was
to use "no_subtree_check" in /etc/exports.

(The next thing is pasted, please read below the code)

I stumbled over the following lines of code in fs/nfsd/nfsfh.c:

int nfsd_acceptable(void *expv, struct dentry *dentry)
{
        struct svc_export *exp = expv;
        int rv;
        struct dentry *tdentry;
        struct dentry *parent;

        if (exp->ex_flags & NFSEXP_NOSUBTREECHECK)
                return 1;

        tdentry = dget(dentry);
        while (tdentry != exp->ex_dentry && ! IS_ROOT(tdentry)) {
                /* make sure parents give x permission to user */
                int err;
                parent = dget_parent(tdentry);
                err = permission(parent->d_inode, S_IXOTH, NULL);
                                                  ^^^^^^^ <- !!!!
                if (err < 0) {
                        dput(parent);
                        break;
                }

First, nfsd_acceptable always returns success if subtree_checks are
diabled. Second, I think, the line marked above is not correct.

The comment says "give x permission to user", but the call looks
suspiciously wrong.

You can also make the error disappear by allowing setting all x bits
for "other" from your mount-point down to the directory where the error
appears.

Echoing "32767" to /proc/sys/sunrpx/nfs_debug helped me a great deal
to find that error.

Cheers,
Patrick
