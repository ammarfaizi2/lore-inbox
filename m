Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932320AbVLAQae@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932320AbVLAQae (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 11:30:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932322AbVLAQae
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 11:30:34 -0500
Received: from rtsoft2.corbina.net ([85.21.88.2]:55515 "HELO
	mail.dev.rtsoft.ru") by vger.kernel.org with SMTP id S932320AbVLAQad
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 11:30:33 -0500
Message-ID: <438F253E.20303@ru.mvista.com>
Date: Thu, 01 Dec 2005 19:30:54 +0300
From: Vitaly Wool <vwool@ru.mvista.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: linux-kernel@vger.kernel.org, david-b@pacbell.net, dpervushin@gmail.com,
       akpm@osdl.org, greg@kroah.com, basicmark@yahoo.com,
       komal_shah802003@yahoo.com, stephen@streetfiresound.com,
       spi-devel-general@lists.sourceforge.net, Joachim_Jaeger@digi.com
Subject: Re: [PATCH 2.6-git] SPI core refresh
References: <20051201191109.40f2d04b.vwool@ru.mvista.com> <20051201162102.GB31551@flint.arm.linux.org.uk>
In-Reply-To: <20051201162102.GB31551@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:

>>+iii. struct spi_driver
>>+~~~~~~~~~~~~~~~~~~~~~~
>>+
>>+struct spi_driver {
>>+    	void* (*alloc)( size_t, int );
>>+    	void  (*free)( const void* );
>>+    	unsigned char* (*get_buffer)( struct spi_device*, void* );
>>+    	void (*release_buffer)( struct spi_device*, unsigned char*);
>>+    	void (*control)( struct spi_device*, int mode, u32 ctl );
>>+        struct device_driver driver;
>>+};
>>    
>>
>
>This doesn't appear to have been updated.
>
>  
>
>>+formed spi_driver structure:
>>+	extern struct bus_type spi_bus;
>>+	static struct spi_driver pnx4008_eeprom_driver = {
>>+        	.driver = {
>>+                   	.bus = &spi_bus,
>>+                   	.name = "pnx4008-eeprom",
>>+                   	.probe = pnx4008_spiee_probe,
>>+                   	.remove = pnx4008_spiee_remove,
>>+                   	.suspend = pnx4008_spiee_suspend,
>>+                   	.resume = pnx4008_spiee_resume,
>>+               	},
>>+};
>>    
>>
>
>Ditto.
>
>  
>
>>+iv. struct spi_bus_driver
>>+~~~~~~~~~~~~~~~~~~~~~~~~~
>>+To handle transactions over the SPI bus, the spi_bus_driver structure must
>>+be prepared and registered with core. Any transactions, either synchronous
>>+or asynchronous, go through spi_bus_driver->xfer function.
>>+
>>+struct spi_bus_driver
>>+{
>>+        int (*xfer)( struct spi_msg* msgs );
>>+        void (*select) ( struct spi_device* arg );
>>+        void (*deselect)( struct spi_device* arg );
>>+
>>+	struct spi_msg *(*retrieve)( struct spi_bus_driver *this, struct spi_bus_data *bd);
>>+	void (*reset)( struct spi_bus_driver *this, u32 context);
>>+
>>+        struct device_driver driver;
>>+};
>>    
>>
>
>Does this need updating as well?
>
>  
>
>>+spi_bus_driver structure:
>>+	static struct spi_bus_driver spipnx_driver = {
>>+        .driver = {
>>+                   .bus = &platform_bus_type,
>>+                   .name = "spipnx",
>>+                   .probe = spipnx_probe,
>>+                   .remove = spipnx_remove,
>>+                   .suspend = spipnx_suspend,
>>+                   .resume = spipnx_resume,
>>+                   },
>>+        .xfer = spipnx_xfer,
>>+};
>>    
>>
>
>From this it looks like it does.
>
>  
>
Yep, thanks for pointing that out. The Documentation part needs to be 
updated. Will do soon.

>  
>
>>+
>>+int spi_driver_suspend (struct device *dev, pm_message_t pm)
>>+{
>>+	struct spi_driver *sdrv = TO_SPI_DRIVER(dev->driver);
>>+	struct spi_device *sdev = TO_SPI_DEV(dev);
>>+
>>+	return (sdrv && sdrv->suspend) ?  sdrv->suspend(sdev, pm) : -EFAULT;
>>+}
>>+
>>+int spi_driver_resume (struct device *dev)
>>+{
>>+	struct spi_driver *sdrv = TO_SPI_DRIVER(dev->driver);
>>+	struct spi_device *sdev = TO_SPI_DEV(dev);
>>+
>>+	return (sdrv && sdrv->resume) ? sdrv->resume(sdev) : -EFAULT;
>>+}
>>    
>>
>
>If the bus_type does not call the device_driver suspend/resume methods,
>these are not necessary.
>
>Another oddity I notice is that if there isn't a driver or method, you're
>returning -EFAULT - seems odd since if there isn't a driver do you really
>want to prevent suspend/resume?
>  
>
Yep, I must admit here that it's really better to do something like
if (!dev->driver)
return 0;
else if (sdrv->suspend)
return sdrv->suspend(...)

Does that sound better to you?

>  
>
>>+static inline int spi_driver_add(struct spi_driver *drv)
>>+{
>>+	drv->driver.bus = &spi_bus;
>>+	drv->driver.probe = spi_driver_probe;
>>+	drv->driver.remove = spi_driver_remove;
>>+	drv->driver.shutdown = spi_driver_shutdown;
>>    
>>
>
>  
>
>>+	drv->driver.suspend = spi_driver_suspend;
>>+	drv->driver.resume = spi_driver_resume;
>>    
>>
>
>As a result of the comment above, you don't need these two initialisers.
>
>  
>
Yup. Thanks.

Vitaly

