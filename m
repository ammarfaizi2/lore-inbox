Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267254AbUH0Sxk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267254AbUH0Sxk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 14:53:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267238AbUH0Sxk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 14:53:40 -0400
Received: from rproxy.gmail.com ([64.233.170.203]:57393 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S267254AbUH0SwE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 14:52:04 -0400
Message-ID: <4ef5fec604082711523b3935f9@mail.gmail.com>
Date: Fri, 27 Aug 2004 11:52:01 -0700
From: Martin Peck <coderman@gmail.com>
Reply-To: Martin Peck <coderman@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: faster via/centaur hw rng throughput patch for 2.6.8.1
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i have prepared a hw_random.c patch for the via / centaur C5P
processor entropy sources which utilizes module parameters to
achieve significant increases in throughput.

this is not a final patch; this is a partial work which i
would like to see tested on a C5XL and perhaps used to assist
an actual kernel dev/maintainer in making similar performance
improvements in the 2.6 tree.  (read: this code is ugly and
probably has bugs)

a brief explanation of the changes is as follows:

- an 8 byte xstore is used.  the latency for this longer
  instruction is almost non existant and worth the large
  improvement in throughput it provides.

- module parameters are used to specify configuration of
  the entropy sources.  in this fashion every read from
  the entropy pool can confirm that the settings in
  effect during the xstore are consistent with what the
  module was loaded and initialized with.  this is not
  a priveleged instruction so any userspace process
  could potentially manipulate whitener, string filter,
  and DC bias settings (among other things).  this is
  bad (tm).

- use of cpu_has_xstore replaced with model / stepping
  checks to determine C5XL/C5P/C5J/* capability.  there
  is a problem with first generation C5XL boards (with
  stepping 0 IIRC) that do not report xstore but do
  have a functional hardware rng device.  the stepping
  check also distinguishes the single entropy C5XL from
  the dual entropy C5P+.

a brief comparison of original hw_random performance
with the new changes in various configurations is listed
as follows:

baseline hw_random throughput on C5P core:
  Maximum throughput for 10240x1024 test:
    Kbits / sec: 39.0679
  Entropy allocation times (usec) for block size: 128
    Min: 25450
    Max: 61615
    Avg: 25666
  Entropy allocation times (usec) for block size: 10240
    Min: 2047608
    Max: 2056888
    Avg: 2047716


mod hw_random rngsrc 'A', rdelay 1, rawbit 0:
  Maximum throughput for 10240x1024 test:
    Kbits / sec: 7519.05
  Entropy allocation times (usec) for block size: 128
    Min: 112
    Max: 332
    Avg: 132
  Entropy allocation times (usec) for block size: 10240
    Min: 10575
    Max: 10909
    Avg: 10640


mod hw_random rngsrc 'both', rdelay 1, rawbit 0:
  Maximum throughput for 10240x1024 test:
    Kbits / sec: 15246.6
  Entropy allocation times (usec) for block size: 128
    Min: 43
    Max: 284
    Avg: 65
  Entropy allocation times (usec) for block size: 10240
    Min: 4424
    Max: 6099
    Avg: 5247


mod hw_random rngsrc 'both', rdelay 1, rawbit 1:
  Maximum throughput for 10240x1024 test:
    Kbits / sec: 58017
  Entropy allocation times (usec) for block size: 128
    Min: 18
    Max: 40
    Avg: 18
  Entropy allocation times (usec) for block size: 10240
    Min: 1372
    Max: 1534
    Avg: 1379


with the whitener disabled and utilizing both entropy
sources this represents a ~1500 fold increase over the
current hw_random implementation.

log files from this test are available here:

a modified rngd utilizing two threads to cope with the
/dev/hwrandom throughput will be released shortly.

any feedback appreciated.

-----

diff -urN ./orig-linux-2.6.8.1/drivers/char/hw_random.c
./viarng-linux-2.6.8.1/drivers/char/hw_random.c
--- ./orig-linux-2.6.8.1/drivers/char/hw_random.c       2004-08-14
03:55:10.000000000 -0700
+++ ./viarng-linux-2.6.8.1/drivers/char/hw_random.c     2004-08-27
10:47:07.000000000 -0700
@@ -1,4 +1,8 @@
-/*
+/*     Modified by <coderman@peertech.org> for 8 byte xtore,
+        added parameters to control rng sources.
+
+       derived from
+
        Hardware driver for the Intel/AMD/VIA Random Number Generators (RNG)
        (c) Copyright 2003 Red Hat Inc <jgarzik@redhat.com>

@@ -47,7 +51,7 @@
 /*
  * core module and version information
  */
-#define RNG_VERSION "1.0.0"
+#define RNG_VERSION "1.0.1"
 #define RNG_MODULE_NAME "hw_random"
 #define RNG_DRIVER_NAME   RNG_MODULE_NAME " hardware driver " RNG_VERSION
 #define PFX RNG_MODULE_NAME ": "
@@ -78,32 +82,48 @@

 #define RNG_MISCDEV_MINOR              183 /* official */

+/* use module parameters for the following VIA rng options.
+ * module parms are used because these values should be set
+ * when loaded, and consistent during use of /dev/hwrandom.
+ *
+ * rngsrc - which of two (or both) entropy sources to use
+ *          on dual entropy cores.
+ *          0 = both,  1 = 'A',  2 = 'B' source.
+ * rdelay - microsecond sleep used on dry reads from xstore.
+ * rawbit - bypass whitener and provide raw entropy bits.
+ * strflt - enable continuous bit string filter.
+ * fltlen - length of consecutive bit strings to filter.
+*/
+static int  rngsrc = 0;
+static int  rdelay = 10;
+static int  rawbit = 0;
+static int  strflt = 0;
+static int  fltlen = 0;
+
 static int rng_dev_open (struct inode *inode, struct file *filp);
-static ssize_t rng_dev_read (struct file *filp, char __user *buf, size_t size,
+static ssize_t rng_dev_read (struct file *filp, char *buf, size_t size,
                             loff_t * offp);

 static int __init intel_init (struct pci_dev *dev);
 static void intel_cleanup(void);
 static unsigned int intel_data_present (void);
-static u32 intel_data_read (void);
+static u64 intel_data_read (void);

 static int __init amd_init (struct pci_dev *dev);
 static void amd_cleanup(void);
 static unsigned int amd_data_present (void);
-static u32 amd_data_read (void);
+static u64 amd_data_read (void);

-#ifdef __i386__
 static int __init via_init(struct pci_dev *dev);
 static void via_cleanup(void);
 static unsigned int via_data_present (void);
-static u32 via_data_read (void);
-#endif
+static u64 via_data_read (void);

 struct rng_operations {
        int (*init) (struct pci_dev *dev);
        void (*cleanup) (void);
        unsigned int (*data_present) (void);
-       u32 (*data_read) (void);
+       u64 (*data_read) (void);
        unsigned int n_bytes; /* number of bytes per ->data_read */
 };
 static struct rng_operations *rng_ops;
@@ -139,10 +159,8 @@
        /* rng_hw_amd */
        { amd_init, amd_cleanup, amd_data_present, amd_data_read, 4 },

-#ifdef __i386__
        /* rng_hw_via */
-       { via_init, via_cleanup, via_data_present, via_data_read, 1 },
-#endif
+       { via_init, via_cleanup, via_data_present, via_data_read, 8 },
 };

 /*
@@ -214,7 +232,7 @@
                1 : 0;
 }

-static u32 intel_data_read(void)
+static u64 intel_data_read(void)
 {
        assert (rng_mem != NULL);

@@ -291,7 +309,7 @@
 }


-static u32 amd_data_read (void)
+static u64 amd_data_read (void)
 {
        return inl(pmbase + 0xF0);
 }
@@ -345,7 +363,6 @@
        /* FIXME: twiddle pmio, also? */
 }

