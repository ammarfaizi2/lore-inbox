Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263717AbUCPJ0y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 04:26:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263736AbUCPJ0t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 04:26:49 -0500
Received: from mail.convergence.de ([212.84.236.4]:61847 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S263701AbUCPJZw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 04:25:52 -0500
Message-ID: <4056C805.8090004@convergence.de>
Date: Tue, 16 Mar 2004 10:25:25 +0100
From: Michael Hunold <hunold@convergence.de>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [RFC][2.6] Additional i2c adapter flags for i2c client isolation
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

the DVB subsystem currently has it's own i2c subsystem and I'm working 
on going back to in-kernel i2c.

The original problem that made a colleague create a separate i2c 
subsystem was that i2c client  drivers were probing on new appearing 
busses unconditionally. The worst  example were the Matrox clients that 
were driving other i2c busses besides the ones on the Matrox adapters nuts.

The problem is that some i2c busses on some dvb cards *really* don't 
like being probed by unknown clients on unknown address ranges.

Most i2c client drivers check in their attach_adapter() function if they
need to probe by investigating the adapter->id. But not all.

Unfortunately, this only keeps well-written clients from attaching. The 
i2c-core unconditionally tells every i2c client every new i2c adapter. 
If the i2c-client doesn't check the adapter->id, then it can screw up 
the i2c bus anyway:

int i2c_add_adapter(struct i2c_adapter *adap)
{
[...]
  /* inform drivers of new adapters */
   list_for_each(item,&drivers) {
   driver = list_entry(item, struct i2c_driver, list);
   if (driver->flags & I2C_DF_NOTIFY)
    /* We ignore the return code; if it fails, too bad */
    driver->attach_adapter(adap);
[...]

Here, all client drivers are unconditionally told to try and attach to
the adapter. There is no way that an i2c adapter can keep an i2c driver
away from the bus.

Currently, adapters can already specify a class, for DVB
I2C_ADAP_CLASS_TV_DIGITAL matches perfectly.

What I'd like to have is that client can specify some sort of "class",
too, and that i2c adapters can tell the core that only clients where the
class is matching are allowed to probe their existence.

The above code snippet would then probably look like this:

int i2c_add_adapter(struct i2c_adapter *adap)
{
[...]
  /* inform drivers of new adapters */
  list_for_each(item,&drivers) {
   driver = list_entry(item, struct i2c_driver, list);
   /* skip driver if it specifies a class and class to the
      adapter does not match */
   if (driver->class != 0 && driver->class != adap->client_class)
     continue;	
   if (driver->flags & I2C_DF_NOTIFY)
     /* We ignore the return code; if it fails, too bad */
     driver->attach_adapter(adap);
[...]

This would greatly help to keep any i2c client driver away from the i2c
bus of the dvb card besides the dvb i2c drivers.

Do you think this is feasible? If so, I'd be happy to prepare a patch to
outline my ideas with some lines of code.

CU
Michael.

