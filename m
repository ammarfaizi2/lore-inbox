Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261901AbTKTPLi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 10:11:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261903AbTKTPLi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 10:11:38 -0500
Received: from fw.osdl.org ([65.172.181.6]:44957 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261901AbTKTPLg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 10:11:36 -0500
Date: Thu, 20 Nov 2003 07:17:09 -0800
From: Andrew Morton <akpm@osdl.org>
To: maneesh@in.ibm.com
Cc: viro@parcelfarce.linux.theplanet.co.uk, linux-kernel@vger.kernel.org,
       mochel@osdl.org, dipankar@in.ibm.com
Subject: Re: [PATCH] sysfs_remove_dir Vs dcache_readdir race fix
Message-Id: <20031120071709.0acf35aa.akpm@osdl.org>
In-Reply-To: <20031120102525.GD1367@in.ibm.com>
References: <20031120054707.GA1724@in.ibm.com>
	<20031120054957.GD24159@parcelfarce.linux.theplanet.co.uk>
	<20031120055655.GB1724@in.ibm.com>
	<20031120102525.GD1367@in.ibm.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maneesh Soni <maneesh@in.ibm.com> wrote:
>
> Actually race is not directly between dcache_readdir and sysfs_remove_dir but
>  it is like this
> 
>  cpu 0						cpu 1
>  dcache_dir_open()
>  --> adds the cursor dentry
> 
>  					sysfs_remove_dir()
>  					--> list_del_init cursor dentry
> 
>  dcache_readdir()
>  --> loops forever on inititalized cursor dentry.
> 
> 
>  Though all these operations happen under parent's i_sem, but it is dropped 
>  between ->open() and ->readdir() as both are different calls. 
> 
>  I think people will also agree that there is no need for sysfs_remove_dir() 
>  to modify d_subdirs list.

Seems to me that the libfs code is fragile.

What happens if the dentry at filp->f_private_data gets moved to a
different directory after someone did dcache_dir_open()?  Does the loop
in dcache_readdir() go infinite again?

