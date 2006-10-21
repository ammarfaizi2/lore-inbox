Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422639AbWJUQQi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422639AbWJUQQi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 12:16:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423350AbWJUQQi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 12:16:38 -0400
Received: from moutng.kundenserver.de ([212.227.126.183]:64961 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1422639AbWJUQQh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 12:16:37 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Avi Kivity <avi@qumranet.com>
Subject: Re: [PATCH 0/7] KVM: Kernel-based Virtual Machine
Date: Sat, 21 Oct 2006 18:16:27 +0200
User-Agent: KMail/1.9.4
Cc: Muli Ben-Yehuda <muli@il.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
References: <4537818D.4060204@qumranet.com> <20061019173151.GD4957@rhun.haifa.ibm.com> <4537BD27.7050509@qumranet.com>
In-Reply-To: <4537BD27.7050509@qumranet.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200610211816.27964.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:bf0b512fe2ff06b96d9695102898be39
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 19 October 2006 20:00, Avi Kivity wrote:
> Working code is fairly hairy, since it's emulating a PC.  That'll be on
> sourceforge once they approve my new project.
>
> In general one does
>
>   open("/dev/kvm")
>   ioctl(KVM_SET_MEMORY_REGION) for main memory
>   ioctl(KVM_SET_MEMORY_REGION) for the framebuffer
>   ioctl(KVM_CREATE_VCPU) for the obvious reason
>   if (debugger)
>     ioctl(KVM_DEBUG_GUEST) to singlestep or breakpoint the guest
>   while (1) {
>      ioctl(KVM_RUN)
>      switch (exit reason) {
>          handle mmio, I/O etc. might call
>             ioctl(KVM_INTERRUPT) to queue an external interrupt
>             ioctl(KVM_{GET,SET}_{REGS,SREGS}) to query/modify registers
>             ioctl(KVM_GET_DIRTY_LOG) to see which guest memory pages
> have changed
>      }
>
> I have some simple test code, I'll clean it up and post it.

This looks _a_lot_ like what we're doing for the SPUs in the cell processor,
except that we're using different calls into the kernel. Have you looked
into what we have implemented there? The code is in
arch/powerpc/platforms/cell/spufs. I think it would be a good abstraction
to use for you as well, maybe we could even move to a common infrastructure,
as I have heard from a few other projects that want to do similar things.

The main differences to your interface are:

- A file system is used instead of a character device
- Directories, not open file descriptors represent contexts
- Two new syscalls were introduced (spu_create/spu_run)
- instead of ioctls, files represent different bits of information,
  you can read/write, poll or mmap them.

Your example above could translate to something like:

   int kvm_fd = kvm_create("/kvm/my_vcpu")
   int mem_fd = openat(kvm_fd, "mem", O_RDWR);
   void *mem = mmap(mem_fd, ...); // main memory
   void *fbmem = mmap(mem_fd, ...); // frame buffer memory
   int regs_fd = openat(kvm_fd, "regs", O_RDWR);
   int irq_fd = openat(kvm_fd, "regs", O_WRONLY);

   if (debugger) {
     int fd = openat(fvm_fd, "debug", O_WRONLY);
     write(fd, "1", 1);
     close(fd);
   }
   while (1) {
      int exit_reason = kvm_run(kvm_fd, &kvm_descriptor);
      switch (exit reason) {
          handle mmio, I/O etc. might call
             write(irq_fd, &interrupt_packet, sizeof (interrupt_packet));
             pread(regs_fd, &rax, sizeof rax, KVM_REG_RAX);
   }

	Arnd <><
