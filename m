Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315267AbSHFSkR>; Tue, 6 Aug 2002 14:40:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315277AbSHFSkR>; Tue, 6 Aug 2002 14:40:17 -0400
Received: from [217.167.51.129] ([217.167.51.129]:34300 "EHLO zion.wanadoo.fr")
	by vger.kernel.org with ESMTP id <S315267AbSHFSkO>;
	Tue, 6 Aug 2002 14:40:14 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: PCI<->PCI bridges, transparent resource fix
Date: Tue, 6 Aug 2002 20:44:12 +0200
Message-Id: <20020806184413.17565@192.168.4.1>
X-Mailer: CTM PowerMail 3.1.2 F <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for those who already got this, it seems there is enough
interest/debate to discuss this here. So here we go...

----

You remember that old debate about how to handle PCI<->PCI bridges
resources that are considered "invalid", should those be transparent or
just closed, etc...

After much thinking (and experiments), I figured out that:

 - A "closed" resource could be considered "transparent" without problem.

 - The current code for setting up a transparent resource is broken in
a couple of ways. It makes assumptions about the layout of the parent
resources (0 beeing IO, 1 memory, 2 prefetchable memory), while this
is just not true, especially if your parent is the host bridge. It can
also end up setting up both a resource as beeing transparent and one
that is not, which can lead to intresting messup of the resource tree
under some circumstances.

I have reworked the routine along those lines:

 - If the IO resource is invalid, consider it transparent by pointing
the bus resources to _all_ parent bus resources of type IO

 - If _both_ mem resources are invalid, consider it transparent by
pointing the bus resources to _all_ parent bus resources of type MEM

 - if any of the mem resource is invalid and the other valid, just
use the valid one an ignore the invalid one.

