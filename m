Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265574AbUEUOtL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265574AbUEUOtL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 10:49:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265875AbUEUOtK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 10:49:10 -0400
Received: from [141.156.69.115] ([141.156.69.115]:26278 "EHLO
	mail.infosciences.com") by vger.kernel.org with ESMTP
	id S265574AbUEUOsz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 10:48:55 -0400
Message-ID: <40AE16D6.3070202@infosciences.com>
Date: Fri, 21 May 2004 10:48:54 -0400
From: nardelli <jnardelli@infosciences.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] [PATCH] visor: Fix Oops on disconnect
References: <40AD3A88.2000002@infosciences.com> <20040521043032.GA31113@kroah.com>
In-Reply-To: <20040521043032.GA31113@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Thu, May 20, 2004 at 07:08:56PM -0400, nardelli wrote:
> 
>>Here is a proposed patch for Oops on disconnect in the visor module.
>>For details of the problem, please see
>>http://bugzilla.kernel.org/show_bug.cgi?id=2289
>>
>>I would really appreciate it if anyone that uses this module could please
>>try this patch to make sure that it works as intended.  Also, as this is
>>the first patch that I've submitted, please feel free to be brutally
>>honest regarding content, formatting, etc.
> 
> 
> Ok, I'll be brutal, but remember, you asked :)
> 
> First off, read Documentation/SubmittingPatches and
> Documentation/CodingStyle to see the proper way to make patches, and how
> to format the code.
> 

I'll reformat/regenerate patch.

> 
>>--- old/linux-2.6.6/drivers/usb/serial/visor.c	2004-05-09 22:32:27.000000000 -0400
>>+++ new/linux-2.6.6/drivers/usb/serial/visor.c	2004-05-20 18:04:24.000000000 -0400
> 
> 
> I need to be able to apply this patch by using a -p1 in the kernel
> directory.  So the patch should be one directory up and look like:
> 
> --- linux-2.6.6/drivers/usb/serial/visor.c	2004-05-09 22:32:27.000000000 -0400
> +++ linux-2.6.6/drivers/usb/serial/visor.c	2004-05-20 18:04:24.000000000 -0400
> 
> 

I'll regenerate patch.

> 
>>@@ -12,6 +12,13 @@
>>  *
>>  * See Documentation/usb/usb-serial.txt for more information on using this driver
>>  *
>>+ * (5/20/2004) Joe Nardelli
>>+ *	Reduced possibility for unitialized data access in palm_os_3_probe.
>>+ *	Modified workaround for treo endpoint setup in treo_attach.
>>+ *	Removed assumptions that port->read_urb was always valid (is not true
>>+ *	for usb serial devices with more bulk out or interrupt endpoints than
>>+ *	bulk in endpoints).
> 
> 
> I'm trying not to add new stuff to the changelog at the beginning of the
> file, but this is not really a big deal.
> 
> 

It did seem like the change log was a little old :-).  The comments are at
bugzilla any way.  I'll remove it.


