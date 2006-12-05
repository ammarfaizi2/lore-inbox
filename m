Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966059AbWLEW7b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966059AbWLEW7b (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 17:59:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966586AbWLEW7b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 17:59:31 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:51217 "EHLO
	ebiederm.dsl.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966059AbWLEW73 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 17:59:29 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: David Brownell <david-b@pacbell.net>
Cc: linux-usb-devel@lists.sourceforge.net,
       Peter Stuge <stuge-linuxbios@cdy.org>,
       Stefan Reinauer <stepan@coresystems.de>, Greg KH <gregkh@suse.de>,
       linux-kernel@vger.kernel.org, "Lu, Yinghai" <yinghai.lu@amd.com>,
       Andi Kleen <ak@suse.de>, linuxbios@linuxbios.org
Subject: Re: [linux-usb-devel] [RFC][PATCH 0/2] x86_64 Early usb debug port support.
References: <5986589C150B2F49A46483AC44C7BCA4907276@ssvlexmb2.amd.com>
	<m13b7xf084.fsf@ebiederm.dsl.xmission.com>
	<m1hcwcuu17.fsf_-_@ebiederm.dsl.xmission.com>
	<200612042001.09808.david-b@pacbell.net>
Date: Tue, 05 Dec 2006 04:01:07 -0700
In-Reply-To: <200612042001.09808.david-b@pacbell.net> (David Brownell's
	message of "Mon, 4 Dec 2006 20:01:08 -0800")
Message-ID: <m1hcwa7gjw.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok due to popular demands here is the slightly fixed patch that works
on both i386 and x86_64.  For the i386 version you must not have
HIGHMEM64G enabled. 

I just rolled it all into one patch as I'm to lazy to transmit all
3 of them.

Eric

 arch/i386/kernel/head.S           |    8 +
 arch/x86_64/kernel/early_printk.c |  580 +++++++++++++++++++++++++++++++++++++
 arch/x86_64/kernel/head.S         |   11 +-
 drivers/usb/host/ehci.h           |    8 +
 include/asm-i386/fixmap.h         |    1 +
 include/asm-x86_64/fixmap.h       |    1 +
 6 files changed, 608 insertions(+), 1 deletions(-)

diff --git a/arch/i386/kernel/head.S b/arch/i386/kernel/head.S
index ca31f18..f683565 100644
--- a/arch/i386/kernel/head.S
+++ b/arch/i386/kernel/head.S
@@ -135,6 +135,12 @@ page_pde_offset = (__PAGE_OFFSET >> 20);
 	jb 10b
 	movl %edi,(init_pg_tables_end - __PAGE_OFFSET)
 
+	/* Do an early initialization of the fixmap area */
+	movl $(swapper_pg_dir - __PAGE_OFFSET), %edx
+	movl $(swapper_pg_pmd - __PAGE_OFFSET), %eax
+	addl $0x007, %eax			/* 0x007 = PRESENT+RW+USER */
+	movl %eax, 4092(%edx)
+
 #ifdef CONFIG_SMP
 	xorl %ebx,%ebx				/* This is the boot CPU (BSP) */
 	jmp 3f
@@ -477,6 +483,8 @@ ENTRY(_stext)
 .section ".bss.page_aligned","w"
 ENTRY(swapper_pg_dir)
 	.fill 1024,4,0
+ENTRY(swapper_pg_pmd)
+	.fill 1024,4,0	
 ENTRY(empty_zero_page)
 	.fill 4096,1,0
 
diff --git a/arch/x86_64/kernel/early_printk.c b/arch/x86_64/kernel/early_printk.c
index d4050a5..71f2f88 100644
--- a/arch/x86_64/kernel/early_printk.c
+++ b/arch/x86_64/kernel/early_printk.c
@@ -3,9 +3,19 @@
 #include <linux/init.h>
 #include <linux/string.h>
 #include <linux/screen_info.h>
+#include <linux/usb_ch9.h>
+#include <linux/pci_regs.h>
+#include <linux/pci_ids.h>
+#include <linux/errno.h>
 #include <asm/io.h>
 #include <asm/processor.h>
 #include <asm/fcntl.h>
+#include <asm/pci-direct.h>
+#include <asm/pgtable.h>
+#include <asm/fixmap.h>
+#define EARLY_PRINTK
+#include "../../../drivers/usb/host/ehci.h"
+
 
 /* Simple VGA output */
 
@@ -155,6 +165,564 @@ static struct console early_serial_console = {
 	.index =	-1,
 };
 
+
+static struct ehci_caps __iomem *ehci_caps;
+static struct ehci_regs __iomem *ehci_regs;
+static struct ehci_dbg_port __iomem *ehci_debug;
+static unsigned dbgp_endpoint_out;
+
+#define USB_DEBUG_DEVNUM 127
+
+#define DBGP_DATA_TOGGLE	0x8800
+#define DBGP_PID_UPDATE(x, tok) \
+	((((x) ^ DBGP_DATA_TOGGLE) & 0xffff00) | ((tok) & 0xff))
+
+#define DBGP_LEN_UPDATE(x, len) (((x) & ~0x0f) | ((len) & 0x0f))
+/*
+ * USB Packet IDs (PIDs)
+ */
+
+/* token */
+#define USB_PID_OUT		0xe1
+#define USB_PID_IN		0x69
+#define USB_PID_SOF		0xa5
+#define USB_PID_SETUP		0x2d
+/* handshake */
+#define USB_PID_ACK		0xd2
+#define USB_PID_NAK		0x5a
+#define USB_PID_STALL		0x1e
+#define USB_PID_NYET		0x96
+/* data */
+#define USB_PID_DATA0		0xc3
+#define USB_PID_DATA1		0x4b
+#define USB_PID_DATA2		0x87
+#define USB_PID_MDATA		0x0f
+/* Special */
+#define USB_PID_PREAMBLE	0x3c
+#define USB_PID_ERR		0x3c
+#define USB_PID_SPLIT		0x78
+#define USB_PID_PING		0xb4
+#define USB_PID_UNDEF_0		0xf0
+
+#define USB_PID_DATA_TOGGLE	0x88
+#define DBGP_CLAIM (DBGP_OWNER | DBGP_ENABLED | DBGP_INUSE)
+
+#define PCI_CAP_ID_EHCI_DEBUG	0xa
+
+#define HUB_ROOT_RESET_TIME	50	/* times are in msec */
+#define HUB_SHORT_RESET_TIME	10
+#define HUB_LONG_RESET_TIME	200
+#define HUB_RESET_TIMEOUT	500
+
+#define DBGP_MAX_PACKET		8
+
+static int dbgp_wait_until_complete(void)
+{
+	unsigned ctrl;
+	for (;;) {
+		ctrl = readl(&ehci_debug->control);
+		/* Stop when the transaction is finished */
+		if (ctrl & DBGP_DONE)
+			break;
+	}
+	/* Now that we have observed the completed transaction,
+	 * clear the done bit.
+	 */
+	writel(ctrl | DBGP_DONE, &ehci_debug->control);
+	return (ctrl & DBGP_ERROR) ? -DBGP_ERRCODE(ctrl) : DBGP_LEN(ctrl);
+}
+
+static void dbgp_mdelay(int ms)
+{
+	int i;
+	while (ms--) {
+		for (i = 0; i < 1000; i++)
+			outb(0x1, 0x80);
+	}
+}
+
+static void dbgp_breath(void)
+{
+	/* Sleep to give the debug port a chance to breathe */
+}
+
+static int dbgp_wait_until_done(unsigned ctrl)
+{
+	unsigned pids, lpid;
+	int ret;
+
+retry:
+	writel(ctrl | DBGP_GO, &ehci_debug->control);
+	ret = dbgp_wait_until_complete();
+	pids = readl(&ehci_debug->pids);
+	lpid = DBGP_PID_GET(pids);
+
+	if (ret < 0)
+		return ret;
+
+	/* If the port is getting full or it has dropped data
+	 * start pacing ourselves, not necessary but it's friendly.
+	 */
+	if ((lpid == USB_PID_NAK) || (lpid == USB_PID_NYET))
+		dbgp_breath();
+	
+	/* If I get a NACK reissue the transmission */
+	if (lpid == USB_PID_NAK)
+		goto retry;
+
+	return ret;
+}
+
+static void dbgp_set_data(const void *buf, int size)
+{
+	const unsigned char *bytes = buf;
+	unsigned lo, hi;
+	int i;
+	lo = hi = 0;
+	for (i = 0; i < 4 && i < size; i++)
+		lo |= bytes[i] << (8*i);
+	for (; i < 8 && i < size; i++)
+		hi |= bytes[i] << (8*(i - 4));
+	writel(lo, &ehci_debug->data03);
+	writel(hi, &ehci_debug->data47);
+}
+
+static void dbgp_get_data(void *buf, int size)
+{
+	unsigned char *bytes = buf;
+	unsigned lo, hi;
+	int i;
+	lo = readl(&ehci_debug->data03);
+	hi = readl(&ehci_debug->data47);
+	for (i = 0; i < 4 && i < size; i++)
+		bytes[i] = (lo >> (8*i)) & 0xff;
+	for (; i < 8 && i < size; i++)
+		bytes[i] = (hi >> (8*(i - 4))) & 0xff;
+}
+
+static int dbgp_bulk_write(unsigned devnum, unsigned endpoint, const char *bytes, int size)
+{
+	unsigned pids, addr, ctrl;
+	int ret;
+	if (size > DBGP_MAX_PACKET)
+		return -1;
+
+	addr = DBGP_EPADDR(devnum, endpoint);
+
+	pids = readl(&ehci_debug->pids);
+	pids = DBGP_PID_UPDATE(pids, USB_PID_OUT);
+	
+	ctrl = readl(&ehci_debug->control);
+	ctrl = DBGP_LEN_UPDATE(ctrl, size);
+	ctrl |= DBGP_OUT;
+	ctrl |= DBGP_GO;
+
+	dbgp_set_data(bytes, size);
+	writel(addr, &ehci_debug->address);
+	writel(pids, &ehci_debug->pids);
+
+	ret = dbgp_wait_until_done(ctrl);
+	if (ret < 0) {
+		return ret;
+	}
+	return ret;
+}
+
+static int dbgp_bulk_read(unsigned devnum, unsigned endpoint, void *data, int size)
+{
+	unsigned pids, addr, ctrl;
+	int ret;
+
+	if (size > DBGP_MAX_PACKET)
+		return -1;
+
+	addr = DBGP_EPADDR(devnum, endpoint);
+
+	pids = readl(&ehci_debug->pids);
+	pids = DBGP_PID_UPDATE(pids, USB_PID_IN);
+		
+	ctrl = readl(&ehci_debug->control);
+	ctrl = DBGP_LEN_UPDATE(ctrl, size);
+	ctrl &= ~DBGP_OUT;
+	ctrl |= DBGP_GO;
+		
+	writel(addr, &ehci_debug->address);
+	writel(pids, &ehci_debug->pids);
+	ret = dbgp_wait_until_done(ctrl);
+	if (ret < 0)
+		return ret;
+	if (size > ret)
+		size = ret;
+	dbgp_get_data(data, size);
+	return ret;
+}
+
+static int dbgp_control_msg(unsigned devnum, int requesttype, int request, 
+	int value, int index, void *data, int size)
+{
+	unsigned pids, addr, ctrl;
+	struct usb_ctrlrequest req;
+	int read;
+	int ret;
+
+	read = (requesttype & USB_DIR_IN) != 0;
+	if (size > (read?DBGP_MAX_PACKET:0))
+		return -1;
+	
+	/* Compute the control message */
+	req.bRequestType = requesttype;
+	req.bRequest = request;
+	req.wValue = value;
+	req.wIndex = index;
+	req.wLength = size;
+
+	pids = DBGP_PID_SET(USB_PID_DATA0, USB_PID_SETUP);
+	addr = DBGP_EPADDR(devnum, 0);
+
+	ctrl = readl(&ehci_debug->control);
+	ctrl = DBGP_LEN_UPDATE(ctrl, sizeof(req));
+	ctrl |= DBGP_OUT;
+	ctrl |= DBGP_GO;
+
+	/* Send the setup message */
+	dbgp_set_data(&req, sizeof(req));
+	writel(addr, &ehci_debug->address);
+	writel(pids, &ehci_debug->pids);
+	ret = dbgp_wait_until_done(ctrl);
+	if (ret < 0)
+		return ret;
+
+
+	/* Read the result */
+	ret = dbgp_bulk_read(devnum, 0, data, size);
+	return ret;
+}
+
+
+/* Find a PCI capability */
+static __u32 __init find_cap(int num, int slot, int func, int cap) 
+{ 
+	u8 pos;
+	int bytes;
+	if (!(read_pci_config_16(num,slot,func,PCI_STATUS) & PCI_STATUS_CAP_LIST))
+		return 0;
+	pos = read_pci_config_byte(num,slot,func,PCI_CAPABILITY_LIST);
+	for (bytes = 0; bytes < 48 && pos >= 0x40; bytes++) { 
+		u8 id;
+		pos &= ~3; 
+		id = read_pci_config_byte(num,slot,func,pos+PCI_CAP_LIST_ID);
+		if (id == 0xff)
+			break;
+		if (id == cap) 
+			return pos; 
+		pos = read_pci_config_byte(num,slot,func,pos+PCI_CAP_LIST_NEXT); 
+	} 
+	return 0;
+} 
+
+static __u32 __init find_dbgp(int ehci_num, unsigned *rbus, unsigned *rslot, unsigned *rfunc)
+{
+	unsigned bus, slot, func;
+	
+	for (bus = 0; bus < 256; bus++) {
+		for (slot = 0; slot < 32; slot++) {
+			for (func = 0; func < 8; func++) {
+				u32 class;
+				unsigned cap;
+				class = read_pci_config(bus, slot, func, PCI_CLASS_REVISION);
+				if ((class >> 8) != PCI_CLASS_SERIAL_USB_EHCI)
+					continue;
+				cap = find_cap(bus, slot, func, PCI_CAP_ID_EHCI_DEBUG);
+				if (!cap)
+					continue;
+				if (ehci_num-- != 0)
+					continue;
+				*rbus = bus;
+				*rslot = slot;
+				*rfunc = func;
+				return cap;
+			}
+		}
+	}
+	return 0;
+}
+
+static int ehci_reset_port(int port)
+{
+	unsigned portsc;
+	unsigned delay_time, delay;
+
+	/* Reset the usb debug port */
+	portsc = readl(&ehci_regs->port_status[port - 1]);
+	portsc &= ~PORT_PE;
+	portsc |= PORT_RESET;
+	writel(portsc, &ehci_regs->port_status[port - 1]);
+
+	delay = HUB_ROOT_RESET_TIME;
+	for (delay_time = 0; delay_time < HUB_RESET_TIMEOUT;
+	     delay_time += delay) {
+		dbgp_mdelay(delay);
+
+		portsc = readl(&ehci_regs->port_status[port - 1]);
+		if (portsc & PORT_RESET) {
+			/* force reset to complete */
+			writel(portsc & ~(PORT_RWC_BITS | PORT_RESET), 
+				&ehci_regs->port_status[port - 1]);
+			while (portsc & PORT_RESET)
+				portsc = readl(&ehci_regs->port_status[port - 1]);
+		}
+
+		/* Device went away? */
+		if (!(portsc & PORT_CONNECT))
+			return -ENOTCONN;
+
+		/* bomb out completely if something weird happend */
+		if ((portsc & PORT_CSC))
+			return -EINVAL;
+
+		/* If we've finished resetting, then break out of the loop */
+		if (!(portsc & PORT_RESET) && (portsc & PORT_PE))
+			return 0;
+	}
+	return -EBUSY;
+}
+
+static int ehci_wait_for_port(int port)
+{
+	unsigned status;
+	int ret, reps;
+	for (reps = 0; reps >= 0; reps++) {
+		status = readl(&ehci_regs->status);
+		if (status & STS_PCD) {
+			ret = ehci_reset_port(port);
+			if (ret == 0)
+				return 0;
+		}
+	}
+	return -ENOTCONN;
+}
+
+
+#define DBGP_DEBUG 0
+#if DBGP_DEBUG
+void early_printk(const char *fmt, ...);
+# define dbgp_printk early_printk
+#else
+static inline void dbgp_printk(const char *fmt, ...) { }
+#endif
+
+static int ehci_setup(void)
+{
+	unsigned cmd, ctrl, status, portsc, hcs_params, debug_port, n_ports;
+	int ret;
+
+	hcs_params = readl(&ehci_caps->hcs_params);
+	debug_port = HCS_DEBUG_PORT(hcs_params);
+	n_ports    = HCS_N_PORTS(hcs_params);
+
+	dbgp_printk("debug_port: %d\n", debug_port);
+	dbgp_printk("n_ports:    %d\n", n_ports);
+
+	/* Reset the EHCI controller */
+	cmd = readl(&ehci_regs->command);
+	cmd |=CMD_RESET;
+	writel(cmd, &ehci_regs->command);
+	while (cmd & CMD_RESET)
+		cmd = readl(&ehci_regs->command);
+
+	/* Claim ownership, but do not enable yet */
+	ctrl = readl(&ehci_debug->control);
+	ctrl |= DBGP_OWNER;
+	ctrl &= ~(DBGP_ENABLED | DBGP_INUSE);
+	writel(ctrl, &ehci_debug->control);
+
+	/* Start the ehci running */
+	cmd = readl(&ehci_regs->command);
+	cmd &= ~(CMD_LRESET | CMD_IAAD | CMD_PSE | CMD_ASE | CMD_RESET);
+	cmd |= CMD_RUN;
+	writel(cmd, &ehci_regs->command);
+
+	/* Ensure everything is routed to the EHCI */
+	writel(FLAG_CF, &ehci_regs->configured_flag);
+
+	/* Wait until the controller is no longer halted */
+	do {
+		status = readl(&ehci_regs->status);
+	} while (status & STS_HALT);
+
+	/* Wait for a device to show up in the debug port */
+	ret = ehci_wait_for_port(debug_port);
+	if (ret < 0) {
+		dbgp_printk("No device found in debug port\n");
+		return -1;
+	}
+
+	/* Enable the debug port */
+	ctrl = readl(&ehci_debug->control);
+	ctrl |= DBGP_CLAIM;
+	writel(ctrl, &ehci_debug->control);
+	ctrl = readl(&ehci_debug->control);
+	if ((ctrl & DBGP_CLAIM) != DBGP_CLAIM) {
+		dbgp_printk("No device in debug port\n");
+		writel(ctrl & ~DBGP_CLAIM, &ehci_debug->control);
+		return -1;
+
+	}
+
+	/* Completely transfer the debug device to the debug controller */
+	portsc = readl(&ehci_regs->port_status[debug_port - 1]);
+	portsc &= ~PORT_PE;
+	writel(portsc, &ehci_regs->port_status[debug_port - 1]);
+
+	return 0;
+}
+
+static __init void early_dbgp_init(char *s)
+{
+	struct usb_debug_descriptor dbgp_desc;
+	void __iomem *ehci_bar;
+	unsigned ctrl, devnum;
+	unsigned bus, slot, func, cap;
+	unsigned debug_port, bar, offset;
+	unsigned bar_val;
+	unsigned dbgp_num;
+	char *e;
+	int ret;
+
+	if (!early_pci_allowed())
+		return;
+
+	dbgp_num = 0;
+	if (*s) {
+		dbgp_num = simple_strtoul(s, &e, 10);
+	}
+	dbgp_printk("dbgp_num: %d\n", dbgp_num);
+	cap = find_dbgp(dbgp_num, &bus, &slot, &func);
+	if (!cap)
+		return;
+
+	dbgp_printk("Found EHCI debug port\n");
+
+	debug_port = read_pci_config(bus, slot, func, cap);
+	bar = (debug_port >> 29) & 0x7;
+	bar = (bar * 4) + 0xc;
+	offset = (debug_port >> 16) & 0xfff;
+	dbgp_printk("bar: %02x offset: %03x\n", bar, offset);
+	if (bar != PCI_BASE_ADDRESS_0) {
+		dbgp_printk("only debug ports on bar 1 handled.\n");
+		return;
+	}
+
+	bar_val = read_pci_config(bus, slot, func, PCI_BASE_ADDRESS_0);
+	dbgp_printk("bar: %02x offset: %03x\n", bar, offset);
+	if (bar_val & ~PCI_BASE_ADDRESS_MEM_MASK) {
+		dbgp_printk("only simple 32bit mmio bars supported\n");
+		return;
+	}
+		
+
+	/* FIXME I don't have the bar size so just guess PAGE_SIZE is more
+	 * than enough.  1K is the biggest I have seen.
+	 */
+	dbgp_printk("dbgp pre-set_fixmap_nocache\n");
+	set_fixmap_nocache(FIX_DBGP_BASE, bar_val & PAGE_MASK);
+	dbgp_printk("dbgp post-set_fixmap_nocache\n");
+	ehci_bar = (void __iomem *)__fix_to_virt(FIX_DBGP_BASE);
+	ehci_bar += bar_val & ~PAGE_MASK;
+	dbgp_printk("ehci_bar: %p\n", ehci_bar);
+
+	ehci_caps  = ehci_bar;
+	ehci_regs  = ehci_bar + HC_LENGTH(readl(&ehci_caps->hc_capbase));
+	ehci_debug = ehci_bar + offset;
+
+	ret = ehci_setup();
+	if (ret < 0) {
+		dbgp_printk("ehci_setup failed\n");
+		return;
+	}
+
+	/* Find the debug device and make it device number 127 */
+	for (devnum = 0; devnum <= 127; devnum++) {
+		ret = dbgp_control_msg(devnum,
+			USB_DIR_IN | USB_TYPE_STANDARD | USB_RECIP_DEVICE,
+			USB_REQ_GET_DESCRIPTOR, (USB_DT_DEBUG << 8), 0,
+			&dbgp_desc, sizeof(dbgp_desc));
+		if (ret > 0)
+			break;
+	}
+	if (devnum > 127) {
+		dbgp_printk("Could not find attached debug device\n");
+		goto err;
+	}
+	if (ret < 0) {
+		dbgp_printk("Attached device is not a debug device\n");
+		goto err;
+	}
+	dbgp_endpoint_out = dbgp_desc.bDebugOutEndpoint;
+
+	/* Move the device to 127 if it isn't already there */
+	if (devnum != USB_DEBUG_DEVNUM) {
+		ret = dbgp_control_msg(devnum,
+			USB_DIR_OUT | USB_TYPE_STANDARD | USB_RECIP_DEVICE,
+			USB_REQ_SET_ADDRESS, USB_DEBUG_DEVNUM, 0, NULL, 0);
+		if (ret < 0) {
+			dbgp_printk("Could not move attached device to %d\n", 
+				USB_DEBUG_DEVNUM);
+			goto err;
+		}
+		devnum = USB_DEBUG_DEVNUM;
+	}
+
+	/* Enable the debug interface */
+	ret = dbgp_control_msg(USB_DEBUG_DEVNUM,
+		USB_DIR_OUT | USB_TYPE_STANDARD | USB_RECIP_DEVICE,
+		USB_REQ_SET_FEATURE, USB_DEVICE_DEBUG_MODE, 0, NULL, 0);
+	if (ret < 0) {
+		dbgp_printk(" Could not enable the debug device\n");
+		goto err;
+	}
+
+	/* Perform a small write to get the even/odd data state in sync
+	 */
+	ret = dbgp_bulk_write(USB_DEBUG_DEVNUM, dbgp_endpoint_out, " ",1);
+	if (ret < 0) {
+		dbgp_printk("dbgp_bulk_write failed: %d\n", ret);
+		goto err;
+	}
+
+
+	return;
+err:
+	/* Things didn't work so remove my claim */
+	ctrl = readl(&ehci_debug->control);
+	ctrl &= ~(DBGP_CLAIM | DBGP_OUT);
+	writel(ctrl, &ehci_debug->control);
+	return;
+}
+
+static void early_dbgp_write(struct console *con, const char *str, unsigned n)
+{
+	int chunk, ret;
+	if (!ehci_debug)
+		return;
+	while (n > 0) {
+		chunk = n;
+		if (chunk > DBGP_MAX_PACKET)
+			chunk = DBGP_MAX_PACKET;
+		ret = dbgp_bulk_write(USB_DEBUG_DEVNUM, 
+			dbgp_endpoint_out, str, chunk);
+		str += chunk;
+		n -= chunk;
+	}
+}
+
+static struct console early_dbgp_console = {
+	.name =		"earlydbg",
+	.write =	early_dbgp_write,
+	.flags = 	CON_PRINTBUFFER,
+	.index = 	-1,
+};
+
 /* Console interface to a host file on AMD's SimNow! */
 
 static int simnow_fd;
@@ -242,8 +810,20 @@ static int __init setup_early_printk(char *buf)
  		simnow_init(buf + 6);
  		early_console = &simnow_console;
  		keep_early = 1;
+	} else if (!strncmp(buf, "dbgp", 4)) {
+		early_dbgp_init(buf + 4);
+		early_console = &early_dbgp_console;
 	}
 	register_console(early_console);
