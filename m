Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261880AbUCaJWN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 04:22:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261884AbUCaJWN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 04:22:13 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:7160 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S261880AbUCaJWI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 04:22:08 -0500
Date: Wed, 31 Mar 2004 14:56:31 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, greg@kroah.com,
       torvalds@osdl.org, stern@rowland.harvard.edu, david-b@pacbell.net,
       viro@math.psu.edu, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] [PATCH] back out sysfs reference count change
Message-ID: <20040331092631.GA21484@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <20040328123857.55f04527.akpm@osdl.org> <20040329210219.GA16735@kroah.com> <20040329132551.23e12144.akpm@osdl.org> <20040329231604.GA29494@kroah.com> <20040329153117.558c3263.akpm@osdl.org> <20040330055135.GA8448@in.ibm.com> <20040330230142.GA13571@kroah.com> <20040330235533.GA9018@kroah.com> <1080699090.1198.117.camel@gaston> <20040330181915.401b8a04.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040330181915.401b8a04.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2004 at 06:19:15PM -0800, Andrew Morton wrote:
> 
> But it looks like that's all in a faraway perfect world, and Greg is going
> to fix stuff up somehow ;)

For convenience I will explain the race here..

cpu 0							cpu 1
kobject_unregister()				   sysfs_open_file()
  kobject_del()					     check_perm()
    sysfs_remove_dir()					   :
     (dentry remains alive due to ref. taken 		   :
      on the way to sysfs_open_file)			   :
  kobject_put()					   	   :
    kobject_cleanup()					kobject_get(->d_fsdata)

cpu 1 could end up referring to a freed kobject through dentry->d_fsdata or
starts spitting Badness in kobject_get at lib/kobject.c:429. For triggering 
this race try running these two loops simultaneously on SMP 

# while true; do insmod drivers/net/dummy.ko; rmmod dummy; done
# while true; do find /sys/class/net | xargs cat; done

Probably it can be solved by making sure that when sysfs file is 
opened/read/written some _race_ free check is done and fail if kobject if gone. 

Maneesh


-- 
Maneesh Soni
Linux Technology Center, 
IBM Software Lab, Bangalore, India
email: maneesh@in.ibm.com
Phone: 91-80-25044999 Fax: 91-80-25268553
T/L : 9243696
