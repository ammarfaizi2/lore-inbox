Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265320AbSKNXtD>; Thu, 14 Nov 2002 18:49:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265326AbSKNXtD>; Thu, 14 Nov 2002 18:49:03 -0500
Received: from fmr06.intel.com ([134.134.136.7]:19681 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id <S265320AbSKNXs5>; Thu, 14 Nov 2002 18:48:57 -0500
Message-ID: <72B3FD82E303D611BD0100508BB29735046DFFA4@orsmsx102.jf.intel.com>
From: "Lee, Jung-Ik" <jung-ik.lee@intel.com>
To: "'Greg KH'" <greg@kroah.com>
Cc: pcihpd-discuss@lists.sourceforge.net,
       linux ia64 kernel list <linux-ia64@linuxia64.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: RE: 2.5.45 cpqphp driver patch w/ intcphp driver enhancements
Date: Thu, 14 Nov 2002 15:52:12 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Thanks for the comments.
Most of your comments regarding style/preference are applied.
My answers to your questions are below, and let me know your idea.


> This driver doesn't need a list of Updates, as these are only done by
> your group, not anyone else.  Please delete this, thanks.

Isn't it a good time to start logging as a little appreciation and
recognition of each individual's contribution ?

>  struct pci_resource {
>  	struct pci_resource * next;
> -	u32 base;
> -	u32 length;
> +	ulong base;
> +	ulong length;
>  };
> 
> No, don't use "ulong", here, or anywhere else in the kernel, 
> use the u32
> and friends types only.

I'm toggling between your comment and the kernel's "struct resource" pci_dev
res is based on.
In linux/ioport.h, struct resource is defined as unsigned long as follows,
and that is used for pci io/mem/dma resources in struct pci_dev. And
pci/setup-*.c is also unsigned long. Even I'm leaning toward your's, ulong
seems to be the safest bet for the kernel ala "struct kernel" and related
are in ulong.
What do you suggest ?

struct resource {
	const char *name;
	unsigned long start, end;
	unsigned long flags;
	struct resource *parent, *sibling, *child;
}
And, some i386 platform might need 64bit range. In this case also, the above
structs need to be changed first to u64.


> +	//  reformat it to SHPC
>
> Try not to use C++ style comments in the code, thanks.

Done, no "//" in my code. Most of "//" are from original cpqphp source. I
tried to minimize changes in the original cpqphp codes, unless otherwise
needed for functionality.


> +struct hpc_ops {
> +	int	(*power_on_slot )	(struct slot *slot);
> +	int	(*power_off_slot )	(struct slot *slot);
> +	void	(*set_attention_status)	(struct slot *slot, u8 status);
> +	int	(*get_power_status)	(struct slot *slot, u8 *status);
> +	int	(*get_attention_status)	(struct slot *slot, u8 *status);
> +	int	(*get_latch_status)	(struct slot *slot, u8 *status);
> +	int	(*get_adapter_status)	(struct slot *slot, u8 *status);
> +	int	(*get_max_bus_speed)	(struct slot *slot, 
> enum pci_bus_speed *value);
> +	int	(*get_cur_bus_speed)	(struct slot *slot, 
> enum pci_bus_speed *value);
> +	int	(*get_adapter_speed)	(struct slot *slot, 
> enum pci_bus_speed *value);
> +	u32	(*get_slot_capabilities)(struct slot *slot);
> +	u32	(*get_slot_status)	(struct slot *slot);
> +	int	(*get_power_fault_status)(struct slot *slot);
> +	void	(*set_led_state)	(struct slot * slot, 
> struct php_led_id_state *lis, ...);
> +	void	(*set_slot_on)		(struct slot * slot);
> +	void	(*set_slot_off)		(struct slot * slot);
> +	void	(*set_slot_serr_off)	(struct slot * slot);
>  
> -	hp_slot = slot->device - ctrl->slot_device_offset;
> +	void	(*enable_msl_interrupts)(struct slot *slot);
> +	void	(*acquire_lock)		(struct slot *slot);
> +	void	(*release_lock)		(struct slot *slot);
> +	void	(*release_ctlr)		(struct controller *ctrl);
>  
> -	return read_amber_LED (ctrl, hp_slot);
> -}
> +	int	(*chk_bus_freq)		(struct controller 
> *ctrl, u8 slot);
> +	int	(*is_64bit)		(struct controller 
> *ctrl, u8 slot);
> +	int	(*PCIX_capable)		(struct controller 
> *ctrl, u8 slot);
> +};
> 
> This is a nice idea, but is it really necessary to have all of these
> functions in the structure?

The last three are removed for now since they are for other type of PCI
HPCs.


> And why the varargs on set_led_state()?

It is to control *multiple* LEDs in one call, instead of sequence of LED
setup calls.


