Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136537AbRD3Wnl>; Mon, 30 Apr 2001 18:43:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136538AbRD3Wnc>; Mon, 30 Apr 2001 18:43:32 -0400
Received: from mail-3.addcom.de ([62.96.128.37]:14355 "HELO mail-3.addcom.de")
	by vger.kernel.org with SMTP id <S136537AbRD3WnW>;
	Mon, 30 Apr 2001 18:43:22 -0400
Date: Tue, 1 May 2001 00:43:42 +0200 (CEST)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: <kai@vaio>
To: <linux-kernel@vger.kernel.org>
cc: <kbuild-devel@lists.sourceforge.net>
Subject: [PATCH] automatic multi-part link rules (fwd)
Message-ID: <Pine.LNX.4.33.0105010022020.24511-100000@vaio>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I sent this to the kbuild list about a week ago, and I received exactly
zero replies, so I'm posting to l-k now. This may mean that the idea is
totally stupid (but I'd like to know) or unquestionably good (that's what
I'd prefer :), well, maybe I'll get some feedback this time.

SHORT VERSION:

The attached patch allows to get rid of the "list-multi := ..." lines and
link-rules for multi-part objects in all the Makefiles without breaking
any current Makefile.


---------- Forwarded message ----------
Date: Tue, 24 Apr 2001 15:05:07 +0200 (CEST)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
To: kbuild-devel@lists.sourceforge.net
Subject: [kbuild-devel] [PATCH] automatic multi-part link rules


Hi!

I'd like to get some comments on the appended patch. It removes the need
to put explicit link rules for multi-part objects in the individual
Makefiles in the subdirectores and leaves them to Rules.make instead.

I know that 2.5 kbuild will look entirely differently, but I consider this
patch useful for 2.4 as well, it's a cleanup which IMO can be applied
(after checking) to a stable kernel. (BTW: I have a lot of comments and
some code for kbuild-2.5 as well, but later).

To guarantee a smooth transition, the patch to Rules.make doesn't change
current behavior, at least with correct Makefiles. Today, a Makefile which
may build multi-part modules looks like the following:

	list-multi := foo.o
	foo-objs   := foo_bar1.o foo_bar2.o

	obj-$(CONFIG_FOO) += foo.o

	include $(TOPDIR)/Rules.make

	foo.o: $(foo-objs)
		$(LD) -r -o $@ $(foo-objs)

The patch ensures that for multi-part objects, which are listed in
list-multi, no automatic link rules is generated, so nothing changes
there. However, you now can remove the list-multi line and the link rule,

        foo-objs := foo_bar1.o foo_bar2.o

	obj-$(CONFIG_FOO) += foo.o

        include $(TOPDIR)/Rules.make

and everything will still work. Actually, there is one further advantage,
i.e. the link rule is subject to the usual flags handling now. That means
that we'll recognize when the command line changes and relink the
composite module, even if the individual parts were not touched.

There is also one minor drawback, due to make limitations: Even if only
one of the composite modules in a given directory needs to be rebuilt
(because e.g. one of its sources were touched), all the others get
relinked as well. That's not much of a problem, though, since linking is
really fast, as compared to compiling.

The patch shows the needed Rules.make adaption and demonstrates the
achievable cleanup in drivers/isdn/{,*/}Makefile. It works fine here.

--Kai

Index: linux_2_4/Rules.make
diff -u linux_2_4/Rules.make:1.1.1.4 linux_2_4/Rules.make:1.1.1.4.2.1
--- linux_2_4/Rules.make:1.1.1.4	Sat Apr 28 18:17:43 2001
+++ linux_2_4/Rules.make	Tue May  1 00:39:40 2001
@@ -118,6 +118,24 @@
 	) > $(dir $@)/.$(notdir $@).flags
 endif

