Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262148AbVBAW3Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262148AbVBAW3Z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 17:29:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262145AbVBAW2P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 17:28:15 -0500
Received: from sccrmhc12.comcast.net ([204.127.202.56]:18568 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S262142AbVBAWXl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 17:23:41 -0500
Message-ID: <4200016C.6050201@acm.org>
Date: Tue, 01 Feb 2005 16:23:40 -0600
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] Minor IPMI enhancements
Content-Type: multipart/mixed;
 boundary="------------060104000601010903040001"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060104000601010903040001
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



--------------060104000601010903040001
Content-Type: text/plain;
 name="ipmi_base.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ipmi_base.diff"


This patch cleans up the DMI handling so that multiple interfaces
can be reported from the DMI tables and so that the DMI slave
address can be transferred up to the upper layer.  It also adds
an option to specify the slave address as an init parm and removes
some unnecessary initializers.

Signed-off-by: Corey Minyard <minyard@acm.org>

Index: linux-2.6.11-rc2/drivers/char/ipmi/ipmi_si_intf.c
===================================================================
--- linux-2.6.11-rc2.orig/drivers/char/ipmi/ipmi_si_intf.c
+++ linux-2.6.11-rc2/drivers/char/ipmi/ipmi_si_intf.c
@@ -176,6 +176,9 @@
 	unsigned char ipmi_version_major;
 	unsigned char ipmi_version_minor;
 
+	/* Slave address, could be reported from DMI. */
+	unsigned char slave_addr;
+
 	/* Counters and things for the proc filesystem. */
 	spinlock_t count_lock;
 	unsigned long short_timeouts;
@@ -407,7 +410,7 @@
 			/* Error fetching flags, just give up for
 			   now. */
 			smi_info->si_state = SI_NORMAL;
-		} else if (len < 3) {
+		} else if (len < 4) {
 			/* Hmm, no flags.  That's technically illegal, but
 			   don't use uninitialized data. */
 			smi_info->si_state = SI_NORMAL;
@@ -897,21 +900,23 @@
 #define DEFAULT_REGSPACING	1
 
 static int           si_trydefaults = 1;
-static char          *si_type[SI_MAX_PARMS] = { NULL, NULL, NULL, NULL };
+static char          *si_type[SI_MAX_PARMS];
 #define MAX_SI_TYPE_STR 30
 static char          si_type_str[MAX_SI_TYPE_STR];
-static unsigned long addrs[SI_MAX_PARMS] = { 0, 0, 0, 0 };
-static int num_addrs = 0;
-static unsigned int  ports[SI_MAX_PARMS] = { 0, 0, 0, 0 };
-static int num_ports = 0;
-static int           irqs[SI_MAX_PARMS] = { 0, 0, 0, 0 };
-static int num_irqs = 0;
-static int           regspacings[SI_MAX_PARMS] = { 0, 0, 0, 0 };
+static unsigned long addrs[SI_MAX_PARMS];
+static int num_addrs;
+static unsigned int  ports[SI_MAX_PARMS];
+static int num_ports;
+static int           irqs[SI_MAX_PARMS];
+static int num_irqs;
+static int           regspacings[SI_MAX_PARMS];
 static int num_regspacings = 0;
-static int           regsizes[SI_MAX_PARMS] = { 0, 0, 0, 0 };
+static int           regsizes[SI_MAX_PARMS];
 static int num_regsizes = 0;
-static int           regshifts[SI_MAX_PARMS] = { 0, 0, 0, 0 };
+static int           regshifts[SI_MAX_PARMS];
 static int num_regshifts = 0;
+static int slave_addrs[SI_MAX_PARMS];
+static int num_slave_addrs = 0;
 
 
 module_param_named(trydefaults, si_trydefaults, bool, 0);
@@ -955,6 +960,12 @@
 		 " IPMI register, in bits.  For instance, if the data"
 		 " is read from a 32-bit word and the IPMI data is in"
 		 " bit 8-15, then the shift would be 8");
+module_param_array(slave_addrs, int, &num_slave_addrs, 0);
+MODULE_PARM_DESC(slave_addrs, "Set the default IPMB slave address for"
+		 " the controller.  Normally this is 0x20, but can be"
+		 " overridden by this parm.  This is an array indexed"
+		 " by interface number.");
+
 
 #define IPMI_MEM_ADDR_SPACE 1
 #define IPMI_IO_ADDR_SPACE  2
@@ -1542,7 +1553,6 @@
 #endif
 
 #ifdef CONFIG_X86
-
 typedef struct dmi_ipmi_data
 {
 	u8   		type;
@@ -1550,24 +1560,29 @@
 	unsigned long	base_addr;
 	u8   		irq;
 	u8              offset;
-}dmi_ipmi_data_t;
+	u8              slave_addr;
+} dmi_ipmi_data_t;
+
+static dmi_ipmi_data_t dmi_data[SI_MAX_DRIVERS];
+static int dmi_data_entries;
 
 typedef struct dmi_header
 {
 	u8	type;
 	u8	length;
 	u16	handle;
-}dmi_header_t;
+} dmi_header_t;
 
