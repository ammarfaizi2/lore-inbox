Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964969AbWALBtU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964969AbWALBtU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 20:49:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964970AbWALBtU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 20:49:20 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:34178 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S964969AbWALBtT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 20:49:19 -0500
Message-ID: <43C5B59C.8050908@us.ibm.com>
Date: Wed, 11 Jan 2006 20:49:16 -0500
From: "Mike D. Day" <ncmike@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Macintosh/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: lkml <linux-kernel@vger.kernel.org>, xen-devel@lists.xensource.com
Subject: Re: [RFC] [PATCH] sysfs support for Xen attributes
References: <43C53DA0.60704@us.ibm.com> <20060111230704.GA32558@kroah.com> <43C5A199.1080708@us.ibm.com> <20060112005710.GA2936@kroah.com>
In-Reply-To: <20060112005710.GA2936@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:

>>I think it comes down to simplification for non-driver code, which is 
>>admittedly not the mainstream use model for sysfs.
> 
> /sys/module/ is a pretty "mainstream use model for sysfs", right?

Yes, but xen is not a module. I believe /sys/xen/ is different than 
/sys/module/, and provide some further reasoning below.

>>The module version? Xen is not a module nor a driver, so that interface 
>>doesn't quite serve the purpose.
> 
> Then it doesn't need a separate version, as it is the same as the main
> kernel version, right?  Just because your code is out-of-the-tree right

No. For example, I could run linux-2.6.x in a domain under xen 3.0.0. In 
this case the xen version is 3.0.0, the linux version is 2.6.x. I could 
run the very same kernel on xen 3.0.1, xen 3.1, and eventually xen 
4.x.x. The xen version exists outside of the linux kernel version, but 
userspace will have good reasons to want to know the xen version (think 
management tools).
> 
> Huh?  You can't just throw a "MODULE_VERSION()", and a module_init()
> somewhere into the xen code to get this to happen?  Then all of your
> configurable paramaters show up automagically.

No, I can't. Xen does not have modules. Xen loads and runs linux. I am 
trying to make it simple for linux to represent xen attributes under 
/sys/xen. This is analogous to a kernel module representing the kernel. 
I know it is weird.

>>/sys/xen/version may not be the best example for this discussion. What
>>is important is that this attribute is obtained from Xen using a
>>hypercall. Sysfs works great to prove the xen version and other
>>similar xen attributes to userspace.
> 
> 
> Like what?  Specifics please.

What privileges are granted to the kernel by xen - can the kernel 
control real devices or just virtual ones. How many other domains 
(virtual machines) are being hosted by xen? How much memory is available 
for ballooning (increasing the memory used by kernels through the 
remapping of pages inside the hypervisor). Can the domain be migrated to 
another physical host? What scheduler is Xen using (xen has plug-in 
schedulers)? All the actual information resides within the xen 
hypervisor, not the linux kernel.

> So you want to divorce the relationship in sysfs between directories and
> kobjects?  

Not quite, just hide the relationship for users of sysfs that have no 
reason to know about it.

That's a valid proposal, but just don't do it as a xen
specific thing please, that's being selfish.

ok

> But I think you will fail in this, as we want to keep a very strict
> heirachy in sysfs, as userspace relies on this.  See the previous
> proposal from Pat Mochel to try to do this (in the lkml archives) for
> the problems when he tried to do so.

Hence why I created this as a xeno-linux patch. I can control where the 
sysfs files get created. For example, I check to make sure the path 
starts with "/sys/xen." I don't want to interfere with keeping a strict 
heirarchy.

> 
>>Currently in xeno-linux there are several files under /proc/xen. These 
>>are created by different areas of the xeno-linux kernel. In xeno-linux 
>>today there is a single higher-level routine that each of these 
>>different areas uses to create its own file under /proc/xen. In other 
>>words, I think there should be a unifying element to the interface 
>>because the callers are not organized within a single module.
> 
> Ok, but again, that's no different than anything else in the kernel,
> right?

I think that it is different. The sysfs attributes are being created by 
the kernel, not a driver or module. The attribute values themselves are 
located in the xen hypervisor, which is totally outside of the kernel 
and everything it controls.

> not be applied due to a broken email client setup, tried to do all of
> the work in your own subsection of an external kernel tree that seems to

I worked within the xen project hoping that the code might get applied 
there and later merged.

> strongly avoid getting merged into mainline, ignored the existing kernel
> interfaces, 

No, I didn't ignore them. I may be mistaken, but I believe this is a 
different use model.

and didn't cc: the subsystem maintainer.

Sorry, will make certain to cc: the maintainer in the future.

Mike
-- 

Mike D. Day
STSM and Architect, Open Virtualization
IBM Linux Technology Center
ncmike@us.ibm.com
