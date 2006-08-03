Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932567AbWHCVl2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932567AbWHCVl2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 17:41:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932581AbWHCVl2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 17:41:28 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:20447 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S932567AbWHCVl1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 17:41:27 -0400
Message-ID: <44D26D87.2070208@vmware.com>
Date: Thu, 03 Aug 2006 14:41:27 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>,
       Rusty Russell <rusty@rustcorp.com.au>, Jack Lo <jlo@vmware.com>
Subject: Re: A proposal - binary
References: <44D1CC7D.4010600@vmware.com> <20060803190605.GB14237@kroah.com> <44D24DD8.1080006@vmware.com> <20060803200136.GB28537@kroah.com>
In-Reply-To: <20060803200136.GB28537@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Thu, Aug 03, 2006 at 12:26:16PM -0700, Zachary Amsden wrote:
>   
>> Greg KH wrote:
>>     
>>> Sorry, but we aren't lawyers here, we are programmers.  Do you have a
>>> patch that shows what you are trying to describe here?  Care to post it?
>>>  
>>>       
>> <Posts kernel/module.c unmodified>
>>     
>
> If you want to stick with the current kernel module interface, I don't
> see why you even need to bring this up, there are no arguments about
> that API being in constant flux :)
>   

Hence my point follows.  Using source compiled with the kernel as a 
module does nothing to provide a stable interface to the backend 
hardware / hypervisor implementation.

>   
>>> How does this differ with the way that the Xen developers are proposing?
>>> Why haven't you worked with them to find a solution that everyone likes?
>>>  
>>>       
>> We want our backend to provide a greater degree of stability than a pure 
>> source level API as the Xen folks have proposed.  We have tried to 
>> convince them that an ABI is in their best interest, but they are 
>> reluctant to commit to one or codesign one at this time.
>>     
>
> Don't you feel it's a bit early to "commit" to anything yet when we
> don't have a working implementation?  Things change over time, and it's
> one of the main reasons Linux is so successful.
>   

We have a working implementation of an ABI that interfaces to both ESX 
and Xen.  I have no argument that things change over time, and that 
helps Linux to be successful and adaptive.  But the fact that things 
change so much over time is the problem.  Distributing a hypervisor that 
runs only one particular version of some hacked up kernel is almost 
useless from a commercial standpoint.  Most end users get their kernels 
from some distro, and these kernels have a long lifetime, while the 
release cycle for an entire OS distribution is getting much longer.  
During that time, the hypervisor and the kernel will diverge.  If is not 
a question of if - it is a question of how much.  A well designed ABI 
slows that divergence to a pace that allows some hope of compatibility.  
An ad-hoc source layer compatibility does not.


>>> And what about Rusty's proposal that is supposed to be the "middle
>>> ground" between the two competing camps?  How does this differ from
>>> that?  Why don't you like Rusty's proposal?
>>>  
>>>       
>> Who said that?  Please smack them on the head with a broom.  We are all 
>> actively working on implementing Rusty's paravirt-ops proposal.  It 
>> makes the API vs ABI discussion moot, as it allow for both.
>>     
>
> So everyone is still skirting the issue, oh great :)
>   

There are many nice things about Rusty's proposal that allow for a 
simpler and cleaner interface to Linux - for example, getting rid of the 
need to have a special hypervisor sub-architecture, and allowing 
non-performance critical operations to be indirected for flexibility of 
implementation.

The Xen ABI as it stands today is not cleanly done - it assumes too many 
details about how the hypervisor will operate, and is purely a 
hypervisor specific ABI.  We and other vendors would have to bend over 
backwards and jump through flaming hoops while holding our breath in a 
cloud of sulfurous gas to implement that interface.  And there is no 
guarantee that the interface will remain stable and compatible.  So it 
is really a non-starter.

VMI as it stands today is hypervisor independent, and provides a much 
more stable and compatible interface.  Although I believe it is possible 
that it could work for other vendors than just VMware and Xen, those 
other vendors could have their own, proprietary, single purpose ABI that 
is either deliberately hypervisor specific or accidentally so from a 
lack of forethought.  <Zach removes soapbox>.

As you mention, Linux is adaptive and will change going forward.  
Rusty's proposal allows a way to accommodate that change until such a 
time as a true vendor independent hypervisor agnostic ABI evolves.  
Hopefully in time it will - but that is not the case today, despite our 
sincere efforts to make it happen.  In fairness, we could have been more 
public and forthcoming about our interface, but we also have not 
received significant cooperation or collaboration on our efforts until 
the work on paravirt-ops began.  With the code coming into public 
scrutiny and the goal of working together, perhaps our model can serve 
as a blueprint, or at least a rough draft of what a long term stable ABI 
will look like.  But that is neither here nor there until the code is 
working and ready to go.  Paravirt-ops provides a nice house for this - 
it lets us all speak the same language in Linux, even if we have to 
phone our hypervisor in Sanskrit and Xen speaks in Latin.  Creating a 
common lingua franca is still an excellent goal, but we can't predict 
the future.  Hopefully, nobody starts using smoke signals.  In the end, 
paravirt-ops allows us all to play on the same field, and either a 
unified hypervisor independent solution will win, or the hypervisor 
interfaces will fragment, and Linux will still have an interface that 
allows it to run on multiple hypervisors.  Either way, Linux gets more 
functionality and better performance in more environments, which is the 
real win.

Zach