-static int decode_dmi(dmi_header_t *dm, dmi_ipmi_data_t *ipmi_data)
+static int decode_dmi(dmi_header_t *dm, int intf_num)
 {
 	u8		*data = (u8 *)dm;
 	unsigned long  	base_addr;
 	u8		reg_spacing;
+	dmi_ipmi_data_t *ipmi_data = dmi_data+intf_num;
 
-	ipmi_data->type = data[0x04];
+	ipmi_data->type = data[4];
 
-	memcpy(&base_addr,&data[0x08],sizeof(unsigned long));
+	memcpy(&base_addr, data+8, sizeof(unsigned long));
 	if (base_addr & 1) {
 		/* I/O */
 		base_addr &= 0xFFFE;
@@ -1591,33 +1606,36 @@
 		ipmi_data->offset = 16;
 		break;
 	default:
-		printk("ipmi_si: Unknown SMBIOS IPMI Base Addr"
-		       " Modifier: 0x%x\n", reg_spacing);
+		/* Some other interface, just ignore it. */
 		return -EIO;
 	}
 
+	ipmi_data->slave_addr = data[6];
+
 	/* If bit 4 of byte 0x10 is set, then the lsb for the address
 	   is odd. */
 	ipmi_data->base_addr = base_addr | ((data[0x10] & 0x10) >> 4);
 
 	ipmi_data->irq = data[0x11];
 
-	if (is_new_interface(-1, ipmi_data->addr_space,ipmi_data->base_addr))
-	    return 0;
+	if (is_new_interface(-1, ipmi_data->addr_space,ipmi_data->base_addr)) {
+		dmi_data_entries++;
+		return 0;
+	}
 
 	memset(ipmi_data,0,sizeof(dmi_ipmi_data_t));
 
 	return -1;
 }
 