+#
+# Rule to link composite objects
+#
+
+# for make >= 3.78 the following is cleaner:
+# multi-used := $(foreach m,$(obj-y) $(obj-m), $(if $($(basename $(m))-objs), $(m)))
+multi-used := $(sort $(foreach m,$(obj-y) $(obj-m),$(patsubst %,$(m),$($(basename $(m))-objs))))
+ld-multi-used := $(filter-out $(list-multi),$(multi-used))
+ld-multi-objs := $(foreach m, $(ld-multi-used), $($(basename $(m))-objs))
+
+$(ld-multi-used) : %.o: $(ld-multi-objs)
+	rm -f $@
+	$(LD) $(EXTRA_LDFLAGS) -r -o $@ $(filter $($(basename $@)-objs), $^)
+	@ ( \
+	    echo 'ifeq ($(strip $(subst $(comma),:,$(LD) $(EXTRA_LDFLAGS) $($(basename $@)-objs)),$$(strip $$(subst $$(comma),:,$$(LD) $$(EXTRA_LDFLAGS) $$($(basename $@)-objs)))))' ; \
+	    echo 'FILES_FLAGS_UP_TO_DATE += $@' ; \
+	    echo 'endif' \
+	) > $(dir $@)/.$(notdir $@).flags

 #
 # This make dependencies quickly
@@ -198,8 +216,7 @@
 #
 ifdef CONFIG_MODULES

-multi-used	:= $(filter $(list-multi), $(obj-y) $(obj-m))
-multi-objs	:= $(foreach m, $(multi-used), $($(basename $(m))-objs))
+multi-objs	:= $(foreach m, $(obj-y) $(obj-m), $($(basename $(m))-objs))
 active-objs	:= $(sort $(multi-objs) $(obj-y) $(obj-m))

 ifdef CONFIG_MODVERSIONS
Index: linux_2_4/drivers/isdn/Makefile
diff -u linux_2_4/drivers/isdn/Makefile:1.1.1.2 linux_2_4/drivers/isdn/Makefile:1.1.1.2.24.1
--- linux_2_4/drivers/isdn/Makefile:1.1.1.2	Tue Apr 24 00:50:53 2001
+++ linux_2_4/drivers/isdn/Makefile	Tue May  1 00:39:58 2001
@@ -10,7 +10,6 @@

 # Multipart objects.

-list-multi	:= isdn.o
 isdn-objs	:= isdn_net.o isdn_tty.o isdn_v110.o isdn_common.o

 # Optional parts of multipart objects.
@@ -49,8 +48,3 @@
 # The global Rules.make.

 include $(TOPDIR)/Rules.make
-
-# Link rules for multi-part drivers.
-
-isdn.o: $(isdn-objs)
-	$(LD) -r -o $@ $(isdn-objs)
Index: linux_2_4/drivers/isdn/act2000/Makefile
diff -u linux_2_4/drivers/isdn/act2000/Makefile:1.1.1.1 linux_2_4/drivers/isdn/act2000/Makefile:1.1.1.1.28.1
--- linux_2_4/drivers/isdn/act2000/Makefile:1.1.1.1	Tue Apr 24 00:13:53 2001
+++ linux_2_4/drivers/isdn/act2000/Makefile	Tue May  1 00:40:03 2001
@@ -6,7 +6,6 @@

 # Multipart objects.

-list-multi	:= act2000.o
 act2000-objs	:= module.o capi.o act2000_isa.o

 # Each configuration option enables a list of files.
@@ -14,8 +13,3 @@
 obj-$(CONFIG_ISDN_DRV_ACT2000)	+= act2000.o

 include $(TOPDIR)/Rules.make
-
-# Link rules for multi-part drivers.
-
-act2000.o: $(act2000-objs)
-	$(LD) -r -o $@ $(act2000-objs)
Index: linux_2_4/drivers/isdn/avmb1/Makefile
diff -u linux_2_4/drivers/isdn/avmb1/Makefile:1.1.1.1 linux_2_4/drivers/isdn/avmb1/Makefile:1.1.1.1.28.1
--- linux_2_4/drivers/isdn/avmb1/Makefile:1.1.1.1	Tue Apr 24 00:13:47 2001
+++ linux_2_4/drivers/isdn/avmb1/Makefile	Tue May  1 00:40:03 2001
@@ -10,7 +10,6 @@

 # Multipart objects.

