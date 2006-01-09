Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750800AbWAIXLT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750800AbWAIXLT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 18:11:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750832AbWAIXLT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 18:11:19 -0500
Received: from gate.crashing.org ([63.228.1.57]:4530 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1750800AbWAIXLS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 18:11:18 -0500
Subject: Re: I2C bus implementation
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Angelos Manousarides <amanous@inaccessnetworks.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <43C2914A.8080409@inaccessnetworks.com>
References: <43C2914A.8080409@inaccessnetworks.com>
Content-Type: text/plain
Date: Tue, 10 Jan 2006 10:12:14 +1100
Message-Id: <1136848334.19965.21.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The problem is that since all I2C device drivers are written in the way 
> above, I am having trouble writting the code for this I2C bus. The 
> master_xfer function accepts a list of i2c_msg. So for a I2c read my 
> driver would get 2 messages one with the first byte (address write) and 
> one with the read buffer, although this is a single I2C transaction!
> 
> How can I glue the I2C code to this interface?
> Is there a bus similar to the MPC82xx implemented already?
> 
> Can I assume that the i2c_msg list passed to the master_xfer function 
> will always contain a single I2C transaction? This way I could setup the 
> buffers using the i2c_mgs elements and when the list finishes, I cound 
> issue the "I2C start" command.

You can parse the msg list for validity and if it contains anything you
don't grok, reject it. That's a bit of a pain though. That's why for
PowerMac (see the patches that just went in rewriting the PowerMac i2c
code), I have my own low level layer that uses different semantics
closer to what Apple HW provides and one stub driver that hooks to linux
i2c layer. In that stub, I chose to mostly implement the "smbus"
transactions. In fact, smbus transactions map to pretty much 90% of the
needs of most i2c devices around here. Of course, that mean you can't
use existing i2c drivers that use the master_xfer() entry and not the
smbus API, but then, do you really want to use an existing i2c driver ?
I find them generally of no use as they don't know anything about the
specifics of the platform anyway.

Ben.


