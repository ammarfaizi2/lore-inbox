Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262634AbUEKJ7H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262634AbUEKJ7H (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 05:59:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262810AbUEKJ7H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 05:59:07 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:33931 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262634AbUEKJ7C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 05:59:02 -0400
Date: Wed, 6 Oct 2004 15:26:02 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: Richard A Nelson <cowboy@debian.org>
Cc: Stephen Hemminger <shemminger@osdl.org>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.6-mm1 Oops with dummy network device (sysfs related?)
Message-ID: <20041006095602.GB2004@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <Pine.LNX.4.58.0405101654130.5731@erartnqr.onqynaqf.bet> <20040510141829.467a2bb6@dell_ss3.pdx.osdl.net> <Pine.LNX.4.58.0405101909450.31018@onpx40.onqynaqf.bet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0405101909450.31018@onpx40.onqynaqf.bet>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2004 at 11:35:00PM +0000, Richard A Nelson wrote:
> On Mon, 10 May 2004, Stephen Hemminger wrote:
> 
> > It would be easier to know what is wrong, if you said what you
> > did that started the problem.  Looks like ifrename or something
> > like that.
> 
> hrm, been trying to track that down (several oopses later...)
> 
> the modprobe dummy worked ok (and is seen in the log)
> the next command is 'ip link set name ipsec0 dev dummy0'
> and I've yet to get passed that

ok it is sysfs related and because of the backing store patches from me.

And here is the fix. Hope this solves your problem. 


Thanks
Maneesh

o Fix sysfs_rename_dir(). The sysfs_lookup() does not hash
  negative dentries so just hash it before calling d_move

 fs/sysfs/dir.c |    1 +
 1 files changed, 1 insertion(+)

diff -puN fs/sysfs/dir.c~sysfs-backing-store-sysfs_rename_dir-fix fs/sysfs/dir.c
--- linux-2.6.6-mm1/fs/sysfs/dir.c~sysfs-backing-store-sysfs_rename_dir-fix	2004-10-06 15:21:37.000000000 +0530
+++ linux-2.6.6-mm1-maneesh/fs/sysfs/dir.c	2004-10-06 15:22:03.000000000 +0530
@@ -314,6 +314,7 @@ void sysfs_rename_dir(struct kobject * k
 	new_dentry = sysfs_get_dentry(parent, new_name);
 	if (!IS_ERR(new_dentry)) {
 		if (!new_dentry->d_inode) {
+			d_add(new_dentry, NULL);
 			d_move(kobj->dentry, new_dentry);
 			kobject_set_name(kobj,new_name);
 		}

_


-- 
Maneesh Soni
Linux Technology Center, 
IBM Software Lab, Bangalore, India
email: maneesh@in.ibm.com
Phone: 91-80-25044999 Fax: 91-80-25268553
T/L : 9243696
