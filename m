Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262291AbUDAFNQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 00:13:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262292AbUDAFNQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 00:13:16 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:22936 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262291AbUDAFNN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 00:13:13 -0500
Date: Thu, 1 Apr 2004 10:47:40 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Andrew Morton <akpm@osdl.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>, greg@kroah.com,
       torvalds@osdl.org, david-b@pacbell.net, viro@math.psu.edu,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] [PATCH] back out sysfs reference count change
Message-ID: <20040401051740.GA1291@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <20040331092631.GA21484@in.ibm.com> <Pine.LNX.4.44L0.0403311001440.1752-100000@ida.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0403311001440.1752-100000@ida.rowland.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 31, 2004 at 10:11:37AM -0500, Alan Stern wrote:
> On Wed, 31 Mar 2004, Maneesh Soni wrote:
> 
> > For convenience I will explain the race here..
> > 
> > cpu 0							cpu 1
> > kobject_unregister()				   sysfs_open_file()
> >   kobject_del()					     check_perm()
> >     sysfs_remove_dir()					   :
> >      (dentry remains alive due to ref. taken 		   :
> >       on the way to sysfs_open_file)			   :
> >   kobject_put()					   	   :
> >     kobject_cleanup()					kobject_get(->d_fsdata)
> > 
> > cpu 1 could end up referring to a freed kobject through dentry->d_fsdata or
> > starts spitting Badness in kobject_get at lib/kobject.c:429. For triggering 
> > this race try running these two loops simultaneously on SMP 
> > 
> > # while true; do insmod drivers/net/dummy.ko; rmmod dummy; done
> > # while true; do find /sys/class/net | xargs cat; done
> > 
> > Probably it can be solved by making sure that when sysfs file is 
> > opened/read/written some _race_ free check is done and fail if kobject if gone. 
> > 
> > Maneesh
> 
> Here's a suggestion.  At the start of check_perm() grab the dentry 
> semaphore, then check whether d_fsdata is NULL, if it isn't then do the 
> kobject_get(), then unlock the semaphore.
> 

I have tried this with no luck. I still get 
(Badness in kobject_get at lib/kobject.c:42) which means it is not correct fix.

I am out of any more ideas except something like making sysfs single threaded 
or requesting people to try my sysfs backing store patch set. It does not
suffer from the negative dentries problem as it does not create any negative
dentries. I have to re-diff the patch set again to take recent changes into
account.

Maneesh



-- 
Maneesh Soni
Linux Technology Center, 
IBM Software Lab, Bangalore, India
email: maneesh@in.ibm.com
Phone: 91-80-25044999 Fax: 91-80-25268553
T/L : 9243696
