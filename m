Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932509AbVIZUXQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932509AbVIZUXQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 16:23:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932510AbVIZUXQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 16:23:16 -0400
Received: from zproxy.gmail.com ([64.233.162.198]:18189 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932509AbVIZUXP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 16:23:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=BAmNCBLGc3nraHCUxwrrZODoZRfRKYC1spuVOdTDnCHcpGxsDOIn8HdohGGGAucusiDXonhyHRUN2vOy9+lVCTv8Gu4Wd6CKTPCzVce+MgptpaZW/Xh76kfbyXUn38H3fmriDR8pKORthgYflYucaIevQFOFwN3YxLLaEwrMPwU=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: dmitry pervushin <dpervushin@gmail.com>
Subject: Re: SPI
Date: Mon, 26 Sep 2005 22:25:25 +0200
User-Agent: KMail/1.8.2
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       spi-devel-general@lists.sourceforge.net
References: <1127733134.7577.0.camel@diimka.dev.rtsoft.ru>
In-Reply-To: <1127733134.7577.0.camel@diimka.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509262225.25946.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 26 September 2005 13:12, dmitry pervushin wrote:
> Hello guys,
> 
> I am attaching the next incarnation of SPI core; feel free to comment it.
> 
A few small style comments below.

General notes:
	Please use only tabs for indentation.
	Please get rid of all the trailing whitespace. A small sed script 
	 like this will do:  sed -r s/"[ \t]+$"/""/
	Please use only one statement pr line.
	Please get rid of the extra whitespace after opening paren and before
	 closing paren:  not like ( this ), but like (this).
	Please use a single space after if. Like this: if (foo), not if(foo).
	For pointer variables,  "type *name" is usually prefered, 
	 not "type* name" or "type * name".

See the changes I've made below for more details (note: I may have missed some
 bits, if so, please correct what I missed as well) :-)

See Documentation/CodingStyle for yet more details and rationale.



