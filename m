Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262006AbUCaPLl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 10:11:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262017AbUCaPLl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 10:11:41 -0500
Received: from ida.rowland.org ([192.131.102.52]:5124 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S262006AbUCaPLi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 10:11:38 -0500
Date: Wed, 31 Mar 2004 10:11:37 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Maneesh Soni <maneesh@in.ibm.com>
cc: Andrew Morton <akpm@osdl.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>, <greg@kroah.com>,
       <torvalds@osdl.org>, <david-b@pacbell.net>, <viro@math.psu.edu>,
       <linux-usb-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] [PATCH] back out sysfs reference count change
In-Reply-To: <20040331092631.GA21484@in.ibm.com>
Message-ID: <Pine.LNX.4.44L0.0403311001440.1752-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Mar 2004, Maneesh Soni wrote:

> For convenience I will explain the race here..
> 
> cpu 0							cpu 1
> kobject_unregister()				   sysfs_open_file()
>   kobject_del()					     check_perm()
>     sysfs_remove_dir()					   :
>      (dentry remains alive due to ref. taken 		   :
>       on the way to sysfs_open_file)			   :
>   kobject_put()					   	   :
>     kobject_cleanup()					kobject_get(->d_fsdata)
> 
> cpu 1 could end up referring to a freed kobject through dentry->d_fsdata or
> starts spitting Badness in kobject_get at lib/kobject.c:429. For triggering 
> this race try running these two loops simultaneously on SMP 
> 
> # while true; do insmod drivers/net/dummy.ko; rmmod dummy; done
> # while true; do find /sys/class/net | xargs cat; done
> 
> Probably it can be solved by making sure that when sysfs file is 
> opened/read/written some _race_ free check is done and fail if kobject if gone. 
> 
> Maneesh

Here's a suggestion.  At the start of check_perm() grab the dentry 
semaphore, then check whether d_fsdata is NULL, if it isn't then do the 
kobject_get(), then unlock the semaphore.

Alan Stern