> +# ifndef __IN_HPC__
> +#define phphpc_power_on_slot(slot) \
> +((slot)->hpc_ops->power_on_slot(slot))
>  
> Ok, this is just nasty.  Don't have functions be one thing if compiled
> into one file, and another in a different file.  That's just _too_
> complicated.  If you want to use the structure's hpc_ops function, say
> that is what you are really doing.

I removed the #ifndef __IN_HPC__ to avoid confusion, but want to keep the
macro for convenience sake.


> Wow, that's a lot of debug macros that probably are not 
> needed anymore, right? :)
> 
> Also, add a do {} while 0; to your _DBG_PRINT macro if you really want
> it to stay around.
> 
> Also, any reason for using "_" at the start of these macros?

Removed all macros per your recomendation except the two entry/exit macro
pair. "_" prefix is also removed too. Allow these simple two entry/exit
macros in hpc code only for a while since it's useful in debugging revisions
of HPC hardwares on multiple revisions of servers... The rest of the driver
codes is relatively mature but HPC codes are always hot because of new
revisions of HWs... 

> +struct sema_struct {
> +	struct semaphore crit_sect;
> +	int owner_id;
> +};
>
> Ok, this is crazy.  The only reason you have a owner_id is to prevent
> yourself from trying to grab a lock twice.  Instead you should know what
> you are doing and not try to do that.  In short, do not do this.

This sis not a q&d trick for impaired lock-unlock. This is for controlled
multiple lock requests where subsequent lock requests from lower-primitive
functions are simply granted success w/o actual lock when mother caller
already grabbed the exclusive hw access lock. Lock-unlock pair is managed in
callee's side who knows where/when exclusive access is needed to perform
certain controller operations. Caller, as consumer of the controller APIs
shouldn't worry about the lock. 
Caller still can request lock to perform a sequence of functions w/
exclusive hw access. In this case, callees(child functions)' individual lock
requests will simply succeed w/o actual lock. 
Actual instance of this is in init probe() function only. So, we know where
and what :)


> +#define  TIGER_PLATFORM		/* Uncomment for Tiger 
> platform (870 chipset) */
> 
> Make this a config item if you really want to.  Otherwise get 
> rid of it,
> or at least fix the comment :)

Urrg...this secret code name should've been removed :)


> +_DEFINE_DBG_BUFFER		/* Debug string buffer for 
> entire HPC defined here */
> 
> Why here?  What was wrong with a few lines above this?

That is definition, this is declaration.


> +#ifdef CONFIG_IA64
> +static wait_queue_head_t delay_wait_q_head;
> +
> +/* delay in jiffies to wait */
> +static void longdelay(int delay)
> +{
> +	init_waitqueue_head(&delay_wait_q_head);
> +
> +	interruptible_sleep_on_timeout(&delay_wait_q_head, delay);
> +}
> +#endif				/* CONFIG_IA64 */
> 
> Why does ia64 need an extra delay?  And if it _really_ needs 
> it, please
> provide a non-ia64 version of the function so you don't need 
> the #ifdef
> later on in the code where you call this function.

#ifdef is removed to allow delay for both i386 and ia64.


> +	_phphpc_acquire_lock(ctrl->hpc_ctlr_handle);
> 
> So the "global" phphpc_acquire_lock() function isn't to be 
> called here?
> Why not?  This is just causing another level of indirection that isn't
> needed (not to mention that this doesn't need to be a 
> function call, but
> just grab the lock instead.)

OK. only global phphpc_acquire|release_lock().


> +	/* turn on board without attaching to the bus */
> +	pPhpCtlr->creg->slot_power |= (0x01 << slot);
> 
> Do NOT write directly to memory. You do this a LOT.  Use the proper
> functions to do this instead.

No direct mem access ??? This memory mapped access is very convenient
feature that kernel provides, as many others do. Moreover, coming
PCI-Express native hpc registers are all accessed thru memory-map too, by
the spec. Am I missing something ?

> +static void
> +phphpc_set_led_state(struct slot * slot, struct 
> php_led_id_state * led_id_state, ...)
> +{
....
> +	va_list args;
> +	va_start(args, led_id_state);
> 
> varargs within the kernel for setting a LED?  Isn't this a 
> bit overkill?
> Can't you just make the individual LED calls instead?

This single set_led_state(slot, green_on, amber_blink, ...) replaces at
least 6 LED APIs such as   
 green_on(slot); green_off(slot); green_blink(slot), amber_on(slot), ..., 
and controls LEDs at a single API/lock overhead.
Unfolding to individual LED colors is just one of many implementation
choices. 


> +	return (1);
> 
> Where is this return() funtion defined?  :)
> (hint, don't pass a paramater to return, it's not needed, and 
> isn't the
> kernel style of programming.)

Agree... One more param to this function then.

