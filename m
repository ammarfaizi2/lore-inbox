Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267738AbTBUV0L>; Fri, 21 Feb 2003 16:26:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267741AbTBUV0L>; Fri, 21 Feb 2003 16:26:11 -0500
Received: from tolkor.SGI.COM ([198.149.18.6]:12177 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id <S267738AbTBUVZq>;
	Fri, 21 Feb 2003 16:25:46 -0500
Date: Fri, 21 Feb 2003 23:51:35 -0500
From: Christoph Hellwig <hch@sgi.com>
To: Christoph Hellwig <hch@sgi.com>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] try_module_get(THIS_MODULE) is bogus
Message-ID: <20030221235135.A24944@sgi.com>
Mail-Followup-To: Christoph Hellwig <hch@sgi.com>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
References: <20030221181843.A23315@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030221181843.A23315@sgi.com>; from hch@sgi.com on Fri, Feb 21, 2003 at 06:18:43PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2003 at 06:18:43PM -0500, Christoph Hellwig wrote:
> In most cases the fix is to add an struct module * member to the operations
> vector instead and manipulate the refcounts in the callers context.
> 
> For the ALSA cases it was completly superflous (when will people get it that
> using an exported symbol will make it's module unloadable?..)

This one had a use after free bug..  Fixed version below.


--- 1.2/drivers/char/ipmi/ipmi_kcs_intf.c	Tue Feb 18 19:31:36 2003
+++ edited/drivers/char/ipmi/ipmi_kcs_intf.c	Fri Feb 21 19:45:45 2003
@@ -613,18 +613,6 @@
 	atomic_set(&kcs_info->req_events, 1);
 }
 
-static int new_user(void *send_info)
-{
-	if (!try_module_get(THIS_MODULE))
-		return -EBUSY;
-	return 0;
-}
-
-static void user_left(void *send_info)
-{
-	module_put(THIS_MODULE);
-}
-
 /* Call every 10 ms. */
 #define KCS_TIMEOUT_TIME_USEC	10000
 #define KCS_USEC_PER_JIFFY	(1000000/HZ)
@@ -718,11 +706,10 @@
 
 static struct ipmi_smi_handlers handlers =
 {
-	sender:		       sender,
-	request_events:        request_events,
-	new_user:	       new_user,
-	user_left:	       user_left,
-	set_run_to_completion: set_run_to_completion
+	.owner			= THIS_MODULE,
+	.sender			= sender,
+	.request_events		= request_events,
+	.set_run_to_completion	= set_run_to_completion,
 };
 
 static unsigned char ipmi_kcs_dev_rev;
===== drivers/char/ipmi/ipmi_msghandler.c 1.1 vs edited =====
--- 1.1/drivers/char/ipmi/ipmi_msghandler.c	Mon Jan 13 13:07:12 2003
+++ edited/drivers/char/ipmi/ipmi_msghandler.c	Fri Feb 21 19:45:45 2003
@@ -485,13 +485,14 @@
 	new_user->intf = ipmi_interfaces[if_num];
 	new_user->gets_events = 0;
 
-	rv = new_user->intf->handlers->new_user(new_user->intf->send_info);
-	if (rv)
+	if (!try_module_get(new_user->intf->handlers->owner)) {
+		rv = -ENODEV;
 		goto out_unlock;
+	}
 
-	write_lock_irqsave(&(new_user->intf->users_lock), flags);
-	list_add_tail(&(new_user->link), &(new_user->intf->users));
-	write_unlock_irqrestore(&(new_user->intf->users_lock), flags);
+	write_lock_irqsave(&new_user->intf->users_lock, flags);
+	list_add_tail(&new_user->link, &new_user->intf->users);
+	write_unlock_irqrestore(&new_user->intf->users_lock, flags);
 
  out_unlock:	
 	if (rv) {
@@ -563,12 +564,12 @@
 	unsigned long flags;
 
 	down_read(&interfaces_sem);
-	write_lock_irqsave(&(intf->users_lock), flags);
+	write_lock_irqsave(&intf->users_lock, flags);
 	rv = ipmi_destroy_user_nolock(user);
 	if (!rv)
-		intf->handlers->user_left(intf->send_info);
+		module_put(intf->handlers->owner);
 		
-	write_unlock_irqrestore(&(intf->users_lock), flags);
+	write_unlock_irqrestore(&intf->users_lock, flags);
 	up_read(&interfaces_sem);
 	return rv;
 }
