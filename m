Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261452AbTCYEY1>; Mon, 24 Mar 2003 23:24:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261449AbTCYEY0>; Mon, 24 Mar 2003 23:24:26 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:54032 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261447AbTCYEYT>;
	Mon, 24 Mar 2003 23:24:19 -0500
Date: Mon, 24 Mar 2003 20:34:54 -0800
From: Greg KH <greg@kroah.com>
To: CaT <cat@zip.com.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.66
Message-ID: <20030325043454.GJ11874@kroah.com>
References: <Pine.LNX.4.44.0303241524050.1741-100000@penguin.transmeta.com> <20030325012252.7aafee8c.us15@os.inf.tu-dresden.de> <20030325003048.GC10505@kroah.com> <20030325041802.GA535@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030325041802.GA535@zip.com.au>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 25, 2003 at 03:18:03PM +1100, CaT wrote:
> On Mon, Mar 24, 2003 at 04:30:48PM -0800, Greg KH wrote:
> > Yes, I sent out some patches a few evenings ago to lkml that should fix
> > this problem.  I'm resyncing them with 2.5.66 right now and will send
> > them to Linus in a bit.
> 
> I have an oops of my very own to report, and this one is with the afore
> mentioned patches applied:
> 
> mice: PS/2 mouse device common for all mice
> logimb.c: Didn't find Logitech busmouse at 0x23c
> input: PC Speaker
> input: PS/2 Synaptics Touchpad on isa0060/serio1
> serio: i8042 AUX port at 0x60,0x64 irq 12
> input: AT Set 2 keyboard on isa0060/serio0
> serio: i8042 KBD port at 0x60,0x64 irq 1
> i2c-dev.o: i2c /dev entries driver module version 2.7.0 (20021208)
> i2c-proc.o version 2.7.0 (20021208)
> i2c-pixx4 version 2.7.0 (20021208)
> piix4 smbus 00.07.3: Found Intel Corp. 82371AB/EM/MB PIIX4  device
> Unable to handle kernel NULL pointer dereference at vertual address 00000000

Do you have the patches I just sent out a few hours ago?
You will need the last one, I've attached it here.  Let me know if it
fixes this or not.

thanks,

greg k-h


ChangeSet 1.985.1.4, 2003/03/24 15:16:12-08:00, greg@kroah.com

[PATCH] i2c: set up a "generic" i2c driver to prevent oopses when devices are registering.

This is needed as we are still not using the driver core model for
matching up devices to drivers, but doing it by hand.  Once that is
changed, this will not be needed.


 drivers/i2c/i2c-core.c |    9 +++++++++
 1 files changed, 9 insertions(+)


diff -Nru a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
--- a/drivers/i2c/i2c-core.c	Mon Mar 24 17:26:51 2003
+++ b/drivers/i2c/i2c-core.c	Mon Mar 24 17:26:51 2003
@@ -65,6 +65,14 @@
 	return 0;
 }
 
+static struct device_driver i2c_generic_driver = {
+	.name =	"i2c",
+	.bus = &i2c_bus_type,
+	.probe = i2c_device_probe,
+	.remove = i2c_device_remove,
+};
+
+
 /* ---------------------------------------------------
  * registering functions 
  * --------------------------------------------------- 
@@ -106,6 +114,7 @@
 	if (adap->dev.parent == NULL)
 		adap->dev.parent = &legacy_bus;
 	sprintf(adap->dev.bus_id, "i2c-%d", i);
+	adap->dev.driver = &i2c_generic_driver;
 	device_register(&adap->dev);
 
 	/* inform drivers of new adapters */