-static int dmi_table(u32 base, int len, int num,
-	dmi_ipmi_data_t *ipmi_data)
+static int dmi_table(u32 base, int len, int num)
 {
 	u8 		  *buf;
 	struct dmi_header *dm;
 	u8 		  *data;
 	int 		  i=1;
 	int		  status=-1;
+	int               intf_num = 0;
 
 	buf = ioremap(base, len);
 	if(buf==NULL)
@@ -1633,9 +1651,10 @@
         		break;
 
 		if (dm->type == 38) {
-			if (decode_dmi(dm, ipmi_data) == 0) {
-				status = 0;
-				break;
+			if (decode_dmi(dm, intf_num) == 0) {
+				intf_num++;
+				if (intf_num >= SI_MAX_DRIVERS)
+					break;
 			}
 		}
 
@@ -1660,7 +1679,7 @@
 	return (sum==0);
 }
 
-static int dmi_iterator(dmi_ipmi_data_t *ipmi_data)
+static int dmi_decode(void)
 {
 	u8   buf[15];
 	u32  fp=0xF0000;
@@ -1678,7 +1697,7 @@
 			u16 len=buf[7]<<8|buf[6];
 			u32 base=buf[11]<<24|buf[10]<<16|buf[9]<<8|buf[8];
 
-			if(dmi_table(base, len, num, ipmi_data) == 0)
+			if(dmi_table(base, len, num) == 0)
 				return 0;
 		}
 		fp+=16;
@@ -1690,16 +1709,13 @@
 static int try_init_smbios(int intf_num, struct smi_info **new_info)
 {
 	struct smi_info   *info;
-	dmi_ipmi_data_t   ipmi_data;
+	dmi_ipmi_data_t   *ipmi_data = dmi_data+intf_num;
 	char              *io_type;
-	int               status;
-
-	status = dmi_iterator(&ipmi_data);
 
-	if (status < 0)
+	if (intf_num >= dmi_data_entries)
 		return -ENODEV;
 
-	switch(ipmi_data.type) {
+	switch(ipmi_data->type) {
 		case 0x01: /* KCS */
 			si_type[intf_num] = "kcs";
 			break;
@@ -1710,7 +1726,6 @@
 			si_type[intf_num] = "bt";
 			break;
 		default:
-			printk("ipmi_si: Unknown SMBIOS SI type.\n");
 			return -EIO;
 	}
 
@@ -1721,15 +1736,15 @@
 	}
 	memset(info, 0, sizeof(*info));
 
-	if (ipmi_data.addr_space == 1) {
+	if (ipmi_data->addr_space == 1) {
 		io_type = "memory";
 		info->io_setup = mem_setup;
-		addrs[intf_num] = ipmi_data.base_addr;
+		addrs[intf_num] = ipmi_data->base_addr;
 		info->io.info = &(addrs[intf_num]);
-	} else if (ipmi_data.addr_space == 2) {
+	} else if (ipmi_data->addr_space == 2) {
 		io_type = "I/O";
 		info->io_setup = port_setup;
-		ports[intf_num] = ipmi_data.base_addr;
+		ports[intf_num] = ipmi_data->base_addr;
 		info->io.info = &(ports[intf_num]);
 	} else {
 		kfree(info);
@@ -1737,20 +1752,23 @@
 		return -EIO;
 	}
 
-	regspacings[intf_num] = ipmi_data.offset;
+	regspacings[intf_num] = ipmi_data->offset;
 	info->io.regspacing = regspacings[intf_num];
 	if (!info->io.regspacing)
 		info->io.regspacing = DEFAULT_REGSPACING;
 	info->io.regsize = DEFAULT_REGSPACING;
 	info->io.regshift = regshifts[intf_num];
 
-	irqs[intf_num] = ipmi_data.irq;
+	info->slave_addr = ipmi_data->slave_addr;
+
+	irqs[intf_num] = ipmi_data->irq;
 
 	*new_info = info;
 
 	printk("ipmi_si: Found SMBIOS-specified state machine at %s"
-	       " address 0x%lx\n",
-	       io_type, (unsigned long)ipmi_data.base_addr);
+	       " address 0x%lx, slave address 0x%x\n",
+	       io_type, (unsigned long)ipmi_data->base_addr,
+	       ipmi_data->slave_addr);
 	return 0;
 }
 #endif /* CONFIG_X86 */
@@ -2115,6 +2133,7 @@
 			       new_smi,
 			       new_smi->ipmi_version_major,
 			       new_smi->ipmi_version_minor,
+			       new_smi->slave_addr,
 			       &(new_smi->intf));
 	if (rv) {
 		printk(KERN_ERR
@@ -2216,6 +2235,10 @@
    	        printk(", BT version %s", bt_smi_handlers.version);
 	printk("\n");
 
+#ifdef CONFIG_X86
+	dmi_decode();
+#endif
+
 	rv = init_one_smi(0, &(smi_infos[pos]));
 	if (rv && !ports[0] && si_trydefaults) {
 		/* If we are trying defaults and the initial port is
Index: linux-2.6.11-rc2/include/linux/ipmi_smi.h
===================================================================
--- linux-2.6.11-rc2.orig/include/linux/ipmi_smi.h
+++ linux-2.6.11-rc2/include/linux/ipmi_smi.h
@@ -106,11 +106,13 @@
 	void (*poll)(void *send_info);
 };
 
-/* Add a low-level interface to the IPMI driver. */
+/* Add a low-level interface to the IPMI driver.  Note that if the
+   interface doesn't know its slave address, it should pass in zero. */
 int ipmi_register_smi(struct ipmi_smi_handlers *handlers,
 		      void                     *send_info,
 		      unsigned char            version_major,
 		      unsigned char            version_minor,
+		      unsigned char            slave_addr,
 		      ipmi_smi_t               *intf);
 
 /*
Index: linux-2.6.11-rc2/drivers/char/ipmi/ipmi_msghandler.c
===================================================================
--- linux-2.6.11-rc2.orig/drivers/char/ipmi/ipmi_msghandler.c
+++ linux-2.6.11-rc2/drivers/char/ipmi/ipmi_msghandler.c
@@ -1626,6 +1626,7 @@
 		      void		       *send_info,
 		      unsigned char            version_major,
 		      unsigned char            version_minor,
+		      unsigned char            slave_addr,
 		      ipmi_smi_t               *intf)
 {
 	int              i, j;
@@ -1661,7 +1662,10 @@
 			new_intf->intf_num = i;
 			new_intf->version_major = version_major;
 			new_intf->version_minor = version_minor;
-			new_intf->my_address = IPMI_BMC_SLAVE_ADDR;
+			if (slave_addr == 0)
+				new_intf->my_address = IPMI_BMC_SLAVE_ADDR;
+			else
+				new_intf->my_address = slave_addr;
 			new_intf->my_lun = 2;  /* the SMS LUN. */
 			rwlock_init(&(new_intf->users_lock));
 			INIT_LIST_HEAD(&(new_intf->users));
Index: linux-2.6.11-rc2/Documentation/IPMI.txt
===================================================================
--- linux-2.6.11-rc2.orig/Documentation/IPMI.txt
+++ linux-2.6.11-rc2/Documentation/IPMI.txt
@@ -342,6 +342,7 @@
        irqs=<irq1>,<irq2>... trydefaults=[0|1]
        regspacings=<sp1>,<sp2>,... regsizes=<size1>,<size2>,...
        regshifts=<shift1>,<shift2>,...
+       slave_addrs=<addr1>,<addr2>,...
 
 Each of these except si_trydefaults is a list, the first item for the
 first interface, second item for the second interface, etc.
@@ -383,6 +384,10 @@
 be in the lower 8 bits.  The regshifts parameter give the amount to shift
 the data to get to the actual IPMI data.
 
+The slave_addrs specifies the IPMI address of the local BMC.  This is
+usually 0x20 and the driver defaults to that, but in case it's not, it
+can be specified when the driver starts up.
+
 When compiled into the kernel, the addresses can be specified on the
 kernel command line as:
 
@@ -392,6 +397,7 @@
        ipmi_si.regspacings=<sp1>,<sp2>,...
        ipmi_si.regsizes=<size1>,<size2>,...
        ipmi_si.regshifts=<shift1>,<shift2>,...
+       ipmi_si.slave_addrs=<addr1>,<addr2>,...
 
 It works the same as the module parameters of the same names.
 

--------------060104000601010903040001--
