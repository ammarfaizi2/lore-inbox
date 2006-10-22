Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751145AbWJVQSi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751145AbWJVQSi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 12:18:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751155AbWJVQSi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 12:18:38 -0400
Received: from mis011-1.exch011.intermedia.net ([64.78.21.128]:55686 "EHLO
	mis011-1.exch011.intermedia.net") by vger.kernel.org with ESMTP
	id S1751145AbWJVQSh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 12:18:37 -0400
Message-ID: <453B99D7.1050004@qumranet.com>
Date: Sun, 22 Oct 2006 18:18:31 +0200
From: Avi Kivity <avi@qumranet.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
CC: Muli Ben-Yehuda <muli@il.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Anthony Liguori <aliguori@us.ibm.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 0/7] KVM: Kernel-based Virtual Machine
References: <4537818D.4060204@qumranet.com> <200610211816.27964.arnd@arndb.de> <453B2DDB.3010303@qumranet.com> <200610221723.48646.arnd@arndb.de>
In-Reply-To: <200610221723.48646.arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Oct 2006 16:18:36.0859 (UTC) FILETIME=[BA5568B0:01C6F5F5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann wrote:
> On Sunday 22 October 2006 10:37, Avi Kivity wrote:
>   
>> I like this.  Since we plan to support multiple vcpus per vm, the fs
>> structure might look like:
>>
>> /kvm/my_vm
>>     |
>>     +----memory          # mkdir to create memory slot.
>>     
>
> Note that the way spufs does it, every directory is a reference-counted
> object. Currently that includes single contexts and groups of
> contexts that are supposed to be scheduled simultaneously.
>
> The trick is that we use the special 'spu_create' syscall to
> add a new object, while naming it, and return an open file
> descriptor to it. When that file descriptor gets closed, the
> object gets garbage-collected automatically.
>   

Yes.  Well, a single fd and ioctl()s do that as well.

>
> We ended up adding a lot more file than we initially planned,
> but the interface is really handy, especially if you want to
> create some procps-like tools for it.
>
>   

I don't really see the need.  The cell dsps are a shared resource, while 
virtual machines are just another execution mode of an existing resource 
- the main cpu, which has a sharing mechanism (the scheduler and 
priorities).


>>     |     |              #    how to set size and offset?
>>     |     |
>>     |     +---0          # guest physical memory slot
>>     |         |
>>     |         +-- dirty_bitmap  # read to get and atomically reset
>>     |                           # the changed pages log
>>     
>
> Have you thought about simply defining your guest to be a section
> of the processes virtual address space? That way you could use
> an anonymous mapping in the host as your guest address space, or
> even use a file backed mapping in order to make the state persistant
> over multiple runs. Or you could map the guest kernel into the
> guest real address space with a private mapping and share the
> text segment over multiple guests to save L2 and RAM.
>   

I've thought of it but it can't work on i386 because guest physical 
address space is larger than virtual address space on i386.  So we 
mmap("/dev/kvm") with file offsets corresponding to guest physical 
addresses.

I still like that idea, since it allows using hugetlbfs and allowing 
swapping.  Perhaps we'll just accept the limitation that guests on i386 
are limited.

>   
>>     |
>>     |
>>     +----cpu             # mkdir/rmdir to create/remove vcpu
>>           |
>>     
>
> I'd recommend not allowing mkdir or similar operations, although
> it's not that far off. One option would be to let the user specify
> the number of CPUs at kvm_create() time, another option might
> be to allow kvm_create with a special flag or yet another syscall
> to create the vcpu objects.
>   

Okay.

>   
>>           +----0
>>           |     |
>>           |     +--- irq     # write to inject an irq
>>           |     |
>>           |     +--- regs    # read/write to get/set registers
>>           |     |
>>           |     +--- debugger   # write to set breakpoints/singlestep mode
>>           |
>>           +----1
>>                 [...]
>>
>> It's certainly a lot more code though, and requires new syscalls.  Since
>> this is a little esoteric does it warrant new syscalls?
>>     
>
> We've gone through a number of iterations on the spufs design regarding this,
> and in the end decided that the garbage-collecting property of spu_create
> was superior to any other option, and adding the spu_run syscall was then
> the logical step. BTW, one inspiration for spu_run came from sys_vm86, which
> as you are probably aware of is already doing a lot of what you do, just
> not for protected mode guests.
>   

Yes, we're doing a sort of vmx86_64().

Thanks for the ideas, I'm certainly leaning towards a filesystem based 
approach and I'll also reconsider the mapping (mmap() vi virtual address 
space subsection).

-- 
error compiling committee.c: too many arguments to function

