Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932580AbVHJWgU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932580AbVHJWgU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 18:36:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932582AbVHJWgU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 18:36:20 -0400
Received: from mail.kroah.org ([69.55.234.183]:50383 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932580AbVHJWgT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 18:36:19 -0400
Date: Wed, 10 Aug 2005 15:35:53 -0700
From: Greg KH <greg@kroah.com>
To: Maneesh Soni <maneesh@in.ibm.com>
Cc: Keith Owens <kaos@sgi.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc4 use after free in class_device_attr_show
Message-ID: <20050810223552.GB6045@kroah.com>
References: <20050802080422.GA32556@in.ibm.com> <15242.1123655211@kao2.melbourne.sgi.com> <20050810100636.GB5334@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050810100636.GB5334@in.ibm.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 10, 2005 at 03:36:36PM +0530, Maneesh Soni wrote:
> On Wed, Aug 10, 2005 at 04:26:51PM +1000, Keith Owens wrote:
> > FYI, the intermittent free after use in sysfs is still there in
> > 2.6.13-rc6.
> > 
> 
> The race condition is known here. It is some thing in the upper layer. 
> In this case "driver/base/class.c" which frees the kobject's attributes 
> even if there are live references to kobject.
> 
> 
> open sysfs file				unregister class device
> sysfs_open_file()			class_device_del()
>   -> takes a ref on kobject		  -> kfree attribute struct
>      -> accesses attributes		  -> kobject_del()
> 					      -> kref_put()	
> close sysfs file				  
> sysfs_release()				    
>   -> acesses attributes using s_element
>   -> drops ref to kobject
> 
> Solution could be either we have reference counting for attributes also
> or keep attributes alive till the last reference to the kobject. Both these
> needs changes in the driver core.
> 
> Greg, will the following patch make sense? This postpones the kfree() of
> devt_attr till class_dev_release() is called. 

Yes, that patch looks good, if you fix up the space vs. tabs issue :)

But will that really fix this race?  I was under the impression the oops
didn't come from trying to access the devt_attr, but the sysfs s_element
pointer?

> Please check this patch out, if this helps or not.

I'd be interested in seeing if this fixes it.

thanks,

greg k-h
