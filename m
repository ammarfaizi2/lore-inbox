Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268957AbUIXRLt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268957AbUIXRLt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 13:11:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268950AbUIXRI3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 13:08:29 -0400
Received: from smtp08.web.de ([217.72.192.226]:36498 "EHLO smtp08.web.de")
	by vger.kernel.org with ESMTP id S268957AbUIXRHY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 13:07:24 -0400
Message-ID: <41545421.5080408@web.de>
Date: Fri, 24 Sep 2004 19:06:41 +0200
From: Michael Hunold <hunold-ml@web.de>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Michael Hunold <hunold@linuxtv.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       sensors@stimpy.netroedge.com
Subject: Re: [PATCH][2.6] Add command function to struct i2c_adapter
References: <414F111C.9030809@linuxtv.org> <20040921154111.GA13028@kroah.com>
In-Reply-To: <20040921154111.GA13028@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 21.09.2004 17:41, Greg KH wrote:
> On Mon, Sep 20, 2004 at 07:19:24PM +0200, Michael Hunold wrote:
> 
>> 
>>+	/* a ioctl like command that can be used to perform specific functions
>>+	 * with the adapter.
>>+	 */
>>+	int (*command)(struct i2c_adapter *adapter, unsigned int cmd, void *arg);
> 
> 
> Ick ick ick.  We don't like ioctls for the very reason they aren't type
> safe, and you can pretty much stick anything in there you want.  So
> let's not try to add the same type of interface to another subsystem.

Ok, Gerd Knorr and I have been discussing this and we have come up with 
the following idea.

We like to have an completly isolated i2c adapter, where the device 
driver can invite i2c drivers to connect an i2c client to. When the 
connection is made, an "interface" pointer with client-specific data or 
function pointers can be provided.

- i2c adapter and i2c clients register themselves as usual

- add a new NO_PROBE flag to struct i2c_adapter, so a particular adapter 
is never probed by anyone

- add these two functions to struct i2c_driver:
int (*connect)(struct i2c_adapter *adapter, void *interface, struct 
i2c_client **client);
int (*disconnect)(struct i2c_client *client);

- add new generic i2c functions:
struct i2c_driver* i2c_driver_get(char *name);
void i2c_driver_put(struct i2c_driver *drv);

- the dvb-ttpci driver now can do the following:

struct stv0299_interface {
	struct dvb_adapter *dvb_adap;
	int tuner_addr;
};

struct stv0299_interface s_if;
struct i2c_driver *drv;
struct i2c_client *clt;

request_module("stv0299");
drv = i2c_driver_get("stv0299");
// fill s_if here
drv->connect(adap, &s_if, &clt);

Now inside the "connect" function of the stv0299 demodulator i2c driver 
the device is probed, registered to the adapter and the pointer to the 
interface with the h/w dependend information is stored.

> thanks,
> greg k-h

The crucial point is probably the void * interface pointer, isn't it? Is 
this a no-no in this situation?

The dvb-ttpci driver is inviting a very specific driver, no probing 
involved. The driver interface is well-defined and will only be hidden 
behind the void * pointer to avoid a functional reference to the 
demodulator driver.

We have discussed simply adding a type-safe stv0299-specific connect 
function as well, but that would introduce a functional dependency. The 
dvb-ttpci driver can be used with about 8 different frontend drivers, so 
loading the driver would cause unnecessary frontend drivers to be loaded 
as well.

CU
Michael.