===== drivers/ieee1394/hosts.c 1.13 vs edited =====
--- 1.13/drivers/ieee1394/hosts.c	Sat Feb  1 17:43:09 2003
+++ edited/drivers/ieee1394/hosts.c	Fri Feb 21 19:45:45 2003
@@ -11,6 +11,7 @@
  */
 
 #include <linux/config.h>
+#include <linux/module.h>
 #include <linux/types.h>
 #include <linux/list.h>
 #include <linux/init.h>
@@ -69,8 +70,10 @@
         spin_lock_irqsave(&hosts_lock, flags);
         list_for_each(lh, &hosts) {
                 if (host == list_entry(lh, struct hpsb_host, host_list)) {
-			if (host->driver->devctl(host, MODIFY_USAGE, 1)) {
-				host->driver->devctl(host, MODIFY_USAGE, 1);
+			if (try_module_get(host->driver->owner)) {
+				/* we're doing this twice and don't seem
+				   to undo it..  --hch */
+				(void)try_module_get(host->driver->owner);
 				host->refcount++;
 				retval = 1;
 			}
@@ -95,7 +98,7 @@
 {
         unsigned long flags;
 
-        host->driver->devctl(host, MODIFY_USAGE, 0);
+	module_put(host->driver->owner);
 
         spin_lock_irqsave(&hosts_lock, flags);
         host->refcount--;
===== drivers/ieee1394/hosts.h 1.11 vs edited =====
--- 1.11/drivers/ieee1394/hosts.h	Fri Jan 31 01:48:22 2003
+++ edited/drivers/ieee1394/hosts.h	Fri Feb 21 19:45:45 2003
@@ -92,12 +92,6 @@
          * Return void. */
         CANCEL_REQUESTS,
 
-        /* Decrease host usage count if arg == 0, increase otherwise.  Return
-         * 1 for success, 0 for failure.  Increase usage may fail if the driver
-         * is in the process of shutting itself down.  Decrease usage can not
-         * fail. */
-        MODIFY_USAGE,
-
         /* Start or stop receiving isochronous channel in arg.  Return void.
          * This acts as an optimization hint, hosts are not required not to
          * listen on unrequested channels. */
@@ -147,6 +141,7 @@
 };
 
 struct hpsb_host_driver {
+	struct module *owner;
 	const char *name;
 
         /* This function must store a pointer to the configuration ROM into the
===== drivers/ieee1394/ohci1394.c 1.19 vs edited =====
--- 1.19/drivers/ieee1394/ohci1394.c	Sun Feb  2 08:01:36 2003
+++ edited/drivers/ieee1394/ohci1394.c	Fri Feb 21 19:45:45 2003
@@ -966,16 +966,6 @@
 		dma_trm_reset(&ohci->at_resp_context);
 		break;
 
-	case MODIFY_USAGE:
-		if (arg) {
-			if (try_module_get(THIS_MODULE))
-				retval = 1;
-		} else {
-			module_put(THIS_MODULE);
-			retval = 1;
-		}
-                break;
-
 	case ISO_LISTEN_CHANNEL:
         {
 		u64 mask;
@@ -3202,6 +3192,7 @@
 }
 
 static struct hpsb_host_driver ohci1394_driver = {
+	.owner =		THIS_MODULE,
 	.name =			OHCI1394_DRIVER_NAME,
 	.get_rom =		ohci_get_rom,
 	.transmit_packet =	ohci_transmit,
===== drivers/ieee1394/pcilynx.c 1.24 vs edited =====
--- 1.24/drivers/ieee1394/pcilynx.c	Tue Feb 11 00:00:08 2003
+++ edited/drivers/ieee1394/pcilynx.c	Fri Feb 21 19:45:45 2003
@@ -801,17 +801,6 @@
 
                 break;
 
-        case MODIFY_USAGE:
-		if (arg) {
-			if (try_module_get(THIS_MODULE))
-				retval = 1;
-		} else {
-			module_put(THIS_MODULE);
-			retval = 1;
-		}
-
-                break;
-
         case ISO_LISTEN_CHANNEL:
                 spin_lock_irqsave(&lynx->iso_rcv.lock, flags);
                 
@@ -1904,6 +1893,7 @@
 };
 
 static struct hpsb_host_driver lynx_driver = {
+	.owner =	   THIS_MODULE,
 	.name =		   PCILYNX_DRIVER_NAME,
         .get_rom =         get_lynx_rom,
         .transmit_packet = lynx_transmit,
===== drivers/pci/hotplug.c 1.10 vs edited =====
--- 1.10/drivers/pci/hotplug.c	Thu Feb  6 10:58:43 2003
+++ edited/drivers/pci/hotplug.c	Fri Feb 21 19:43:17 2003
@@ -173,44 +173,6 @@
 EXPORT_SYMBOL(pci_visit_dev);
 
 /**
- * pci_is_dev_in_use - query devices' usage
- * @dev: PCI device to query
- *
- * Queries whether a given PCI device is in use by a driver or not.
- * Returns 1 if the device is in use, 0 if it is not.
- */
-int pci_is_dev_in_use(struct pci_dev *dev)
-{
-	/* 
-	 * dev->driver will be set if the device is in use by a new-style 
-	 * driver -- otherwise, check the device's regions to see if any
-	 * driver has claimed them.
-	 */
-
-	int i;
-	int inuse = 0;
-
-	if (dev->driver) {
-		/* Assume driver feels responsible */
-		return 1;
-	}
-
-	for (i = 0; !dev->driver && !inuse && (i < 6); i++) {
-		if (!pci_resource_start(dev, i))
-			continue;
-		if (pci_resource_flags(dev, i) & IORESOURCE_IO) {
-			inuse = check_region(pci_resource_start(dev, i),
-					     pci_resource_len(dev, i));
-		} else if (pci_resource_flags(dev, i) & IORESOURCE_MEM) {
-			inuse = check_mem_region(pci_resource_start(dev, i),
-						 pci_resource_len(dev, i));
-		}
-	}
-	return inuse;
-}
-EXPORT_SYMBOL(pci_is_dev_in_use);
-
-/**
  * pci_remove_device_safe - remove an unused hotplug device
  * @dev: the device to remove
  *
@@ -221,9 +183,8 @@
  */
 int pci_remove_device_safe(struct pci_dev *dev)
 {
-	if (pci_is_dev_in_use(dev)) {
+	if (pci_dev_driver(dev))
 		return -EBUSY;
-	}
 	pci_remove_device(dev);
 	return 0;
 }
===== include/linux/ipmi_smi.h 1.1 vs edited =====
--- 1.1/include/linux/ipmi_smi.h	Tue Nov 26 23:06:25 2002
+++ edited/include/linux/ipmi_smi.h	Fri Feb 21 19:45:47 2003
@@ -78,6 +78,8 @@
 
 struct ipmi_smi_handlers
 {
+	struct module *owner;
+
 	/* Called to enqueue an SMI message to be sent.  This
 	   operation is not allowed to fail.  If an error occurs, it
 	   should report back the error in a received message.  It may
@@ -92,15 +94,6 @@
 	/* Called by the upper layer to request that we try to get
 	   events from the BMC we are attached to. */
 	void (*request_events)(void *send_info);
-
-	/* Called when someone is using the interface, so the module can
-	   adjust it's use count.  Return zero if successful, or an
-	   errno if not. */
-	int (*new_user)(void *send_info);
-
-	/* Called when someone is no longer using the interface, so the
-	   module can adjust it's use count. */
-	void (*user_left)(void *send_info);
 
 	/* Called when the interface should go into "run to
 	   completion" mode.  If this call sets the value to true, the
===== include/linux/sunrpc/auth.h 1.7 vs edited =====
--- 1.7/include/linux/sunrpc/auth.h	Sun Jan 12 22:40:31 2003
+++ edited/include/linux/sunrpc/auth.h	Fri Feb 21 19:45:47 2003
@@ -84,6 +84,7 @@
  * Client authentication ops
  */
 struct rpc_authops {
+	struct module		*owner;
 	rpc_authflavor_t	au_flavor;	/* flavor (RPC_AUTH_*) */
 #ifdef RPC_DEBUG
 	char *			au_name;
+++ edited/net/sunrpc/auth.c	Fri Feb 21 22:12:30 2003
@@ -8,6 +8,7 @@
 
 #include <linux/types.h>
 #include <linux/sched.h>
+#include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/errno.h>
 #include <linux/socket.h>
@@ -65,6 +66,8 @@
 
 	if (flavor >= RPC_AUTH_MAXFLAVOR || !(ops = auth_flavors[flavor]))
 		return NULL;
+	if (!try_module_get(ops->owner))
+		return NULL;
 	clnt->cl_auth = ops->create(clnt, pseudoflavor);
 	return clnt->cl_auth;
 }
@@ -73,6 +76,8 @@
 rpcauth_destroy(struct rpc_auth *auth)
 {
 	auth->au_ops->destroy(auth);
+	module_put(auth->au_ops->owner);
+	kfree(auth);
 }
 
 static spinlock_t rpc_credcache_lock = SPIN_LOCK_UNLOCKED;
===== net/sunrpc/auth_null.c 1.9 vs edited =====
--- 1.9/net/sunrpc/auth_null.c	Sun Jan 12 22:40:13 2003
+++ edited/net/sunrpc/auth_null.c	Fri Feb 21 22:12:51 2003
@@ -8,6 +8,7 @@
 
 #include <linux/types.h>
 #include <linux/socket.h>
+#include <linux/module.h>
 #include <linux/in.h>
 #include <linux/utsname.h>
 #include <linux/sunrpc/clnt.h>
@@ -41,7 +42,6 @@
 {
 	dprintk("RPC: destroying NULL authenticator %p\n", auth);
 	rpcauth_free_credcache(auth);
-	kfree(auth);
 }
 
 /*
@@ -125,6 +125,7 @@
 }
 
 struct rpc_authops	authnull_ops = {
+	.owner		= THIS_MODULE,
 	.au_flavor	= RPC_AUTH_NULL,
 #ifdef RPC_DEBUG
 	.au_name	= "NULL",
===== net/sunrpc/auth_unix.c 1.9 vs edited =====
--- 1.9/net/sunrpc/auth_unix.c	Sun Jan 12 22:40:13 2003
+++ edited/net/sunrpc/auth_unix.c	Fri Feb 21 22:12:35 2003
@@ -8,6 +8,7 @@
 
 #include <linux/types.h>
 #include <linux/sched.h>
+#include <linux/module.h>
 #include <linux/socket.h>
 #include <linux/in.h>
 #include <linux/sunrpc/clnt.h>
@@ -60,7 +61,6 @@
 {
 	dprintk("RPC: destroying UNIX authenticator %p\n", auth);
 	rpcauth_free_credcache(auth);
-	kfree(auth);
 }
 
 static struct rpc_cred *
@@ -219,6 +219,7 @@
 }
 
 struct rpc_authops	authunix_ops = {
+	.owner		= THIS_MODULE,
 	.au_flavor	= RPC_AUTH_UNIX,
 #ifdef RPC_DEBUG
 	.au_name	= "UNIX",
===== net/sunrpc/auth_gss/auth_gss.c 1.2 vs edited =====
--- 1.2/net/sunrpc/auth_gss/auth_gss.c	Sun Jan 12 22:40:31 2003
+++ edited/net/sunrpc/auth_gss/auth_gss.c	Fri Feb 21 22:13:20 2003
@@ -438,8 +438,6 @@
 	struct rpc_auth * auth;
 
 	dprintk("RPC: creating GSS authenticator for client %p\n",clnt);
-	if (!try_module_get(THIS_MODULE))
-		return NULL;
 	if (!(gss_auth = kmalloc(sizeof(*gss_auth), GFP_KERNEL)))
 		goto out_dec;
 	gss_auth->mech = gss_pseudoflavor_to_mech(flavor);
@@ -470,7 +468,6 @@
 err_free:
 	kfree(gss_auth);
 out_dec:
-	module_put(THIS_MODULE);
 	return NULL;
 }
 
@@ -485,9 +482,6 @@
 	rpc_unlink(gss_auth->path);
 
 	rpcauth_free_credcache(auth);
-
-	kfree(auth);
-	module_put(THIS_MODULE);
 }
 
 /* gss_destroy_cred (and gss_destroy_ctx) are used to clean up after failure
@@ -691,6 +685,7 @@
 }
 
 static struct rpc_authops authgss_ops = {
+	.owner		= THIS_MODULE,
 	.au_flavor	= RPC_AUTH_GSS,
 #ifdef RPC_DEBUG
 	.au_name	= "RPCSEC_GSS",
===== sound/pci/rme9652/hammerfall_mem.c 1.11 vs edited =====
--- 1.11/sound/pci/rme9652/hammerfall_mem.c	Mon Jan 27 18:30:54 2003
+++ edited/sound/pci/rme9652/hammerfall_mem.c	Fri Feb 21 19:45:47 2003
@@ -150,8 +150,6 @@
 	for (i = 0; i < NBUFS; i++) {
 		rbuf = &hammerfall_buffers[i];
 		if (rbuf->flags == HAMMERFALL_BUF_ALLOCATED) {
-			if (! try_module_get(THIS_MODULE))
-				return NULL;
 			rbuf->flags |= HAMMERFALL_BUF_USED;
 			rbuf->pci = pcidev;
 			*dmaaddr = rbuf->addr;
@@ -171,7 +169,6 @@
 		rbuf = &hammerfall_buffers[i];
 		if (rbuf->buf == addr && rbuf->pci == pcidev) {
 			rbuf->flags &= ~HAMMERFALL_BUF_USED;
-			module_put(THIS_MODULE);
 			return;
 		}
 	}
