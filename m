Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261290AbSKNAtw>; Wed, 13 Nov 2002 19:49:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261401AbSKNAtw>; Wed, 13 Nov 2002 19:49:52 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:34067 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261290AbSKNAtq>;
	Wed, 13 Nov 2002 19:49:46 -0500
Date: Wed, 13 Nov 2002 16:51:13 -0800
From: Greg KH <greg@kroah.com>
To: "Lee, Jung-Ik" <jung-ik.lee@intel.com>
Cc: pcihpd-discuss@lists.sourceforge.net,
       linux ia64 kernel list <linux-ia64@linuxia64.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.45 cpqphp driver patch w/ intcphp driver enhancements
Message-ID: <20021114005113.GB8958@kroah.com>
References: <72B3FD82E303D611BD0100508BB29735046DFF89@orsmsx102.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72B3FD82E303D611BD0100508BB29735046DFF89@orsmsx102.jf.intel.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2002 at 04:20:16PM -0800, Lee, Jung-Ik wrote:
> Hi Greg,
> 
> Here's PCI hotplug driver patch to cpqphp driver in 2.5.45.
> It took a while since this patch required integration of intcphp driver and
> cpqphp driver, which basically nullified all previous validation/regression
> on intcphp, hence driver had to go thru it again... It's been verified on
> three servers (Itanium2(Tiger), Itanium1(Lion), and i386 Intel server) in
> 2.5.39 and 2.5.45 kernels.

Ok, nice job, this is some good progress.  Here are some specific issues
I have with the patch (note, I didn't run the code, only read it and
built it.)


diff -urN linux-2.5.45-ia64-021031-phpa/drivers/hotplug.org/Kconfig linux-2.5.45-ia64-021031-phpa/drivers/hotplug/Kconfig
--- linux-2.5.45-ia64-021031-phpa/drivers/hotplug.org/Kconfig	Wed Oct 30 16:42:29 2002
+++ linux-2.5.45-ia64-021031-phpa/drivers/hotplug/Kconfig	Tue Nov  5 12:40:27 2002
@@ -21,12 +21,12 @@
 
 	  When in doubt, say N.
 
-config HOTPLUG_PCI_COMPAQ
-	tristate "Compaq PCI Hotplug driver"
-	depends on HOTPLUG_PCI && X86
+config HOTPLUG_PCI_COMPAQ_INTEL
+	tristate "Compaq/Intel PCI Hotplug driver"
+	depends on HOTPLUG_PCI


I've already given my comment here.  Leave the name as Compaq, but put
the Intel name in the help text for those users who have those kinds of
systems.

 
+ifdef CONFIG_HOTPLUG_PCI_COMPAQ_INTEL
+  ifeq ($(CONFIG_HOTPLUG_PCI_COMPAQ_INTEL_PHPRM_LEGACY),y)
+    cpqphp-objs += phprm_legacy.o
+  else
+    cpqphp-objs += phprm_acpi.o
+    EXTRA_CFLAGS  += -D_LINUX -I$(TOPDIR)/drivers/acpi -I$(TOPDIR)/drivers/acpi/include -DPHP_ACPI
+  endif
+endif
+

You don't need the first ifdef here.

diff -urN linux-2.5.45-ia64-021031-phpa/drivers/hotplug.org/cpqphp.h linux-2.5.45-ia64-021031-phpa/drivers/hotplug/cpqphp.h
--- linux-2.5.45-ia64-021031-phpa/drivers/hotplug.org/cpqphp.h	Wed Oct 30 16:43:38 2002
+++ linux-2.5.45-ia64-021031-phpa/drivers/hotplug/cpqphp.h	Mon Nov 11 14:53:17 2002
@@ -4,6 +4,9 @@
  * Copyright (c) 1995,2001 Compaq Computer Corporation
  * Copyright (c) 2001 Greg Kroah-Hartman (greg@kroah.com)
  * Copyright (c) 2001 IBM
