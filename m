Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316064AbSEJQrd>; Fri, 10 May 2002 12:47:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316065AbSEJQrc>; Fri, 10 May 2002 12:47:32 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:45744 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S316064AbSEJQrb>; Fri, 10 May 2002 12:47:31 -0400
Date: Fri, 10 May 2002 12:47:27 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
To: schwidefsky@de.ibm.com
Cc: linux-kernel@vger.kernel.org
Subject: Strange s390 code in 2.4.19-pre8
Message-ID: <20020510124727.A10127@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I reviewed the -pre8 briefly, and is seems that the vast
majority of s390/s390x changes are good, but I cannot discern
the intent of some of them. I would like Martin or Ulrich
to comment.

#1 - smp_call_function in a driver, trying to be ultra smart
or IBM's hardware is too broken and asymmetric?

+       iucv_debug(1, "entering");
+       if (smp_processor_id() == 0)
+               iucv_declare_buffer_cpu0(&b2f0_result);
+       else
+               smp_call_function(iucv_declare_buffer_cpu0, &b2f0_result, 0, 1);+       iucv_debug(1, "Address of EIB = %p", iucv_external_int_buffer);
+       if (b2f0_result == 0x0deadbeef)
+           b2f0_result = 0xaa;
+       iucv_debug(1, "exiting");
        return b2f0_result;

#2 - strange changes to net Makefile

--- linux.orig/drivers/s390/net/Makefile        Thu May  2 22:37:01 2002
+++ linux/drivers/s390/net/Makefile     Thu May  2 22:25:05 2002
@@ -9,8 +9,8 @@

 ctc-objs := ctcmain.o ctctty.o

-obj-y += iucv.o fsm.o
-obj-$(CONFIG_CTC) += ctc.o
+obj-$(CONFIG_IUCV) += iucv.o fsm.o
+obj-$(CONFIG_CTC) += ctc.o fsm.o
 obj-$(CONFIG_IUCV) += netiucv.o

 include $(TOPDIR)/Rules.make

I guarantee you that this blows up, unless CTC and IUCV are
built in. And why does it add wo CONFIG_IUCV lines? It is
legal, but unconventional.

#3 - config.in patch inconsistent or deadwood

--- linux.orig/arch/s390/config.in      Thu May  2 22:36:59 2002
+++ linux/arch/s390/config.in   Thu May  2 22:25:01 2002
@@ -37,6 +37,8 @@
 mainmenu_option next_comment
 comment 'General setup'
 bool 'Fast IRQ handling' CONFIG_FAST_IRQ
+bool 'Process warning machine checks' CONFIG_MACHCHK_WARNING
+bool 'Use chscs for Common I/O' CONFIG_CHSC
 bool 'Builtin IPL record support' CONFIG_IPL
 if [ "$CONFIG_IPL" = "y" ]; then
   choice 'IPL method generated into head.S' \

This is wonderful, but why did you merge it to Marcelo if the
rest of the code is missing?

And, while we are on topic, when are you guys going to merge
changes to the partitioning code?

-- Pete
