Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267374AbTAMDGe>; Sun, 12 Jan 2003 22:06:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267509AbTAMDGe>; Sun, 12 Jan 2003 22:06:34 -0500
Received: from pacific.moreton.com.au ([203.143.238.4]:25614 "EHLO
	dorfl.internal.moreton.com.au") by vger.kernel.org with ESMTP
	id <S267374AbTAMDGb>; Sun, 12 Jan 2003 22:06:31 -0500
Message-ID: <3E222E99.2040206@snapgear.com>
Date: Mon, 13 Jan 2003 13:12:25 +1000
From: Greg Ungerer <gerg@snapgear.com>
Organization: SnapGear
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021126
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: Miles Bader <miles@gnu.org>, linux-kernel@vger.kernel.org,
       David McCullough <davidm@snapgear.com>, torvalds@transmeta.com
Subject: Re: exception tables in 2.5.55
References: <20030110091012.290C02C3CE@lists.samba.org>
In-Reply-To: <20030110091012.290C02C3CE@lists.samba.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Rusty Russell wrote:
> You can now make kernel/extable.o depend on this configuration option
> (whatever you decide it should be).
> 
> And surround kernel/module.c's search_module_extables with the same
> option.
> 
> It's trivial, just CC: me when you send to Linus, and I'll re-xmit if
> he drops it.

Heres a patch for it. Pretty strait forward, if everyone is
happy with this I will run with it...

Tested and working on m68knommu architecture.

Regards
Greg




diff -Naur linux-2.5.56/kernel/Makefile linux-2.5.56-uc0/kernel/Makefile
--- linux-2.5.56/kernel/Makefile	Sat Jan 11 06:11:36 2003
+++ linux-2.5.56-uc0/kernel/Makefile	Mon Jan 13 13:03:45 2003
@@ -10,7 +10,7 @@
  	    exit.o itimer.o time.o softirq.o resource.o \
  	    sysctl.o capability.o ptrace.o timer.o user.o \
  	    signal.o sys.o kmod.o workqueue.o futex.o pid.o \
-	    rcupdate.o intermodule.o extable.o params.o
+	    rcupdate.o intermodule.o params.o

  obj-$(CONFIG_GENERIC_ISA_DMA) += dma.o
  obj-$(CONFIG_SMP) += cpu.o
@@ -22,6 +22,7 @@
  obj-$(CONFIG_BSD_PROCESS_ACCT) += acct.o
  obj-$(CONFIG_SOFTWARE_SUSPEND) += suspend.o
  obj-$(CONFIG_COMPAT) += compat.o
+obj-$(CONFIG_MMU) += extable.o

  ifneq ($(CONFIG_IA64),y)
  # According to Alan Modra <alan@linuxcare.com.au>, the 
-fno-omit-frame-pointer is
diff -Naur linux-2.5.56/kernel/module.c linux-2.5.56-uc0/kernel/module.c
--- linux-2.5.56/kernel/module.c	Sat Jan 11 06:12:11 2003
+++ linux-2.5.56-uc0/kernel/module.c	Mon Jan 13 13:06:00 2003
@@ -1438,6 +1438,7 @@
  	.show	= m_show
  };

+#ifdef CONFIG_MMU
  /* Given an address, look for it in the module exception tables. */
  const struct exception_table_entry *search_module_extables(unsigned 
long addr)
  {
@@ -1460,6 +1461,7 @@
             we cannot unload the module, hence no refcnt needed. */
  	return e;
  }
+#endif /* CONFIG_MMU */

  /* Is this a valid kernel address?  We don't grab the lock: we are 
oopsing. */
  int module_text_address(unsigned long addr)


------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Wizard        EMAIL:  gerg@snapgear.com
SnapGear Pty Ltd                               PHONE:    +61 7 3435 2888
825 Stanley St,                                  FAX:    +61 7 3891 3630
Woolloongabba, QLD, 4102, Australia              WEB:   www.SnapGear.com

