Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030230AbVHPQiF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030230AbVHPQiF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 12:38:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030232AbVHPQiE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 12:38:04 -0400
Received: from smtp-102-tuesday.nerim.net ([62.4.16.102]:20753 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S1030229AbVHPQiB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 12:38:01 -0400
Date: Tue, 16 Aug 2005 18:38:39 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Nathan Lutchansky <lutchann@litech.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <lm-sensors@lm-sensors.org>, Greg KH <greg@kroah.com>
Subject: Re: [PATCH 4/5] add i2c_probe_device and i2c_remove_device
Message-Id: <20050816183839.0eda95e3.khali@linux-fr.org>
In-Reply-To: <20050816033353.GI24959@litech.org>
References: <20050815175106.GA24959@litech.org>
	<20050815175438.GE24959@litech.org>
	<20050816001413.50b9c6be.khali@linux-fr.org>
	<20050816033353.GI24959@litech.org>
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nathan,

> > Do you know of any adapter actually not supporting the SMBus Quick
> > command (which we use for probing)?
> 
> I do, in fact, which is the reason I submitted these patches in the
> first place.  :-)
> 
> The WIS GO7007, which is the MPEG1/2/4 video encoder used in the
> Plextor ConvertX, has an on-board i2c interface that supports nothing
> but 8-bit and 16-bit register reads and writes.

Do you mean that it supports SMBus Read Byte but not SMBus Receive Byte?

I'm asking because, as said in a previous post, I am considering using
SMBus Receive Byte as an alternative to SMBus Quick for bus probing
where SMBus Quick is either unavailable or unsafe.

> Worse, it does not correctly report i2c errors.

Can you elaborate on this?

>  Even if it did support probing, though, I wouldn't want to use it
> because the i2c adapter generally lives on the other end of a USB and
> requires a minimum of 15 USB round trips per i2c transaction, so
> probing 124 i2c addresses would take a while.

Why would it probe 124 addresses? Even in the current model this
wouldn't happen. For every given driver, only listed addresses are
probed. This is rarely more than 8 addresses. But still, the point is
valid, if we do know what chips are on a given bus and at what
addresses, probing could be skipped.

BTW, I'me just noticing that my reimplementation of i2c_probe() could be
improved. It currently exists if SMBus Quick cannot be used. However,
now that forced addresses are done first, this test could be moved until
forced addresses have been processed:

 drivers/i2c/i2c-core.c |   15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

--- linux-2.6.13-rc6.orig/drivers/i2c/i2c-core.c	2005-08-16 17:12:33.000000000 +0200
+++ linux-2.6.13-rc6/drivers/i2c/i2c-core.c	2005-08-16 17:29:13.000000000 +0200
@@ -706,10 +706,6 @@
 	int i, err;
 	int adap_id = i2c_adapter_id(adapter);
 
-	/* Forget it if we can't probe using SMBUS_QUICK */
-	if (! i2c_check_functionality(adapter,I2C_FUNC_SMBUS_QUICK))
-		return -1;
-
 	/* Force entries are done first, and are not affected by ignore
 	   entries */
 	if (address_data->forces) {
@@ -736,6 +732,17 @@
 		}
 	}
 
+	/* Stop here if we can't use SMBUS_QUICK */
+	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_QUICK)) {
+		if (address_data->probe[0] == I2C_CLIENT_END
+		 && address_data->normal_i2c[0] == I2C_CLIENT_END)
+		 	return 0;
+
+		dev_warn(&adapter->dev, "SMBus Quick command not supported, "
+			 "can't probe for chips\n");
+		return -1;
+	}
+
 	/* Probe entries are done second, and are not affected by ignore
 	   entries either */
 	for (i = 0; address_data->probe[i] != I2C_CLIENT_END; i += 2) {

Would this help you? It looks to me like you could then call this
function for your specific busses, with a properly crafted
i2c_client_address_data structure (only force entries, no
probe/normal_i2c entries). Or do you need more than that?

> > Coding style please: one space after the comma. 
> (...)
> Yeah, I copied those lines from other parts of i2c-core.c.  But I'll
> fix them.

True, I know that coding style in the i2c-core is less than optimal at
places :(

> (...) Is there a reason i2c_probe_address is limited to
> 7-bit addresses?  Clients with 10-bit addresses (I've never seen one,
> but I guess they exist?) should be able to be instantiated though the
> known-device list.

I've never seen 10-bit chips either. There is preliminary support in
i2c-core as far as I can see, but I wouldn't expect too much from it, as
it was probably never tested and might even not be complete enough to
work at all.

10-bit addressing is an extension of the I2C protocol. It requires
pushing one additional byte on the bus for each command, and is
incompatible with SMBus 2.0 [1], which might explain why it ain't
popular. Quite frankly, I can't see why any manufacturer would start
using 10-bit addresses when I've never seen a crowded I2C bus. I think I
remember that there is no theoretical limit to the number of chips on an
I2C bus (other than the total number of addresses), but there are
electrical conditions that must be fulfilled, making it clear that we
aren't going to see I2C busses with more than 20 chips or so. It also
looks like manufacturers are more likely to use multiplexing than 10-bit
addresses if they really need to put many chips on a bus.

All in all, I don't see any reason why we would work on 10-bit address
support until there is actually a need for this. There are much higher
priorities at the moment.

[1] SMBus 2.0, specifications, page 25:
"All 10-bit slave addresses are reserved for future use and are outside
the scope of this specification."

> I think the way to go about this would be to rework and resubmit the
> first 3 patches once we decide how to handle the no-probe adapter
> flag, and later I will send a separate patch set for review with the
> known-device list implementation.

Sounds like a good plan to me.

Thanks,
-- 
Jean Delvare
