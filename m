Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262514AbUCHRYa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 12:24:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262567AbUCHRYa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 12:24:30 -0500
Received: from fw.osdl.org ([65.172.181.6]:46730 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262514AbUCHRYZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 12:24:25 -0500
Date: Mon, 8 Mar 2004 09:26:13 -0800
From: Dave Olien <dmo@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: markus.amsler@oribi.org, linux-kernel@vger.kernel.org
Subject: Re: Fw: [PATCH] DAC960 Oopses
Message-ID: <20040308172613.GA2522@osdl.org>
References: <20040307163738.3d014647.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="6c2NcOVqGQ03X4Wi"
Content-Disposition: inline
In-Reply-To: <20040307163738.3d014647.akpm@osdl.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Andrew,

Yup, this patch fixes one legitimate bug with the device unregistering,
and the change for alpha is OK.  Please apply Markus's patch.
I've attached markus's the patch to this mail message.

Dave


On Sun, Mar 07, 2004 at 04:37:38PM -0800, Andrew Morton wrote:
> 
> 
> Begin forwarded message:
> 
> Date: Sun,  7 Mar 2004 15:38:43 +0100
> From: markus.amsler@oribi.org
> To: linux-kernel@vger.kernel.org
> Subject: [PATCH] DAC960 Oopses
> 
> 
> Hi,
> 
> The first part fixes a Kernel paging request failure on alpha with
> some older DAC960P cards (i tried D040340-0-DEC/Firmware 2.70).
> The Problem was, that ioremap_nocache(NULL) is not  NULL (only on alpha).
> This card is still unsupported, due to lacking PCI resources.
> 
> The second part fixes a kernel Oops, if the initialization
> of the Controller fails (like too old firmware).
> In that case, DAC960_UnregisterBlockDevice fails, 
> because DAC960_RegisterBlockDevice was never called.
> This is a side effect of the multi-queue patch by Dave Olien.
> 
> Please CC to me directly.
> 
> --- linux-2.6.3/drivers/block/DAC960.c	Wed Feb 18 04:59:05 2004
> +++ linux/drivers/block/DAC960.c	Sun Mar  7 11:47:55 2004
> @@ -2723,6 +2723,20 @@
>  	  break;
>    }
>  
> +  /*
> +    Controller with Mylex P/N D040340-0-DEC has no PCI resource[1]!!
> +    Checking the MemoryMappedAddress == NULL will fail on 
> +    virtual Alpha addresses. 
> +  */	  
> +  if (!Controller->PCI_Address)
> +  {
> +	  DAC960_Error("Unable to get PCI Address. "
> +		       "This Controller is currently not supported.\n",
> +                       Controller);
> +	  Controller->IO_Address = 0;
> +	  goto Failure;
> +  }
> +
>    pci_set_drvdata(PCI_Device, (void *)((long)Controller->ControllerNumber));
>    for (i = 0; i < DAC960_MaxLogicalDrives; i++) {
>  	Controller->disks[i] = alloc_disk(1<<DAC960_MaxPartitionsBits);
> @@ -3061,8 +3075,8 @@
>  				    DAC960_V2_RAID_Controller);
>  	  DAC960_Notice("done\n", Controller);
>  	}
> +    DAC960_UnregisterBlockDevice(Controller);
>      }
> -  DAC960_UnregisterBlockDevice(Controller);
>    DAC960_DestroyAuxiliaryStructures(Controller);
>    DAC960_DestroyProcEntries(Controller);
>    DAC960_DetectCleanup(Controller);
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="D.patch"

--- linux-2.6.3/drivers/block/DAC960.c	Wed Feb 18 04:59:05 2004
+++ linux/drivers/block/DAC960.c	Sun Mar  7 11:47:55 2004
@@ -2723,6 +2723,20 @@
 	  break;
   }
 
+  /*
+    Controller with Mylex P/N D040340-0-DEC has no PCI resource[1]!!
+    Checking the MemoryMappedAddress == NULL will fail on 
+    virtual Alpha addresses. 
+  */	  
+  if (!Controller->PCI_Address)
+  {
+	  DAC960_Error("Unable to get PCI Address. "
+		       "This Controller is currently not supported.\n",
+                       Controller);
+	  Controller->IO_Address = 0;
+	  goto Failure;
+  }
+
   pci_set_drvdata(PCI_Device, (void *)((long)Controller->ControllerNumber));
   for (i = 0; i < DAC960_MaxLogicalDrives; i++) {
 	Controller->disks[i] = alloc_disk(1<<DAC960_MaxPartitionsBits);
@@ -3061,8 +3075,8 @@
 				    DAC960_V2_RAID_Controller);
 	  DAC960_Notice("done\n", Controller);
 	}
+    DAC960_UnregisterBlockDevice(Controller);
     }
-  DAC960_UnregisterBlockDevice(Controller);
   DAC960_DestroyAuxiliaryStructures(Controller);
   DAC960_DestroyProcEntries(Controller);
   DAC960_DetectCleanup(Controller);

--6c2NcOVqGQ03X4Wi--
