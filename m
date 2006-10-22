Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751326AbWJVRkG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751326AbWJVRkG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 13:40:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751761AbWJVRkF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 13:40:05 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:54419 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751326AbWJVRkE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 13:40:04 -0400
Message-ID: <453BACEF.9010106@us.ibm.com>
Date: Sun, 22 Oct 2006 12:39:59 -0500
From: Anthony Liguori <aliguori@us.ibm.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To: Avi Kivity <avi@qumranet.com>
CC: Arnd Bergmann <arnd@arndb.de>, Muli Ben-Yehuda <muli@il.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 0/7] KVM: Kernel-based Virtual Machine
References: <4537818D.4060204@qumranet.com> <20061019173151.GD4957@rhun.haifa.ibm.com> <4537BD27.7050509@qumranet.com> <200610211816.27964.arnd@arndb.de> <453B2DDB.3010303@qumranet.com>
In-Reply-To: <453B2DDB.3010303@qumranet.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Avi Kivity wrote:
> Arnd Bergmann wrote:
>> This looks _a_lot_ like what we're doing for the SPUs in the cell 
>> processor,
>> except that we're using different calls into the kernel. Have you looked
>> into what we have implemented there? The code is in
>> arch/powerpc/platforms/cell/spufs. I think it would be a good 
>> abstraction
>> to use for you as well, maybe we could even move to a common 
>> infrastructure,
>> as I have heard from a few other projects that want to do similar 
>> things.
>>
>> The main differences to your interface are:
>>
>> - A file system is used instead of a character device
>> - Directories, not open file descriptors represent contexts
>> - Two new syscalls were introduced (spu_create/spu_run)
>> - instead of ioctls, files represent different bits of information,
>>   you can read/write, poll or mmap them.
>>
>> Your example above could translate to something like:
>>
>>    int kvm_fd = kvm_create("/kvm/my_vcpu")
>>    int mem_fd = openat(kvm_fd, "mem", O_RDWR);
>>    void *mem = mmap(mem_fd, ...); // main memory
>>    void *fbmem = mmap(mem_fd, ...); // frame buffer memory
>>    int regs_fd = openat(kvm_fd, "regs", O_RDWR);
>>    int irq_fd = openat(kvm_fd, "regs", O_WRONLY);
>>
>>    if (debugger) {
>>      int fd = openat(fvm_fd, "debug", O_WRONLY);
>>      write(fd, "1", 1);
>>      close(fd);
>>    }
>>    while (1) {
>>       int exit_reason = kvm_run(kvm_fd, &kvm_descriptor);
>>       switch (exit reason) {
>>           handle mmio, I/O etc. might call
>>              write(irq_fd, &interrupt_packet, sizeof 
>> (interrupt_packet));
>>              pread(regs_fd, &rax, sizeof rax, KVM_REG_RAX);
>>    }
>>   
>
> [cc'ing some others to solicit their opinion]
>
> I like this.  Since we plan to support multiple vcpus per vm, the fs 
> structure might look like:

I like the idea of a filesystem.  In particular, if you exposed the CPU 
state as a mmap()'able file, you could read/write from userspace without 
any syscall overhead.

There are some clever ways that you could get around need that many 
syscalls.  For instance, you could have a "paused" file that you could 
write a "1" into in order to run the guest (assuming that the memory/CPU 
state is setup properly).

You could then have an "event" file that you could select() for read 
on.  When "event" became readable, you could read the exit reason, do 
whatever is needed, and then write a "1" into "paused" again.

Perhaps an ioctl is better for pausing/unpausing but I do think it's 
necessary to select() on something to wait for the next exit reason to 
occur.

Regards,

Anthony Liguori

> /kvm/my_vm
>    |
>    +----memory          # mkdir to create memory slot.
>    |     |              #    how to set size and offset?
>    |     |
>    |     +---0          # guest physical memory slot
>    |         |
>    |         +-- dirty_bitmap  # read to get and atomically reset
>    |                           # the changed pages log
>    |
>    |
>    +----cpu             # mkdir/rmdir to create/remove vcpu
>          |
>          +----0
>          |     |
>          |     +--- irq     # write to inject an irq
>          |     |
>          |     +--- regs    # read/write to get/set registers
>          |     |
>          |     +--- debugger   # write to set breakpoints/singlestep mode
>          |
>          +----1
>                [...]
>
> It's certainly a lot more code though, and requires new syscalls.  
> Since this is a little esoteric does it warrant new syscalls?
>

