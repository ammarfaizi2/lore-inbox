Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262112AbVEYKYR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262112AbVEYKYR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 06:24:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262117AbVEYKYR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 06:24:17 -0400
Received: from proxy1.vsa.de ([62.180.233.78]:23073 "EHLO proxy1.vsa.de")
	by vger.kernel.org with ESMTP id S262112AbVEYKYI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 06:24:08 -0400
From: =?iso-8859-1?q?J=FCrgen=20G=FCnther?= <juergen.guenther@cse.de>
To: linux-kernel@vger.kernel.org
Subject: A possible BUG-FIX
Date: Wed, 25 May 2005 12:18:43 +0200
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200505251218.43035.juergen.guenther@cse.de>
X-OriginalArrivalTime: 25 May 2005 10:13:12.0783 (UTC) FILETIME=[5BD3A5F0:01C56112]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

at first - please excuse my bad english. Here is my ?bug report? and
a ?possible solution.?

[1.] One line summary of the problem:    
Risk of a froozen system loading stallion-module and no funktion

[2.] Full description of the problem/report:
I wanted to use a Stallion EC 8/64 PCI card. After loading the kernel-
module with "modprobe stallion" i tried to echo a text to one of the serial
devices ( echo "Hello World" >/dev/ttyE0 ). The tty is not opened and 
no characters are sent. (I am sure it is not a handshake problem) 

After doing that two, three or more times the complete system stalled.

[3.] Keywords (i.e., modules, networking, kernel):
[4.] Kernel version (from /proc/version):
2.6.10
2.6.11.9
both compiled as non-smp-kernels because of cli() / sti()

[5.] Output of Oops.. message (if applicable) with symbolic information 
     resolved (see Documentation/oops-tracing.txt)
none
[6.] A small shell script or example program which triggers the
     problem (if possible)

modprobe stallion
echo "Hello World" >/dev/ttyE0

[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)
[7.2.] Processor information (from /proc/cpuinfo):
I tested it at different Systems with different Pentium III/4 CPU's
[7.3.] Module information (from /proc/modules):
[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
[7.5.] PCI information ('lspci -vvv' as root)
[7.6.] SCSI information (from /proc/scsi/scsi)
[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):
[X.] Other notes, patches, fixes, workarounds:

This patch shows you how i tryed to fix this problem

diff -urN ./linux-2.6.11.9.org/kernel/irq/manage.c ./linux-2.6.11.9.new/
kernel/irq/manage.c
--- ./linux-2.6.11.9.org/kernel/irq/manage.c    2005-05-12 00:43:36.000000000 
+0200
+++ ./linux-2.6.11.9.new/kernel/irq/manage.c    2005-05-24 20:28:25.000000000 
+0200
@@ -320,8 +320,15 @@
         * which interrupt is which (messes up the interrupt freeing
         * logic etc).
         */
-       if ((irqflags & SA_SHIRQ) && !dev_id)
-               return -EINVAL;
+       //if ((irqflags & SA_SHIRQ) && !dev_id)
+       //      return -EINVAL;
+
+       if(irqflags & SA_SHIRQ) {
+               if(!dev_id)
+                 printk("Bad boy: %s called us without a dev_id !\n",
+                       devname);
+       }
+
        if (irq >= NR_IRQS)
                return -EINVAL;
        if (!handler)
----------------------------------------------------------------------------------------------------
Greetings from Bavaria

Jürgen

