Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129585AbQJ0Lvo>; Fri, 27 Oct 2000 07:51:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129734AbQJ0Lve>; Fri, 27 Oct 2000 07:51:34 -0400
Received: from isis.its.uow.edu.au ([130.130.68.21]:32414 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S129585AbQJ0LvT>; Fri, 27 Oct 2000 07:51:19 -0400
Message-ID: <39F96BE1.B9C97C20@uow.edu.au>
Date: Fri, 27 Oct 2000 22:49:53 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Patrick van de Lageweg <patrick@bitwizard.nl>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rogier Wolff <wolff@bitwizard.nl>,
        Philipp Rumpf <prumpf@parcelfarce.linux.theplanet.co.uk>
Subject: Re: [PROPOSED PATCH] ATM refcount + firestream
In-Reply-To: <Pine.LNX.4.21.0010270945510.13233-200000@panoramix.bitwizard.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick van de Lageweg wrote:
> 
> Hi all,
> 
> Here is the second try for the atm refcount problem. I've made made
> several enhancement over the previos patch. Can you take a look at it if
> I've missed anything? (This time it also includes the driver for the
> firestream card. That's why the patch is so large. It's gziped and
> uuencoded).

Patrick, I looked at the modules stuff and you do not
appear to be actually _using_ it anywhere:

bix:/home/morton> grep owner patch
+  owner:       THIS_MODULE,
+       owner:          THIS_MODULE
+       owner:          THIS_MODULE,
+       owner:        THIS_MODULE,
+  owner:       THIS_MODULE,
+       owner:          THIS_MODULE,
+   owner:      THIS_MODULE,
+       struct module *owner;
+       struct module *owner;
bix:/home/morton>


It looks like you'll need something like the following:
(warning: uncompiled ATM-ignoramus code)

Index: net/atm/common.c
===================================================================
RCS file: /opt/cvs/lk/net/atm/common.c,v
retrieving revision 1.3.2.1
diff -u -u -r1.3.2.1 common.c
--- net/atm/common.c	2000/07/08 06:26:43	1.3.2.1
+++ net/atm/common.c	2000/10/27 11:17:45
@@ -144,6 +144,8 @@
 			    "rx_inuse == %d after closing\n",
 			    atomic_read(&vcc->rx_inuse));
+		if (vcc->dev->ops->owner)
+			__MOD_DEC_USE_COUNT(vcc->dev->ops->owner);
 		bind_vcc(vcc,NULL);
 	}
 	if (free_sk) free_atm_vcc_sk(sk);
 }
@@ -199,13 +201,22 @@
 {
 	int error;
 
+	if (try_inc_mod_count(dev->ops->owner) == 0) {
+		return -ENODEV;
+	}
+
+	error = 0;
+
 	if ((vpi != ATM_VPI_UNSPEC && vpi != ATM_VPI_ANY &&
 	    vpi >> dev->ci_range.vpi_bits) || (vci != ATM_VCI_UNSPEC &&
-	    vci != ATM_VCI_ANY && vci >> dev->ci_range.vci_bits))
-		return -EINVAL;
-	if (vci > 0 && vci < ATM_NOT_RSV_VCI && !capable(CAP_NET_BIND_SERVICE))
-		return -EPERM;
-	error = 0;
+	    vci != ATM_VCI_ANY && vci >> dev->ci_range.vci_bits)) {
+		error = -EINVAL;
+		goto out;
+	}
+	if (vci > 0 && vci < ATM_NOT_RSV_VCI && !capable(CAP_NET_BIND_SERVICE)) {
+		error = -EPERM;
+		goto out;
+	}
 	bind_vcc(vcc,dev);
 	switch (vcc->qos.aal) {
 		case ATM_AAL0:
@@ -231,19 +242,26 @@
 	if (!error) error = adjust_tp(&vcc->qos.rxtp,vcc->qos.aal);
 	if (error) {
 		bind_vcc(vcc,NULL);
-		return error;
+		goto out;
 	}
 	DPRINTK("VCC %d.%d, AAL %d\n",vpi,vci,vcc->qos.aal);
 	DPRINTK("  TX: %d, PCR %d..%d, SDU %d\n",vcc->qos.txtp.traffic_class,
 	    vcc->qos.txtp.min_pcr,vcc->qos.txtp.max_pcr,vcc->qos.txtp.max_sdu);
 	DPRINTK("  RX: %d, PCR %d..%d, SDU %d\n",vcc->qos.rxtp.traffic_class,
 	    vcc->qos.rxtp.min_pcr,vcc->qos.rxtp.max_pcr,vcc->qos.rxtp.max_sdu);
+
 	if (dev->ops->open) {
 		error = dev->ops->open(vcc,vpi,vci);
 		if (error) {
 			bind_vcc(vcc,NULL);
-			return error;
+			goto out;
 		}
+	}
+
+out:
+	if (error) {
+		if (dev->ops->owner)
+			__MOD_DEC_USE_COUNT(dev->ops->owner);
 	}
 	return 0;
 }


Something similar will be need to be wrapped around the usage of
`struct atm_tcp_ops()' as well.  Let me know if you'd like me to
prototype a patch for that.

The other thing you need to watch out for is atmdev_ops.ioctl().
Can this be called when the device is not open?

In other words, can atmdev_ops.ioctl() be called prior to
atmdev_ops.open()?  In more other words, can ioctl() be
called after close()?

If so then the above patch is not sufficient - it only increments
the module use count on the open() path.

If this is the case then you're fairly severely screwed.  This is
because the atm_dev handling has the same design flaw as the
netdevice handling: the logical place to inc/dec the module
refcount is within atm_dev_[de]register().  But this doesn't
work because you can never _get_ to the deregister point
through sys_delete_module() to drop the refcount.

Like netdevices, ATM needs to be able to separate the act
of loading the module from the act of registering the driver.

netdevices manage to get away with it because of ANK's funky
dev_hold()/dev_put() refcounting.  It looks like ATM devices
aren't that lucky.

One workaround would be to refuse to allow the device to be
accessed at all if it isn't open.  This may be unacceptable.


Look, this modules stuff is really bad.  Phillip Rumpf proposed
a radical alternative a while back which I felt was not given
sufficient consideration.  The idea was to make sys_delete_module()
grab all the other CPUs and leave them spinning on a flag while
the unload was proceeding.  This was very similar to
arch/i386/kernel/apm.c:apm_power_off().

As far as I can recall, the only restriction was that you are
not allowed to call module functions when the module refcount
is zero if those functions can call schedule().

prumpf, please dig out that patch.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
