Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131843AbQLHB4P>; Thu, 7 Dec 2000 20:56:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131456AbQLHB4G>; Thu, 7 Dec 2000 20:56:06 -0500
Received: from [213.237.20.108] ([213.237.20.108]:5685 "EHLO ns.geekboy.dk")
	by vger.kernel.org with ESMTP id <S129967AbQLHB4B>;
	Thu, 7 Dec 2000 20:56:01 -0500
Date: Fri, 8 Dec 2000 02:30:07 +0100
From: Torben Mathiasen <torben@kernel.dk>
To: strieder@student.uni-kl.de
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: SCSI modules and kmod
Message-ID: <20001208023007.A10269@torben>
In-Reply-To: <3A2FD00F.E7449D2D@student.uni-kl.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ew6BAiZeqk4r7MaW"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A2FD00F.E7449D2D@student.uni-kl.de>; from strieder@student.uni-kl.de on Thu, Dec 07, 2000 at 06:59:43PM +0100
X-OS: Linux 2.4.0-test12 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 07 2000, strieder@student.uni-kl.de wrote:

[deleted]
 
>     int regdevresult;
> ....
>     case MODULE_SCSI_DEV:
> #ifdef CONFIG_KMOD
>         if (scsi_hosts == NULL)
>           {
>             request_module("scsi_hostadapter");
>             return scsi_register_device_module((struct
> Scsi_Device_Template *) ptr);
>           }
> #endif
>         regdevresult = scsi_register_device_module((struct
> Scsi_Device_Template *) ptr);
> #ifdef CONFIG_KMOD
>         if (regdevresult != 0) /* is this the right case? */
>             request_module("scsi_hostadapter");
>         regdevresult = scsi_register_device_module((struct
> Scsi_Device_Template *) ptr);
> #endif
>         return regdevresult;
> 
This won't work. scsi_register_device_module returns 0 when the 
driver loads ok, not when a device was actually found. Remember
its possible to load the sd driver with no host adapter present.

How about just removing the check for scsi_hosts == NULL. If some
hostadapter was already loaded, so be it. It won't change anything,
besides maybe more devices beeing loaded which shouldn't hurt anyone.

Small patch attached (against t12p7). Not tested, not even compiled.


-- 
Torben Mathiasen <torben@kernel.dk>
Linux ThunderLAN maintainer 
http://tlan.kernel.dk

--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="scsi.diff"

--- /opt/kernel/kernels/linux/drivers/scsi/scsi.c	Wed Nov  1 15:04:02 2000
+++ linux/drivers/scsi/scsi.c	Fri Dec  8 02:13:47 2000
@@ -2322,11 +2322,9 @@
 		/* Load upper level device handler of some kind */
 	case MODULE_SCSI_DEV:
 #ifdef CONFIG_KMOD
-		if (scsi_hosts == NULL)
-			request_module("scsi_hostadapter");
+	request_module("scsi_hostadapter");
 #endif
-		return scsi_register_device_module((struct Scsi_Device_Template *) ptr);
-		/* The rest of these are not yet implemented */
+ 	return scsi_register_device_module((struct Scsi_Device_Template *) ptr);
 
 		/* Load constants.o */
 	case MODULE_SCSI_CONST:

--ew6BAiZeqk4r7MaW--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