[snip]
> + */
> +static int spi_bus_match_name(struct device *dev, struct device_driver *drv)
> +{
> +	return  !strcmp (drv->name, SPI_DEV_CHAR) || 

	return  !strcmp(drv->name, SPI_DEV_CHAR) || 


[snip]
> + * Parameters:
> + * 	struct device* dev	the 'bus' device
> + * 	void* context		not used. Will be NULL

 * 	struct device *dev	the 'bus' device
 * 	void *context		not used. Will be NULL


[snip]
> +int __spi_bus_free(struct device *dev, void *context)
> +{
> +	struct spi_bus_data *pd = dev->platform_data;
> +
> +	atomic_inc(&pd->exiting);
> +	kthread_stop(pd->thread);
> +	kfree(pd);
> +
> +	dev_dbg( dev, "unregistering children\n" );

	dev_dbg(dev, "unregistering children\n");


> +	/* 
> +	 * NOTE: the loop below might needs redesign. Currently
> +	 *       we delete devices from the head of children list
> +	 *       until the list is empty; that's because the function
> +	 *       device_for_each_child will hold the semaphore needed 
> +	 *       for deletion of device
> +	 */
> +	while( !list_empty( &dev->children ) ) {
> +		struct device* child = list_entry ( dev->children.next, struct device, node );
> +	    	spi_device_del (TO_SPI_DEV (child) );

	while(!list_empty(&dev->children)) {
		struct device *child = list_entry(dev->children.next, struct device, node);
	    	spi_device_del(TO_SPI_DEV(child));


[snip]
> + * spi_bus_driver_unregister
> + *
> + * unregisters the SPI bus from the system. Before unregistering, it deletes
> + * each SPI device on the bus using call to __spi_device_free
> + *
> + * Parameters:
> + *  	struct spi_bus_driver* bus_driver	the bus driver

 *  	struct spi_bus_driver *bus_driver	the bus driver


[snip]
> +void spi_bus_driver_unregister(struct spi_bus_driver *bus_driver)
> +{
> +	if (bus_driver) {
> +		driver_for_each_dev( &bus_driver->driver, NULL, __spi_bus_free);

		driver_for_each_dev(&bus_driver->driver, NULL, __spi_bus_free);


[snip]
> + * 	struct device* dev

 * 	struct device *dev

> + * Return value:
> + * 	none
> + */
> +void spi_device_release( struct device* dev )

void spi_device_release(struct device *dev)


[snip]
> + * 	struct device* parent		the 'bus' device
> + * 	struct spi_device* dev		new device to be added
> + * 	char* name			name of device. Should not be NULL

 * 	struct device *parent		the 'bus' device
 * 	struct spi_device *dev		new device to be added
 * 	char *name			name of device. Should not be NULL

[snip]
> +int spi_device_add(struct device *parent, struct spi_device *dev, char *name)
> +{
> +	if (!name || !dev) 
> +	    return -EINVAL;
> +	    
> +	memset(&dev->dev, 0, sizeof(dev->dev));
> +	dev->dev.parent = parent;
> +	dev->dev.bus = &spi_bus;
> +	strncpy( dev->name, name, sizeof(dev->name));
> +	strncpy( dev->dev.bus_id, name, sizeof( dev->dev.bus_id ) );

	strncpy(dev->dev.bus_id, name, sizeof(dev->dev.bus_id));


[snip]
> + * spi_queue
> + *
> + * Queue the message to be processed asynchronously
> + *
> + * Parameters:
> + *  	struct spi_msg* msg            message to be sent

 *  	struct spi_msg *msg            message to be sent


> + * Return value:
> + *  	0 on no errors, negative error code otherwise
> + */
> +int spi_queue( struct spi_msg *msg)

int spi_queue(struct spi_msg *msg)


> +{
> +	struct device* dev = &msg->device->dev;

	struct device *dev = &msg->device->dev;


> +	struct spi_bus_data *pd = dev->parent->platform_data;
> +
> +	down(&pd->lock);
> +	list_add_tail(&msg->link, &pd->msgs);
> +	dev_dbg(dev->parent, "message has been queued\n" );

	dev_dbg(dev->parent, "message has been queued\n");


[snip]
> + * __spi_transfer_callback
> + *
> + * callback for synchronously processed message. If spi_transfer determines
> + * that there is no callback provided neither by msg->status nor callback
> + * parameter, the __spi_transfer_callback will be used, and spi_transfer
> + * does not return until transfer is finished
> + *
> + * Parameters:
> + * 	struct spimsg* msg	message that is being processed now

 * 	struct spimsg *msg	message that is being processed now


> + * 	int code		status of processing
> + */
> +static void __spi_transfer_callback( struct spi_msg* msg, int code )

static void __spi_transfer_callback(struct spi_msg *msg, int code)



> +{
> +	if( code & (SPIMSG_OK|SPIMSG_FAILED) ) 
> +		complete( (struct completion*)msg->context );

	if (code & (SPIMSG_OK|SPIMSG_FAILED)) 
		complete((struct completion*)msg->context);

[snip]
> + * spi_transfer
> + *
> + * Process the SPI message, by queuing it to the driver and either
> + * immediately return or waiting till the end-of-processing
> + *
> + * Parameters:
> + * 	struct spi_msg* msg	message to process

 * 	struct spi_msg *msg	message to process


[snip]
> +int spi_transfer( struct spi_msg* msg, void (*callback)( struct spi_msg*, int ) )

int spi_transfer(struct spi_msg *msg, void (*callback)(struct spi_msg*, int))


> +{
> +	struct completion msg_done;
> +	int err = -EINVAL;
> +
> +	if( callback && !msg->status ) {

	if (callback && !msg->status) {


[snip]
> +	if( !callback ) {
> +		if( !msg->status ) {
> +			init_completion( &msg_done );
> +			msg->context = &msg_done;
> +			msg->status = __spi_transfer_callback;
> +			spi_queue( msg );
> +			wait_for_completion( &msg_done );
> +			err = 0;
> +		} else {
> +			err = spi_queue( msg );

	if (!callback) {
		if (!msg->status) {
			init_completion(&msg_done);
			msg->context = &msg_done;
			msg->status = __spi_transfer_callback;
			spi_queue(msg);
			wait_for_completion(&msg_done);
			err = 0;
		} else {
			err = spi_queue(msg);


[snip]
> + * spi_thread
> + * 
> + * This function is started as separate thread to perform actual 
> + * transfers on SPI bus
> + *
> + * Parameters:
> + *	void* context 		pointer to struct spi_bus_data 

 *	void *context 		pointer to struct spi_bus_data 


[snip]
> +	while (!kthread_should_stop()) {
> +
^^^^^ superfluous blank line.
> +		wait_event_interruptible(bd->queue, spi_thread_awake(bd));


[snip]
> +			if( bd->bus->set_clock && msg->clock )
> +				bd->bus->set_clock( 
> +					msg->device->dev.parent, msg->clock );
> +			xfer_status = bd->bus->xfer( msg );

			if (bd->bus->set_clock && msg->clock)
				bd->bus->set_clock(	<-- this line has trailing whitespace.
					msg->device->dev.parent, msg->clock);
			xfer_status = bd->bus->xfer(msg);



[snip]
> + * spi_write 
> + * 	send data to a device on an SPI bus
> + * Parameters:
> + * 	spi_device* dev		the target device
> + *	char* buf		buffer to be sent

 * 	spi_device *dev		the target device
 *	char *buf		buffer to be sent


[snip]
> +	ret = spi_transfer( msg, NULL );

	ret = spi_transfer(msg, NULL);


[snip]
> + * spi_write 
> + * 	receive data from a device on an SPI bus
> + * Parameters:
> + * 	spi_device* dev		the target device
> + *	char* buf		buffer to be sent

 * 	spi_device *dev		the target device
 *	char *buf		buffer to be sent


[snip]
> +int spi_read(struct spi_device *dev, char *buf, int len)
> +{
> +	int ret;
> +	struct spimsg *msg = spimsg_alloc(dev, SPI_M_RD, len, NULL);
> +
> +	ret = spi_transfer( msg, NULL );

	ret = spi_transfer(msg, NULL);


[snip]
> +int spi_bus_populate(struct device *parent,
> +		     char *devices,
> +		     void (*callback) (struct device * bus,
> +				       struct spi_device * new_dev))

int spi_bus_populate(struct device *parent,
		char *devices,
		void (*callback)(struct device *bus,
			struct spi_device *new_dev))



[snip]
> +	while (devices[0]) {
> +		dev_dbg(parent, "discovered new SPI device, name '%s'\n",
> +			devices);
> +		new_device = kmalloc(sizeof(struct spi_device), GFP_KERNEL);
> +		if (!new_device) {
> +			break;
> +		}
> +		if (spi_device_add(parent, new_device, devices)) {
> +			break;
> +		}
> +		if (callback) {
> +			callback(parent, new_device);
> +		}

		if (!new_device)
			break;
		if (spi_device_add(parent, new_device, devices))
			break;
		if (callback)
			callback(parent, new_device);

We usually don't use curly braces for if statements when the body of the if
is only a single statement.


[snip]
> +int __init spi_core_init( void )

int __init spi_core_init(void)

[snip]
> +++ linux-2.6.10/drivers/spi/spi-dev.c
[snip]
[snip]
> +#include <linux/init.h>
> +#include <asm/uaccess.h>
> +#include <linux/spi.h>

#include <linux/init.h>
#include <linux/spi.h>
#include <asm/uaccess.h>

conventionally, asm/ includes are placed last.


[snip]
> +static ssize_t spidev_read(struct file *file, char *buf, size_t count,
> +			   loff_t * offset);
> +static ssize_t spidev_write(struct file *file, const char *buf, size_t count,
> +			    loff_t * offset);

static ssize_t spidev_read(struct file *file, char *buf, size_t count,
		loff_t *offset);
static ssize_t spidev_write(struct file *file, const char *buf, size_t count,
		loff_t *offset);


[snip]
> +static int spidev_probe(struct device *dev)
> +{
> +	struct spidev_driver_data *drvdata;
> +
> +	drvdata = kmalloc(sizeof(struct spidev_driver_data), GFP_KERNEL);
> +	if ( !drvdata) {
> +		dev_dbg( dev, "allocating drvdata failed\n" );

	if (!drvdata) {
		dev_dbg(dev, "allocating drvdata failed\n");


[snip]
> +	dev_dbg( dev, " added\n" );

	dev_dbg(dev, " added\n");


[snip]
> +static int spidev_remove(struct device *dev)
> +{
> +	struct spidev_driver_data *drvdata;
> +
> +	drvdata = (struct spidev_driver_data *)dev_get_drvdata(dev);
> +	class_simple_device_remove(MKDEV(SPI_MAJOR, drvdata->minor));
> +	kfree(drvdata);
> +	dev_dbg( dev, " removed\n" );

	dev_dbg(dev, " removed\n");


[snip]
> +static ssize_t spidev_read(struct file *file, char *buf, size_t count,
> +			   loff_t * offset)

static ssize_t spidev_read(struct file *file, char *buf, size_t count,
		loff_t *offset)


> +{
> +	struct spi_device *dev = (struct spi_device *)file->private_data;
> +	if( count > SPI_TRANSFER_MAX ) count = SPI_TRANSFER_MAX;
> +	return spi_read(dev, buf, count );

	if (count > SPI_TRANSFER_MAX)
		count = SPI_TRANSFER_MAX;
	return spi_read(dev, buf, count);


[snip]
> +static ssize_t spidev_write(struct file *file, const char *buf, size_t count,
> +			    loff_t * offset)

static ssize_t spidev_write(struct file *file, const char *buf, size_t count,
		loff_t *offset)


> +{
> +	struct spi_device *dev = (struct spi_device *)file->private_data;
> +	if( count > SPI_TRANSFER_MAX ) count = SPI_TRANSFER_MAX;
> +	return spi_write( dev, buf, count );

	if (count > SPI_TRANSFER_MAX)
		count = SPI_TRANSFER_MAX;
	return spi_write(dev, buf, count);


[snip]
> +	if (NULL == drvdata) {

	if (drvdata == NULL) {

debatable, but I believe the most common style is what I changed it to.


[snip]
> +++ linux-2.6.10/include/linux/spi.h
[snip]
> +/*
> + *  linux/include/linux/spi/spi.h
> + *
> + *  Copyright (C) 2005 MontaVista Software, Inc <sources@mvista.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License.
> + *
> + * Derived from l3.h by Jamey Hicks
> + */
+
> +#ifndef SPI_H

Blank line between end of comment and start of code at the top of file seems
to be most common.


[snip]
> +struct spi_bus_data
> +{
> +	struct semaphore lock;
> +	struct list_head msgs;
> +	atomic_t exiting;
> +	struct task_struct* thread;
> +	wait_queue_head_t queue; 
> +	struct spi_device* selected_device;
> +	struct spi_bus_driver* bus;

	struct task_struct *thread;
	wait_queue_head_t queue; 
	struct spi_device *selected_device;
	struct spi_bus_driver *bus;


[snip]
> +#define TO_SPI_BUS_DRIVER(drv) container_of( drv, struct spi_bus_driver, driver )

#define TO_SPI_BUS_DRIVER(drv) container_of(drv, struct spi_bus_driver, driver)


> +struct spi_bus_driver
> +{
> +	int (*xfer)( struct spi_msg* msg );
> +	void (*select)( struct spi_device* dev );
> +	void (*deselect)( struct spi_device* dev );
> +	void (*set_clock)( struct device* bus_device, u32 clock_hz );
> +	struct device_driver driver;

	int (*xfer)(struct spi_msg *msg);
	void (*select)(struct spi_device *dev);
	void (*deselect)(struct spi_device *dev);
	void (*set_clock)(struct device *bus_device, u32 clock_hz);


[snip]
> +#define TO_SPI_DEV(device) container_of( device, struct spi_device, dev )

#define TO_SPI_DEV(device) container_of(device, struct spi_device, dev)


> +struct spi_device 
> +{
> +	char name[ BUS_ID_SIZE ];

	char name[BUS_ID_SIZE];


[snip]
> +#define TO_SPI_DRIVER(drv) container_of( drv, struct spi_driver, driver )

#define TO_SPI_DRIVER(drv) container_of(drv, struct spi_driver, driver)


> +struct spi_driver {
> +    	void* (*alloc)( size_t, int );
> +    	void  (*free)( const void* );
> +    	unsigned char* (*get_buffer)( struct spi_device*, void* );
> +    	void (*release_buffer)( struct spi_device*, unsigned char*);
> +    	void (*control)( struct spi_device*, int mode, u32 ctl );

struct spi_driver {
    	void *(*alloc)(size_t, int);
    	void (*free)(const void *);
    	unsigned char *(*get_buffer)(struct spi_device *, void *);
    	void (*release_buffer)(struct spi_device *, unsigned char *);
    	void (*control)(struct spi_device *, int mode, u32 ctl);


[snip]
> +#define SPI_DEV_DRV( device )  TO_SPI_DRIVER( (device)->dev.driver )

#define SPI_DEV_DRV(device) TO_SPI_DRIVER((device)->dev.driver)

> +
> +#define spi_device_lock( dev ) /* down( dev->dev.sem ) */
> +#define spi_device_unlock( dev ) /* up( dev->dev.sem ) */

#define spi_device_lock(dev) /* down(dev->dev.sem) */
#define spi_device_unlock(dev) /* up(dev->dev.sem) */



> +/*
> + * struct spi_msg
> + *
> + * This structure represent the SPI message internally. You should never use fields of this structure directly
> + * Please use corresponding functions to create/destroy/access fields

 * This structure represent the SPI message internally.
 * You should never use fields of this structure directly.
 * Please use corresponding functions to create/destroy/access fields


[snip]
> +struct spi_msg {
> +	unsigned char flags;
> +#define SPI_M_RD	0x01
> +#define SPI_M_WR	0x02	/**< Write mode flag */
> +#define SPI_M_CSREL	0x04	/**< CS release level at end of the frame  */
> +#define SPI_M_CS	0x08	/**< CS active level at begining of frame ( default low ) */
> +#define SPI_M_CPOL	0x10	/**< Clock polarity */
> +#define SPI_M_CPHA	0x20	/**< Clock Phase */
> +	unsigned short len;	/* msg length           */
> +	unsigned long clock;
> +	struct spi_device* device;
> +	void	      *context;
> +	struct list_head link; 
> +	void (*status)( struct spi_msg* msg, int code );

#define SPI_M_WR	0x02	/* Write mode flag */
#define SPI_M_CSREL	0x04	/* CS release level at end of the frame */
#define SPI_M_CS	0x08	/* CS active level at begining of frame (default low) */
#define SPI_M_CPOL	0x10	/* Clock polarity */
#define SPI_M_CPHA	0x20	/* Clock Phase */
	unsigned short len;	/* msg length */
	unsigned long clock;
	struct spi_device *device;
	void *context;
	struct list_head link; 
	void (*status)(struct spi_msg *msg, int code);


[snip]
> +static inline struct spi_msg* spimsg_alloc( struct spi_device* device, 
> +					    unsigned flags,
> +					    unsigned short len, 
> +					    void (*status)( struct spi_msg*, int code ) )

static inline struct spi_msg* spimsg_alloc( struct spi_device* device, 
		unsigned flags, unsigned short len,
		void (*status)(struct spi_msg *, int code))

> +{
> +    struct spi_msg* msg;
> +    struct spi_driver* drv = SPI_DEV_DRV( device );
> +    
> +    msg = kmalloc( sizeof( struct spi_msg ), GFP_KERNEL );
> +    if( !msg )
> +	return NULL;
> +    memset( msg, 0, sizeof( struct spi_msg ) );

    struct spi_msg *msg;
    struct spi_driver *drv = SPI_DEV_DRV(device);
    
    msg = kmalloc(sizeof(struct spi_msg), GFP_KERNEL);
    if (!msg)
	return NULL;
    memset(msg, 0, sizeof(struct spi_msg));

In addition to the spacing changes you also seem to be using spaces for 
indentation here instead of tabs. Please use only tabs for indentation - this 
is true for other locations in the file as well, but I'm only mentioning it 
once here.


[snip]
> +    INIT_LIST_HEAD( &msg->link );
> +    if( flags & SPI_M_RD ) {
> +        msg->devbuf_rd =  drv->alloc ? 
> +	    drv->alloc( len, GFP_KERNEL ):kmalloc( len, GFP_KERNEL);
> +	msg->databuf_rd = drv->get_buffer ? 
> +	    drv->get_buffer( device, msg->devbuf_rd ) : msg->devbuf_rd;
> +    }

    INIT_LIST_HEAD(&msg->link);
    if (flags & SPI_M_RD) {
        msg->devbuf_rd =  drv->alloc ? 
	    drv->alloc(len, GFP_KERNEL) : kmalloc(len, GFP_KERNEL);
	msg->databuf_rd = drv->get_buffer ? 
	    drv->get_buffer(device, msg->devbuf_rd) : msg->devbuf_rd;
    }


> +    if( flags & SPI_M_WR ) {
> +        msg->devbuf_wr =  drv->alloc ? 
> +	    drv->alloc( len, GFP_KERNEL ):kmalloc( len, GFP_KERNEL);
> +	msg->databuf_wr = drv->get_buffer ? 
> +	    drv->get_buffer( device, msg->devbuf_wr ) : msg->devbuf_wr;
> +    }

	if (flags & SPI_M_WR) {
		msg->devbuf_wr =  drv->alloc ? 
			drv->alloc(len, GFP_KERNEL) :
				kmalloc(len, GFP_KERNEL);
		msg->databuf_wr = drv->get_buffer ? 
			drv->get_buffer(device, msg->devbuf_wr) :
				msg->devbuf_wr;
    }


> +    pr_debug( "%s: msg = %p, RD=(%p,%p) WR=(%p,%p). Actual flags = %s+%s\n",
> +		   __FUNCTION__,
> +		  msg, 
> +		  msg->devbuf_rd, msg->databuf_rd,
> +		  msg->devbuf_wr, msg->databuf_wr, 
> +		  msg->flags & SPI_M_RD ? "RD" : "~rd",
> +		  msg->flags & SPI_M_WR ? "WR" : "~wr" );

pr_debug("%s: msg = %p, RD=(%p,%p) WR=(%p,%p). Actual flags = %s+%s\n",
	__FUNCTION__,
	msg, 
	msg->devbuf_rd, msg->databuf_rd,
	msg->devbuf_wr, msg->databuf_wr, 
	msg->flags & SPI_M_RD ? "RD" : "~rd",
	msg->flags & SPI_M_WR ? "WR" : "~wr");


[snip]
> +static inline void spimsg_free( struct spi_msg * msg )
> +{
> +    void (*do_free)( const void* ) = kfree;
> +    struct spi_driver* drv = SPI_DEV_DRV( msg->device );

static inline void spimsg_free(struct spi_msg *msg)
{
	void (*do_free)(const void *) = kfree;
	struct spi_driver *drv = SPI_DEV_DRV(msg->device);

> +    
> +    if( msg ) {
> +	    if( drv->free ) 
> +		do_free = drv->free;
> +	    if( drv->release_buffer ) {
> +		if( msg->databuf_rd) 
> +		    drv->release_buffer( msg->device, msg->databuf_rd );
> +    		if( msg->databuf_wr) 
> +		    drv->release_buffer( msg->device, msg->databuf_wr );
> +	}
> +	if( msg->devbuf_rd ) 
> +	    do_free( msg->devbuf_rd );
> +	if( msg->devbuf_wr)
> +	    do_free( msg->devbuf_wr );
> +	kfree( msg );
> +    }

	if (msg) {
		if (drv->free) 
			do_free = drv->free;
		if (drv->release_buffer) {
			if (msg->databuf_rd) 
				drv->release_buffer(msg->device, msg->databuf_rd);
			if (msg->databuf_wr) 
				drv->release_buffer( msg->device, msg->databuf_wr);
		}
		if (msg->devbuf_rd) 
			do_free( msg->devbuf_rd);
		if (msg->devbuf_wr)
			do_free( msg->devbuf_wr);
		kfree(msg);
	}




[snip]
> +static inline u8* spimsg_buffer_rd( struct spi_msg* msg ) 

static inline u8 *spimsg_buffer_rd(struct spi_msg *msg) 


[snip]
> +static inline u8* spimsg_buffer_wr( struct spi_msg* msg ) 

static inline u8 *spimsg_buffer_wr(struct spi_msg *msg) 


[snip]
> +static inline u8* spimsg_buffer( struct spi_msg* msg ) 
> +{
> +    if( !msg ) return NULL;
> +    if( ( msg->flags & (SPI_M_RD|SPI_M_WR) ) == (SPI_M_RD|SPI_M_WR) ) {
> +	printk( KERN_ERR"%s: what buffer do you really want ?\n", __FUNCTION__ );
> +	return NULL;
> +    }
> +    if( msg->flags & SPI_M_RD) return msg->databuf_rd;
> +    if( msg->flags & SPI_M_WR) return msg->databuf_wr;
> +}

static inline u8 *spimsg_buffer(struct spi_msg* msg)
{
	if (!msg)
		return NULL;
	if ((msg->flags & (SPI_M_RD|SPI_M_WR)) == (SPI_M_RD|SPI_M_WR)) {
		printk(KERN_ERR "%s: what buffer do you really want ?\n",
			__FUNCTION__ );
		return NULL;
	}
	if (msg->flags & SPI_M_RD)
		return msg->databuf_rd;
	if (msg->flags & SPI_M_WR)
		return msg->databuf_wr;
}


> +
> +#define SPIMSG_OK 	0x01
> +#define SPIMSG_FAILED 	0x80
> +#define SPIMSG_STARTED  0x02 
> +#define SPIMSG_DONE	0x04
> +
> +#define SPI_MAJOR	98

#define SPIMSG_OK	0x01
#define SPIMSG_FAILED	0x80
#define SPIMSG_STARTED	0x02 
#define SPIMSG_DONE	0x04

#define SPI_MAJOR	98

It may not be obvious what change I made here, so I'll tell you. You were
mixing spaces and tabs between the defined named and the value, I've changed
it to only use a single tab (it still lines up nicely).

[snip]
> +static inline int spi_bus_driver_register( struct spi_bus_driver* bus_driver )
> +{
> +	return driver_register( &bus_driver->driver );
> +}

static inline int spi_bus_driver_register(struct spi_bus_driver *bus_driver)
{
	return driver_register(&bus_driver->driver);
}

> +
> +void spi_bus_driver_unregister( struct spi_bus_driver* );
> +int spi_bus_driver_init( struct spi_bus_driver* driver, struct device* dev );
> +int spi_device_add( struct device* parent, struct spi_device*, char* name );

void spi_bus_driver_unregister(struct spi_bus_driver *);
int spi_bus_driver_init(struct spi_bus_driver * driver, struct device *dev);
int spi_device_add(struct device *parent, struct spi_device *, char *name);


> +static inline void spi_device_del( struct spi_device* dev )
> +{
> +	device_unregister( &dev->dev );
> +}

static inline void spi_device_del(struct spi_device *dev)
{
	device_unregister(&dev->dev);
}

> +static inline int spi_driver_add( struct spi_driver* drv ) 
> +{
> +	return driver_register( &drv->driver );
> +}

static inline int spi_driver_add(struct spi_driver *drv) 
{
	return driver_register(&drv->driver);
}

> +static inline void spi_driver_del( struct spi_driver* drv ) 
> +{
> +	driver_unregister( &drv->driver );
> +}

static inline void spi_driver_del(struct spi_driver *drv)
{
	driver_unregister(&drv->driver);
}


[snip]
> +extern int spi_queue( struct spi_msg* message );
> +extern int spi_transfer( struct spi_msg* message, void (*status)( struct spi_msg*, int ) );
> +extern int spi_bus_populate( struct device* parent, char* device, void (*assign)( struct device* parent, struct spi_device* ) );

extern int spi_queue(struct spi_msg* message);
extern int spi_transfer(struct spi_msg *message,
		void (*status)(struct spi_msg *, int));
extern int spi_bus_populate(struct device *parent, char *device,
		void (*assign)(struct device *parent, struct spi_device *));

> +
> +#endif				/* SPI_H */

#endif	/* SPI_H */



-- 
Jesper Juhl <jesper.juhl@gmail.com>



