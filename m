Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261368AbVEBIAx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261368AbVEBIAx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 04:00:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261632AbVEBIAw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 04:00:52 -0400
Received: from mx6.mail.ru ([194.67.23.26]:12135 "EHLO mx6.mail.ru")
	by vger.kernel.org with ESMTP id S261368AbVEBIAO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 04:00:14 -0400
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [linux-usb-devel] init 1 kill khubd on 2.6.11
Date: Mon, 2 May 2005 12:00:02 +0400
User-Agent: KMail/1.8
Cc: Alan Stern <stern@rowland.harvard.edu>,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <200505012021.56649.arvidjaar@mail.ru> <Pine.LNX.4.44L0.0505011659130.19155-100000@netrider.rowland.org> <20050501153051.2471294e.akpm@osdl.org>
In-Reply-To: <20050501153051.2471294e.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart8859111.kpadkqcOsW";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200505021200.10313.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart8859111.kpadkqcOsW
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 02 May 2005 02:30, Andrew Morton wrote:
> Alan Stern <stern@rowland.harvard.edu> wrote:
> > On Sun, 1 May 2005, Andrey Borzenkov wrote:
> > > Hub driver is using SIGKILL to terminate khubd. Unfortunately on a
> > > number of distributions switching init levels implicitly does "killall
> > > -9", killing khubd. The only way to restart it is to reload USB
> > > subsystem.
> > >
> > > Is signal usage in this case really needed? What about replacing it
> > > with simple flag (i.e. will patch be accepted)?
> >
> > IMO the problem lies in those distributions.  They should not
> > indiscrimately kill processes when switching init levels.
>
> Nevertheless it's better that kernel internals not be exposed to userspace
> actions in this manner, and using signals for in-kernel IPC is crufty, IM=
O.
>
> It's pretty simple to convert khubd to use the kthread API.  Something li=
ke
> this (untested):
>


Something strange is going on with this patch.

insmod usbcore; insmod uhci-hcd works as expected, finds out all devices,=20
triggers hotplug etc. But

{pts/2}% sudo insmod ./usbcore.ko
{pts/2}% sudo mount -t usbfs -o devmode=3D0664,devgid=3D43 none /proc/bus/u=
sb
{pts/2}% sudo modprobe usb-interface

results in

usbcore: registered new driver usbfs
usbcore: registered new driver hub
USB Universal Host Controller Interface driver v2.2
ACPI: PCI interrupt 0000:00:1f.2[D] -> GSI 5 (level, low) -> IRQ 5
uhci_hcd 0000:00:1f.2: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1f.2 to 64
uhci_hcd 0000:00:1f.2: irq 5, io base 0xa400
uhci_hcd 0000:00:1f.2: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:1f.4[C] -> GSI 9 (level, low) -> IRQ 9
uhci_hcd 0000:00:1f.4: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1f.4 to 64
uhci_hcd 0000:00:1f.4: irq 9, io base 0xa000
usb 1-1: new low speed USB device using uhci_hcd and address 2
uhci_hcd 0000:00:1f.2: Unlink after no-IRQ?  Controller is probably using t=
he=20
wrong IRQ.
usb 1-1: khubd timed out on ep0out
usb 1-1: khubd timed out on ep0out
usb 1-1: device not accepting address 2, error -110
usb 1-1: new low speed USB device using uhci_hcd and address 3
usb 1-1: khubd timed out on ep0out
usb 1-1: khubd timed out on ep0out
usb 1-1: device not accepting address 3, error -110
usb 1-1: new low speed USB device using uhci_hcd and address 4
usb 1-1: khubd timed out on ep0in
usb 1-1: khubd timed out on ep0out
usb 1-1: khubd timed out on ep0out
usb 1-1: device not accepting address 4, error -110
usb 1-1: new low speed USB device using uhci_hcd and address 5
usb 1-1: khubd timed out on ep0in
usb 1-1: khubd timed out on ep0out
usb 1-1: khubd timed out on ep0out
usb 1-1: device not accepting address 5, error -110
usb 1-2: new full speed USB device using uhci_hcd and address 6
usb 1-2: khubd timed out on ep0out
usb 1-2: khubd timed out on ep0out
usb 1-2: device not accepting address 6, error -110
usb 1-2: new full speed USB device using uhci_hcd and address 7
usb 1-2: khubd timed out on ep0out
usb 1-2: khubd timed out on ep0out
usb 1-2: device not accepting address 7, error -110
usb 1-2: new full speed USB device using uhci_hcd and address 8
usb 1-2: khubd timed out on ep0in
usb 1-2: khubd timed out on ep0out
usb 1-2: khubd timed out on ep0out
usb 1-2: device not accepting address 8, error -110
usb 1-2: new full speed USB device using uhci_hcd and address 9
usb 1-2: khubd timed out on ep0in
usb 1-2: khubd timed out on ep0out
usb 1-2: khubd timed out on ep0out
usb 1-2: device not accepting address 9, error -110
uhci_hcd 0000:00:1f.4: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
usb 2-2: new full speed USB device using uhci_hcd and address 2
hub 2-2:1.0: USB hub found
hub 2-2:1.0: 4 ports detected

I do not understand what difference mounting usbfs makes. For reference her=
e=20
is result of loading the same usbcore without mounting usbfs:

{pts/2}% sudo insmod ./usbcore-new.ko
{pts/2}% sudo modprobe uhci-hcd