+ * Copyright (C) 2001-2002 Intel
+ *  Copyright (C) Fred Lewis (frederick.v.lewis@intel.com)
+ *  Copyright (c) J.I. Lee (jung-ik.lee@intel.com)

Keep the spacing the same :)

  * Send feedback to <greg@kroah.com>
  *
+ *  Updates
+ *  -------
+ *  01/05/01    F. Lewis    Modified and/or moved data structures and data
+ *                          types so that hardware specific access code could
+ *                          be configured as a separate loadable driver.
+ *                          Changed filename.  Removed Compaq specific
+ *                          references.  Other minor changes.
+ *  06/07/02    J.I. Lee    Major revision for PHP Resource management
+ *                          Now common for ia32/ia64, ACPI/legacy.
+ *                          Moved/changed all IA32/Legacy codes to phprm_lagacy.
+ *  10/05/02    J.I. Lee    Major revision for PHP HPC
+ *  11/05/02    J.I. Lee    Integration to x86 cpqphp driver

This driver doesn't need a list of Updates, as these are only done by
your group, not anyone else.  Please delete this, thanks.

 struct pci_resource {
 	struct pci_resource * next;
-	u32 base;
-	u32 length;
+	ulong base;
+	ulong length;
 };

No, don't use "ulong", here, or anywhere else in the kernel, use the u32
and friends types only.

+	// J.I. TBI: Hide this HPC specifics into hpc_ctlr_handle and
+	//  reformat it to SHPC

Try not to use C++ style comments in the code, thanks.

+struct hpc_ops {
+	int	(*power_on_slot )	(struct slot *slot);
+	int	(*power_off_slot )	(struct slot *slot);
+	void	(*set_attention_status)	(struct slot *slot, u8 status);
+	int	(*get_power_status)	(struct slot *slot, u8 *status);
+	int	(*get_attention_status)	(struct slot *slot, u8 *status);
+	int	(*get_latch_status)	(struct slot *slot, u8 *status);
+	int	(*get_adapter_status)	(struct slot *slot, u8 *status);
+	int	(*get_max_bus_speed)	(struct slot *slot, enum pci_bus_speed *value);
+	int	(*get_cur_bus_speed)	(struct slot *slot, enum pci_bus_speed *value);
+	int	(*get_adapter_speed)	(struct slot *slot, enum pci_bus_speed *value);
+	u32	(*get_slot_capabilities)(struct slot *slot);
+	u32	(*get_slot_status)	(struct slot *slot);
+	int	(*get_power_fault_status)(struct slot *slot);
+	void	(*set_led_state)	(struct slot * slot, struct php_led_id_state *lis, ...);
+	void	(*set_slot_on)		(struct slot * slot);
+	void	(*set_slot_off)		(struct slot * slot);
+	void	(*set_slot_serr_off)	(struct slot * slot);
 
-	hp_slot = slot->device - ctrl->slot_device_offset;
+	void	(*enable_msl_interrupts)(struct slot *slot);
+	void	(*acquire_lock)		(struct slot *slot);
+	void	(*release_lock)		(struct slot *slot);
+	void	(*release_ctlr)		(struct controller *ctrl);
 
-	return read_amber_LED (ctrl, hp_slot);
-}
+	int	(*chk_bus_freq)		(struct controller *ctrl, u8 slot);
+	int	(*is_64bit)		(struct controller *ctrl, u8 slot);
+	int	(*PCIX_capable)		(struct controller *ctrl, u8 slot);
+};

This is a nice idea, but is it really necessary to have all of these
functions in the structure?  And why the varargs on set_led_state()?


+# ifndef __IN_HPC__
+#define phphpc_power_on_slot(slot) \
+((slot)->hpc_ops->power_on_slot(slot))
 
Ok, this is just nasty.  Don't have functions be one thing if compiled
into one file, and another in a different file.  That's just _too_
complicated.  If you want to use the structure's hpc_ops function, say
that is what you are really doing.

