Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262574AbTJJIBP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 04:01:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262617AbTJJIBP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 04:01:15 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:45067 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262574AbTJJIBI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 04:01:08 -0400
Date: Fri, 10 Oct 2003 09:01:04 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Patrick Mochel <mochel@osdl.org>
Subject: Re: bug in init_i82365 wrt sysfs
Message-ID: <20031010090104.A23806@flint.arm.linux.org.uk>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Patrick Mochel <mochel@osdl.org>
References: <20031010035940.GA9668@conectiva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20031010035940.GA9668@conectiva.com.br>; from acme@conectiva.com.br on Fri, Oct 10, 2003 at 12:59:40AM -0300
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 10, 2003 at 12:59:40AM -0300, Arnaldo Carvalho de Melo wrote:
> Call Trace:
>  [<c01dbf4c>] class_device_create_file+0x1c/0x30
>  [<c2805188>] init_i82365+0xe8/0x1e8 [i82365]
>  [<c0139cff>] sys_init_module+0x15f/0x2f0
>  [<c0109897>] syscall_call+0x7/0xb

This oops has been caused by the need to register the class before
registering any objects against it.  Unfortunately, the class needs
to be registered asynchronously in a separate thread to avoid driver
model deadlock with yenta with cardbus cards inserted or standard
PCMCIA cards not being detected correctly due to a race.

I think the only real solution is to remove the class_device_create_file
calls from all socket drivers.  This is just a simple commenting out of
the calls, and should be suitable for the remainder of the -test kernels.

Due to the number of cases that we're encountering with PCMCIA, I'm
beginning to wonder if the driver model could be fixed to be more kind
to PCMCIA by avoiding some of these ordering dependencies.  None of this
would be a problem if the driver model would allow PCI device drivers to
register PCI devices while their probe or remove functions were executing.

Below is a completely untested patch.  Arnaldo - please test whether this
fixes your problem.

===== drivers/pcmcia/i82365.c 1.46 vs edited =====
--- 1.46/drivers/pcmcia/i82365.c	Sun Sep 28 00:04:09 2003
+++ edited/drivers/pcmcia/i82365.c	Fri Oct 10 08:59:26 2003
@@ -1211,6 +1211,7 @@
     return 0;
 } /* i365_set_mem_map */
 
+#if 0 /* driver model ordering issue */
 /*======================================================================
 
     Routines for accessing socket information and register dumps via
@@ -1250,6 +1251,7 @@
 
 static CLASS_DEVICE_ATTR(exca, S_IRUGO, show_exca, NULL);
 static CLASS_DEVICE_ATTR(info, S_IRUGO, show_info, NULL);
+#endif
 
 /*====================================================================*/
 
@@ -1414,10 +1416,12 @@
 			    pcmcia_unregister_socket(&socket[i].socket);
 		    break;
 	    }
+#if 0 /* driver model ordering issue */
 	   class_device_create_file(&socket[i].socket.dev,
 			   	    &class_device_attr_info);
 	   class_device_create_file(&socket[i].socket.dev,
 			   	    &class_device_attr_exca);
+#endif
     }
 
     /* Finally, schedule a polling interrupt */


-- 
Russell King (rmk@arm.linux.org.uk)	http://www.arm.linux.org.uk/personal/
      Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
      maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                      2.6 Serial core