-list-multi	:= kernelcapi.o
 kernelcapi-objs	:= kcapi.o

 # Ordering constraints: kernelcapi.o first
@@ -32,9 +31,3 @@
 # The global Rules.make.

 include $(TOPDIR)/Rules.make
-
-# Link rules for multi-part drivers.
-
-kernelcapi.o: $(kernelcapi-objs)
-	$(LD) -r -o $@ $(kernelcapi-objs)
-
Index: linux_2_4/drivers/isdn/divert/Makefile
diff -u linux_2_4/drivers/isdn/divert/Makefile:1.1.1.1 linux_2_4/drivers/isdn/divert/Makefile:1.1.1.1.28.1
--- linux_2_4/drivers/isdn/divert/Makefile:1.1.1.1	Tue Apr 24 00:13:52 2001
+++ linux_2_4/drivers/isdn/divert/Makefile	Tue May  1 00:40:03 2001
@@ -8,7 +8,6 @@

 # Multipart objects.

-list-multi		:= dss1_divert.o
 dss1_divert-objs	:= isdn_divert.o divert_procfs.o divert_init.o

 # Each configuration option enables a list of files.
@@ -16,12 +15,6 @@
 obj-$(CONFIG_ISDN_DIVERSION)	+= dss1_divert.o

 include $(TOPDIR)/Rules.make
-
-# Link rules for multi-part drivers.
-
-dss1_divert.o: $(dss1_divert-objs)
-	$(LD) -r -o $@ $(dss1_divert-objs)
-



Index: linux_2_4/drivers/isdn/eicon/Makefile
diff -u linux_2_4/drivers/isdn/eicon/Makefile:1.1.1.2 linux_2_4/drivers/isdn/eicon/Makefile:1.1.1.2.24.1
--- linux_2_4/drivers/isdn/eicon/Makefile:1.1.1.2	Tue Apr 24 00:50:57 2001
+++ linux_2_4/drivers/isdn/eicon/Makefile	Tue May  1 00:40:03 2001
@@ -10,7 +10,6 @@

 # Multipart objects.

-list-multi	:= eicon.o divas.o
 eicon-objs	:= eicon_mod.o eicon_isa.o eicon_pci.o eicon_idi.o \
 		   eicon_io.o
 divas-objs	:= common.o idi.o bri.o pri.o log.o xlog.o kprintf.o fpga.o \
@@ -30,13 +29,3 @@
 obj-$(CONFIG_ISDN_DRV_EICON_DIVAS)	+= divas.o

 include $(TOPDIR)/Rules.make
-
-# Link rules for multi-part drivers.
-
-eicon.o: $(eicon-objs)
-	$(LD) -r -o $@ $(eicon-objs)
-
-divas.o: $(divas-objs)
-	$(LD) -r -o $@ $(divas-objs)
-
-
Index: linux_2_4/drivers/isdn/hisax/Makefile
diff -u linux_2_4/drivers/isdn/hisax/Makefile:1.1.1.3 linux_2_4/drivers/isdn/hisax/Makefile:1.1.1.3.20.1
--- linux_2_4/drivers/isdn/hisax/Makefile:1.1.1.3	Tue Apr 24 01:34:02 2001
+++ linux_2_4/drivers/isdn/hisax/Makefile	Tue May  1 00:40:03 2001
@@ -10,7 +10,6 @@

 # Multipart objects.

-list-multi	:= hisax.o
 hisax-objs	:= config.o isdnl1.o tei.o isdnl2.o isdnl3.o \
 		   lmgr.o q931.o callc.o fsm.o cert.o

@@ -50,7 +49,7 @@
 hisax-objs-$(CONFIG_HISAX_W6692) += w6692.o
 #hisax-objs-$(CONFIG_HISAX_TESTEMU) += testemu.o

-hisax-objs += $(sort $(hisax-objs-y))
+hisax-objs += $(hisax-objs-y)

 # Each configuration option enables a list of files.

@@ -65,8 +64,3 @@
 CFLAGS_cert.o := -DCERTIFICATION=$(CERT)

 include $(TOPDIR)/Rules.make
