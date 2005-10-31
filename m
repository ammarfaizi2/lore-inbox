Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964900AbVJaX6F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964900AbVJaX6F (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 18:58:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964905AbVJaX6E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 18:58:04 -0500
Received: from smtp.osdl.org ([65.172.181.4]:34946 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964898AbVJaX6C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 18:58:02 -0500
Date: Mon, 31 Oct 2005 15:58:03 -0800
From: Andrew Morton <akpm@osdl.org>
To: matthieu castet <castet.matthieu@free.fr>
Cc: linux-usb-devel@lists.sourceforge.net, usbatm@lists.infradead.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH]  Eagle and ADI 930 usb adsl modem driver
Message-Id: <20051031155803.2e94069f.akpm@osdl.org>
In-Reply-To: <4363F9B5.6010907@free.fr>
References: <4363F9B5.6010907@free.fr>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

matthieu castet <castet.matthieu@free.fr> wrote:
>
> Hi,
> 
> attached is the driver for USB ADSL modems based on the ADI eagle
> chipset using the usb_atm infrastructure.
> 

Dunno much about USB drivers, but..

> +/*
> + * sometime hotplug don't have time to give the firmware the
> + * first time, retry it.
> + */
> +static int sleepy_request_firmware(const struct firmware **fw, 
> +		const char *name, struct device *dev)
> +{
> +	if (request_firmware(fw, name, dev) == 0)
> +		return 0;
> +	msleep(1000);
> +	return request_firmware(fw, name, dev);
> +}

egad.   Is there no better way?

> ...
> +static int request_cmvs(struct uea_softc *sc,
> +		 struct uea_cmvs **cmvs, const struct firmware **fw)
> +{
> +	int ret, size;
> +	u8 *data;
> +	char *file;
> +	char cmv_name[256] = FW_DIR;

That's rather a lot of stack.  Can this be made static, of kmalloced?

> +
> +	*cmvs = (struct uea_cmvs *)(data + 1);

That's a bit rude - asking the compiler to perform a structure copy from an
odd address.  memcpy() would be saner.


> ...
> +static int uea_kthread(void *data)
> +{
> +	struct uea_softc *sc = (struct uea_softc *)data;

Unneeded cast.

> ...
> +/**
> + * uea_read_proc : /proc information
> + */
> +static int uea_read_proc(char *page, 
> +		char **start, off_t off, int count, int *eof, void *data)

People get shouted at for adding /proc handlers.  Greg may have thoughts...


General: the patch adds tons of trailing whitespace.  I stripped that off
the patch I added to -mm.


Trivial fixups:


 drivers/usb/atm/ueagle-atm.c |   31 ++++++++++++++-----------------
 1 files changed, 14 insertions(+), 17 deletions(-)

diff -puN drivers/usb/atm/ueagle-atm.c~eagle-and-adi-930-usb-adsl-modem-driver-tidies drivers/usb/atm/ueagle-atm.c
--- 25/drivers/usb/atm/ueagle-atm.c~eagle-and-adi-930-usb-adsl-modem-driver-tidies	Mon Oct 31 15:56:36 2005
+++ 25-akpm/drivers/usb/atm/ueagle-atm.c	Mon Oct 31 15:56:36 2005
@@ -74,17 +74,17 @@ static int uea_read_proc(char *page, cha
 
 static struct usb_driver uea_driver;
 static struct proc_dir_entry *uea_procdir;
-DECLARE_MUTEX(uea_semaphore);
+static DECLARE_MUTEX(uea_semaphore);
 static const char *chip_name[] = {"ADI930", "Eagle I", "Eagle II", "Eagle III"};
 
 /*
  * User supplied debug level
  */
-static unsigned int debug = 0;
+static unsigned int debug;
 
-static int modem_index = 0;
-static int sync_wait[NB_MODEM] = {[0 ... (NB_MODEM - 1)] = 0 };
-static char *cmv_file[NB_MODEM] = {[0 ... (NB_MODEM - 1)] = NULL };
+static int modem_index;
+static int sync_wait[NB_MODEM];
+static char *cmv_file[NB_MODEM];
 
 module_param(debug, uint, 0644);
 MODULE_PARM_DESC(debug, "module debug level (0=off,1=on,2=verbose)");
@@ -314,15 +314,13 @@ static int uea_idma_write(struct uea_sof
 
 	memcpy(xfer_buff, data, size);
 
-	ret =
-	    usb_bulk_msg(sc->usb_dev,
+	ret = usb_bulk_msg(sc->usb_dev,
 			 usb_sndbulkpipe(sc->usb_dev, UEA_IDMA_PIPE),
 			 xfer_buff, size, &bytes_read, BULK_TIMEOUT);
 
 	kfree(xfer_buff);
-	if (ret < 0) {
+	if (ret < 0)
 		return ret;
-	}
 	if (size != bytes_read) {
 		uea_err(INS_TO_USBDEV(sc), "size != bytes_read %d %d\n", size,
 		       bytes_read);
@@ -873,7 +871,7 @@ out:
 
 static int uea_kthread(void *data)
 {
-	struct uea_softc *sc = (struct uea_softc *)data;
+	struct uea_softc *sc = data;
 	int ret = -EAGAIN;
 
 	uea_enters(INS_TO_USBDEV(sc));
@@ -1135,7 +1133,7 @@ static void uea_stop(struct uea_softc *s
 	/* stop any pending boot process */
 	flush_scheduled_work();
 
-     	uea_request(sc, UEA_SET_MODE, UEA_LOOPBACK_ON, 0, NULL);
+	uea_request(sc, UEA_SET_MODE, UEA_LOOPBACK_ON, 0, NULL);
 
 	usb_kill_urb(sc->urb_int);
 	kfree(sc->urb_int->transfer_buffer);
@@ -1146,7 +1144,6 @@ static void uea_stop(struct uea_softc *s
 	uea_leaves(INS_TO_USBDEV(sc));
 }
 
-
 /* syfs interface */
 static struct uea_softc *dev_to_uea(struct device *dev)
 {
@@ -1161,7 +1158,7 @@ static struct uea_softc *dev_to_uea(stru
 	if (!usbatm)
 		return NULL;
 
-	return (struct uea_softc *)usbatm->driver_data;
+	return usbatm->driver_data;
 }
 
 /* we need to use semaphore until sysfs and removable devices is fixed
@@ -1247,14 +1244,14 @@ static int uea_getesi(struct uea_softc *
 /* ATM stuff */
 static int uea_atm_open(struct usbatm_data *usbatm, struct atm_dev *atm_dev)
 {
-	struct uea_softc *sc = (struct uea_softc *)usbatm->driver_data;
+	struct uea_softc *sc = usbatm->driver_data;
 
 	return uea_getesi(sc, atm_dev->esi);
 }
 
 static int uea_heavy(struct usbatm_data *usbatm, struct usb_interface *intf)
 {
-	struct uea_softc *sc = (struct uea_softc *)usbatm->driver_data;
+	struct uea_softc *sc = usbatm->driver_data;
 
 	wait_event(sc->sync_q, IS_OPERATIONAL(sc));
 
@@ -1340,7 +1337,7 @@ static int uea_bind(struct usbatm_data *
 			return ret;
 	}
 
-	sc = kcalloc(1, sizeof(struct uea_softc), GFP_KERNEL);
+	sc = kzalloc(sizeof(struct uea_softc), GFP_KERNEL);
 	if (!sc) {
 		uea_err(INS_TO_USBDEV(sc), "uea_init: not enough memory !\n");
 		return -ENOMEM;
@@ -1382,7 +1379,7 @@ static void destroy_fs_entries(struct ue
 
 static void uea_unbind(struct usbatm_data *usbatm, struct usb_interface *intf)
 {
-	struct uea_softc *sc = (struct uea_softc *)usbatm->driver_data;
+	struct uea_softc *sc = usbatm->driver_data;
 
 	destroy_fs_entries(sc, intf);
 	uea_stop(sc);
_

