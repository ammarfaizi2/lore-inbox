Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131457AbRCQAWs>; Fri, 16 Mar 2001 19:22:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131483AbRCQAWi>; Fri, 16 Mar 2001 19:22:38 -0500
Received: from hypnos.cps.intel.com ([192.198.165.17]:19946 "EHLO
	hypnos.cps.intel.com") by vger.kernel.org with ESMTP
	id <S131457AbRCQAW0>; Fri, 16 Mar 2001 19:22:26 -0500
Message-ID: <4148FEAAD879D311AC5700A0C969E8905DE775@orsmsx35.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'linux-usb-devel@lists.sourceforge.net'" 
	<linux-usb-devel@lists.sourceforge.net>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "Acpi-linux (E-mail)" <acpi@phobos.fachschaften.tu-muenchen.de>
Subject: [PATCH] USB suspend when no devices attached
Date: Fri, 16 Mar 2001 16:21:28 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C0AE78.35DFECB0"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C0AE78.35DFECB0
Content-Type: text/plain;
	charset="iso-8859-1"

Hi all.

This is a preliminary patch against 2.4.2 to uhci.c that puts the host
controller into global suspend when there are no devices attached. This
conserves power on mobile systems, and because suspending the host
controller ceases UHCI's incessant busmastering activity, it allows the CPU
to enter a deeper idle state.

The main problem with this implementation is that it just looks at the 2
root hub ports and suspends if nothing is connected. Ideally, it would be
smart enough to realize it can also suspend when only hubs are present, or
when all devices on the USB are also suspended. I hope a USB expert can add
these enhancements, as it's beyond me.

You should be able to verify this patch is working in one of two ways:
1) Turn on USB debug messages, and look for suspend_hc and wakeup_hc
messages
2) Download the latest ACPI patch from
http://developer.intel.com/technology/iapc/acpi/downloads.htm and verify
that /proc/acpi/processor/0/status shows mostly 0's for busmastering
activity (as opposed to mostly F's) when no USB devices are connected.

Thanks -- Regards -- Andy


------_=_NextPart_000_01C0AE78.35DFECB0
Content-Type: application/octet-stream;
	name="uhci.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="uhci.diff"

diff -ruN -X exclude /usr/src/linux/drivers/usb/uhci.c =
linux/drivers/usb/uhci.c=0A=
--- /usr/src/linux/drivers/usb/uhci.c	Fri Feb  9 11:30:23 2001=0A=
+++ linux/drivers/usb/uhci.c	Fri Mar 16 16:46:29 2001=0A=
@@ -66,6 +66,10 @@=0A=
 static int uhci_unlink_generic(struct urb *urb);=0A=
 static int uhci_unlink_urb(struct urb *urb);=0A=
 =0A=
+static int  ports_active(struct uhci *uhci);=0A=
+static void suspend_hc(struct uhci *uhci);=0A=
+static void wakeup_hc(struct uhci *uhci);=0A=
+=0A=
 #define min(a,b) (((a)<(b))?(a):(b))=0A=
 =0A=
 /* If a transfer is still active after this much time, turn off FSBR =
*/=0A=
@@ -1767,6 +1771,10 @@=0A=
 	}=0A=
 	nested_unlock(&uhci->urblist_lock, flags);=0A=
 =0A=
+	/* enter global suspend if nothing connected */=0A=
+	if (!uhci->is_suspended && !ports_active(uhci))=0A=
+		suspend_hc(uhci);=0A=
+=0A=
 	rh_init_int_timer(urb);=0A=
 }=0A=
 =0A=
@@ -2037,19 +2045,21 @@=0A=
 		return;=0A=
 	outw(status, io_addr + USBSTS);=0A=
 =0A=