+#ifdef DEBUG
+#define _DBG_K_TRACE_ENTRY      ((unsigned int)0x00000001)	/* On function entry */
+#define _DBG_K_TRACE_EXIT       ((unsigned int)0x00000002)	/* On function exit */
+#define _DBG_K_INFO             ((unsigned int)0x00000004)	/* Info messages */
+#define _DBG_K_ERROR            ((unsigned int)0x00000008)	/* Error messages */
+#define _DBG_K_TRACE            (_DBG_K_TRACE_ENTRY|_DBG_K_TRACE_EXIT)
+#define _DBG_K_STANDARD         (_DBG_K_INFO|_DBG_K_ERROR|_DBG_K_TRACE)
+/* Redefine this flagword to set debug level */
+#define _DEBUG_LEVEL            _DBG_K_STANDARD
+
+#define _DEFINE_DBG_BUFFER               \
+char __dbg_str_buf[256];
+
+#define _DBG_PRINT( dbg_flags, args... )                 \
+	if ( _DEBUG_LEVEL & ( dbg_flags ) )              \
+	{                                                \
+	    int len;                                     \
+	    len = sprintf( __dbg_str_buf, "%s:%d: %s: ", \
+		  __FILE__, __LINE__, __FUNCTION__ );    \
+	    sprintf( __dbg_str_buf + len, args );        \
+	    printk( KERN_NOTICE "%s\n", __dbg_str_buf ); \
+	}
+
+#define _DBG_ENTER_ROUTINE	_DBG_PRINT (_DBG_K_TRACE_ENTRY, "%s", "[Entry]");
+#define _DBG_LEAVE_ROUTINE	_DBG_PRINT (_DBG_K_TRACE_EXIT, "%s", "[Exit]");
+#define _DBG_PRINT_ERROR( args... )	_DBG_PRINT (_DBG_K_ERROR, args);
+#define _DBG_PRINT_INFO( args... )	_DBG_PRINT (_DBG_K_INFO, args);
+#else
+#define _DEFINE_DBG_BUFFER
+#define _DBG_PRINT( dbg_flags, args... )
+#define _DBG_ENTER_ROUTINE
+#define _DBG_LEAVE_ROUTINE
+#define _DBG_PRINT_ERROR( args... )
+#define _DBG_PRINT_INFO( args... )
+#endif				/* DEBUG */

Wow, that's a lot of debug macros that probably are not needed anymore,
right? :)

Also, add a do {} while 0; to your _DBG_PRINT macro if you really want
it to stay around.

Also, any reason for using "_" at the start of these macros?

+struct sema_struct {
+	struct semaphore crit_sect;
+	int owner_id;
+};

Ok, this is crazy.  The only reason you have a owner_id is to prevent
yourself from trying to grab a lock twice.  Instead you should know what
you are doing and not try to do that.  In short, do not do this.

You do this in the following function:

+static void _phphpc_acquire_lock(struct php_ctlr_state_s *pPhpCtlr)
+{
+	int self;
+
+	self = current->pid;
+
+	if ((pPhpCtlr->hwlock).owner_id == self)
+		return;
+
+	down(&((pPhpCtlr->hwlock).crit_sect));
+	(pPhpCtlr->hwlock).owner_id = self;
+
+	return;
+}

+#define  TIGER_PLATFORM		/* Uncomment for Tiger platform (870 chipset) */

Make this a config item if you really want to.  Otherwise get rid of it,
or at least fix the comment :)

+_DEFINE_DBG_BUFFER		/* Debug string buffer for entire HPC defined here */

Why here?  What was wrong with a few lines above this?

+#ifdef CONFIG_IA64
+static wait_queue_head_t delay_wait_q_head;
+
+/* delay in jiffies to wait */
+static void longdelay(int delay)
+{
+	init_waitqueue_head(&delay_wait_q_head);
+
+	interruptible_sleep_on_timeout(&delay_wait_q_head, delay);
+}
+#endif				/* CONFIG_IA64 */

Why does ia64 need an extra delay?  And if it _really_ needs it, please
provide a non-ia64 version of the function so you don't need the #ifdef
later on in the code where you call this function.

