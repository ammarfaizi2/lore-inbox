Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261659AbTKTKZy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 05:25:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261680AbTKTKZy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 05:25:54 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:10942 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261659AbTKTKZu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 05:25:50 -0500
Date: Thu, 20 Nov 2003 15:55:25 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: LKML <linux-kernel@vger.kernel.org>, Patrick Mochel <mochel@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Dipankar Sarma <dipankar@in.ibm.com>
Subject: Re: [PATCH] sysfs_remove_dir Vs dcache_readdir race fix
Message-ID: <20031120102525.GD1367@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <20031120054707.GA1724@in.ibm.com> <20031120054957.GD24159@parcelfarce.linux.theplanet.co.uk> <20031120055655.GB1724@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031120055655.GB1724@in.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 20, 2003 at 11:26:55AM +0530, Maneesh Soni wrote:
> On Thu, Nov 20, 2003 at 05:49:57AM +0000, viro@parcelfarce.linux.theplanet.co.uk wrote:
> > On Thu, Nov 20, 2003 at 11:17:07AM +0530, Maneesh Soni wrote:
> > > Hi,
> > > 
> > > sysfs_remove_dir modifies d_subdirs list which results in inconsistency
> > > when there is concurrent dcache_readdir is going on. I think there
> > > is no need for sysfs_remove_dir to modify d_subdirs list and removal
> > > of dentries from d_child list is taken care in the final dput().
> > 
> > WTF?
> > 
> > All instances of ->readdir() are protected by ->i_sem on parent.  So
> > are all operations in sysfs_remove_dir().
> > 
> > Have you actually observed any race there?
> 
> Yes.. if you run the mentioned two loops on an SMP box, you will find that
> dcache_readdir is looping with dcache_lock held up in less than a minute. 
> The problem comes when sysfs_remove_dir has done list_del_init on the cursor 
> dentry which is being used in dcache_readdir. Please enable pr_debug() also 
> in sysfs_remove_dir to see the this happening.
> 
> Maneesh

Clarrifying more:

Actually race is not directly between dcache_readdir and sysfs_remove_dir but
it is like this

cpu 0						cpu 1
dcache_dir_open()
--> adds the cursor dentry

					sysfs_remove_dir()
					--> list_del_init cursor dentry

dcache_readdir()
--> loops forever on inititalized cursor dentry.


Though all these operations happen under parent's i_sem, but it is dropped 
between ->open() and ->readdir() as both are different calls. 

I think people will also agree that there is no need for sysfs_remove_dir() 
to modify d_subdirs list.

Maneesh

-- 
Maneesh Soni
Linux Technology Center, 
IBM Software Lab, Bangalore, India
email: maneesh@in.ibm.com
Phone: 91-80-5044999 Fax: 91-80-5268553
T/L : 9243696
