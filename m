Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290624AbSBFPkr>; Wed, 6 Feb 2002 10:40:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290620AbSBFPkh>; Wed, 6 Feb 2002 10:40:37 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:59171 "EHLO
	svldns02.veritas.com") by vger.kernel.org with ESMTP
	id <S290625AbSBFPk2>; Wed, 6 Feb 2002 10:40:28 -0500
Date: Wed, 6 Feb 2002 15:42:35 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
To: "Drew P. Vogel" <dvogel@intercarve.net>
cc: paule <paule@ilu.vu>, linux-kernel@vger.kernel.org
Subject: Re: Swap issue
In-Reply-To: <Pine.LNX.4.33.0202060926570.27274-100000@northface.intercarve.net>
Message-ID: <Pine.LNX.4.21.0202061539570.1452-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, 6 Feb 2002, paule wrote:
> 
> >Having just upgraded slackware8.0 (2.2 kernel)
> >to using 2.5.2, (2.5.3 patch install failed looking for malloc.h)
> >Im unable to use swap, despite it showing a success.

Known problem, fixed by Al Viro, additional fix by Andrey Panin:

--- 2.5.2/mm/swapfile.c	Sat Jan 19 21:13:17 2002
+++ linux/mm/swapfile.c	Wed Feb  6 15:36:10 2002
@@ -904,11 +904,12 @@
 	swap_file = filp_open(name, O_RDWR, 0);
 	putname(name);
 	error = PTR_ERR(swap_file);
-	if (error)
+	if (IS_ERR(swap_file))
 		goto bad_swap_2;
 
 	p->swap_file = swap_file;
 
+	error = -EINVAL;
 	if (S_ISBLK(swap_file->f_dentry->d_inode->i_mode)) {
 		p->swap_device = swap_file->f_dentry->d_inode->i_rdev;
 		set_blocksize(p->swap_device, PAGE_SIZE);
@@ -1072,7 +1073,7 @@
 	swap_list_unlock();
 	if (swap_map)
 		vfree(swap_map);
-	if (swap_file)
+	if (swap_file && !IS_ERR(swap_file))
 		filp_close(swap_file, NULL);
 out:
 	if (swap_header)

