Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264625AbSKIDal>; Fri, 8 Nov 2002 22:30:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264628AbSKIDal>; Fri, 8 Nov 2002 22:30:41 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:3081 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S264625AbSKIDaj>;
	Fri, 8 Nov 2002 22:30:39 -0500
Date: Sat, 9 Nov 2002 03:37:19 +0000
From: Matthew Wilcox <willy@debian.org>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: James.Bottomley@steeleye.com, andmike@us.ibm.com, hch@lst.de,
       parisc-linux@lists.parisc-linux.org, Patrick Mochel <mochel@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [parisc-linux] Untested port of parisc_device to generic device interface
Message-ID: <20021109033719.R12011@parcelfarce.linux.theplanet.co.uk>
References: <200211090128.RAA31693@adam.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200211090128.RAA31693@adam.yggdrasil.com>; from adam@yggdrasil.com on Fri, Nov 08, 2002 at 05:28:05PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 08, 2002 at 05:28:05PM -0800, Adam J. Richter wrote:
> 	To start with, here is another completely untested patch that
> I haven't even tried to compile that attempts to port the parisc device
> type to the generic device model.  I have deliberately not included any
> changes that would make it dependent on my generic DMA routine facility.

Actually I think the generic device model is crap.  It's failed to live
up to its promise of removing common fields from structs, it's introduced
a new composite filesystem and it's not helped in any concrete way.

Just look at pci_dev:

struct pci_dev {
        struct list_head global_list;   /* node in list of all PCI devices */
        struct list_head bus_list;      /* node in per-bus list */
        struct pci_bus  *bus;           /* bus this device is on */
        struct pci_bus  *subordinate;   /* bus this device bridges to */
        struct proc_dir_entry *procent; /* device entry in /proc/bus/pci */

        unsigned int    devfn;          /* encoded device & function index */
        struct pci_driver *driver;      /* which driver has allocated this devic
e */
        void            *driver_data;   /* data private to the driver */
        struct  device  dev;            /* Generic device interface */
        struct resource resource[DEVICE_COUNT_RESOURCE]; /* I/O and memory regio
ns + expansion ROMs */
        struct resource dma_resource[DEVICE_COUNT_DMA];
        struct resource irq_resource[DEVICE_COUNT_IRQ];
        char            name[90];       /* device name */
}

(there may be some more duplicate fields i've missed)

here's the duplicate fields in struct device:

struct device {
        struct list_head g_list;        /* node in depth-first order list */
        struct list_head node;          /* node in sibling list */
        struct list_head bus_list;      /* node in bus's list */
        struct list_head driver_list;
        struct list_head children;
        struct list_head intf_list;
        struct device   * parent;
        char    name[DEVICE_NAME_SIZE]; /* descriptive ascii string */
        char    bus_id[BUS_ID_SIZE];    /* position on parent bus */

        spinlock_t      lock;           /* lock for the device to ensure two
                                           different layers don't access it at
                                           the same time. */
        atomic_t        refcount;       /* refcount to make sure the device
                                         * persists for the right amount of time
 */

        struct bus_type * bus;          /* type of bus device is on */
        struct device_driver *driver;   /* which driver has allocated this
                                           device */
        void            *driver_data;   /* data private to the driver */
}

Oh, and _that_ embeds a struct kobject:

struct kobject {
        char                    name[KOBJ_NAME_LEN];
        atomic_t                refcount;
        struct list_head        entry;
        struct kobject          * parent;
        struct subsystem        * subsys;
        struct dentry           * dentry;
};

For fucks sake, this is ridiculous.  I haven't dared compare the relative
sizes of struct pci_dev between 2.5, 2.4 and 2.2, but this is sheer bloat.

I was hoping for something _incredibly_ simple from struct device.
Something to replace pci_alloc_consistent with device_alloc_consistent.
Something where I could look through the ancestors of a device to find
out whether it was under a CCIO or just a processor.  Something I could
query to find out whether it was an EISA, a GSC or a PCI device.

I'm disappointed this is trying to serve the needs of USB over the needs
of busses in the box.  I don't think it was even remotely smart to unify
USB with other busses.  And I think the PCI system has suffered the most.
I guess I'm so annoyed because I thought it might solve problems instead
of increasing the amount of user eyecandy.

> 	One question about the machine that has no consistent memory
> option: does it take PCI cards?  If so, then all PCI device drivers
> should theoretically use something like wback_fake_consistent.
> If not, then it sounds like the facility needs only to apply to
> generic DMA operations for "parisc" bus cards.

The only machines which can take any kind of PCI devices that don't
have consistent memory available to them are the T-class machines.
We have no plans to support these machines.  What you do need to watch
out for are machines such as the 735/755 which can take an NCR720 chip
in a non-coherent memory machine.  It is of course also used in machines
which are perfectly capable of allocating consistent memory (whether
through uncached mappings or a cache-coherent IO TLB).

-- 
Revolutions do not require corporate support.
