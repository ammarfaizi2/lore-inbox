Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965021AbVHJGrR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965021AbVHJGrR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 02:47:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965022AbVHJGrR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 02:47:17 -0400
Received: from smtpout.mac.com ([17.250.248.44]:56805 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S965021AbVHJGrQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 02:47:16 -0400
In-Reply-To: <1123654250.3217.5.camel@laptopd505.fenrus.org>
References: <17145.23098.798473.364481@cargo.ozlabs.ibm.com> <1123654250.3217.5.camel@laptopd505.fenrus.org>
Mime-Version: 1.0 (Apple Message framework v733)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <11FC83FD-AAF5-49A0-9C89-1AFB9FC55B2E@mac.com>
Cc: Paul Mackerras <paulus@samba.org>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org, linas@austin.ibm.com
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [RFC/PATCH] Add pci_walk_bus function to PCI core
Date: Wed, 10 Aug 2005 02:47:03 -0400
To: Arjan van de Ven <arjan@infradead.org>
X-Mailer: Apple Mail (2.733)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 10, 2005, at 02:10:49, Arjan van de Ven wrote:
> On Wed, 2005-08-10 at 11:36 +1000, Paul Mackerras wrote:
>
>> Greg,
>>
>> Any comments on this patch?  Would you be amenable to it going in  
>> post
>> 2.6.13?
>>
>> The PCI error recovery infrastructure needs to be able to contact all
>> the drivers affected by a PCI error event, which may mean traversing
>> all the devices under a given PCI-PCI bridge.  This patch adds a
>> function to the PCI core that traverses all the PCI devices on a PCI
>> bus and under any PCI-PCI bridges on that bus (recursively),  
>> calling a
>> given function for each device.
>
> is there a way to avoid the recursion somehow? Recursion is "not fun"
> stack usage wise, esp if you have really deep hierarchies....

Hmm, it looks like PCI error recovery wants breadth-first recursion, so
you should be able to do some sort of tail-recursion or something.  If
only one error-recovery action on a given subtree can be going at a  
time,
you should be able to add an "error_recovery" linked-list to the device
structure and do something like this:

void recover(...) {
     struct list_head recovery_list = LIST_HEAD_INIT(recovery_list);
     list_add(&dev->error_recovery, &recovery_list);

     while(!list_empty(&recovery_list)) {
         struct some_device_type *dev =
             list_entry(recovery_list->next, struct some_device_type,  
error_recovery);

         dev->some_recovery_function(dev, [...]);

         list_del(&dev->error_recovery);
     }
}

Then each PCI-PCI bridge's some_recovery_function could do this:

void some_recovery_function(struct some_device_type *dev, [...]) {
     struct some_device_type *child;

     actually_do_my_recovery();

     list_for_each_entry(child, dev->some_pci_subdev_list,  
some_pci_list) {
         if (needs_recovery(child))
             list_add_tail(&child->error_recovery,&dev->error_recovery);
     }
}

With such an arrangement, the callstack is as shallow as possible:

recover
     some_recovery_function
         actually_do_my_recovery
         needs_recovery
     childs_recovery_function
     [...]

If you can have multiple simultaneous error-recovery actions per  
subtree,
that wouldn't properly work unless they were exclusive-blocking, IE:
an error recovery action triggers an error on a subtree which must
recover itself.  In that case, with some extra state saved in the  
recover
function and passed to the "some_recovery_function", you could allow the
other recovery to continue before resuming.

If you can have two CPUs recovering the same device tree, I'd be  
inclined
to wonder what kind of strange errors you're causing on the PCI bus :-D,
and I'd be interested in an example of how that could work in any  
sane way.

Cheers,
Kyle Moffett

--
Premature optimization is the root of all evil in programming
   -- C.A.R. Hoare



