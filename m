Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <160240-219>; Fri, 11 Dec 1998 21:30:24 -0500
Received: from post-11.mail.demon.net ([194.217.242.40]:56950 "EHLO post.mail.demon.net" ident: "NO-IDENT-SERVICE[2]") by vger.rutgers.edu with ESMTP id <160274-219>; Fri, 11 Dec 1998 09:01:06 -0500
Message-ID: <19981211141622.A11270@tantalophile.demon.co.uk>
Date: Fri, 11 Dec 1998 14:16:22 +0000
From: Jamie Lokier <lkd@tantalophile.demon.co.uk>
To: Linux Lists <lists@cyclades.com>, linux-kernel@vger.rutgers.edu
Subject: Re: Access to I/O-mapped / Memory-mapped resources
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2
In-Reply-To: <no.id>; from Linux Lists on Wed, Dec 09, 1998 at 03:19:10PM -0800
Sender: owner-linux-kernel@vger.rutgers.edu

On Wed, Dec 09, 1998 at 03:19:10PM -0800, Linux Lists wrote:
> I have a question: is there any reference in regards to how / when to use
> the virt_to_phys, virt_to_bus, ioremap, etc. ... functions, other than 
> /usr/src/linux/Documentation/IO-mapping.txt ?!? I'd like to understand it
> better, but this text has not been enough (for me, of course).

Well, the whole address thing is a bit messy anyway; I don't expect a
perfect understanding of it is even possible...

But in case it helps, try the document below.

> If there is no other way, I'll try to re-read it 1000 times to see if my
> understanding increases 1000 times as well ... ;)

Do that :-)

	linux/Documentation/IO-mapping.txt
        ----------------------------------

...is a little out of date but basically right.  Give it a read.
Then read this addendum; it might clarify things a bit.

Types of address
================

*bus* is an address you pass to devices.  E.g., what you'd write to a
PCI bus-mastering DMA device for its target address.  To access a bus
address from kernel C code, known as memory-mapped I/O, you must use
ioremap() to convert it to an *ioremap* address.  From C code, these
should always be accessed through readl(), writel() etc. and not as
ordinary memory references.  See <asm/io.h>.

*phys* is a CPU address after MMU translation.  It only appears in page
tables and things related to page tables.  Even this is hidden to some
extent because pte_page(*pte) returns a *virt* address despite appearances.
See <asm/pgtable.h>.

*virt* is a kernel direct-mapped address.  These are addresses you can
read and write from C, that correspond to main memory.  E.g., on x86,
the *virt* address 0xc0001000 means the 4097th byte of main memory.  See
<asm/page.h>.

There are other kinds of address too:

*user* addresses (such as passed to read() and write()) are
none of the above, and should always by accessed through get_user(),
put_user() etc.  See <asm/uaccess.h>.

*static* addresses are the addresses of functions and variables that are
declared in source code.  Because kernel code and modules are allocated
in various ways, you can't assume much about these addresses, but you
can always read and write them from kernel C code.

*vmalloc* addresses (returned by vmalloc()).  These are kernel virtual
address, which you can read and write from kernel C code.  But you can't
pass them to any of the virt_to_XXX macros, because they're *not* *virt*
addresses!  See <linux/vmalloc.h>.

*fixmap* addresses (returned by fix_to_virt()) (which has a misleading
name).  These are like *vmalloc* addresses: you can't pass them to the
virt_to_XXX macros, so they're _not_ *virt* addresses.  It's not very
clear if you're supposed to use readl() and writel() to access these.
See <asm/fixmap.h>.

*ioremap* addresses are returned by ioremap(), which takes a *bus*
address.  These have some similarity to *vmalloc* addresses, but you can
only use readl(), writel() etc. to access the device memory referred to
here.  Unhelpfully, just reading and writing these directly does work on
some architectures, and most older device drivers still do this.

Memory map
==========

The actual memory map varies a lot between architectures.  But since
someone asked, I'll give a quick summary of one particular memory map.
This example is for an i386 architecture: a particular 64MB Pentium II
dual processor box with PCI and an ISA bridge.

Virtual map
...........

This is what C code sees in user mode:

0x00000000-0xbfffffff  User space virtual memory mappings.

This is what C code sees in kernel mode:

0x00000000-0xbfffffff User space virtual memory mappings (current->mm context).
0xc0000000-0xc3ffffff 64MB kernel view of all of main memory, uses 4MB pages.
0xc4000000-0xc47fffff 8MB unmapped hole.
0xc4800000-0xffffbfff Kernel virtual mappings for vmalloc() and ioremap().
0xffffc000-0xffffcfff Memory mapped local APIC registers.
0xffffd000-0xffffdfff Memory mapped IO-APIC registers.