+	struct php_ctlr_state_s *pPhpCtlr = (struct php_ctlr_state_s *) ctrl->hpc_ctlr_handle;

Ugh, please use a Linux variable naming scheme, instead of this.

+	_DBG_ENTER_ROUTINE
+
+	if (!ctrl->hpc_ctlr_handle) {
+		_DBG_PRINT_ERROR("Process %d: Invalid HPC Controller handle!", current->pid);
+		return -1;
+	}
+
+	_phphpc_acquire_lock(ctrl->hpc_ctlr_handle);

So the "global" phphpc_acquire_lock() function isn't to be called here?
Why not?  This is just causing another level of indirection that isn't
needed (not to mention that this doesn't need to be a function call, but
just grab the lock instead.)

+	/* turn on board without attaching to the bus */
+	pPhpCtlr->creg->slot_power |= (0x01 << slot);

Do NOT write directly to memory.  You do this a LOT.  Use the proper
functions to do this instead.

The functions you deleted do this correctly :)

+static void
+phphpc_set_led_state(struct slot * slot, struct php_led_id_state * led_id_state, ...)
+{
+	u16 word_register;
+	struct php_ctlr_state_s *pPhpCtlr = (struct php_ctlr_state_s *) slot->ctrl->hpc_ctlr_handle;
+	unsigned int shift = 0, bits = 0, mask;
+	struct php_led_id_state *led_status = led_id_state;
+	int DONE = 0;

Ah, you want to make sure we are done?  Why all caps here?

+	va_list args;
+	va_start(args, led_id_state);

varargs within the kernel for setting a LED?  Isn't this a bit overkill?
Can't you just make the individual LED calls instead?

+	return (1);

Where is this return() funtion defined?  :)
(hint, don't pass a paramater to return, it's not needed, and isn't the
kernel style of programming.)

+void phphpc_get_ctlr_dev_id(struct pci_device_id *hpc_dev_id)
+{
+#ifdef  CONFIG_IA64
+	struct pci_dev *pdev;
+
+	hpc_dev_id->vendor = PCI_VENDOR_ID_INTEL;
+	pdev = pci_find_subsys(PCI_VENDOR_ID_INTEL, PCI_INTC_P64H2_DID, PCI_ANY_ID, PCI_ANY_ID, NULL);
+	if (pdev != NULL) {
+		hpc_did = PCI_INTC_P64H2_DID;
+		hpc_dev_id->device = PCI_INTC_P64H2_DID;
+	} else {
+		pdev = pci_find_subsys(PCI_VENDOR_ID_INTEL, PCI_INTC_WXB_DID, PCI_ANY_ID, PCI_ANY_ID, NULL);
+		if (pdev != NULL) {
+			hpc_did = PCI_INTC_WXB_DID;
+			hpc_dev_id->device = PCI_INTC_WXB_DID;
+		} else
+			hpc_dev_id->device = 0;	// should cause a failing return code
+		// from pci_module_init()
+	}
+#else
+	hpc_dev_id->vendor = PCI_VENDOR_ID_COMPAQ;
+	hpc_dev_id->device = PCI_HPC_ID;
+#endif				/* CONFIG_IA64 */
+
+	hpc_dev_id->subvendor = PCI_ANY_ID;
+	hpc_dev_id->subdevice = PCI_ANY_ID;
+	hpc_dev_id->class = 0;
+	hpc_dev_id->class_mask = 0;
+	hpc_dev_id->driver_data = 0;
+
+}

So a Compaq chip will _never_ be on a ia64 machine?  Why not just get
this info from the pci_dev that was passed to the probe function
originally?