-#ifdef __i386__
 /***********************************************************************
  *
  * VIA RNG operations
@@ -353,10 +370,32 @@
  */

 enum {
+        /* VIA MSR register bit layout
+         * 31:22 reserved
+         * 21:16 string filter count
+         * 15:15 string filter failed
+         * 14:14 string filter enabled
+         * 13:13 raw bits enabled
+         * 12:10 dc bias value
+         * 09:08 noise source select
+        *       00 - 'A' active
+        *       01 - 'B' active
+        *       10 - both active
+        *       11 - both active
+         * 07:07 reserved
+         * 06:06 rng enabled
+         * 05:05 reserved
+         * 04:00 current byte count
+        */
        VIA_STRFILT_CNT_SHIFT   = 16,
        VIA_STRFILT_FAIL        = (1 << 15),
        VIA_STRFILT_ENABLE      = (1 << 14),
+       VIA_STRFLT_MIN          = 8,
+       VIA_STRFLT_MAX          = 63,
        VIA_RAWBITS_ENABLE      = (1 << 13),
+       VIA_DCBIAS_SHIFT        = 10,
+       VIA_DCBIAS_MAX          = 7,
+        VIA_NOISE_SRC_SHIFT     = 8,
        VIA_RNG_ENABLE          = (1 << 6),
        VIA_XSTORE_CNT_MASK     = 0x0F,

@@ -369,99 +408,115 @@
        VIA_RNG_CHUNK_1_MASK    = 0xFF,
 };

