Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265400AbSKOAfQ>; Thu, 14 Nov 2002 19:35:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265475AbSKOAfQ>; Thu, 14 Nov 2002 19:35:16 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:24326 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S265400AbSKOAeI>;
	Thu, 14 Nov 2002 19:34:08 -0500
Date: Thu, 14 Nov 2002 16:35:25 -0800
From: Greg KH <greg@kroah.com>
To: "Lee, Jung-Ik" <jung-ik.lee@intel.com>
Cc: pcihpd-discuss@lists.sourceforge.net,
       linux ia64 kernel list <linux-ia64@linuxia64.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.45 cpqphp driver patch w/ intcphp driver enhancements
Message-ID: <20021115003525.GY16235@kroah.com>
References: <72B3FD82E303D611BD0100508BB29735046DFFA4@orsmsx102.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72B3FD82E303D611BD0100508BB29735046DFFA4@orsmsx102.jf.intel.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 14, 2002 at 03:52:12PM -0800, Lee, Jung-Ik wrote:
> Hi Greg,
> 
> Thanks for the comments.
> Most of your comments regarding style/preference are applied.
> My answers to your questions are below, and let me know your idea.
> 
> 
> > This driver doesn't need a list of Updates, as these are only done by
> > your group, not anyone else.  Please delete this, thanks.
> 
> Isn't it a good time to start logging as a little appreciation and
> recognition of each individual's contribution ?

If you really want to.  What I have seen in the past is that this either
quickly grows quite large, or is ignored.  If you really want it there,
fine, but at least sync up the dates with ones that reflect that the
change made it into the kernel (your multiple dates doesn't show that.)

> >  struct pci_resource {
> >  	struct pci_resource * next;
> > -	u32 base;
> > -	u32 length;
> > +	ulong base;
> > +	ulong length;
> >  };
> > 
> > No, don't use "ulong", here, or anywhere else in the kernel, 
> > use the u32
> > and friends types only.
> 
> I'm toggling between your comment and the kernel's "struct resource" pci_dev
> res is based on.
> In linux/ioport.h, struct resource is defined as unsigned long as follows,
> and that is used for pci io/mem/dma resources in struct pci_dev. And
> pci/setup-*.c is also unsigned long. Even I'm leaning toward your's, ulong
> seems to be the safest bet for the kernel ala "struct kernel" and related
> are in ulong.
> What do you suggest ?

If you are trying to keep in sync with the struct resource, then use
unsigned long (and spell it out, don't use ulong please).  If not, then
specifically set the length of the variable.  In this case, it looks
like unsigned long is what you want.

> > And why the varargs on set_led_state()?
> 
> It is to control *multiple* LEDs in one call, instead of sequence of LED
> setup calls.

That's all nice and good, but is it really that hard to just sequence
the calls?  I'd prefer that to varargs trickery which doesn't play nice
with the stack.

> > +# ifndef __IN_HPC__
> > +#define phphpc_power_on_slot(slot) \
> > +((slot)->hpc_ops->power_on_slot(slot))
> >  
> > Ok, this is just nasty.  Don't have functions be one thing if compiled
> > into one file, and another in a different file.  That's just _too_
> > complicated.  If you want to use the structure's hpc_ops function, say
> > that is what you are really doing.
> 
> I removed the #ifndef __IN_HPC__ to avoid confusion, but want to keep the
> macro for convenience sake.

Then you have changed the names of the other functions that matched up
with these macro names?

> Removed all macros per your recomendation except the two entry/exit macro
> pair. "_" prefix is also removed too. Allow these simple two entry/exit
> macros in hpc code only for a while since it's useful in debugging revisions
> of HPC hardwares on multiple revisions of servers... The rest of the driver
> codes is relatively mature but HPC codes are always hot because of new
> revisions of HWs... 

Ok, that sounds good.

> > +struct sema_struct {
> > +	struct semaphore crit_sect;
> > +	int owner_id;
> > +};
> >
> > Ok, this is crazy.  The only reason you have a owner_id is to prevent
> > yourself from trying to grab a lock twice.  Instead you should know what
> > you are doing and not try to do that.  In short, do not do this.
> 
> This sis not a q&d trick for impaired lock-unlock. This is for controlled
> multiple lock requests where subsequent lock requests from lower-primitive
> functions are simply granted success w/o actual lock when mother caller
> already grabbed the exclusive hw access lock. Lock-unlock pair is managed in
> callee's side who knows where/when exclusive access is needed to perform
> certain controller operations. Caller, as consumer of the controller APIs
> shouldn't worry about the lock. 
> Caller still can request lock to perform a sequence of functions w/
> exclusive hw access. In this case, callees(child functions)' individual lock
> requests will simply succeed w/o actual lock. 
> Actual instance of this is in init probe() function only. So, we know where
> and what :)

But the old code did not need this type of locking mess.  I'd suggest to
just stick with a simple semaphore.  It is cleaner, smaller, and easier
to maintain over time.

> > +_DEFINE_DBG_BUFFER		/* Debug string buffer for 
> > entire HPC defined here */
> > 
> > Why here?  What was wrong with a few lines above this?
> 
> That is definition, this is declaration.

But a one time declaration, which kind of means that making a definition
for it was useless :)