-
-# Link rules for multi-part drivers.
-
-hisax.o: $(hisax-objs)
-	$(LD) -r -o $@ $(hisax-objs)
Index: linux_2_4/drivers/isdn/hysdn/Makefile
diff -u linux_2_4/drivers/isdn/hysdn/Makefile:1.1.1.1 linux_2_4/drivers/isdn/hysdn/Makefile:1.1.1.1.28.1
--- linux_2_4/drivers/isdn/hysdn/Makefile:1.1.1.1	Tue Apr 24 00:13:52 2001
+++ linux_2_4/drivers/isdn/hysdn/Makefile	Tue May  1 00:40:03 2001
@@ -6,7 +6,6 @@

 # Multipart objects.

-list-multi	:= hysdn.o
 hysdn-objs	:= hysdn_procconf.o hysdn_proclog.o boardergo.o hysdn_boot.o \
 		   hysdn_sched.o hysdn_net.o hysdn_init.o

@@ -21,9 +20,3 @@
 obj-$(CONFIG_HYSDN)	+= hysdn.o

 include $(TOPDIR)/Rules.make
-
-# Link rules for multi-part drivers.
-
-hysdn.o: $(hysdn-objs)
-	$(LD) -r -o $@ $(hysdn-objs)
-
Index: linux_2_4/drivers/isdn/icn/Makefile
diff -u linux_2_4/drivers/isdn/icn/Makefile:1.1.1.1 linux_2_4/drivers/isdn/icn/Makefile:1.1.1.1.28.1
--- linux_2_4/drivers/isdn/icn/Makefile:1.1.1.1	Tue Apr 24 00:13:47 2001
+++ linux_2_4/drivers/isdn/icn/Makefile	Tue May  1 00:40:03 2001
@@ -1,4 +1,4 @@
-# Makefile for the act2000 ISDN device driver
+# Makefile for the icn ISDN device driver

 # The target object and module list name.

Index: linux_2_4/drivers/isdn/pcbit/Makefile
diff -u linux_2_4/drivers/isdn/pcbit/Makefile:1.1.1.1 linux_2_4/drivers/isdn/pcbit/Makefile:1.1.1.1.28.1
--- linux_2_4/drivers/isdn/pcbit/Makefile:1.1.1.1	Tue Apr 24 00:13:52 2001
+++ linux_2_4/drivers/isdn/pcbit/Makefile	Tue May  1 00:40:03 2001
@@ -6,7 +6,6 @@

 # Multipart objects.

-list-multi	:= pcbit.o
 pcbit-objs	:= module.o edss1.o drv.o layer2.o capi.o callbacks.o

 # Each configuration option enables a list of files.
@@ -14,8 +13,3 @@
 obj-$(CONFIG_ISDN_DRV_PCBIT)	+= pcbit.o

 include $(TOPDIR)/Rules.make
-
-# Link rules for multi-part drivers.
-
-pcbit.o: $(pcbit-objs)
-	$(LD) -r -o $@ $(pcbit-objs)
Index: linux_2_4/drivers/isdn/sc/Makefile
diff -u linux_2_4/drivers/isdn/sc/Makefile:1.1.1.1 linux_2_4/drivers/isdn/sc/Makefile:1.1.1.1.28.1
--- linux_2_4/drivers/isdn/sc/Makefile:1.1.1.1	Tue Apr 24 00:13:47 2001
+++ linux_2_4/drivers/isdn/sc/Makefile	Tue May  1 00:40:03 2001
@@ -6,7 +6,6 @@

 # Multipart objects.

-list-multi	:= sc.o
 sc-objs		:= shmem.o init.o debug.o packet.o command.o event.o \
 		   ioctl.o interrupt.o message.o timer.o

@@ -15,8 +14,3 @@
 obj-$(CONFIG_ISDN_DRV_SC)	+= sc.o

 include $(TOPDIR)/Rules.make
-
-# Link rules for multi-part drivers.
-
-sc.o: $(sc-objs)
-	$(LD) -r -o $@ $(sc-objs)


