Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274174AbRJRGXG>; Thu, 18 Oct 2001 02:23:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275790AbRJRGW6>; Thu, 18 Oct 2001 02:22:58 -0400
Received: from toad.com ([140.174.2.1]:52230 "EHLO toad.com")
	by vger.kernel.org with ESMTP id <S274174AbRJRGWp>;
	Thu, 18 Oct 2001 02:22:45 -0400
Message-ID: <3BCE7568.1DAB9FF0@mandrakesoft.com>
Date: Thu, 18 Oct 2001 02:23:36 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.13-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Patrick Mochel <mochelp@infinity.powertie.org>
CC: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [RFC] New Driver Model for 2.5
In-Reply-To: <Pine.LNX.4.21.0110171617460.15653-100000@marty.infinity.powertie.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick Mochel wrote:
> 
> One July afternoon, while hacking on the pm_dev layer for the purpose of
> system-wide power management support, I decided that I was quite tired of
> trying to make this layer look like a tree and feel like a tree, but not
> have any real integration with the actual device drivers..
> 
> I had read the accounts of what the goals were for 2.5. And, after some
> conversations with Linus and the (gasp) ACPI guys, I realized that I had a
> good chunk of the infrastructural code written; it was a matter of working
> out a few crucial details and massaging it in nicely.
> 
> I have had the chance this week (after moving and vacationing) to update
> the (read: write some) documentation for it. I will not go into details,
> and will let the document speak for itself.
> 
> With all luck, this should go into the early stages of 2.5, and allow a
> significant cleanup of many drivers. Such a model will also allow for neat
> tricks like full device power management support, and Plug N Play
> capabilities.
> 
> In order to support the new driver model, I have written a small in-memory
> filesystem, called ddfs, to export a unified interface to userland. It is
> mentioned in the doc, and is pretty self-explanatory. More information
> will be available soon.
> 
> There is code available for the model and ddfs at:
> 
> http://kernel.org/pub/linux/kernel/people/mochel/device/
> 
> but there are some fairly large caveats concerning it.
> 
> First, I feel comfortable with the device layer code and the ddfs
> code. Though, the PCI code is still work in progress. I am still working
> out some of the finer details concerning it.
> 
> Next is the environment under which I developed it all. It was on an ia32
> box, with only PCI support, and using ACPI. The latter didn't have too
> much of an effect on the development, but there are a few items explicitly
> inspired by it..
> 
> I am hoping both the PCI code, and the structure and in general can be
> further improved based on the input of the driver maintainers.
> 
> This model is not final, and may be way off from what most people actually
> want. It has gotten tentative blessing from all those that have seen it,
> though they number but a few. It's definitely not the only solution...
> 
> That said, enjoy; and have at it.
> 
>         -pat
> 
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> The (New) Linux Kernel Driver Model
> 
> Version 0.01
> 
> 17 October 2001
> 
> Overview
> ~~~~~~~~
> 
> This driver model is a unification of all the current, disparate driver models
> that are currently in the kernel. It is intended is to augment the
> bus-specific drivers for bridges and devices by consolidating a set of data
> and operations into globally accessible data structures.
> 
> Current driver models implement some sort of tree-like structure (sometimes
> just a list) for the devices they control. But, there is no linkage between
> the different bus types.
> 
> A common data structure can provide this linkage with little overhead: when a
> bus driver discovers a particular device, it can insert it into the global
> tree as well as its local tree. In fact, the local tree becomes just a subset
> of the global tree.
> 
> Common data fields can also be moved out of the local bus models into the
> global model. Some of the manipulation of these fields can also be
> consolidated. Most likely, manipulation functions will become a set
> of helper functions, which the bus drivers wrap around to include any
> bus-specific items.
> 
> The common device and bridge interface currently reflects the goals of the
> modern PC: namely the ability to do seamless Plug and Play, power management,
> and hot plug. (The model dictated by Intel and Microsoft (read: ACPI) ensures
> us that any device in the system may fit any of these criteria.)
> 
> In reality, not every bus will be able to support such operations. But, most
> buses will support a majority of those operations, and all future buses will.
> In other words, a bus that doesn't support an operation is the exception,
> instead of the other way around.
> 
> Drivers
> ~~~~~~~
> 
> The callbacks for bridges and devices are intended to be singular for a
> particular type of bus. For each type of bus that has support compiled in the
> kernel, there should be one statically allocated structure with the
> appropriate callbacks that each device (or bridge) of that type share.
> 
> Each bus layer should implement the callbacks for these drivers. It then
> forwards the calls on to the device-specific callbacks. This means that
> device-specific drivers must still implement callbacks for each operation.
> But, they are not called from the top level driver layer.
> 
> This does add another layer of indirection for calling one of these functions,
> but there are benefits that are believed to outweigh this slowdown.
> 
> First, it prevents device-specific drivers from having to know about the
> global device layer. This speeds up integration time incredibly. It also
> allows drivers to be more portable across kernel versions. Note that the
> former was intentional, the latter is an added bonus.
> 
> Second, this added indirection allows the bus to perform any additional logic
> necessary for its child devices. A bus layer may add additional information to
> the call, or translate it into something meaningful for its children.
> 
> This could be done in the driver, but if it happens for every object of a
> particular type, it is best done at a higher level.
> 
> Recap
> ~~~~~
> 
> Instances of devices and bridges are allocated dynamically as the system
> discovers their existence. Their fields describe the individual object.
> Drivers - in the global sense - are statically allocated and singular for a
> particular type of bus. They describe a set of operations that every type of
> bus could implement, the implementation following the bus's semantics.
> 
> Downstream Access
> ~~~~~~~~~~~~~~~~~
> 
> Common data fields have been moved out of individual bus layers into a common
> data structure. But, these fields must still be accessed by the bus layers,
> and
> sometimes by the device-specific drivers.
> 
> Other bus layers are encouraged to do what has been done for the PCI layer.
> struct pci_dev now looks like this:
> 
> struct pci_dev {
>         ...
> 
>         struct device device;
> };
> 
> Note first that it is statically allocated. This means only one allocation on
> device discovery. Note also that it is at the _end_ of struct pci_dev. This is
> to make people think about what they're doing when switching between the bus
> driver and the global driver; and to prevent against mindless casts between
> the two.
> 
> The PCI bus layer freely accesses the fields of struct device. It knows about
> the structure of struct pci_dev, and it should know the structure of struct
> device. PCI devices that have been converted generally do not touch the fields
> of struct device. More precisely, device-specific drivers should not touch
> fields of struct device unless there is a strong compelling reason to do so.
> 
> This abstraction is prevention of unnecessary pain during transitional phases.
> If the name of the field changes or is removed, then every downstream driver
> will break. On the other hand, if only the bus layer (and not the device
> layer) accesses struct device, it is only those that need to change.
> 
> User Interface
> ~~~~~~~~~~~~~~
> 
> By virtue of having a complete hierarchical view of all the devices in the
> system, exporting a complete hierarchical view to userspace becomes relatively
> easy. Whenever a device is inserted into the tree, a file or directory can be
> created for it.
> 
> In this model, a directory is created for each bridge and each device. When it
> is created, it is populated with a set of default files, first at the global
> layer, then at the bus layer. The device layer may then add its own files.
> 
> These files export data about the driver and can be used to modify behavior of
> the driver or even device.
> 
> For example, at the global layer, a file named 'status' is created for each
> device. When read, it reports to the user the name of the device, its bus ID,
> its current power state, and the name of the driver its using.
> 
> By writing to this file, you can have control over the device. By writing
> "suspend 3" to this file, one could place the device into power state "3".
> Basically, by writing to this file, the user has access to the operations
> defined in struct device_driver.
> 
> The PCI layer also adds default files. For devices, it adds a "resource" file
> and a "wake" file. The former reports the BAR information for the device; the
> latter reports the wake capabilities of the device.
> 
> The device layer could also add files for device-specific data reporting and
> control.
> 
> The dentry to the device's directory is kept in struct device. It also keeps a
> linked list of all the files in the directory, with pointers to their read and
> write callbacks. This allows the driver layer to maintain full control of its
> destiny. If it desired to override the default behavior of a file, or simply
> remove it, it could easily do so. (It is assumed that the files added upstream
> will always be a known quantity.)
> 
> These features were initially implemented using procfs. However, after one
> conversation with Linus, a new filesystem - ddfs - was created to implement
> these features. It is an in-memory filesystem, based heavily off of ramfs,
> though it uses procfs as inspiration for its callback functionality.
> 
> Device Structures
> ~~~~~~~~~~~~~~~~~
> 
> struct device {
>         struct list_head        bus_list;
>         struct io_bus           *parent;
>         struct io_bus           *subordinate;
> 
>         char                    name[DEVICE_NAME_SIZE];
>         char                    bus_id[BUS_ID_SIZE];
> 
>         struct dentry           *dentry;
>         struct list_head        files;
> 
>         struct  semaphore       lock;
> 
>         struct device_driver    *driver;
>         void                    *driver_data;
>         void                    *platform_data;
> 
>         u32                     current_state;
>         unsigned char           *saved_state;
> };
> 
> bus_list:
>         List of all devices on a particular bus; i.e. the device's siblings
> 
> parent:
>         The parent bridge for the device.
> 
> subordinate:
>         If the device is a bridge itself, this points to the struct io_bus that is
>         created for it.
> 
> name:
>         Human readable (descriptive) name of device. E.g. "Intel EEPro 100"
> 
> bus_id:
>         Parsable (yet ASCII) bus id. E.g. "00:04.00" (PCI Bus 0, Device 4, Function
>         0). It is necessary to have a searchable bus id for each device; making it
>         ASCII allows us to use it for its directory name without translating it.
> 
> dentry:
>         Pointer to driver's ddfs directory.
> 
> files:
>         Linked list of all the files that a driver has in its ddfs directory.
> 
> lock:
>         Driver specific lock.
> 
> driver:
>         Pointer to a struct device_driver, the common operations for each device. See
>         next section.
> 
> driver_data:
>         Private data for the driver.
>         Much like the PCI implementation of this field, this allows device-specific
>         drivers to keep a pointer to a device-specific data.
> 
> platform_data:
>         Data that the platform (firmware) provides about the device.
>         For example, the ACPI BIOS or EFI may have additional information about the
>         device that is not directly mappable to any existing kernel data structure.
>         It also allows the platform driver (e.g. ACPI) to a driver without the driver
>         having to have explicit knowledge of (atrocities like) ACPI.
> 
> current_state:
>         Current power state of the device. For PCI and other modern devices, this is
>         0-3, though it's not necessarily limited to those values.
> 
> saved_state:
>         Pointer to driver-specific set of saved state.
>         Having it here allows modules to be unloaded on system suspend and reloaded
>         on resume and maintain state across transitions.
>         It also allows generic drivers to maintain state across system state
>         transitions.
>         (I've implemented a generic PCI driver for devices that don't have a
>         device-specific driver. Instead of managing some vector of saved state
>         for each device the generic driver supports, it can simply store it here.)
> 
> struct device_driver {
>         int     (*probe)        (struct device *dev);
>         int     (*remove)       (struct device *dev);
> 
>         int     (*init)         (struct device *dev);
>         int     (*shutdown)     (struct device *dev);
> 
>         int     (*save_state)   (struct device *dev, u32 state);
>         int     (*restore_state)(struct device *dev);
> 
>         int     (*suspend)      (struct device *dev, u32 state);
>         int     (*resume)       (struct device *dev);
> }
> 
> probe:
>         Check for device existence and associate driver with it.
> 
> remove:
>         Dissociate driver with device. Releases device so that it could be used by
>         another driver. Also, if it is a hotplug device (hotplug PCI, Cardbus), an
>         ejection event could take place here.
> 
> init:
>         Initialise the device - allocate resources, irqs, etc.
> 
> shutdown:
>         "De-initialise" the device - release resources, free memory, etc.
> 
> save_state:
>         Save current device state before entering suspend state.
> 
> restore_state:
>         Restore device state, after coming back from suspend state.
> 
> suspend:
>         Physically enter suspend state.
> 
> resume:
>         Physically leave suspend state and re-initialise hardware.
> 
> Initially, the probe/remove sequence followed the PCI semantics exactly, but
> have since been broken up into a four-stage process: probe(), remove(),
> init(), and shutdown().
> 
> While it's not entirely necessary in all environments, breaking them up so
> each routine does only one thing makes sense.
> 
> Hot-pluggable devices may also benefit from this model, especially ones that
> can be subjected to suprise removals - only the remove function would be
> called, and the driver could easily know if the there was still hardware there
> to shutdown.
> 
> Drivers that are controlling failing, or buggy, hardware, by allowing the user
> to trigger a removal of the driver from userspace, without trying to shutdown
> down the device.
> 
> In each case that remove() is called without a shutdown(), it's important to
> note that resources will still need to be freed; it's only the hardware that
> cannot be assumed to be present.

So, remove() might be called without a shutdown(), and then asked to
perform the duties normally performed by shutdown()?  That sounds like
API dain bramage.  :)

Your proposal sounds ok, my one objection is separating probe/remove
further into init/shutdown.  Can you give real-life cases where this
will be useful?  I don't see it causing much except headache.

The preferred way of doing things (IMHO) is to do some simply sanity
checking of the h/w device at probe time, and then perform lots of
initialization and such at device/interface open time.  You ideally want
a device driver lifecycle to look like

probe:
	register interface
	sanity check h/w to make sure it's there and alive
	stop DMA/interrupts/etc., just in case
	start timer to powerdown h/w in N seconds

dev_open:
	wake up device, if necessary
	init device

dev_close:
	stop DMA/interrupts/etc.
	start timer to powerdown h/w in N seconds

With that in mind, init -really- happens at device open, and in
additional is driven more through normal user interaction via standard
APIs, than the PCI and PM subsystems.

-- 
Jeff Garzik      | "Mind if I drive?" -Sam
Building 1024    | "Not if you don't mind me clawing at the dash
MandrakeSoft     |  and shrieking like a cheerleader." -Max