+static int phphpc_is_64bit(struct controller *ctrl, u8 slot)
+{
+	struct php_ctlr_state_s *pPhpCtlr = (struct php_ctlr_state_s *) ctrl->hpc_ctlr_handle;
+
+	_DBG_ENTER_ROUTINE 
+	if (!ctrl->hpc_ctlr_handle) {
+		_DBG_PRINT_ERROR("Process %d: Invalid HPC controller handle!", current->pid);
+		return 0;
+	}
+
+	if (slot >= pPhpCtlr->num_slots) {
+		_DBG_PRINT_ERROR("Process %d: Invalid HPC slot number!", current->pid);
+		return 0;
+	}
+
+	_DBG_LEAVE_ROUTINE 
+	return 1;
+}

You don't actually test anything in this function, why not?

+#ifdef CONFIG_IA64
+	longdelay(6 * (HZ / 10));
+#endif				/*  CONFIG_IA64 */

Ah, see, this can be removed, as was mentioned previously.  And why does
ia64 need the delay?

+static int phphpc_get_cur_bus_speed (struct slot *slot, enum pci_bus_speed *value)
+{
+	struct php_ctlr_state_s *pPhpCtlr = (struct php_ctlr_state_s *) slot->ctrl->hpc_ctlr_handle;
+	u32 pci_misc_config;
+	enum pci_bus_speed bus_speed = PCI_SPEED_UNKNOWN;
+	u16 temp_word;
+	u32 temp_dword;
+	struct pci_dev *dev;
+
+	_DBG_ENTER_ROUTINE 
+	if (!slot->ctrl->hpc_ctlr_handle) {
+		_DBG_PRINT_ERROR("Process %d: Invalid HPC controller handle!", current->pid);
+		return -1;
+	}
+
+	if (hpc_did == PCI_INTC_P64H2_DID) {
+		dev = pci_find_subsys(PCI_VENDOR_ID_INTEL, PCI_INTC_P64H2_HUB_PCI, PCI_ANY_ID, PCI_ANY_ID, NULL);

Why not just save off pci_dev, instead of constantly having to find it
again.  That's why it is passed to the probe() function :)


diff -urN linux-2.5.45-ia64-021031-phpa/drivers/hotplug.org/cpqphp_nvram.c linux-2.5.45-ia64-021031-phpa/drivers/hotplug/cpqphp_nvram.c
--- linux-2.5.45-ia64-021031-phpa/drivers/hotplug.org/cpqphp_nvram.c	Wed Oct 30 16:43:39 2002
+++ linux-2.5.45-ia64-021031-phpa/drivers/hotplug/cpqphp_nvram.c	Tue Nov  5 21:20:15 2002
@@ -168,6 +168,9 @@
 
 static u32 access_EV (u16 operation, u8 *ev_name, u8 *buffer, u32 *buf_size)
 {
+#ifdef	CONFIG_IA64
+	return 0;
+#else

Why not just prevent this file from being compiled in on ia64.  That
would make things easier instead of having to put #ifdefs in the code.

+/*
+ ************************************************************************
+ * PCI HotPlug support routines..... These should probably be in    *
+ * the common pci code, but it's not going in right now (pre 2.4)   *
+ ************************************************************************
  */

We are post 2.4 right now :)

 int cpqhp_set_irq (u8 bus_num, u8 dev_num, u8 int_pin, u8 irq_num)
 {
+#if defined(CONFIG_HOTPLUG_PCI_COMPAQ_NVRAM) && defined(CONFIG_X86)
 	int rc;
 	u16 temp_word;
 	struct pci_dev fakedev;
@@ -372,35 +359,27 @@
 	// This should only be for x86 as it sets the Edge Level Control Register
 	outb((u8) (temp_word & 0xFF), 0x4d0);
 	outb((u8) ((temp_word & 0xFF00) >> 8), 0x4d1);
-
+#endif
 	return 0;
 }

Why doesn't ia64 work properly here?

+	struct pci_bus lpci_bus, *pci_bus;
+	memcpy(&lpci_bus, ctrl->pci_bus, sizeof(lpci_bus));
+	pci_bus = &lpci_bus;
+	pci_bus->number = new_slot->bus;

Why mock up a pci_bus on the stack here?  Don't we know it based on the
controller's pci_bus?  Why did you change this?

Well that's enough to start with :)

thanks,

greg k-h