+#if DBGP_DEBUG
+	{
+		static const char dbgp_test_str[] = 
+			"The quick brown fox jumped over the lazy dog!\n";
+		early_dbgp_init("");
+		early_dbgp_write(&early_dbgp_console, 
+			dbgp_test_str, sizeof(dbgp_test_str) - 1);
+	}
+#endif
 	return 0;
 }
 
diff --git a/arch/x86_64/kernel/head.S b/arch/x86_64/kernel/head.S
index 2f65469..4004965 100644
--- a/arch/x86_64/kernel/head.S
+++ b/arch/x86_64/kernel/head.S
@@ -271,7 +271,16 @@ NEXT_PAGE(level3_kernel_pgt)
 	.fill	510,8,0
 	/* (2^48-(2*1024*1024*1024)-((2^39)*511))/(2^30) = 510 */
 	.quad	phys_level2_kernel_pgt | 0x007
-	.fill	1,8,0
+	.quad	phys_level2_fixmap_pgt | 0x007
+
+NEXT_PAGE(level2_fixmap_pgt)
+	.fill	506,8,0
+	.quad	phys_level1_fixmap_pgt | 0x007
+	/* 8MB reserved for vsyscalls + a 2MB hole = 4 + 1 entries */
+	.fill	5,8,0
+
+NEXT_PAGE(level1_fixmap_pgt)
+	.fill	512,8,0
 
 NEXT_PAGE(level2_ident_pgt)
 	/* 40MB for bootup. 	*/