> > +#ifdef CONFIG_IA64
> > +static wait_queue_head_t delay_wait_q_head;
> > +
> > +/* delay in jiffies to wait */
> > +static void longdelay(int delay)
> > +{
> > +	init_waitqueue_head(&delay_wait_q_head);
> > +
> > +	interruptible_sleep_on_timeout(&delay_wait_q_head, delay);
> > +}
> > +#endif				/* CONFIG_IA64 */
> > 
> > Why does ia64 need an extra delay?  And if it _really_ needs 
> > it, please
> > provide a non-ia64 version of the function so you don't need 
> > the #ifdef
> > later on in the code where you call this function.
> 
> #ifdef is removed to allow delay for both i386 and ia64.

Is that what you really want?  Why?  What is the delay for?

> > +	_phphpc_acquire_lock(ctrl->hpc_ctlr_handle);
> > 
> > So the "global" phphpc_acquire_lock() function isn't to be 
> > called here?
> > Why not?  This is just causing another level of indirection that isn't
> > needed (not to mention that this doesn't need to be a 
> > function call, but
> > just grab the lock instead.)
> 
> OK. only global phphpc_acquire|release_lock().

thanks.

> > +	/* turn on board without attaching to the bus */
> > +	pPhpCtlr->creg->slot_power |= (0x01 << slot);
> > 
> > Do NOT write directly to memory. You do this a LOT.  Use the proper
> > functions to do this instead.
> 
> No direct mem access ??? This memory mapped access is very convenient
> feature that kernel provides, as many others do. Moreover, coming
> PCI-Express native hpc registers are all accessed thru memory-map too, by
> the spec. Am I missing something ?

Yes you are, please read Documentation/IO-mapping.txt.  You are getting
away with this by the fact that these archs allow a pointer to a remaped
area to be directly written to.  That's not portable at all.

> This single set_led_state(slot, green_on, amber_blink, ...) replaces at
> least 6 LED APIs such as   
>  green_on(slot); green_off(slot); green_blink(slot), amber_on(slot), ..., 
> and controls LEDs at a single API/lock overhead.
> Unfolding to individual LED colors is just one of many implementation
> choices. 

Please do that, it saves kernel stack space and reduces complexity.

> Agreed. pci_dev should be used whenever possible as you pointed out.
> So I changed pci_device_id table in pci_driver (core.c) into an array of id
> tables covering different cpq, intc controllers. And the above routine is
> removed.

thank you.

> > +	if (hpc_did == PCI_INTC_P64H2_DID) {
> > +		dev = pci_find_subsys(PCI_VENDOR_ID_INTEL, 
> > PCI_INTC_P64H2_HUB_PCI, PCI_ANY_ID, PCI_ANY_ID, NULL);
> > 
> > Why not just save off pci_dev, instead of constantly having to find it
> > again.  That's why it is passed to the probe() function :)
> 
> We need either pci_find_subsystem() or pci_find_device() here because if hpc
> is "PCI_INTC_P64H2_DID", speed is obtained by "PCI_INTC_P64H2_HUB_PCI"
> device on the bus. Hence, we have to find "PCI_INTC_P64H2_HUB_PCI" device on
> the same pci bus. hpc_did is removed and pci_dev->device is used instead.

So you need to talk to the "main" controller instead?  Do you have a
spec citation for this anywhere?

> >  static u32 access_EV (u16 operation, u8 *ev_name, u8 
> > *buffer, u32 *buf_size)
> >  {
> > +#ifdef	CONFIG_IA64
> > +	return 0;
> > +#else
> > 
> > Why not just prevent this file from being compiled in on ia64.  That
> > would make things easier instead of having to put #ifdefs in the code.
> 
> Then all access_EV caller codes need #ifdef CONFIG_IA64 around this (3 ~ 4
> instances).

No, the "no nvram" functions will be called as defined in the header
file.

> In fact, if compaq controller makes to IA64 platform, it'll need IA64
> version of this code, if needed.

Yes it would, but as you stated earlier, you aren't doing that work :)

> >  int cpqhp_set_irq (u8 bus_num, u8 dev_num, u8 int_pin, u8 irq_num)
> >  {
> > +#if defined(CONFIG_HOTPLUG_PCI_COMPAQ_NVRAM) && defined(CONFIG_X86)
> >  	int rc;
> >  	u16 temp_word;
> >  	struct pci_dev fakedev;
> > @@ -372,35 +359,27 @@
> >  	// This should only be for x86 as it sets the Edge 
> > Level Control Register
> >  	outb((u8) (temp_word & 0xFF), 0x4d0);
> >  	outb((u8) ((temp_word & 0xFF00) >> 8), 0x4d1);
> > -
> > +#endif
> >  	return 0;
> >  }
> > 
> > Why doesn't ia64 work properly here?
> 
> IA64 servers and Intel i386 servers don't need this code.
> This routine is from original cpqphp, and I saved it for cpq servers.

But what about cpq servers who do not specify the NVRAM option?  They
need them, but it is now broken.

> > +	struct pci_bus lpci_bus, *pci_bus;
> > +	memcpy(&lpci_bus, ctrl->pci_bus, sizeof(lpci_bus));
> > +	pci_bus = &lpci_bus;
> > +	pci_bus->number = new_slot->bus;
> > 
> > Why mock up a pci_bus on the stack here?  Don't we know it 
> > based on the
> > controller's pci_bus?  Why did you change this?
> 
> To support PCI bridge cards where dev and funcs are populated over bridge
> devices recursively.
> Using ctrl->pci_bus->number in current cpqphp and ibmphp is not recursion
> safe. Do they support bridge card hot-add ?

They should, I haven't seen any instances where this would not work.

thanks,

greg k-h