> +void phphpc_get_ctlr_dev_id(struct pci_device_id *hpc_dev_id)
> +{
> +#ifdef  CONFIG_IA64
> +	struct pci_dev *pdev;
> +
> +	hpc_dev_id->vendor = PCI_VENDOR_ID_INTEL;
> +	pdev = pci_find_subsys(PCI_VENDOR_ID_INTEL, 
> PCI_INTC_P64H2_DID, PCI_ANY_ID, PCI_ANY_ID, NULL);
> +	if (pdev != NULL) {
> +		hpc_did = PCI_INTC_P64H2_DID;
> +		hpc_dev_id->device = PCI_INTC_P64H2_DID;
> +	} else {
> +		pdev = pci_find_subsys(PCI_VENDOR_ID_INTEL, 
> PCI_INTC_WXB_DID, PCI_ANY_ID, PCI_ANY_ID, NULL);
> +		if (pdev != NULL) {
> +			hpc_did = PCI_INTC_WXB_DID;
> +			hpc_dev_id->device = PCI_INTC_WXB_DID;
> +		} else
> +			hpc_dev_id->device = 0;	// should cause 
> a failing return code
> +		// from pci_module_init()
> +	}
> +#else
> +	hpc_dev_id->vendor = PCI_VENDOR_ID_COMPAQ;
> +	hpc_dev_id->device = PCI_HPC_ID;
> +#endif				/* CONFIG_IA64 */
> +
> +	hpc_dev_id->subvendor = PCI_ANY_ID;
> +	hpc_dev_id->subdevice = PCI_ANY_ID;
> +	hpc_dev_id->class = 0;
> +	hpc_dev_id->class_mask = 0;
> +	hpc_dev_id->driver_data = 0;
> +
> +}
> 
> So a Compaq chip will _never_ be on a ia64 machine?  Why not just get
> this info from the pci_dev that was passed to the probe function
> originally?

No one asked me to support compaq controller for ia64 :)
Agreed. pci_dev should be used whenever possible as you pointed out.
So I changed pci_device_id table in pci_driver (core.c) into an array of id
tables covering different cpq, intc controllers. And the above routine is
removed.


> +	if (hpc_did == PCI_INTC_P64H2_DID) {
> +		dev = pci_find_subsys(PCI_VENDOR_ID_INTEL, 
> PCI_INTC_P64H2_HUB_PCI, PCI_ANY_ID, PCI_ANY_ID, NULL);
> 
> Why not just save off pci_dev, instead of constantly having to find it
> again.  That's why it is passed to the probe() function :)

We need either pci_find_subsystem() or pci_find_device() here because if hpc
is "PCI_INTC_P64H2_DID", speed is obtained by "PCI_INTC_P64H2_HUB_PCI"
device on the bus. Hence, we have to find "PCI_INTC_P64H2_HUB_PCI" device on
the same pci bus. hpc_did is removed and pci_dev->device is used instead.


>  static u32 access_EV (u16 operation, u8 *ev_name, u8 
> *buffer, u32 *buf_size)
>  {
> +#ifdef	CONFIG_IA64
> +	return 0;
> +#else
> 
> Why not just prevent this file from being compiled in on ia64.  That
> would make things easier instead of having to put #ifdefs in the code.

Then all access_EV caller codes need #ifdef CONFIG_IA64 around this (3 ~ 4
instances).
In fact, if compaq controller makes to IA64 platform, it'll need IA64
version of this code, if needed.


>  int cpqhp_set_irq (u8 bus_num, u8 dev_num, u8 int_pin, u8 irq_num)
>  {
> +#if defined(CONFIG_HOTPLUG_PCI_COMPAQ_NVRAM) && defined(CONFIG_X86)
>  	int rc;
>  	u16 temp_word;
>  	struct pci_dev fakedev;
> @@ -372,35 +359,27 @@
>  	// This should only be for x86 as it sets the Edge 
> Level Control Register
>  	outb((u8) (temp_word & 0xFF), 0x4d0);
>  	outb((u8) ((temp_word & 0xFF00) >> 8), 0x4d1);
> -
> +#endif
>  	return 0;
>  }
> 
> Why doesn't ia64 work properly here?

IA64 servers and Intel i386 servers don't need this code.
This routine is from original cpqphp, and I saved it for cpq servers.


> +	struct pci_bus lpci_bus, *pci_bus;
> +	memcpy(&lpci_bus, ctrl->pci_bus, sizeof(lpci_bus));
> +	pci_bus = &lpci_bus;
> +	pci_bus->number = new_slot->bus;
> 
> Why mock up a pci_bus on the stack here?  Don't we know it 
> based on the
> controller's pci_bus?  Why did you change this?

To support PCI bridge cards where dev and funcs are populated over bridge
devices recursively.
Using ctrl->pci_bus->number in current cpqphp and ibmphp is not recursion
safe. Do they support bridge card hot-add ?

> Well that's enough to start with :)

Way enough :)


Driver is re-hauled again, and verified on two Itanium servers and one xeon
server... again.
Can you just send your version of 'cb' so that I can simply run it on the
driver with "cb -greg", to get code compliant to your coding style
presentation foil ?
Just kidding :-)

thanks,
J.I.
