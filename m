Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264001AbSL1M2p>; Sat, 28 Dec 2002 07:28:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264665AbSL1M2p>; Sat, 28 Dec 2002 07:28:45 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:64004 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S264001AbSL1M2l>; Sat, 28 Dec 2002 07:28:41 -0500
Date: Sat, 28 Dec 2002 12:36:56 +0000
From: Christoph Hellwig <hch@infradead.org>
To: pavel@ucw.cz, Arjan van de Ven <arjanv@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] amd756 and amd8111 sensors support
Message-ID: <20021228123655.A31843@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>, pavel@ucw.cz,
	Arjan van de Ven <arjanv@redhat.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200212280303.gBS33o628113@hera.kernel.org> <1041076002.1485.2.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1041076002.1485.2.camel@laptop.fenrus.com>; from arjanv@redhat.com on Sat, Dec 28, 2002 at 12:46:42PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 28, 2002 at 12:46:42PM +0100, Arjan van de Ven wrote:
> cool! lm_sensors finally in 2.5!

It would be cool if the code wasn't that obviously broken.


 obj-$(CONFIG_I2C)		+= i2c/
+obj-$(CONFIG_I2C_MAINBOARD)	+= i2c/busses/
+obj-$(CONFIG_SENSORS)		+= i2c/chips/

Please add them inside drivers/i2c/, not at the toplevel.

 obj-$(CONFIG_PHONE)		+= telephony/
 obj-$(CONFIG_MD)		+= md/
 obj-$(CONFIG_BT)		+= bluetooth/
diff -Nru a/drivers/char/mem.c b/drivers/char/mem.c
--- a/drivers/char/mem.c	Sat Dec 28 12:25:39 2002
+++ b/drivers/char/mem.c	Sat Dec 28 12:25:39 2002
@@ -27,6 +27,12 @@
 #include <asm/io.h>
 #include <asm/pgalloc.h>
 
+#ifdef CONFIG_I2C_MAINBOARD
+extern void i2c_mainboard_init_all(void);
+#endif
+#ifdef CONFIG_SENSORS
+extern void sensors_init_all(void);
+#endif
 #ifdef CONFIG_I2C
 extern int i2c_init_all(void);
 #endif
@@ -705,6 +711,9 @@
 #ifdef CONFIG_I2C
 	i2c_init_all();
 #endif
+#ifdef CONFIG_I2C_MAINBOARD
+	i2c_mainboard_init_all();
+#endif
 #if defined (CONFIG_FB)
 	fbmem_init();
 #endif
@@ -719,6 +728,10 @@
 #if defined(CONFIG_S390_TAPE) && defined(CONFIG_S390_TAPE_CHAR)
 	tapechar_init();
 #endif
+#ifdef CONFIG_SENSORS
+	sensors_init_all();
+#endif

Where have you been the last years?  Plese use initcalls instead
of adding explicit junk in mem.c.

+#include <linux/version.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <asm/io.h>
+#include <linux/kernel.h>
+#include <linux/stddef.h>
+#include <linux/sched.h>
+#include <linux/ioport.h>
+#include <linux/i2c.h>
+#include <linux/init.h>

<asm/*.h> after <linux/*.h>, please

+
+struct sd {
+    const unsigned short vendor;
+    const unsigned short device;
+    const unsigned short function;
+    const char* name;
+    int amdsetup:1;
+};
+
+static struct sd supported[] = {
+    {PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_VIPER_740B, 3, "AMD756", 1},
+    {PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_VIPER_7413, 3, "AMD766", 1},
+    {PCI_VENDOR_ID_AMD, 0x7443, 3, "AMD768", 1},
+    {PCI_VENDOR_ID_NVIDIA, 0x01B4, 1, "nVidia nForce", 0},
+    {0, 0, 0}
+};

This should really use a proper pci ID table from the generic code.

+	/* id */ I2C_ALGO_SMBUS,
+	/* master_xfer */ NULL,
+	/* smbus_access */ amd756_access,
+	/* slave;_send */ NULL,
+	/* slave_rcv */ NULL,
+	/* algo_control */ NULL,
+	/* functionality */ amd756_func,
+};
+
+static struct i2c_adapter amd756_adapter = {
+	"unset",
+	I2C_ALGO_SMBUS | I2C_HW_SMBUS_AMD756,
+	&smbus_algorithm,
+	NULL,
+	amd756_inc,
+	amd756_dec,
+	NULL,
+	NULL,
+};

