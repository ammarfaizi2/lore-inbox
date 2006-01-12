Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751414AbWALP54@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751414AbWALP54 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 10:57:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751422AbWALP54
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 10:57:56 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:64446 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751414AbWALP5z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 10:57:55 -0500
Message-ID: <43C67C7E.3070909@us.ibm.com>
Date: Thu, 12 Jan 2006 09:57:50 -0600
From: Anthony Liguori <aliguori@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Mike D. Day" <ncmike@us.ibm.com>
CC: Greg KH <greg@kroah.com>, xen-devel@lists.xensource.com,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [Xen-devel] Re: [RFC] [PATCH] sysfs support for Xen attributes
References: <43C53DA0.60704@us.ibm.com> <20060111230704.GA32558@kroah.com>	<43C5A199.1080708@us.ibm.com> <20060112005710.GA2936@kroah.com>	<43C5B59C.8050908@us.ibm.com> <20060112071000.GA32418@kroah.com> <43C66B56.8030801@us.ibm.com>
In-Reply-To: <43C66B56.8030801@us.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike D. Day wrote:

> Greg KH wrote:
>
>> What other, specific sysfs files are you going to want to create?
>> What is the hierarchy going to look like?
>> What is the contents of the file going to look like?
>
>
> You make a very good point. We have not agreed on the heirarchy and 
> file contents, and  we need to do so before continuing.
> Some _very rough_ ideas include
>
> /sys/xen/version/{major minor extra version build}
> /sys/xen/domain/{dom0 dom1 ... domn} (each domain could be a dir. with 
> attributes)

I don't think we want to expose domain specific information in sysfs.  
Right now, domain lifecycle events are managed in userspace so 
maintaining the kobject hierarchy here would be awkward at best.

> /sys/xen/hypervisor/{scheduler cpu memory}
> /sys/xen/migrate/{hosts_to, hosts_from}

Same thing as above with migration.  Let's try to focus on the minimum 
set of things we need to expose that we cannot expose else where.  There 
are other options (like FUSE) for providing a general filesystem 
management interface that we can do entirely in userspace.

I think Gerd mentioned earlier that ballooning can be exposed via the 
module interface--that's probably a good idea.  The ioctl() interfaces 
should probably be misc char drivers (especially since /dev/evtchn is 
already).

Here's a list of the remaining things we current expose in /proc/xen 
that have no obvious place:

1) capabilities (is the domain a management domain)
2) xsd_mfn (a frame number for our bus so that userspace can connect to it)
3) xsd_evtchn (a virtual IRQ for xen bus for userspace)

I would think these would most obviously go under something like:

/sys/hypervisor/xen/

That would introduce a hypervisor subsystem.  There are at least a few 
hypervisors out there already so this isn't that bad of an idea 
(although perhaps it may belong somewhere else in the hierarchy).  Greg?

Regards,

Anthony Liguori

> These will be text files with simple attrributes. Most will be 
> read-only. It is kind of fun to think about creating a domain by doing 
> something like
>
> cat $domain_config > /sys/xen/domain/new
>
> but there are some ugly aspects of doing so. Likewise it would be good 
> to add a potential migration host by writing an ip address to
> /sys/xen/migrate/hosts_to
>
> Again, we need to get this solidified before going further.
>
>>
>> I think this is happening as you are trying to port your code that
>> currently uses /proc (and file names there) to use sysfs instead, right?
>> To do this correctly, you need to stop thinking about file names and
>> paths, and start thinking about the hierarchy and relationship between
>> the files, which will allow you to create a tree of kobjects easier.
>
>
> yes
>
>> If you answer the questions above, I think we can work to figure this
>> out.
>
>
> Excellent, we will work on doing so.
>
>> I should be happy you didn't try to post them using Notes :)
>
>
> Make that two of us :)


