Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312513AbSCUVtU>; Thu, 21 Mar 2002 16:49:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312515AbSCUVtK>; Thu, 21 Mar 2002 16:49:10 -0500
Received: from mail.actcom.co.il ([192.114.47.13]:10930 "EHLO
	lmail.actcom.co.il") by vger.kernel.org with ESMTP
	id <S312513AbSCUVtD>; Thu, 21 Mar 2002 16:49:03 -0500
Message-Id: <200203212148.g2LLmY426830@lmail.actcom.co.il>
From: Itai Nahshon <nahshon@actcom.co.il>
Reply-To: nahshon@actcom.co.il
To: Richard Gooch <rgooch@ras.ucalgary.ca>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] [was SCSI host numbers? ]
Date: Thu, 21 Mar 2002 23:48:21 +0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org, Pete Zaitcev <zaitcev@redhat.com>
In-Reply-To: <E16LjdE-0003m4-00@the-village.bc.nu> <200201160703.g0G73Sr27779@vindaloo.ras.ucalgary.ca> <200201160947.g0G9lxv15813@lmail.actcom.co.il>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_L8FCKRXQN94384OJLKVC"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_L8FCKRXQN94384OJLKVC
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

Hello all,

Under some scenarios Linux assigns the same
host_no to more than one scsi device.

I raised this problem a long time ago.

To repeat the problem (all recent 2.4.x and possibly 2.5.x kernels):
Use two scsi drivers that are not required for system
use (mean - not the one that drives your hard disk). I got
this problem the first time with ide-scsi and usb-storage.
Call these device drivers A and B.
Host numbers are remembered after they are assigned
until the next reboot (or until unloading scsi_mod if
it is compiled as a module). Start with a "clean" system.

modprobe A
rmmod A
modprobe B
modprobe A

And - the two adapters now have the same host number.
In this case, some functions of A will not work. Especially devices
attached to A cannot be accessed through the sg interface. I believe
that writes to /proc/scsi/scsi will not work for these devices too
(but these are useless for the drivers that I used in my tests).

See also <http://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=55876>.

I gave it as much testing as I could, and I believe it is not worse
than it was. People with more SCSI hardware should be able to try
more complex cases.

I left the stuff in #ifdef + comments because I believe that the scsi
registration code needs more cleanup. I have some related questions
that I will post on a separate message to lkml.

-- Itai


--------------Boundary-00=_L8FCKRXQN94384OJLKVC
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="scsi-host_no.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="scsi-host_no.patch"

--- drivers/scsi/hosts-2.4.19-pre4.c=09Thu Mar 21 03:35:41 2002
+++ drivers/scsi/hosts.c=09Thu Mar 21 04:02:18 2002
@@ -81,8 +81,8 @@
 struct Scsi_Host * scsi_hostlist;
 struct Scsi_Device_Template * scsi_devicelist;
=20
-int max_scsi_hosts;
-int next_scsi_host;
+int max_scsi_hosts;=09/* host_no for next new host */
+int next_scsi_host;=09/* count of registered scsi hosts */
=20
 void
 scsi_unregister(struct Scsi_Host * sh){
@@ -107,6 +107,18 @@
     if (shn) shn->host_registered =3D 0;
     /* else {} : This should not happen, we should panic here... */
    =20
+#if 1
+    /* We shoult not decrement max_scsi_hosts (and make this value
+     * candidate for re-allocation by a different driver).
+     * Reason: the device is _still_ on the
+     * scsi_host_no_list and it's identified by its name. When the same
+     * device is re-registered it will get the same host_no again while
+     * new devices may use the allocation scheme and get this very same
+     * host_no.
+     * It's OK to have "holes" in the allocation but it does not mean
+     * "leaks".
+     */
+#else // if 0
     /* If we are removing the last host registered, it is safe to reuse
      * its host number (this avoids "holes" at boot time) (DB)=20
      * It is also safe to reuse those of numbers directly below which ha=
ve
@@ -121,7 +133,9 @@
 =09=09break;
 =09}
     }
+#endif
     next_scsi_host--;
+
     kfree((char *) sh);
 }
=20

--------------Boundary-00=_L8FCKRXQN94384OJLKVC--