usbcore: registered new driver usbfs
usbcore: registered new driver hub
USB Universal Host Controller Interface driver v2.2
ACPI: PCI interrupt 0000:00:1f.2[D] -> GSI 5 (level, low) -> IRQ 5
uhci_hcd 0000:00:1f.2: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1f.2 to 64
uhci_hcd 0000:00:1f.2: irq 5, io base 0xa400
uhci_hcd 0000:00:1f.2: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:1f.4[C] -> GSI 9 (level, low) -> IRQ 9
uhci_hcd 0000:00:1f.4: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1f.4 to 64
uhci_hcd 0000:00:1f.4: irq 9, io base 0xa000
uhci_hcd 0000:00:1f.4: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
usb 1-1: new low speed USB device using uhci_hcd and address 2
usb 1-2: new full speed USB device using uhci_hcd and address 3
usb 2-2: new full speed USB device using uhci_hcd and address 2
hub 2-2:1.0: USB hub found
hub 2-2:1.0: 4 ports detected
drivers/usb/class/usblp.c: usblp0: USB Bidirectional printer dev 3 if 0 alt=
 0=20
proto 2 vid 0x03F0 pid 0x1904
usbcore: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
usbcore: registered new driver hiddev
usbhid: probe of 1-1:1.0 failed with error -5
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
usbcore: registered new driver xpad
drivers/usb/input/xpad-core.c: driver for Xbox controllers with mouse=20
emulation v0.1.4


=2Dandrey

>  drivers/usb/core/hub.c |   40 +++++++++++-----------------------------
>  1 files changed, 11 insertions(+), 29 deletions(-)
>
> diff -puN drivers/usb/core/hub.c~hub-use-kthread drivers/usb/core/hub.c
> --- 25/drivers/usb/core/hub.c~hub-use-kthread	2005-05-01 15:22:24.6345399=
28
> -0700 +++ 25-akpm/drivers/usb/core/hub.c	2005-05-01 15:29:55.739961480
> -0700 @@ -26,6 +26,7 @@
>  #include <linux/ioctl.h>
>  #include <linux/usb.h>
>  #include <linux/usbdevice_fs.h>
> +#include <linux/kthread.h>
>
>  #include <asm/semaphore.h>
>  #include <asm/uaccess.h>
> @@ -47,8 +48,7 @@ static LIST_HEAD(hub_event_list);	/* Lis
>  /* Wakes up khubd */
>  static DECLARE_WAIT_QUEUE_HEAD(khubd_wait);
>
> -static pid_t khubd_pid =3D 0;			/* PID of khubd */
> -static DECLARE_COMPLETION(khubd_exited);
> +static struct task_struct *khubd_task;
>
>  /* cycle leds on hubs that aren't blinking for attention */
>  static int blinkenlights =3D 0;
> @@ -2807,23 +2807,16 @@ loop:
>
>  static int hub_thread(void *__unused)
>  {
> -	/*
> -	 * This thread doesn't need any user-level access,
> -	 * so get rid of all our resources
> -	 */
> -
> -	daemonize("khubd");
> -	allow_signal(SIGKILL);
> -
> -	/* Send me a signal to get me die (for debugging) */
>  	do {
>  		hub_events();
> -		wait_event_interruptible(khubd_wait, !list_empty(&hub_event_list));
> +		wait_event_interruptible(khubd_wait,
> +				!list_empty(&hub_event_list) ||
> +				kthread_should_stop());
>  		try_to_freeze(PF_FREEZE);
> -	} while (!signal_pending(current));
> +	} while (!kthread_should_stop() || !list_empty(&hub_event_list));
>
> -	pr_debug ("%s: khubd exiting\n", usbcore_name);
> -	complete_and_exit(&khubd_exited, 0);
> +	pr_debug("%s: khubd exiting\n", usbcore_name);
> +	return 0;
>  }
>
>  static struct usb_device_id hub_id_table [] =3D {
> @@ -2849,20 +2842,15 @@ static struct usb_driver hub_driver =3D {
>
>  int usb_hub_init(void)
>  {
> -	pid_t pid;
> -
>  	if (usb_register(&hub_driver) < 0) {
>  		printk(KERN_ERR "%s: can't register hub driver\n",
>  			usbcore_name);
>  		return -1;
>  	}
>
> -	pid =3D kernel_thread(hub_thread, NULL, CLONE_KERNEL);
> -	if (pid >=3D 0) {
> -		khubd_pid =3D pid;
> -
> +	khubd_task =3D kthread_run(hub_thread, NULL, "khubd");
> +	if (!IS_ERR(khubd_task))
>  		return 0;
> -	}
>
>  	/* Fall through if kernel_thread failed */
>  	usb_deregister(&hub_driver);
> @@ -2873,12 +2861,7 @@ int usb_hub_init(void)
>
>  void usb_hub_cleanup(void)
>  {
> -	int ret;
> -
> -	/* Kill the thread */
> -	ret =3D kill_proc(khubd_pid, SIGKILL, 1);
> -
> -	wait_for_completion(&khubd_exited);
> +	kthread_stop(khubd_task);
>
>  	/*
>  	 * Hub resources are freed for us by usb_deregister. It calls
> @@ -2890,7 +2873,6 @@ void usb_hub_cleanup(void)
>  	usb_deregister(&hub_driver);
>  } /* usb_hub_cleanup() */
>
> -
>  static int config_descriptors_changed(struct usb_device *udev)
>  {
>  	unsigned			index;
> _

--nextPart8859111.kpadkqcOsW
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCdd4KR6LMutpd94wRAqCQAKCmnq1ldxdXF1wGtk1iOUWBxB5v+gCfXn3p
kQl1YZrmPnZsgn3yQWVYmuo=
=UE8T
-----END PGP SIGNATURE-----

--nextPart8859111.kpadkqcOsW--
