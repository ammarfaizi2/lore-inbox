Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266852AbSK1Xr1>; Thu, 28 Nov 2002 18:47:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266849AbSK1Xr1>; Thu, 28 Nov 2002 18:47:27 -0500
Received: from ns1.triode.net.au ([202.147.124.1]:26347 "EHLO
	iggy.triode.net.au") by vger.kernel.org with ESMTP
	id <S266848AbSK1XrY>; Thu, 28 Nov 2002 18:47:24 -0500
Message-ID: <3DE69E68.7070304@torque.net>
Date: Fri, 29 Nov 2002 09:53:28 +1100
From: Douglas Gilbert <dougg@torque.net>
Reply-To: dougg@torque.net
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020830
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@steeleye.com>
CC: Andries.Brouwer@cwi.nl, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] scsi/hosts.c device_register fix
References: <200211281657.gASGve102802@localhost.localdomain>
Content-Type: multipart/mixed;
 boundary="------------090009020605010109080903"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090009020605010109080903
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

James Bottomley wrote:
> Actually, the patch is wrong.  It will wreak havoc with SCSI's use of sysfs.  
> The device_register has to be done in scsi_add_host, which is called after all 
> the driver specific sysfs setup has been done.  The correct fix is to move the 
> corresponding device_unregister into scsi_remove_host so that they match.
> 
> I've attached it below.  I'll also commit it to the scsi-misc-2.5 BK tree.
> 
> James
> 
> 
> 
> ------------------------------------------------------------------------
> 
> ===== hosts.c 1.31 vs edited =====
> --- 1.31/drivers/scsi/hosts.c	Sun Nov 17 15:47:02 2002
> +++ edited/hosts.c	Sat Nov 23 17:25:57 2002
> @@ -295,6 +295,8 @@
>  		kfree(sdev);
>  	}
>  
> +	device_unregister(&shost->host_driverfs_dev);
> +
>  	return 0;
>  }
>  
> @@ -348,7 +350,6 @@
>  
>  	/* Cleanup proc and driverfs */
>  	scsi_proc_host_rm(shost);
> -	device_unregister(&shost->host_driverfs_dev);
>  
>  	kfree(shost);
>  }

James,
The above patch is a bit noisy when applied to lk 2.5.50 .
Attached is the same patch (I hope) which applies cleanly.

Doug Gilbert

--------------090009020605010109080903
Content-Type: text/plain;
 name="dev_reg_2550.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dev_reg_2550.diff"

--- linux/drivers/scsi/hosts.c	2002-11-29 09:27:35.000000000 +1100
+++ linux/drivers/scsi/hosts.c2550jb	2002-11-29 09:45:28.000000000 +1100
@@ -297,6 +297,8 @@
 		scsi_free_sdev(list_entry(le, Scsi_Device, siblings));
 	}
 
+	device_unregister(&shost->host_driverfs_dev);
+
 	return 0;
 }
 
@@ -348,7 +350,6 @@
 
 	/* Cleanup proc and driverfs */
 	scsi_proc_host_rm(shost);
-	device_unregister(&shost->host_driverfs_dev);
 
 	kfree(shost);
 }

--------------090009020605010109080903--


