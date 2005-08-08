Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750874AbVHHNQ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750874AbVHHNQ7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 09:16:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750876AbVHHNQ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 09:16:58 -0400
Received: from web30307.mail.mud.yahoo.com ([68.142.200.100]:22169 "HELO
	web30307.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750874AbVHHNQ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 09:16:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=eZ/ao3UvD1Hc2oZIWLAh0g5Hy/ildEHJ2EA+8M4GOilDooGhH2mc7Mn4qD/C5mHS3UV0Zfdb43BMGL9yerOxCJw1Ck2Zp924THxVbMXO7b2Wol3NwGkNNmG0uC6elZnT7RdSY7HCjTpGYwnYjHe/SmqzWRnnjhgmhKQpCLSZMN8=  ;
Message-ID: <20050808131655.22499.qmail@web30307.mail.mud.yahoo.com>
Date: Mon, 8 Aug 2005 14:16:54 +0100 (BST)
From: Mark Underwood <basicmark@yahoo.com>
Subject: Re: [PATCH] spi
To: dmitry pervushin <dpervushin@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1123492338.4762.96.camel@diimka.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- dmitry pervushin <dpervushin@gmail.com> wrote:

> Hello all, 
> 
> 
> Here is the spi core patch (slightly redesigned
> again). Now it operates
> with three abstractions:
> a) the spi bus, which is registered in system and is
> resposible for
> general things like registering devices on it,
> handling PM events for
> entire bus, providing bus-wide operations;
> b) the spi device, which is responsible for
> interactions between the
> device and the bus (selecting/deselecting device)
> and PM events for the
> specifi device;
> c) the driver, which is attached to spi devices and
> (possibly) provide
> interface to the upper level like block device
> interface. The spi-dev is
> the good starting point for people who does not want
> anything but simple
> character device access.
> The new abstraction is the spi bus, which
> functionality was represented
> by spi_device structure.
> 
> Especially for Greg K-H: yes, I ran this code
> through sparse :), thank
> you.
> 

Please can we have an example client driver as it
would aid understanding :-). But in the mean time.

-= snip =-

+/**
+ * spi_add_adapter - register a new SPI bus adapter
+ * @spidev: spi_device structure for the registering
adapter
+ *
+ * Make the adapter available for use by clients
using name 
adap->name.
+ * The adap->adapters list is initialised by this
function.
+ *
+ * Returns error code ( 0 on success ) ;
+ */
+struct spi_bus* spi_bus_find( char* id )
+{
+	struct bus_type* the_bus = find_bus( id );
+
+	return the_bus ? container_of( the_bus, struct
spi_bus, the_bus ) : 
NULL;
+}

Eh? The comment is for spi_add_adapter but the
function is spi_bus_find! Where is spi_add_adapter?

-= snip =-


+/**
+ * spi_del_adapter - unregister a SPI bus adapter
+ * @dev: spi_device structure to unregister
+ *
+ * Remove an adapter from the list of available SPI
Bus adapters.
+ *
+ * Returns error code (0 on success);
+ */
+
+void spi_device_del(struct spi_device *dev)
+{
+	device_unregister(&dev->dev);
+}

Eh? The comment is for spi_del_adapter but the
function is spi_device_del! Where is spi_del_adapter?

-= snip =-

+/**
+ * spi_transfer - transfer information on an SPI bus
+ * @adap: adapter structure to perform transfer on
+ * @msgs: array of spi_msg structures describing
transfer
+ * @num: number of spi_msg structures
+ *
+ * Transfer the specified messages to/from a device
on the SPI bus.
+ *
+ * Returns number of messages successfully
transferred, otherwise 
negative
+ * error code.
+ */
+int spi_transfer(struct spi_device *dev, struct
spi_msg msgs[], int 
num)
+{
+	int ret = -ENOSYS;
+	struct spi_bus* bus;
+
+	bus = TO_SPI_BUS( dev->dev.bus );
+
+	if (bus->xfer) {
+		down( &dev->lock );
+		ret = bus->xfer(bus, dev, msgs, num, 0);
+		up(&dev->lock);
+	}
+	return ret;
+}

Surely this should be locked with bus lock?

-= snip =-

Some other comments:
1) I think you need to fix some of your comments
especially those describing how the interfaces work.
2) I take it spi adaptor drivers now use
spi_bus_register/spi_bus_unregister?
3) Different clients on one bus will want to run at
different speeds, how will you handle this?
3) This subsystem can only handle small transfers like
I2C. SPI peripherals like SPI Ethernet devices will
have to do lots of large transfers and with your
current subsystem the device will be forced to wait
until its transfer has finished (as well as other
clients) when it might have other important work to
do.

Best Regards,

Mark


	
	
		
___________________________________________________________ 
Yahoo! Messenger - NEW crystal clear PC to PC calling worldwide with voicemail http://uk.messenger.yahoo.com
