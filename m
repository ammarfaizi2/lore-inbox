Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293082AbSCJQR5>; Sun, 10 Mar 2002 11:17:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293083AbSCJQRs>; Sun, 10 Mar 2002 11:17:48 -0500
Received: from mx0.gmx.de ([213.165.64.100]:49345 "HELO mx0.gmx.net")
	by vger.kernel.org with SMTP id <S293082AbSCJQRe>;
	Sun, 10 Mar 2002 11:17:34 -0500
Date: Sun, 10 Mar 2002 17:17:27 +0100 (MET)
From: Kai Engert <kai.engert@gmx.de>
To: Jochen Friedrich <jochen@scram.de>
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
MIME-Version: 1.0
In-Reply-To: <Pine.LNX.4.43.0203100949470.14532-100000@alpha.bocc.de>
Subject: Re: [patch] Missing module for ISDN / AVM PCMCIA card
X-Priority: 3 (Normal)
X-Authenticated-Sender: #0002126097@gmx.net
X-Authenticated-IP: [212.172.10.91]
Message-ID: <9391.1015777047@www3.gmx.net>
X-Mailer: WWW-Mail 1.5 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jochen,

> > (Please note that Red Hat seems to have modified that patch a little,
> the
> > file included in their kernel 2.4.9-31 has 3 lines changed.
> 
> This might be the bug fix Kai Germaschewski added to my patch:

ok, let me clear the mystery.

Your patch:
  http://uwsg.iu.edu/hypermail/linux/kernel/0103.1/att-0957/01-avmdiff

Kai Germaschewski changed:
  -MODULE_PARM(isdnprot, "1-4");

  +MODULE_PARM(isdnprot, "1-4i");


RedHat did not include Kai's fix, but changed:
---[snip]--------

--- /usr/src/linux/drivers/isdn/pcmcia/avma1_cs.c	Sun Mar 10 01:50:58 2002
+++
/home/inst/up2date/t/usr/src/linux-2.4.9-31/drivers/isdn/hisax/avma1_cs.c	Sun Mar 10 01:18:09 2002
@@ -7,10 +7,12 @@
 ======================================================================*/
 
 #include <linux/module.h>
+
+
 #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <linux/ptrace.h>
-#include <linux/malloc.h>
+#include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/timer.h>
 #include <asm/io.h>
@@ -349,16 +351,16 @@
 		link->conf.ConfigIndex = cf->index;
 		link->io.BasePort1 = cf->io.win[0].base;
 		link->io.NumPorts1 = cf->io.win[0].len;
-		link->io.BasePort2 = 0;
 		link->io.NumPorts2 = 0;
                 printk(KERN_INFO "avma1_cs: testing i/o %#x-%#x\n",
 			link->io.BasePort1,
-		        link->io.BasePort1+link->io.NumPorts1);
+		        link->io.BasePort1+link->io.NumPorts1 - 1);
 		i = CardServices(RequestIO, link->handle, &link->io);
 		if (i == CS_SUCCESS) goto found_port;
 	    }
 	    i = next_tuple(handle, &tuple, &parse);
 	}
+
 found_port:
 	if (i != CS_SUCCESS) {
 	    cs_error(link->handle, RequestIO, i);
@@ -487,7 +489,7 @@
     case CS_EVENT_CARD_REMOVAL:
 	link->state &= ~DEV_PRESENT;
 	if (link->state & DEV_CONFIG) {
-	    link->release.expires = (jiffies+(HZ/20));
+	    link->release.expires =  jiffies + HZ/20;
 	    add_timer(&link->release);
 	}
 	break;
@@ -539,3 +541,5 @@
 	avma1cs_detach(dev_list);
     }
 }
+
+MODULE_LICENSE("GPL");

---[snip]--------

Thanks,
Kai