Here is a replacement for pci_read_bridges_bases() implementing that
in 2.4 (but the code should move to 2.5 without hitch, I'm not asking
for a merge now, I'm asking for comments/suggestions/brown paper bags ;)

I've quickly tested in on a machine here for which one memory range
was incorrectly considered as transparent and it didn't do anything
bad. I would need you to verify that it still works on real transparent
bridges, or else, help me figure out what I overlooked, the goal here
is to avoid having bazillion of per-bridge special cases.

Regards,
Ben.


static inline int __devinit
add_bus_resource(struct pci_bus *child, struct resource* res)
{
        int i;

        /* Find free slot */
        for(i=0; i<4; i++)
                if (child->resource[i] == NULL) {
                        child->resource[i] = res;
                        return 1;
                }
        return 0;
}

static int __devinit
setup_transparent(struct pci_bus *child, unsigned long req_flags)
{
        int i;
        int found = 0;
        
        /* Iterate parent resources for matching flags */
        for(i=0; i<4; i++) {
                struct resource* pres = child->parent->resource[i];
                
                if (pres && ((pres->flags & req_flags) != 0)) {
                        if (!add_bus_resource(child, pres)) {
                                printk(KERN_ERR "Out of resource slots
for transparent bridge resources\n");
                                return 0;
                        }
                        found = 1;
                }
        }
        return found;
}

/*
 * The logic here is as follow:
 * 
 * For each bridge base (IO, mem, mem+prefetch), if the resource appear
 * valid, it is added to the resource tree. If not, things are dealt
 * differently for IO and mem.
 * 
 * If the IO resource is considered invalid, it's marked transparent,
 * that is all of the parent IO ranges are copied down. If the parent
 * has no IO ranges, it's considered closed, we don't provide an IO
 * resource for this bridge childs.
 * 
 * If at least one the memory resources is considered invalid, we have
 * do deal with one of these 3 cases:
 * 
 *   - mem invalid, mem+prefetch invalid : This is the simplest case.
 * the bridge is either completely transparent for memory cycles or
 * completely closed. We copy down all mem resources including
 * mem+prefetch from the parent
 * 
 *   - mem valid, mem+prefetch invalid : Here, we assume the bridge will
 * decode one memory region and is not transparent (the mem+prefetch one
 * is considered as closed). We don't copy any resource from the parent
 * 
 *   - mem invalid, mem+prefetch valid : Do this case exist ? For now, I
 * set it up as non-transparent bridge like the above.
 * 
 * An important goal here is to avoid mixing transparent and non
 * transparent resources of the same type. This messes up the resource
 * hierarchy and cause allocation failures
 */
 
void __devinit pci_read_bridge_bases(struct pci_bus *child)
{
        struct pci_dev *dev = child->self;
        u8 io_base_lo, io_limit_lo;
        u16 mem_base_lo, mem_limit_lo;
        unsigned long base, limit;
        struct resource *res;
        int i;
        int mem_transp = 0;
        
        if (!dev)               /* It's a host bus, nothing to read */
                return;

        for(i=0; i<4; i++)
                child->resource[i] = NULL;

        res = &dev->resource[PCI_BRIDGE_RESOURCES];
        pci_read_config_byte(dev, PCI_IO_BASE, &io_base_lo);
        pci_read_config_byte(dev, PCI_IO_LIMIT, &io_limit_lo);
        base = (io_base_lo & PCI_IO_RANGE_MASK) << 8;
        limit = (io_limit_lo & PCI_IO_RANGE_MASK) << 8;

        if ((io_base_lo & PCI_IO_RANGE_TYPE_MASK) == PCI_IO_RANGE_TYPE_32) {
                u16 io_base_hi, io_limit_hi;
                pci_read_config_word(dev, PCI_IO_BASE_UPPER16, &io_base_hi);
                pci_read_config_word(dev, PCI_IO_LIMIT_UPPER16, &io_limit_hi);
                base |= (unsigned long)(io_base_hi << 16);
                limit |= (unsigned long)(io_limit_hi << 16);
        }

        printk("bridge resource 0, base: %lx, limit: %lx\n", base, limit);
        if ((base || limit) && base <= limit) {
                res->flags = (io_base_lo & PCI_IO_RANGE_TYPE_MASK) |
IORESOURCE_IO;
                res->start = base;
                res->end = limit + 0xfff;
                res->name = child->name;
                if (!add_bus_resource(child, res))
                        printk(KERN_ERR "Out of resource slots for bridge
resource %d: closing...\n", 0);
        } else {
                if (setup_transparent(child, IORESOURCE_IO))
                        printk(KERN_ERR "Unknown bridge resource %d:
assuming transparent IO\n", 0);
                else
                        printk(KERN_ERR "Unknown bridge resource %d:
assuming closed\n", 0);
        }

        res = &dev->resource[PCI_BRIDGE_RESOURCES + 1];
        pci_read_config_word(dev, PCI_MEMORY_BASE, &mem_base_lo);
        pci_read_config_word(dev, PCI_MEMORY_LIMIT, &mem_limit_lo);
        base = (mem_base_lo & PCI_MEMORY_RANGE_MASK) << 16;
        limit = (mem_limit_lo & PCI_MEMORY_RANGE_MASK) << 16;

        printk("bridge resource 1, base: %lx, limit: %lx\n", base, limit);

        if (base && base <= limit) {
                res->flags = (mem_base_lo & PCI_MEMORY_RANGE_TYPE_MASK) |
IORESOURCE_MEM;
                res->start = base;
                res->end = limit + 0xfffff;
                res->name = child->name;
                if (!add_bus_resource(child, res))
                        printk(KERN_ERR "Out of resource slots for bridge
resource %d: closing...\n", 1);
        } else
                mem_transp |= 0x01;
        
        res = &dev->resource[PCI_BRIDGE_RESOURCES + 2];
        pci_read_config_word(dev, PCI_PREF_MEMORY_BASE, &mem_base_lo);
        pci_read_config_word(dev, PCI_PREF_MEMORY_LIMIT, &mem_limit_lo);
        base = (mem_base_lo & PCI_PREF_RANGE_MASK) << 16;
        limit = (mem_limit_lo & PCI_PREF_RANGE_MASK) << 16;

        if ((mem_base_lo & PCI_PREF_RANGE_TYPE_MASK) ==
PCI_PREF_RANGE_TYPE_64) {
                u32 mem_base_hi, mem_limit_hi;
                pci_read_config_dword(dev, PCI_PREF_BASE_UPPER32,
&mem_base_hi);
                pci_read_config_dword(dev, PCI_PREF_LIMIT_UPPER32,
&mem_limit_hi);
#if BITS_PER_LONG == 64
                base |= ((long) mem_base_hi) << 32;
                limit |= ((long) mem_limit_hi) << 32;
#else
                if (mem_base_hi || mem_limit_hi) {
                        printk(KERN_ERR "PCI: Unable to handle 64-bit
address space for %s\n", child->name);
                        return;
                }
#endif
        }
        printk("bridge resource 2, base: %lx, limit: %lx\n", base, limit);

        if (base && base <= limit) {
                res->flags = (mem_base_lo & PCI_MEMORY_RANGE_TYPE_MASK) |
IORESOURCE_MEM | IORESOURCE_PREFETCH;
                res->start = base;
                res->end = limit + 0xfffff;
                res->name = child->name;
                if (!add_bus_resource(child, res))
                        printk(KERN_ERR "Out of resource slots for bridge
resource %d: closing...\n", 2);
        }
        else
                mem_transp |= 0x02;

        if (mem_transp == 0x3) {
                if (setup_transparent(child, IORESOURCE_MEM))
                        printk(KERN_ERR "Unknown bridge resource 1 & 2:
assuming transparent MEM\n");
        }
}


----------------- Fin du message transmis -----------------


