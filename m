Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932313AbVHKT65@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932313AbVHKT65 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 15:58:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932389AbVHKT65
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 15:58:57 -0400
Received: from smtp-104-thursday.nerim.net ([62.4.16.104]:3846 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S932313AbVHKT64
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 15:58:56 -0400
Date: Thu, 11 Aug 2005 21:59:29 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: LM Sensors <lm-sensors@lm-sensors.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: I2C block reads with i2c-viapro: testers wanted
Message-Id: <20050811215929.1df5fab0.khali@linux-fr.org>
In-Reply-To: <m3fytgnv73.fsf@defiant.localdomain>
References: <20050809231328.0726537b.khali@linux-fr.org>
	<42FA6406.4030901@cetrtapot.si>
	<20050810230633.0cb8737b.khali@linux-fr.org>
	<42FA89FE.9050101@cetrtapot.si>
	<20050811185651.0ca4cd96.khali@linux-fr.org>
	<m3fytgnv73.fsf@defiant.localdomain>
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

> Forgive my ignorance, but does it depend on the south bridge at all?
> Isn't the block read capability just a function of EEPROM chip on
> (I assume) RAM module?

EEPROMs can be read using three different access modes: data byte reads
(each transaction asks for one byte at a given offset), continuous byte
reads (first transaction sets offset to 0, each subsequent transaction
reads one byte and the offset auto-increments), and I2C block reads (one
single transaction sets the initial offset and reads the whole block
[1]).

Now, just because most EEPROMs support these three modes doesn't mean
you can always use them. It depends on which bus the EEPROM is sitting
on, and which driver is used to control that bus.

If the bus is a true I2C bus, most of which are known as bit-banging and
are driven by the i2c-algo-bit driver, then all three types of accesses
will work, and we'll use I2C block reads because it's faster. However,
EEPROMs are also often found on SMBus busses, those controller only
implement a subset of all possible I2C commands. Where this subset
includes I2C block reads, we can implement it in the driver and use it.
This is exactly what I am doing with i2c-viapro right now.

More generally, for an I2C/SMBus command to be usable, both the target
chip and the bus controller must support it, and the bus controller
driver must implement it.

I hope it's clearer now :)

[1] Due to an internal limitation in the Linux kernel, the maximum block
size that can be read is actually 32 bytes, so several block reads are
needed to retrieve larger chunks of data.

-- 
Jean Delvare