>>-	if (!port->read_urb) {
>>+	if ((serial->dev->descriptor.idVendor != SONY_VENDOR_ID && !port->read_urb))
>>+	{
> 
> 
> Wrong formatting style for the '{'
> 

Will reformat.

> Your patch says that we might not have a read_urb for the given port?
> How could that be true?  The check here in open() will catch any devices
> that this might not be correct for.  So that portion of this patch is
> not needed, right?
> 
> 

The patch should be happy to let devices thru visor_open with no read_urb,
except for Sonys.

The old check would error out of visor_open() with -ENODEV if there was
not a read_urb for any device, and there was a comment that this was
needed for 'some brain dead Sony devices'.  I modified this to error out
only for Sony devices, instead of just a comment about them.  This
should not modify the behavior on Sonys, but may on others (namely treos).

I'd really like to know more about why some Sony devices do not have a
read_urb, but at least for now, I did not change functionality for them.

>> static int palm_os_3_probe (struct usb_serial *serial, const struct usb_device_id *id)
>>@@ -710,6 +728,13 @@
>> 		return -ENOMEM;
>> 	}
>> 
>>+	/*
>>+	* We don't know how much data gets written into transfer_buffer, so let's
>>+	* at least set it all to 0 to avoid putting random data into num_ports
>>+	* (which causes unitialized, and possibly unallocated data to be accessed)
>>+	*/
>>+	memset (transfer_buffer, 0, sizeof(*connection_info));
> 
> 
> Um, we ask for a set ammount of data, and we should get it.  But we
> should check the size of the data returned to make sure of this, right?
> 
> 

The data being returned had unitialzed data in it.  Before doing a memset, I
almost always had 23130 ports, but that changed upon kernel build.  This
resulted in trying to access ALOT of bad memory.  After adding a memset,
no random data was showing up.  If this were outside of the kernel, I suspect
that would have resulted in a segmentation violation.

The api for usb_control_msg says, 'If successful, it returns 0, othwise a
negative error number', and I didn't see any other way to figure out how
much data was being returned.

I would definitely prefer to do a check on the amount of data being returned.
Any suggestions?

>> 	/* send a get connection info request */
>> 	retval = usb_control_msg (serial->dev,
>> 				  usb_rcvctrlpipe(serial->dev, 0),
>>@@ -726,11 +751,20 @@
>> 
>> 	le16_to_cpus(&connection_info->num_ports);
>> 	num_ports = connection_info->num_ports;
>>-	/* handle devices that report invalid stuff here */
>>-	if (num_ports > 2)
>>+	/*
>>+	* Handle devices that report invalid stuff here.  I think that this will
>>+	* work for both big and little endian architectures that do not report
>>+	* back valid connect info, but I'd still like to verify this on a big
>>+	* endian machine.  Any testers?
>>+	*/
> 
> 
> The call above to le16_to_cpus() will handle the endian issue here.
> This comment can be removed.
> 
> 

I'll drop it.

>>+	if (num_ports <= 0 || num_ports > 2) {
> 
> 
> I like the idea of this check, but you are trying to test for a negative
> value on a __u16 variable, which is always unsigned.  So that check will
> never be true :)
> 
> 

I just noticed that num_ports is defined as an int in palm_os_3_probe(), and
as __u16 in visor.c.  Would you like me to set the one in palm_os_3_probe()
to a __u16?

Either way, I'll change it to look for (num_ports == 0 || num_ports > 2).
With no conection data being returned for treos, it should report 0 ports.

>>+		dev_warn (dev, "%s: No valid connect info available\n",
>>+			serial->type->name);
>> 		num_ports = 2;
>>+	}
>>+  
>> 	dev_info(dev, "%s: Number of ports: %d\n", serial->type->name,
>>-		connection_info->num_ports);
>>+		num_ports);
>> 
>> 	for (i = 0; i < num_ports; ++i) {
>> 		switch (connection_info->connections[i].port_function_id) {
>>@@ -887,8 +921,7 @@
>>  
>> static int treo_attach (struct usb_serial *serial)
>> {
>>-	struct usb_serial_port *port;
>>-	int i;
>>+	struct usb_serial_port swap_port;
>> 
>> 	/* Only do this endpoint hack for the Handspring devices with
>> 	 * interrupt in endpoints, which for now are the Treo devices. */
>>@@ -898,31 +931,32 @@
>> 
>> 	dbg("%s", __FUNCTION__);
>> 
>>-	/* Ok, this is pretty ugly, but these devices want to use the
>>-	 * interrupt endpoint as paired up with a bulk endpoint for a
>>-	 * "virtual serial port".  So let's force the endpoints to be
>>-	 * where we want them to be. */
>>-	for (i = serial->num_bulk_in; i < serial->num_ports; ++i) {
>>-		port = serial->port[i];
>>-		port->read_urb = serial->port[0]->read_urb;
>>-		port->bulk_in_endpointAddress = serial->port[0]->bulk_in_endpointAddress;
>>-		port->bulk_in_buffer = serial->port[0]->bulk_in_buffer;
>>-	}
>>-
>>-	for (i = serial->num_bulk_out; i < serial->num_ports; ++i) {
>>-		port = serial->port[i];
>>-		port->write_urb = serial->port[0]->write_urb;
>>-		port->bulk_out_size = serial->port[0]->bulk_out_size;
>>-		port->bulk_out_endpointAddress = serial->port[0]->bulk_out_endpointAddress;
>>-		port->bulk_out_buffer = serial->port[0]->bulk_out_buffer;
>>-	}
>>-
>>-	for (i = serial->num_interrupt_in; i < serial->num_ports; ++i) {
>>-		port = serial->port[i];
>>-		port->interrupt_in_urb = serial->port[0]->interrupt_in_urb;
>>-		port->interrupt_in_endpointAddress = serial->port[0]->interrupt_in_endpointAddress;
>>-		port->interrupt_in_buffer = serial->port[0]->interrupt_in_buffer;
>>-	}
>>+	/*
>>+	* It appears that Treos want to use the 1st interrupt endpoint to communicate
>>+	* with the 2nd bulk out endpoint, so let's swap the 1st and 2nd bulk in
>>+	* and interrupt endpoints.  Note that swapping the bulk out endpoints would
>>+	* break lots of apps that want to communicate on the second port.
>>+	*/
>>+	swap_port.read_urb = serial->port[0]->read_urb;
>>+	swap_port.bulk_in_endpointAddress = serial->port[0]->bulk_in_endpointAddress;
>>+	swap_port.bulk_in_buffer = serial->port[0]->bulk_in_buffer;
>>+	swap_port.interrupt_in_urb = serial->port[0]->interrupt_in_urb;
>>+	swap_port.interrupt_in_endpointAddress = serial->port[0]->interrupt_in_endpointAddress;
>>+	swap_port.interrupt_in_buffer = serial->port[0]->interrupt_in_buffer;
>>+ 
>>+	serial->port[0]->read_urb = serial->port[1]->read_urb;
>>+	serial->port[0]->bulk_in_endpointAddress = serial->port[1]->bulk_in_endpointAddress;
>>+	serial->port[0]->bulk_in_buffer = serial->port[1]->bulk_in_buffer;
>>+	serial->port[0]->interrupt_in_urb = serial->port[1]->interrupt_in_urb;
>>+	serial->port[0]->interrupt_in_endpointAddress = serial->port[1]->interrupt_in_endpointAddress;
>>+	serial->port[0]->interrupt_in_buffer = serial->port[1]->interrupt_in_buffer;
>>+
>>+	serial->port[1]->read_urb = swap_port.read_urb;
>>+	serial->port[1]->bulk_in_endpointAddress = swap_port.bulk_in_endpointAddress;
>>+	serial->port[1]->bulk_in_buffer = swap_port.bulk_in_buffer;
>>+	serial->port[1]->interrupt_in_urb = swap_port.interrupt_in_urb;
>>+	serial->port[1]->interrupt_in_endpointAddress = swap_port.interrupt_in_endpointAddress;
>>+	serial->port[1]->interrupt_in_buffer = swap_port.interrupt_in_buffer;
> 
> 
> Now this is the meat of the patch.  Is that all that is needed, just
> swaping the info?  That makes more sense than the hack of assigning the
> same port data to both ports.  Does this work properly on disconnect
> too?
> 

That and the memset are the meat of the patch.  Pretty simple, but it took
alot of coming up to speed on usb to try and interpret the output of usbsnoop.
There was some communication on the second (as reported by the device) bulk
out endpoint, but I couldn't figure out what that was doing.  I suspect that
some treo protocol specs would help with that, but I still haven't found any.

After more than 30 backups with jpilot, about 5 listings with pilot-xfer, and
about 5 where I disconnected the device in the middle of a transfer, I have yet
to encounter a problem.  I'd appreciate it others would test this patch after
I've made the changes described above.

> Thanks a lot for doing this, with some cleanups I'll be glad to accept
> this patch.
> 
> thanks,
> 
> greg k-h
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by: Oracle 10g
> Get certified on the hottest thing ever to hit the market... Oracle 10g. 
> Take an Oracle 10g class now, and we'll give you the exam FREE.
> http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
> _______________________________________________
> linux-usb-devel@lists.sourceforge.net
> To unsubscribe, use the last form field at:
> https://lists.sourceforge.net/lists/listinfo/linux-usb-devel
> 


-- 
Joe Nardelli
jnardelli@infosciences.com