diff --git a/drivers/usb/host/ehci.h b/drivers/usb/host/ehci.h
index bbc3082..0a67192 100644
--- a/drivers/usb/host/ehci.h
+++ b/drivers/usb/host/ehci.h
@@ -46,6 +46,7 @@ struct ehci_stats {
 
 #define	EHCI_MAX_ROOT_PORTS	15		/* see HCS_N_PORTS */
 
+#ifndef EARLY_PRINTK
 struct ehci_hcd {			/* one per controller */
 	/* glue to PCI and HCD framework */
 	struct ehci_caps __iomem *caps;
@@ -160,6 +161,7 @@ timer_action (struct ehci_hcd *ehci, enum ehci_timer_action action)
 		mod_timer (&ehci->watchdog, t);
 	}
 }
+#endif /* EARLY_PRINTK */
 
 /*-------------------------------------------------------------------------*/
 
@@ -384,6 +386,7 @@ union ehci_shadow {
  * These appear in both the async and (for interrupt) periodic schedules.
  */
 
+#ifndef EARLY_PRINTK
 struct ehci_qh {
 	/* first part defined by EHCI spec */
 	__le32			hw_next;	 /* see EHCI 3.6.1 */
@@ -432,6 +435,7 @@ struct ehci_qh {
 #define NO_FRAME ((unsigned short)~0)			/* pick new start */
 	struct usb_device	*dev;		/* access to TT */
 } __attribute__ ((aligned (32)));
+#endif /* EARLY_PRITNK */
 
 /*-------------------------------------------------------------------------*/
 
@@ -601,6 +605,8 @@ struct ehci_fstn {
 	union ehci_shadow	fstn_next;	/* ptr to periodic q entry */
 } __attribute__ ((aligned (32)));
 
+#ifndef EARLY_PRINTK
+
 /*-------------------------------------------------------------------------*/
 
 #ifdef CONFIG_USB_EHCI_ROOT_HUB_TT
@@ -659,4 +665,6 @@ ehci_port_speed(struct ehci_hcd *ehci, unsigned int portsc)
 
 /*-------------------------------------------------------------------------*/
 
+#endif /* EARLY_PRINTK */
+
 #endif /* __LINUX_EHCI_HCD_H */
diff --git a/include/asm-i386/fixmap.h b/include/asm-i386/fixmap.h
index 02428cb..ea08885 100644
--- a/include/asm-i386/fixmap.h
+++ b/include/asm-i386/fixmap.h
@@ -56,6 +56,7 @@ extern unsigned long __FIXADDR_TOP;
 enum fixed_addresses {
 	FIX_HOLE,
 	FIX_VDSO,
+	FIX_DBGP_BASE,
 #ifdef CONFIG_X86_LOCAL_APIC
 	FIX_APIC_BASE,	/* local (CPU) APIC) -- required for SMP or not */
 #endif
diff --git a/include/asm-x86_64/fixmap.h b/include/asm-x86_64/fixmap.h
index 1b620db..1f2978a 100644
--- a/include/asm-x86_64/fixmap.h
+++ b/include/asm-x86_64/fixmap.h
@@ -36,6 +36,7 @@ enum fixed_addresses {
 	VSYSCALL_LAST_PAGE,
 	VSYSCALL_FIRST_PAGE = VSYSCALL_LAST_PAGE + ((VSYSCALL_END-VSYSCALL_START) >> PAGE_SHIFT) - 1,
 	VSYSCALL_HPET,
+	FIX_DBGP_BASE,
 	FIX_HPET_BASE,
 	FIX_APIC_BASE,	/* local (CPU) APIC) -- required for SMP or not */
 	FIX_IO_APIC_BASE_0,


