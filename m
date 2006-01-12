Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932672AbWALAX6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932672AbWALAX6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 19:23:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932673AbWALAX5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 19:23:57 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:45738 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S932672AbWALAX5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 19:23:57 -0500
Message-ID: <43C5A199.1080708@us.ibm.com>
Date: Wed, 11 Jan 2006 19:23:53 -0500
From: "Mike D. Day" <ncmike@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Macintosh/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: lkml <linux-kernel@vger.kernel.org>, xen-devel@lists.xensource.com
Subject: Re: [RFC] [PATCH] sysfs support for Xen attributes
References: <43C53DA0.60704@us.ibm.com> <20060111230704.GA32558@kroah.com>
In-Reply-To: <20060111230704.GA32558@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:

> Why is xen special from the rest of the kernel in regards to adding
> files to sysfs?  What does your infrastructure add that is not currently
> already present for everyone to use today?

I think it comes down to simplification for non-driver code, which is 
admittedly not the mainstream use model for sysfs.

> 
> Why is the xen version any different from any other module or driver
> version in the kernel? (hint, use the interface that is availble for
> this already...)

The module version? Xen is not a module nor a driver, so that interface 
doesn't quite serve the purpose. True, one could create a "Xen module" 
that talks to Xen the hypervisor, but then the version interface would 
provide the version of the xen module, not the version of the xen 
hypervisor. /sys/xen/version may not be the best example for this 
discussion. What is important is that this attribute is obtained from 
Xen using a hypercall. Sysfs works great to prove the xen version and 
other similar xen attributes to userspace.

> 
> You have access to the current tree as well as we do to be able to
> answer this question :)

Right. Dumb question.

> You don't have to create a driver subsystem to be able to add stuff to
> sysfs, what makes you think that?

Sorry, you are right. But you do need to have s struct dev or use 
kobjects. What I want is an interface to create sysfs files using a path 
as a parameter, rather than a struct kobject.

> did you look at debugfs?  

yes

> configfs?

no. configfs may be a better choice. I would still want a higher-level 
kernel interface similar to what is in the patch, as explained below. 
But I think sysfs may be more appropriate because attributes show up 
automatically without a user-space action being taken.

> What is wrong with the current kobject/sysfs/driver model interface that
> made you want to create this extra code?

Nothing is wrong, but I want a higher-level interface, to be able to 
create files and directories using a path, and to allow a code that is 
not associated with a device to create sysfs files by specifying a path. 
e.g., create(path, mode, ...).

Currently in xeno-linux there are several files under /proc/xen. These 
are created by different areas of the xeno-linux kernel. In xeno-linux 
today there is a single higher-level routine that each of these 
different areas uses to create its own file under /proc/xen. In other 
words, I think there should be a unifying element to the interface 
because the callers are not organized within a single module.


> Aren't you already going to have a xen virtual bus in sysfs and the
> driver model?  Why not just put your needed attributes there, where they
> belong (on the devices themselves)?

the xenbus, which is now in xen 3.0, allows kernels running in xen 
domains to get access to virtual devices hosted in a driver 
domain/domain0. But the attributes I am creating in /sys/xen are xen 
attributes, not device attributes. The difference is important to 
consumers of the attributes. I could create a device just to export 
hypervisor attributes, but I think the what I've done is simpler.


>>+#define __sysfs_ref__
> 
> 
> Why? 

A simple way to denote functions that get a reference to a reference 
counted object. e.g., int __sysfs_ref__ foo(void);  gone.

> 
> 
>>+struct xen_sysfs_object;
>>+
>>+struct xen_sysfs_attr {
>>+       struct bin_attribute attr;
>>+       ssize_t (*show)(void *, char *) ;
>>+       ssize_t (*store)(void *, const char *, size_t) ;
>>+       ssize_t (*read)(void *, char *, loff_t, size_t );
>>+       ssize_t (*write)(void *, char *, loff_t, size_t) ;
>>+};
> 
> 
> Why a binary attribute?  Do you want to have more than one single piece
> of info in here?  If so, no.

To facilitate creation of binary files. struct bin_attribute contains a 
struct attribute, so it is an alternative to using a union.

Mike (hoping he doesn't end up on linux kernel monkey log)

-- 

Mike D. Day
STSM and Architect, Open Virtualization
IBM Linux Technology Center
ncmike@us.ibm.com
