Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129492AbQKUEsL>; Mon, 20 Nov 2000 23:48:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129516AbQKUEsB>; Mon, 20 Nov 2000 23:48:01 -0500
Received: from gear.torque.net ([204.138.244.1]:30728 "EHLO gear.torque.net")
	by vger.kernel.org with ESMTP id <S129492AbQKUErx>;
	Mon, 20 Nov 2000 23:47:53 -0500
Message-ID: <3A19F445.E529568D@torque.net>
Date: Mon, 20 Nov 2000 23:04:21 -0500
From: Douglas Gilbert <dougg@torque.net>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.4.0-test11 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: John Cavan <johncavan@home.com>, twaugh@redhat.com
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] (new for ppa and imm) Re: [PATCH] Re: Patch to fix lockup on
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 	
Content-Type: multipart/mixed;
 boundary="------------4B08707380476D0EA895C09B"

This is a multi-part message in MIME format.
--------------4B08707380476D0EA895C09B
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

John Cavan wrote:
> Tim Waugh wrote:
> > 
> > On Thu, Nov 16, 2000 at 09:50:40PM -0500, John Cavan wrote:
> > 
> > > [...] This patch unlocks, allows the lowlevel driver to do it's
> > > probes, and then relocks. It could probably be more granular in the
> > > parport_pc code, but my own home tests show it to be working fine.
> > 
> > Is that safe?

Safer than an oops/lockup :-)

> I'm not sure. I know why it causes the NMI lockup, but I'm not enough of
> an expert to sort it out. I've got a pretty good feel for the Zip
> driver, but not the parport or scsi code yet, so I don't know how safe
> it is. The new scsi error stuff does mention that drivers must
> spinunlock/spinlock if it enables interrupts.
>
> > Also, what bit of the parport code is tripping over the lock?
> > Request_module or something?
> 
> During the init phase of the parport_pc module it probes and enables the
> IRQ(s) of the parallel port, but the scsi layer has them locked.

John and Tim,
At least using imm on my SMP machine (BP6 dual celery)
I found that I had to go a bit further than John's patch.
Basically I have unlocked the whole of imm_detect().
It was necessary to unblock parport_enumerate()
but not sufficient.

Please see attachment. I don't have a ppa device to test.
Eric Y. makes some comments just before the (*detect())
call in scsi.c relating to low level driver detect routines.

Doug Gilbert
--------------4B08707380476D0EA895C09B
Content-Type: text/plain; charset=us-ascii;
 name="imm.cx2_diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="imm.cx2_diff"

--- linux/drivers/scsi/imm.c	Mon Nov 20 16:36:19 2000
+++ linux/drivers/scsi/imm.cx2	Mon Nov 20 22:46:10 2000
@@ -122,14 +122,17 @@
     struct Scsi_Host *hreg;
     int ports;
     int i, nhosts, try_again;
-    struct parport *pb = parport_enumerate();
+    struct parport *pb;
 
     printk("imm: Version %s\n", IMM_VERSION);
+    spin_unlock_irq(&io_request_lock);
+    pb = parport_enumerate();
     nhosts = 0;
     try_again = 0;
 
     if (!pb) {
 	printk("imm: parport reports no devices.\n");
+        spin_lock_irq(&io_request_lock);
 	return 0;
     }
   retry_entry:
@@ -154,6 +157,7 @@
 		    printk(KERN_ERR "imm%d: failed to claim parport because a "
 		      "pardevice is owning the port for too longtime!\n",
 			   i);
+                    spin_lock_irq(&io_request_lock);
 		    return 0;
 		}
 	    }
@@ -208,12 +212,16 @@
 	nhosts++;
     }
     if (nhosts == 0) {
-	if (try_again == 1)
+	if (try_again == 1) {
+            spin_lock_irq(&io_request_lock);
 	    return 0;
+	}
 	try_again = 1;
 	goto retry_entry;
-    } else
+    } else {
+        spin_lock_irq(&io_request_lock);
 	return 1;		/* return number of hosts detected */
+    }
 }
 
 /* This is to give the imm driver a way to modify the timings (and other

--------------4B08707380476D0EA895C09B--


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