-u32 via_rng_datum;
-
-/*
- * Investigate using the 'rep' prefix to obtain 32 bits of random data
- * in one insn.  The upside is potentially better performance.  The
- * downside is that the instruction becomes no longer atomic.  Due to
- * this, just like familiar issues with /dev/random itself, the worst
- * case of a 'rep xstore' could potentially pause a cpu for an
- * unreasonably long time.  In practice, this condition would likely
- * only occur when the hardware is failing.  (or so we hope :))
- *
- * Another possible performance boost may come from simply buffering
- * until we have 4 bytes, thus returning a u32 at a time,
- * instead of the current u8-at-a-time.
- */
+u64 via_rng_datum;

-static inline u32 xstore(u32 *addr, u32 edx_in)
+static inline u32 xstore (u64 *dest, u32 edx_in)
 {
        u32 eax_out;

        asm(".byte 0x0F,0xA7,0xC0 /* xstore %%edi (addr=%0) */"
-               :"=m"(*addr), "=a"(eax_out)
-               :"D"(addr), "d"(edx_in));
+               :"=m"(*dest), "=a"(eax_out)
+               :"D"(dest), "d"(edx_in));

        return eax_out;
 }

-static unsigned int via_data_present(void)
+/* return low MSR value with module parameters applied to
+ * rng configuration flags.
+ */
+static inline u32 via_lomsr_with_cfg (u32 lo)
 {
-       u32 bytes_out;
+       int  noisebits;

-       /* We choose the recommended 1-byte-per-instruction RNG rate,
-        * for greater randomness at the expense of speed.  Larger
-        * values 2, 4, or 8 bytes-per-instruction yield greater
-        * speed at lesser randomness.
-        *
-        * If you change this to another VIA_CHUNK_n, you must also
-        * change the ->n_bytes values in rng_vendor_ops[] tables.
-        * VIA_CHUNK_8 requires further code changes.
-        *
-        * A copy of MSR_VIA_RNG is placed in eax_out when xstore
-        * completes.
-        */
-       via_rng_datum = 0; /* paranoia, not really necessary */
-       bytes_out = xstore(&via_rng_datum, VIA_RNG_CHUNK_1) &
VIA_XSTORE_CNT_MASK;
-       if (bytes_out == 0)
-               return 0;
+       switch (rngsrc) {
+               case 0: noisebits = 3; break;
+               case 1: noisebits = 0; break;
+               case 2: noisebits = 1; break;
+           default: noisebits = 0; break;
+       }

-       return 1;
-}
+       lo |= VIA_RNG_ENABLE;
+       lo &= ~(VIA_DCBIAS_MAX << VIA_DCBIAS_SHIFT);
+       lo &= ~(VIA_STRFLT_MAX << VIA_STRFILT_CNT_SHIFT);
+       if (strflt) {
+               lo |= fltlen << VIA_STRFILT_CNT_SHIFT;
+               lo |= VIA_STRFILT_ENABLE;
+       }
+       lo &= ~(3 << VIA_NOISE_SRC_SHIFT);
+       lo |= noisebits << VIA_NOISE_SRC_SHIFT;
+       if (rawbit) {
+               lo |= VIA_RAWBITS_ENABLE;
+       }
+       else {
+               lo &= ~(VIA_RAWBITS_ENABLE);
+       }

