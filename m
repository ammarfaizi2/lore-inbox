Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263794AbSKMX2Q>; Wed, 13 Nov 2002 18:28:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263837AbSKMX2Q>; Wed, 13 Nov 2002 18:28:16 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:38844 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S263794AbSKMX2O>; Wed, 13 Nov 2002 18:28:14 -0500
From: Badari Pulavarty <pbadari@us.ibm.com>
Message-Id: <200211132335.gADNZ4S04007@eng2.beaverton.ibm.com>
Subject: Re: OOPS on module unload 2.5.47-mm1
To: patmans@us.ibm.com (Patrick Mansfield)
Date: Wed, 13 Nov 2002 15:35:04 -0800 (PST)
Cc: pbadari@us.ibm.com (Badari Pulavarty), linux-kernel@vger.kernel.org (lkml)
In-Reply-To: <20021113093708.A22470@eng2.beaverton.ibm.com> from "Patrick Mansfield" at Nov 13, 2002 08:37:08 AM PST
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick,

Your patches fixed my problem. 

Thanks,
Badari

> 
> On Tue, Nov 12, 2002 at 03:49:40PM -0800, Badari Pulavarty wrote:
> > Hi,
> > 
> > I get following panic while rmmod qla driver.  (2.5.47-mm1).
> > 
> > Is this a known problem ? Any ideas ?
> > 
> > Thanks,
> > Badari
> 
> Badari -
> 
> Here are four patches, 3 in sysfs, one in scsi, that I used to enable
> rmmod/insmod of qla and scsi_debug without problems in 2.5.46 or so.
> I have not tried running 2.5.47-mm1 or 2.5.47 with these, but these
> patches still apply against current bk (nov 13). I don't remember all
> the odd behaviour seen without them, generally use-after-freed problems.
> 
> I'm not sure about the sysfs ones, but the scsi one is fine for now
> (exporting the SCSI type is not very useful, we need a common scsi_device
> removal/cleanup function where we can remove scsi_device sysfs attribute
> files. Generally, scsi use of sysfs is broken.)
> 
> I posted these to linux-scsi, Mike A posted the sysfs ones to linux-kernel.
> 
> --- 1.22/drivers/base/bus.c	Thu Oct 31 08:20:23 2002
> +++ edited/drivers/base/bus.c	Wed Nov  6 17:03:24 2002
> @@ -209,8 +209,10 @@
>  				attach(dev);
>  			else
>  				dev->driver = NULL;
> -		} else 
> +		} else  {
>  			attach(dev);
> +			error = 0;
> +		}
>  	}
>  	return error;
>  }
> ===== drivers/base/core.c 1.50 vs edited =====
> --- 1.50/drivers/base/core.c	Thu Oct 31 08:20:23 2002
> +++ edited/drivers/base/core.c	Wed Nov  6 17:03:42 2002
> @@ -173,8 +173,6 @@
>  		return -EINVAL;
>  
>  	device_initialize(dev);
> -	if (dev->parent)
> -		get_device(dev->parent);
>  	error = device_add(dev);
>  	if (error && dev->parent)
>  		put_device(dev->parent);
> ===== drivers/base/driver.c 1.14 vs edited =====
> --- 1.14/drivers/base/driver.c	Wed Oct 30 16:35:48 2002
> +++ edited/drivers/base/driver.c	Wed Nov  6 16:44:13 2002
> @@ -127,6 +127,8 @@
>  	drv->present = 0;
>  	spin_unlock(&device_lock);
>  	pr_debug("driver %s:%s: unregistering\n",drv->bus->name,drv->name);
> +	bus_remove_driver(drv);
> +	kobject_unregister(&drv->kobj);
>  	put_driver(drv);
>  }
>  
> --- 1.33/drivers/scsi/scsi_scan.c	Wed Nov  6 11:46:48 2002
> +++ edited/drivers/scsi/scsi_scan.c	Wed Nov  6 17:04:56 2002
> @@ -307,73 +307,6 @@
>  }
>  
>  /**
> - * scsi_device_type_read - copy out the SCSI type
> - * @driverfs_dev:	driverfs device to check
> - * @page:		copy data into this area
> - * @count:		number of bytes to copy
> - * @off:		start at this offset in page
> - *
> - * Description:
> - *     Called via driverfs when the "type" (in scsi_device_type_file)
> - *     field is read. Copy the appropriate SCSI type string into @page,
> - *     followed by a newline and a '\0'. Go through gyrations so we don't
> - *     write more than @count, and we don't write past @off.
> - *
> - * Notes:
> - *     This is for the top-most scsi entry in driverfs, the upper-level
> - *     drivers have their own type file. XXX This is not part of scanning,
> - *     other than we reference the attr struct in this file, move to
> - *     scsi.c or scsi_lib.c.
> - *
> - * Return:
> - *     number of bytes written into page.
> - **/
> -static ssize_t scsi_device_type_read(struct device *driverfs_dev, char *page,
> -	size_t count, loff_t off)
> -{
> -	struct scsi_device *sdev = to_scsi_device(driverfs_dev);
> -	const char *type;
> -	size_t size, len;
> -
> -	if ((sdev->type > MAX_SCSI_DEVICE_CODE) ||
> -	    (scsi_device_types[(int)sdev->type] == NULL))
> -		type = "Unknown";
> -	else
> -		type = scsi_device_types[(int)sdev->type];
> -	size = strlen(type);
> -	/*
> -	 * Check if off is past size + 1 for newline + 1 for a '\0'.
> -	 */
> -	if (off >= (size + 2))
> -		return 0;
> -	if (size > off) {
> -		len = min((size_t) (size - off), count);
> -		memcpy(page + off, type + off, len);
> -	} else
> -		len = 0;
> -	if (((len + off) == size) && (len < count))
> -		/*
> -		 * We are at the end of the string and have space, add a
> -		 * new line.
> -		 */
> -		*(page + off + len++) = '\n';
> -	if (((len + off) == (size + 1)) && (len < count))
> -		/*
> -		 * We are past the newline and have space, add a
> -		 * terminating '\0'.
> -		 */
> -		*(page + off + len++) = '\0';
> -	return len;
> -}
> -
> -/*
> - * Create dev_attr_type. This is different from the dev_attr_type in scsi
> - * upper level drivers.
> - */
> -static DEVICE_ATTR(type,S_IRUGO,scsi_device_type_read,NULL);
> -
> -
> -/**
>   * print_inquiry - printk the inquiry information
>   * @inq_result:	printk this SCSI INQUIRY
>   *
> @@ -1439,11 +1372,6 @@
>  	sdev->sdev_driverfs_dev.parent = &sdev->host->host_driverfs_dev;
>  	sdev->sdev_driverfs_dev.bus = &scsi_driverfs_bus_type;
>  	device_register(&sdev->sdev_driverfs_dev);
> -
> -	/*
> -	 * Create driverfs file entries
> -	 */
> -	device_create_file(&sdev->sdev_driverfs_dev, &dev_attr_type);
>  
>  	sprintf(devname, "host%d/bus%d/target%d/lun%d",
>  		sdev->host->host_no, sdev->channel, sdev->id, sdev->lun);
> 


-- 
Badari Pulavarty
pbadari@us.ibm.com
IBM Linux Technology Center - Kernel Team
