Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932209AbWAIQht@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932209AbWAIQht (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 11:37:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932437AbWAIQht
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 11:37:49 -0500
Received: from node3.inaccessnetworks.com ([212.205.200.118]:20638 "EHLO
	inaccessnetworks.com") by vger.kernel.org with ESMTP
	id S932209AbWAIQhs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 11:37:48 -0500
Message-ID: <43C2914A.8080409@inaccessnetworks.com>
Date: Mon, 09 Jan 2006 18:37:30 +0200
From: Angelos Manousarides <amanous@inaccessnetworks.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: I2C bus implementation
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am writting a driver for the I2C of the powerpc MPC82xx. I have read 
various implementations of other busses and I2C drivers (drivers for I2C 
devices that is). All the I2C drivers I have seen do something like this 
on a read command:

struct i2c_msg msgs[2] = {
   {client->addr, 0, 1, addr},
   {client->addr, I2C_M_RD, len, buf}
};

...

ret = i2c_transfer(client->adapter, msgs, 2);

..

This sequence implements a I2C read, with a 1-byte write for the slave 
address and a subsequent read. This is ok for a device that does direct 
low level communication with the bus.

In the MPC82xx however, the I2C unit does almost all the work. All the 
driver has to do is setup the buffers for input/output and wait for an 
interrupt once the operation is over. In the example above it would just 
setup a buffer for the outgoing data (1 byte wide), one buffer for the 
incoming data and issue a "start" command.

The problem is that since all I2C device drivers are written in the way 
above, I am having trouble writting the code for this I2C bus. The 
master_xfer function accepts a list of i2c_msg. So for a I2c read my 
driver would get 2 messages one with the first byte (address write) and 
one with the read buffer, although this is a single I2C transaction!

How can I glue the I2C code to this interface?
Is there a bus similar to the MPC82xx implemented already?

Can I assume that the i2c_msg list passed to the master_xfer function 
will always contain a single I2C transaction? This way I could setup the 
buffers using the i2c_mgs elements and when the list finishes, I cound 
issue the "I2C start" command.

--
Manousaridis Angelos
