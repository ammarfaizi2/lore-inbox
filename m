Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750860AbWJVPX5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750860AbWJVPX5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 11:23:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750896AbWJVPX5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 11:23:57 -0400
Received: from moutng.kundenserver.de ([212.227.126.188]:8900 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1750860AbWJVPX4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 11:23:56 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Avi Kivity <avi@qumranet.com>
Subject: Re: [PATCH 0/7] KVM: Kernel-based Virtual Machine
Date: Sun, 22 Oct 2006 17:23:48 +0200
User-Agent: KMail/1.9.5
Cc: Muli Ben-Yehuda <muli@il.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Anthony Liguori <aliguori@us.ibm.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
References: <4537818D.4060204@qumranet.com> <200610211816.27964.arnd@arndb.de> <453B2DDB.3010303@qumranet.com>
In-Reply-To: <453B2DDB.3010303@qumranet.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200610221723.48646.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:bf0b512fe2ff06b96d9695102898be39
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 22 October 2006 10:37, Avi Kivity wrote:
> I like this.  Since we plan to support multiple vcpus per vm, the fs
> structure might look like:
>
> /kvm/my_vm
>     |
>     +----memory          # mkdir to create memory slot.

Note that the way spufs does it, every directory is a reference-counted
object. Currently that includes single contexts and groups of
contexts that are supposed to be scheduled simultaneously.

The trick is that we use the special 'spu_create' syscall to
add a new object, while naming it, and return an open file
descriptor to it. When that file descriptor gets closed, the
object gets garbage-collected automatically.

This way you can simply kill a task, which also cleans up
all the special objects it allocated.

We ended up adding a lot more file than we initially planned,
but the interface is really handy, especially if you want to
create some procps-like tools for it.

>     |     |              #    how to set size and offset?
>     |     |
>     |     +---0          # guest physical memory slot
>     |         |
>     |         +-- dirty_bitmap  # read to get and atomically reset
>     |                           # the changed pages log

Have you thought about simply defining your guest to be a section
of the processes virtual address space? That way you could use
an anonymous mapping in the host as your guest address space, or
even use a file backed mapping in order to make the state persistant
over multiple runs. Or you could map the guest kernel into the
guest real address space with a private mapping and share the
text segment over multiple guests to save L2 and RAM.

>     |
>     |
>     +----cpu             # mkdir/rmdir to create/remove vcpu
>           |

I'd recommend not allowing mkdir or similar operations, although
it's not that far off. One option would be to let the user specify
the number of CPUs at kvm_create() time, another option might
be to allow kvm_create with a special flag or yet another syscall
to create the vcpu objects.

>           +----0
>           |     |
>           |     +--- irq     # write to inject an irq
>           |     |
>           |     +--- regs    # read/write to get/set registers
>           |     |
>           |     +--- debugger   # write to set breakpoints/singlestep mode
>           |
>           +----1
>                 [...]
>
> It's certainly a lot more code though, and requires new syscalls.  Since
> this is a little esoteric does it warrant new syscalls?

We've gone through a number of iterations on the spufs design regarding this,
and in the end decided that the garbage-collecting property of spu_create
was superior to any other option, and adding the spu_run syscall was then
the logical step. BTW, one inspiration for spu_run came from sys_vm86, which
as you are probably aware of is already doing a lot of what you do, just
not for protected mode guests.

	Arnd <><