Please use named initializers for such sparse method vectors.

+
+static int __initdata amd756_initialized;

__initdata for function used in cleanup code is bogus.  But this whole
flag is crap, see below.

+static struct sd *amd756_sd = NULL;

Just properly organize your setup code and you don't need this one.

+static unsigned short amd756_smba = 0;

This is in .bss, no need to initialize to zero.

+	struct pci_dev *AMD756_dev = NULL;
+
+	if (pci_present() == 0) {
+		return -ENODEV;
+	}
+
+	/* Look for a supported chip */
+	for(currdev = supported; currdev->vendor; ) {
+		AMD756_dev = pci_find_device(currdev->vendor,
+						currdev->device, AMD756_dev);
+		if (AMD756_dev != NULL)	{
+			if (PCI_FUNC(AMD756_dev->devfn) == currdev->function)
+				break;
+		} else {
+		    currdev++;
+		}
+	}

I think you really just want to use a proper new-style pci driver..

+	if (check_region(amd756_smba, SMB_IOSIZE)) {
+		printk
+		    ("i2c-amd756.o: SMB region 0x%x already in use!\n",
+		     amd756_smba);
+		return -ENODEV;
+	}
+
+	/* Everything is happy, let's grab the memory and set things up. */
+	request_region(amd756_smba, SMB_IOSIZE, "amd756-smbus");

Don't use check_region.

+
+void amd756_inc(struct i2c_adapter *adapter)
+{
+	MOD_INC_USE_COUNT;
+}
+
+void amd756_dec(struct i2c_adapter *adapter)
+{
+
+	MOD_DEC_USE_COUNT;
+}

Your module-refcounting is bogus.

+int __init i2c_amd756_init(void)
+{
+	int res;
+#ifdef DEBUG
+/* PE- It might be good to make this a permanent part of the code! */
+	if (amd756_initialized) {
+		printk
+		    ("i2c-amd756.o: Oops, amd756_init called a second time!\n");
+		return -EBUSY;
+	}
+#endif

This assert can't ever be triggered.

+	amd756_initialized = 0;

It's in .bss and thus already zero.

+	if ((res = amd756_setup())) {
+		printk
+		    ("i2c-amd756.o: AMD756 or compatible device not detected, module not inserted.\n");
+		amd756_cleanup();
+		return res;
+	}

Just merge amd756_setup into it's only caller and your init code will get
a lot nicer.

+void __exit i2c_amd756_exit(void)
+{
+	amd756_cleanup();
+}
+
+static int amd756_cleanup(void)
+{
+	int res;
+	if (amd756_initialized >= 2) {
+		if ((res = i2c_del_adapter(&amd756_adapter))) {
+			printk
+			    ("i2c-amd756.o: i2c_del_adapter failed, module not removed\n");
+			return res;
+		} else
+			amd756_initialized--;
+	}
+	if (amd756_initialized >= 1) {
+		release_region(amd756_smba, SMB_IOSIZE);
+		amd756_initialized--;
+	}
+			return 0;
+}

Please merge i2c_amd756_exit into amd756_cleanup and do proper error handling
inside the int function instead of the gliobal state mess.

+
+EXPORT_NO_SYMBOLS;

Remove it, it's a noop for 2.5.

+#ifdef MODULE
+
+MODULE_AUTHOR("Merlin Hughes <merlin@merlin.org>");
+MODULE_DESCRIPTION("AMD756/766/768/nVidia nForce SMBus driver");
+
+#ifdef MODULE_LICENSE
+MODULE_LICENSE("GPL");
+#endif
+
+#endif				/* MODULE */

Please get rid of that ifdef mess, you can just always use it.

And please backout the init/exit changes in i2c-dev.c, i2c-core.c and
i2c-proc.c, they're just bogus.