-static u32 via_data_read(void)
-{
-       return via_rng_datum;
+       return lo;
 }

-static int __init via_init(struct pci_dev *dev)
+static int via_rng_initialize (void)
 {
        u32 lo, hi, old_lo;

-       /* Control the RNG via MSR.  Tread lightly and pay very close
-        * close attention to values written, as the reserved fields
-        * are documented to be "undefined and unpredictable"; but it
-        * does not say to write them as zero, so I make a guess that
-        * we restore the values we find in the register.
+       /* Control the RNG via MSR.  Set values based on module
+        * parameters for desired configuration.
         */
-       rdmsr(MSR_VIA_RNG, lo, hi);
+       rdmsr(MSR_VIA_RNG, old_lo, hi);

-       old_lo = lo;
-       lo &= ~(0x7f << VIA_STRFILT_CNT_SHIFT);
-       lo &= ~VIA_XSTORE_CNT_MASK;
-       lo &= ~(VIA_STRFILT_ENABLE | VIA_STRFILT_FAIL | VIA_RAWBITS_ENABLE);
-       lo |= VIA_RNG_ENABLE;
+       lo = via_lomsr_with_cfg (old_lo);

        if (lo != old_lo)
                wrmsr(MSR_VIA_RNG, lo, hi);

-       /* perhaps-unnecessary sanity check; remove after testing if
-          unneeded */
-       rdmsr(MSR_VIA_RNG, lo, hi);
-       if ((lo & VIA_RNG_ENABLE) == 0) {
-               printk(KERN_ERR PFX "cannot enable VIA C3 RNG, aborting\n");
-               return -ENODEV;
+       return 0;
+}
+
+static unsigned int via_data_present (void)
+{
+        u32 rnd_bytes = 0;
+       u32 status_out;
+
+       /* Attempt to read entropy via xstore and confirm rng
+        * state after read.  It is important to validate state
+        * before accepting entropy as userspace processes may
+        * alter the current rng configuration.
+        */
+       status_out = xstore(&via_rng_datum, VIA_RNG_CHUNK_8);
+       if (status_out != via_lomsr_with_cfg (status_out)) {
+               /* something changed the RNG configuration after module
+                * initialization. Consider this read invalid and reset
+                * with desired config settings.
+                */
+               via_rng_initialize ();
+               return 0;
        }

-       return 0;
+        rnd_bytes = status_out & VIA_XSTORE_CNT_MASK;
+       if (rnd_bytes != 8) {
+               return 0;
+        }
+
+       return 1;
+}
+
+static u64 via_data_read (void)
+{
+       return via_rng_datum;
 }

-static void via_cleanup(void)
+static int __init via_init (struct pci_dev *dev)
 {
-       /* do nothing */
+       return via_rng_initialize();
+}
+
+static void via_cleanup (void)
+{
+       u32 lo, hi;
+
+       rdmsr(MSR_VIA_RNG, lo, hi);
+       lo &= ~VIA_RNG_ENABLE;
+       wrmsr(MSR_VIA_RNG, lo, hi);
 }
-#endif


 /***********************************************************************
@@ -482,12 +537,13 @@
 }


-static ssize_t rng_dev_read (struct file *filp, char __user *buf, size_t size,
+static ssize_t rng_dev_read (struct file *filp, char *buf, size_t size,
                             loff_t * offp)
 {
        static spinlock_t rng_lock = SPIN_LOCK_UNLOCKED;
+       int dry_read = 0;
        unsigned int have_data;
-       u32 data = 0;
+       u64 data = 0;
        ssize_t ret = 0;

        while (size) {
@@ -497,6 +553,10 @@
                if (rng_ops->data_present()) {
                        data = rng_ops->data_read();
                        have_data = rng_ops->n_bytes;
+                       dry_read = 0;
+               }
+               else {
+                       dry_read = 1;
                }

                spin_unlock (&rng_lock);
@@ -520,8 +580,11 @@
                        current->state = TASK_INTERRUPTIBLE;
                        schedule_timeout(1);
                }
-               else
-                       udelay(200);    /* FIXME: We could poll for 250uS ?? */
+               else {
+                       if (dry_read) {
+                               udelay(rdelay);
+                       }
+               }

                if (signal_pending (current))
                        return ret ? : -ERESTARTSYS;
@@ -568,6 +631,16 @@
 MODULE_DESCRIPTION("H/W Random Number Generator (RNG) driver");
 MODULE_LICENSE("GPL");

+MODULE_PARM(rngsrc, "i");
+MODULE_PARM_DESC(rngc, "rng source [C5P+ only].  (default 0 - both)");
+MODULE_PARM(rdelay, "i");
+MODULE_PARM_DESC(rdelay, "dry read delay in microseconds (default 10us)");
+MODULE_PARM(rawbit, "i");
+MODULE_PARM_DESC(rawbit, "rawbit enable. (default 0 - no)");
+MODULE_PARM(strflt, "i");
+MODULE_PARM_DESC(strflt, "bit string filter enable.  (default 0 - no)");
+MODULE_PARM(fltlen, "i");
+MODULE_PARM_DESC(fltlen, "filter bitstring length [requires string
filter].  (default 0)");

 /*
  * rng_init - initialize RNG module
@@ -577,6 +650,7 @@
        int rc;
        struct pci_dev *pdev = NULL;
        const struct pci_device_id *ent;
+        struct cpuinfo_x86 *c = NULL;

        DPRINTK ("ENTER\n");

@@ -590,8 +664,30 @@
        }

 #ifdef __i386__
-       /* Probe for VIA RNG */
-       if (cpu_has_xstore) {
+       /* Check for VIA RNG and initialize module parameters.
+         * Use the model/stepping number as indication of xstore
+         * due to problems detecting xstore on early C5XL cores.
+        */
+        c = &current_cpu_data;
+        if (c->x86 == 6 && c->x86_model == 9) {
+               /* anything stepping 7 or less has 1 rng source */
+               if (c->x86_mask <= 7) rngsrc = 1;
+
+               /* validate module parameters */
+               if (rngsrc < 0 || rngsrc > 2) rngsrc = 0;
+               if (rdelay < 1 || rdelay > 1000) rdelay = 1;
+               if (rawbit < 0 || rawbit > 1) rawbit = 0;
+               if (strflt < 0 || strflt > 1) strflt = 0;
+               if (strflt && (fltlen < VIA_STRFLT_MIN || fltlen >
VIA_STRFLT_MAX)) strflt = 0;
+               if (!strflt) fltlen = 0;
+
+               printk ("%s VIA RNG specific options = rng source: %d,
read delay: %d, rawbit: %s, string filt
er: %s, filter length: %d\n",
+                       RNG_MODULE_NAME,
+                       rngsrc, rdelay,
+                       rawbit ? "enabled" : "disabled",
+                       strflt ? "enabled" : "disabled",
+                       fltlen);
+
                rng_ops = &rng_vendor_ops[rng_hw_via];
                pdev = NULL;
                goto match;
@@ -631,3 +727,4 @@

 module_init (rng_init);
 module_exit (rng_cleanup);
+