-	if (status & ~(USBSTS_USBINT | USBSTS_ERROR)) {=0A=
-		if (status & USBSTS_RD)=0A=
-			printk(KERN_INFO "uhci: resume detected, not implemented\n");=0A=
+	if (status & ~(USBSTS_USBINT | USBSTS_ERROR | USBSTS_RD)) {=0A=
 		if (status & USBSTS_HSE)=0A=
 			printk(KERN_ERR "uhci: host system error, PCI problems?\n");=0A=
 		if (status & USBSTS_HCPE)=0A=
 			printk(KERN_ERR "uhci: host controller process error. something bad =
happened\n");=0A=
-		if (status & USBSTS_HCH) {=0A=
+		if ((status & USBSTS_HCH) && !uhci->is_suspended) {=0A=
 			printk(KERN_ERR "uhci: host controller halted. very bad\n");=0A=
 			/* FIXME: Reset the controller, fix the offending TD */=0A=
 		}=0A=
 	}=0A=
 =0A=
+	if (status & USBSTS_RD) {=0A=
+		wakeup_hc(uhci);=0A=
+	}=0A=
+=0A=
 	uhci_free_pending_qhs(uhci);=0A=
 =0A=
 	spin_lock(&uhci->urb_remove_lock);=0A=
@@ -2093,6 +2103,51 @@=0A=
 	wait_ms(50);=0A=
 	outw(0, io_addr + USBCMD);=0A=
 	wait_ms(10);=0A=
+}=0A=
+=0A=
+static void suspend_hc(struct uhci *uhci)=0A=
+{=0A=
+	unsigned int io_addr =3D uhci->io_addr;=0A=
+=0A=
+	dbg("suspend_hc");=0A=
+=0A=
+	outw(USBCMD_EGSM, io_addr + USBCMD);=0A=
+=0A=
+	uhci->is_suspended =3D 1;=0A=
+}=0A=
+=0A=
+static void wakeup_hc(struct uhci *uhci)=0A=
+{=0A=
+	unsigned int io_addr =3D uhci->io_addr;=0A=
+	unsigned int status;=0A=
+=0A=
+	dbg("wakeup_hc");=0A=
+=0A=
+	outw(0, io_addr + USBCMD);=0A=
+	=0A=
+	/* wait for EOP to be sent */=0A=
+	status =3D inw(io_addr + USBCMD);=0A=
+	while (status & USBCMD_FGR) {=0A=
+		status =3D inw(io_addr + USBCMD);=0A=
+	}=0A=
+=0A=
+	uhci->is_suspended =3D 0;=0A=
+=0A=
+	/* Run and mark it configured with a 64-byte max packet */=0A=
+	outw(USBCMD_RS | USBCMD_CF | USBCMD_MAXP, io_addr + USBCMD);=0A=
+}=0A=
+=0A=
+static int ports_active(struct uhci *uhci)=0A=
+{=0A=
+	unsigned int io_addr =3D uhci->io_addr;=0A=
+	int connection =3D 0;=0A=
+	int i;=0A=
+=0A=
+	for (i =3D 0; i < uhci->rh.numports; i++) {=0A=
+		connection |=3D (inw (io_addr + USBPORTSC1 + i * 2) & 0x1);=0A=
+	}=0A=
+=0A=
+	return (connection);=0A=
 }=0A=
 =0A=
 static void start_hc(struct uhci *uhci)=0A=
diff -ruN -X exclude /usr/src/linux/drivers/usb/uhci.h =
linux/drivers/usb/uhci.h=0A=
--- /usr/src/linux/drivers/usb/uhci.h	Wed Feb 21 16:11:49 2001=0A=
+++ linux/drivers/usb/uhci.h	Fri Mar 16 16:09:29 2001=0A=
@@ -332,6 +332,8 @@=0A=
 	struct list_head urb_list;=0A=
 =0A=
 	struct virt_root_hub rh;	/* private data of the virtual root hub =
*/=0A=
+=0A=
+	unsigned int is_suspended;=0A=
 };=0A=
 =0A=
 struct urb_priv {=0A=

------_=_NextPart_000_01C0AE78.35DFECB0--