The 64MB view is subdivided like this (it depends on the PC's details):

0xc0000000-0xc00003ff Zero page, reserved for BIOS.
0xc0000000-0xc009ffff Low memory (first 640k minus zero page).
0xc00a0000-0xc00fffff Low memory-mapped I/O (especially VGA adapter) and ROMs.
0xc0100000-0xc3ffffff High memory (remaining 63MB).

The 64MB view at 0xc0000000 (= PAGE_OFFSET) is directly addressable main
memory.  This is simply memory addresses with PAGE_OFFSET added.  This
contains the main kernel image, and memory allocated with kmalloc(),
get_free_page() and the slab allocator.  Cached disk pages, network
buffers etc. are all addressed in this space.

The 64MB view is the *virt* addresses described earlier.  "Virtual" here
simply refers to the PAGE_OFFSET translation, nothing more.

The vmalloc() mappings are a different way to see this memory, used only
when a large, contiguous address range needs to be allocated.  This is
used to hold loaded modules amongst other things.

The ioremap() mappings occupy the same address range as the vmalloc()
mappings, but are a view onto memory-mapped I/O space (MMIO).  Not all
devices are mapped with ioremap() -- those in the low memory-mapped area
aren't.  In theory you are supposed to use readl(), writel(),
memcpy_fromio() etc. to access memory-mapped I/O space, but many older
drivers fail to do this and work fine on the current x86 implementation.

Physical map
............

Physical addresses are the result of virtual address translation on
board the CPU.  C code (and assembly code) doesn't see these directly,
but they are used in page tables, which control the address translation.

There is some confusion in the kernel page table code about whether the
physical addresses passed around are *phys* addresses (also known as
*linear*), or *virt* address, which are a restricted subset of *phys*
with PAGE_OFFSET added.

When setting entries, *phys* tends to be used, but when reading entries
*virt* tends to be returned.  This sometimes loses information, so
breaking some device drivers.  Perhaps those drivers are broken by
design anyway.

Bus map
.......

This view is completely different to the virtual address view, and the
*virt* view which is a subset of virtual addresses.  Bus addresses can
overlap virtual addresses in an arbitrary way, 

The bus map is the view seen by peripheral devices, like video cards and
disk controllers.  Although different from the CPU's physical map (which
is a sort of private bus map for the CPU), the bus addresses tend to be
consistent between different devices in a single machine.

On a PC, the bus map is arranged by the system BIOS at boot time,
according to rules of Plug'n'Play and other rules.  For the PCI bus,
regions of prefetchable and non-prefetchable memory are mixed
arbitrarily: there's no particularly significant address where one kind
stops and another starts.  (Although your BIOS might make it appear so).
You don't have to worry about the differences, as long as your BIOS
configured everything properly.

`lspci -vb' will show the bus addresses of all PCI devices on a system.

Memory mapped ISA cards tend to have rather low addresses (in the first
megabyte), while PCI cards can be mapped to all sorts of addresses, high
and low depending on the BIOS.

Non-PC architectures have different rules.

On an i386 architecture, bus addresses and *phys* addresses are the
same.  This is convenient but it does tend to hide some problems.  On
other architectures, these two are often different.

Devices with *bus* addresses are supposed to be memory mapped using
ioremap(), and then accessed using readl(), writel() etc.  Because none
of this was necessary on the i386 with the 2.0.x kernels, and the other
platforms weren't very well supported then, many older device drivers
simply access device bus addresses as if they were memory.

This poses big problems with some non-i386 architectures, which require
readl() etc. for the drivers to work.  These days it also poses problems
with the i386, because in 2.1.x kernels the memory layout was changed to
make communication between user space and kernel space more efficient.
As a result, ioremap() is required to get a virtual address which you
can pass to readl(), writel() etc.

Note: there is an ironic twist.  The virtual address returned by
ioremap() is not a *virt* address, so you can't expect meaningful
results if you pass it to virt_to_bus() or virt_to_phys().

Another note: at least on a PC, you don't need ioremap() to access
devices in the first 1MB of the bus address range.  This includes most
ISA devices (but not video cards).

I/O port map
............

This is similar to the bus map, but refers to I/O ports that are
accessed by special I/O instructions from the CPU, if it is an i386
based architecture.  For some other architectures, the I/O ports are
actually quite similar to memory-mapped I/O but using different
addresses.  Although some buses support more than 64k I/O ports, the
i386 architecture does not so this address range is restricted to
0x0000-0xffff.

`cat /proc/ioports' shows all the I/O ports used by drivers currently
loaded on a system.  `lspci -v' shows all the I/O ports used by PCI
devices.

Use inb(), outb() etc. to access I/O ports.  This has been required ever
since the earliest versions of Linux, so all drivers that use I/O ports
get this right.  There is no equivalent to ioremap().

Translating virtual addresses
=============================

Some people try to look up page tables to convert a *user* address or
*vmalloc* address to a *bus* address or *virt* address.  This works for
some things, but breaks others.  It makes a number of assumptions that
are incorrect and won't work when you want to use the driver in a new
way one day, or on a new architecture.

This mess will be cleaned up sometime in version 2.3.  So if you want it
cleaned up, perhaps the best way is to help ensure 2.2 is ready for
release.  Hint :-)

Hope this helps,
-- Jamie

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
