Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262414AbSLAUdY>; Sun, 1 Dec 2002 15:33:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262416AbSLAUdY>; Sun, 1 Dec 2002 15:33:24 -0500
Received: from dhcp024-209-039-058.neo.rr.com ([24.209.39.58]:6530 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id <S262414AbSLAUdV>;
	Sun, 1 Dec 2002 15:33:21 -0500
Date: Sun, 1 Dec 2002 15:40:18 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: Zwane Mwaikambo <zwane@holomorphy.com>
Cc: greg@kroah.com, perex@suse.cz, linux-kernel@vger.kernel.org,
       pelaufer@adelphia.net
Subject: Re: [PATCH][2.5] ALSA ISAPNP update for sound/isa/opl3sa2.c
Message-ID: <20021201154018.GD333@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Zwane Mwaikambo <zwane@holomorphy.com>, greg@kroah.com,
	perex@suse.cz, linux-kernel@vger.kernel.org, pelaufer@adelphia.net
References: <Pine.LNX.4.50.0211300443090.2495-100000@montezuma.mastecende.com> <20021201013004.GA333@neo.rr.com> <Pine.LNX.4.50.0212010139460.1628-100000@montezuma.mastecende.com> <20021201130715.GB333@neo.rr.com> <Pine.LNX.4.50.0212011358150.10730-100000@montezuma.mastecende.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50.0212011358150.10730-100000@montezuma.mastecende.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 01, 2002 at 02:04:45PM -0500, Zwane Mwaikambo wrote:
> On Sun, 1 Dec 2002, Adam Belay wrote:
> 
> > It caused an oops?  I'll bet the pnp layer got confused by it.  I'll add
> > some busy flags to prevent drivers from calling this when the device is
> > being used by the driver through the conventional driver-model style.
> > Thanks for pointing this out.
>
> Here is what the stack looked like;
>
>  EIP is at kfree+0xcd/0xe0
>  [<c024228d>] pnp_free_ids+0x1d/0x30
>  [<c0241beb>] pnp_release_device+0x1b/0x30
>  [<c02555a5>] device_release+0x15/0x20
>  [<c02390e3>] kobject_cleanup+0x73/0x80
>  [<c0241dac>] pnp_remove_device+0x1c/0xcd
>
> We were releasing an already freed block of memory (this one was slab
> poisoned).

Maybe there's something wrong with the release code, I'll take a look at it.

here's a copy of those functions from the latest version but they're
essentially the same as they were in the version you're using.

void __pnp_remove_device(struct pnp_dev *dev)
{
	spin_lock(&pnp_lock);
	list_del_init(&dev->global_list);
	list_del_init(&dev->protocol_list);
	spin_unlock(&pnp_lock);
	device_unregister(&dev->dev);
}

static void pnp_free_ids(struct pnp_dev *dev)
{
	struct pnp_id * id;
	struct pnp_id * next;
	if (!dev)
		return;
	id = dev->id;
	while (id) {
		next = id->next;
		kfree(id);
		id = next;
	}
}

static void pnp_release_device(struct device *dmdev)
{
	struct pnp_dev * dev = to_pnp_dev(dmdev);
	if (dev->res)
		pnp_free_resources(dev->res);
	pnp_free_ids(dev);
	kfree(dev);
}


>
> > I see now.  The problem is that when the remove function is called, the pnp
> > layer expects the device's resources to be freed and not in use.  I should
> > add some checks for this as well.  The pnp layer will disable the device
> > and this could cause big problems if the driver is used in between the time
> > of the ALSA remove code path and this driver removal.  Furthermore, if there
> > is more than one sound card and the driver-model wants to remove one, a
> > problem would occur.  Perhaps this aspect of ALSA needs to be changed.
> > Any ideas?
>
> Hmm i thought ->remove was per device or do you iterate internally over

You are right, ->remove is per device.

> all registered driver devices? Thats why i originally did the
> pnp_remove_device in the driver's card removal path. How about only

You'll see why not to call pnp_remove_device below.

> disabling registered devices on final driver unregister?

If the driver isn't attached to them they should remain disabled so that other
pnp devices can use their resources.  Things can get very tight if you have a
lot of pnp devices.


This may clear some things up for you.

The PnP Device Life cycle.

1.) A PnP protocol detects the device
2.) the PnP protocol creates a pnp_dev structure and sets the values in it
3.) the PnP protocol calls pnp_add_device
4.) pnp_add_device names the device, calls any quirks, and sets aditional
pnp specific values
5.) pnp_add_device registers the device with the driver model
6.) it then adds it to the global device lists and other device management
lists
7.) finally it attaches the sysfs interface to the device
8.) from that point, the driver model takes over the device
9.) it searches through the pool of existing drivers for a match.
(uses pnp_match_device)
10.) if a match isn't found it waits for a driver to be registered
11.) after a match is found it calls the probe function
12.) the pnp layer activates the device, does some housekeeping and then
passes the device to the driver's probe function.
13.) the driver's probe function then reads the resource configuration and
passes the information to the rest of the driver
14.) the device rests happily until the driver model requests that it is to
be unbound from the driver
15.) the driver model then tells the pnp_layer about this and the pnp_layer
informs the driver that it must stop using the device. (->remove)
16.) the driver releases all resources (io ports, irqs, etc) and informs the
device that it is no longer needed.  This cannot fail and thus returns void.
16.) the pnp layer then disables the device so its resource can be used by
other devices.
17.) as drivers are loaded and unloaded steps 8 - 16 repeat
18.) finally the protocol calls pnp_remove device when it discovers that the
device has been physically removed or when the protocol itself is removed.
19.) pnp_remove_device prevents any new devices from matching with it
20.) the driver model calls release when it's ready and all memory resources
(kfree) are freed.

* if the driver is unloaded it calls pnp_unregister driver.  The driver model
then iterates through all devices registered through the driver and calls
->remove (step 15)

> As an aside where does this fit in with the whole pci_dev business?
>

Before the driver model and the new pnp layer pci_dev was used as a universal
structure for resource using devices.  Now that the driver model exists, every
type of device can have its own structure.  If you look, pci_dev still has old
isapnp code in it.  In fact, it's quite a mess becuase of it.  It needs to be
removed but I haven't yet becuase it will cause all of these old pnp drivers
to not be able to compile.  When enough drivers are converted I'll remove
this stuff.

Thanks,
Adam
