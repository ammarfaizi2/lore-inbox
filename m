Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750816AbWCaGAG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750816AbWCaGAG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 01:00:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750847AbWCaGAF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 01:00:05 -0500
Received: from smtp.net4india.com ([202.71.129.68]:14751 "EHLO
	smx2.net4india.com") by vger.kernel.org with ESMTP id S1750816AbWCaGAE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 01:00:04 -0500
Message-ID: <442CC5BA.2030901@designergraphix.com>
Date: Fri, 31 Mar 2006 11:31:30 +0530
From: Kaiwan N Billimoria <kaiwan@designergraphix.com>
Organization: Designer Graphix
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050920
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jean Delvare <khali@linux-fr.org>
CC: linux-kernel@vger.kernel.org
Subject: SPI <-> Parport (light) bridge code  (Re: Stuck creating sysfs hooks
 for a driver..)
References: <43F2DE34.60101@designergraphix.com>	<20060215221301.GA25941@kroah.com>	<43F46319.9090400@designergraphix.com> <20060219142311.ba0f8a38.khali@linux-fr.org>
In-Reply-To: <20060219142311.ba0f8a38.khali@linux-fr.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean Delvare wrote:

>Hi Kaiwan,
>
>  
>
--snip--

>You must stay away from writing a driver for the board itself. What you
>must write is in fact two different drivers:
>
>1* A driver for the SPI interface of your board (basically a parallel
>port <-> SPI bridge). This driver will expose the device as an SPI bus
>to the rest of the kernel. This driver doesn't care about what chip is
>plugged on it.
>
>  
>
Hi Jean,

1. Yes, i know, long time since the above message..yet i'm happy to say 
that i have built a (lightweight version) of the
SPI<->parport bridge (file pasted below), which is based on your 
i2c-parport driver bridge code.
It is built as a header file: the driver developer basically appends 
his/her adapter entry into the adapter_parm[] data structure and 
includes this file in the device driver.

>2* A driver for the LM70 temperature sensor chip, which doesn't care
>about the chip location. This driver will use generic SPI commands as
>offered by the spi kernel interface.
>
>This modular approach makes it possible to then reuse each of the
>drivers. If you later have a similar board for a different chip, the
>first driver will still work (assuming the new board uses SPI and the
>same wiring conventions). If you later have an LM70 chip on a different
>physical interface, the second driver will still work.
>
>  
>
2. I have also done this; i now have a working driver for a specific 
chip (the NS lm70CILD-3 eval board) based on the (above mentioned) 
SPi<->parport bridge. Basically, the "type 0" entry in the 
adapter_parm[] data structure is the lm70CILD-3 entry. The driver 
handles the other things, including creation of a sysfs hook (used to 
query the temperature from userspace).

>No, just do what every other hardware monitoring chip does, so that
>support can be added for the lm70 chip in libsensors - then you win
>instant support in all hardware monitoring application which rely on
>libsensors, and even a few which do not.
>
>It's really not a matter of how many features a chip has. Look at the
>lm75 or w83l785ts driver, you'll see they have very few features as
>well. It's a matter of having a common standard for exporting the
>values to user-space, so that the same library or application can
>handle all sources with minimum effort.
>
>Thanks,
>  
>
3. I still have to work on integrating the userspace conversion into 
libsensors (as recommended by yourself & others).

4. My intention at this point of time is for you (and others) to take a 
look at the spi-parport-light.h code and pl give me your feedback. I'm 
not posting a patch at this time..

5. Also, because it's a header, am not sure what approach to take when 
patching into the kernel; i mean, i can place it under the spi tree 
(either drivers/spi or include/linux/spi) but can't add the usual
"obj-$(CONFIG_xxx) += xxx.o"
line (as it's a header). Or can I do something like this?? i'm really 
quite uncertain, forgive me.. any suggestions on how i should go about this?

Thanks very much,
Kaiwan.

PS> If you'd like to see a usage example, i can post the lm70CILD3.c 
driver code..

+++++++++++++++++++++ File spi-parport-light.h 
+++++++++++++++++++++++++++++++++++++++

---
/* 
------------------------------------------------------------------------ *
 * 
spi-parport-light.h                                                      *
 * SPI bus over parallel 
port                                               *
 * 
------------------------------------------------------------------------ *
   Copyright (C) 2006 Kaiwan N Billimoria <kaiwan@designergraphix.com>
 
   Heavily based on i2c-parport-light.c
   Copyright (C) 2003-2004 Jean Delvare <khali@linux-fr.org>
  
   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 * 
------------------------------------------------------------------------ */

#ifdef DATA
#undef DATA
#endif

#define DATA    0
#define STAT    1
#define CTRL    2

struct lineop {
    u8 val;
    u8 port;
    u8 inverted;
};

struct adapter_parm {
    char *name;
    struct lineop setsda;
    struct lineop setscl;
    struct lineop setcsl;    // chip select
    struct lineop getsda;
    struct lineop getscl;
    struct lineop init;
    struct spi_device *spidev;
};

static struct adapter_parm adapter_parm[] = {
    /* type 0: National Semiconductor LM70CILD-3 evaluation board */
    {
        .name   = "lm70CILD-3",
        .setscl    = { 0x40, DATA, 0 },
        .setcsl    = { 0x20, DATA, 1 },
        .getsda    = { 0x10, STAT, 0 },    // SI/O
        .init   = { 0xFE, DATA, 0 },
    },
    /* add adapters here */
};

/*----------------Module parameters-----------------------------*/
static int type;
module_param(type, int, 0);
MODULE_PARM_DESC(type,
    "Type of adapter: (defaults to 0)\n"
    " 0 = LM70CILD-3 (National Semiconductor) evaluation board\n");
    /* add new type(s) here */

static u16 base;
module_param(base, ushort, 0);
MODULE_PARM_DESC(base, "Parport Base I/O address");
/*--------------------------------------------------------------*/

#include <linux/ioport.h>
#include <linux/delay.h>
#include <asm/io.h>

/* ----- Low-level parallel port access 
----------------------------------- */

#define DEFAULT_BASE 0x378

static inline void port_write(unsigned char p, unsigned char d)
{
    outb(d, base+p);
}

static inline unsigned char port_read(unsigned char p)
{
    return inb(base+p);
}

/* ----- Unified line operation functions 
--------------------------------- */

static inline void line_set(int state, const struct lineop *op)
{
    u8 oldval = port_read(op->port);

    /* Touch only the bit(s) needed */
    if ((op->inverted && !state) || (!op->inverted && state))
        port_write(op->port, oldval | op->val);
    else
        port_write(op->port, oldval & ~op->val);
}

static inline int line_get(const struct lineop *op)
{
    u8 oldval = port_read(op->port);

    return ((op->inverted && (oldval & op->val) != op->val)
        || (!op->inverted && (oldval & op->val) == op->val));
}

/* ----- SPI call-back functions and structures ----------------- */

static void parport_setscl(void *data, int state)
{
    line_set(state, &adapter_parm[type].setscl);
}

static void parport_setsda(void *data, int state)
{
    line_set(state, &adapter_parm[type].setsda);
}

static int parport_getscl(void *data)
{
    return line_get(&adapter_parm[type].getscl);
}

static int parport_getsda(void *data)
{
    return line_get(&adapter_parm[type].getsda);
}

static void parport_setcsl(void *data, int state)
{
    line_set(state, &adapter_parm[type].setcsl);
}

/* ----- Module init and 
exit---------------------------------------------- */

/* Module init : to be called from the specific driver init routine */
static int spi_parport_init(char *name)
{
    /* adapter_parm set in the spi-parport-light.h header; type is a 
module parameter */
    if (type < 0 || type >= ARRAY_SIZE(adapter_parm)) {
        printk(KERN_WARNING "%s: invalid parameter \"type\" (%d)\n\
defaulting to type 0\n", name, type);
        type = 0;
    }

    if (base == 0)
        base = DEFAULT_BASE;

    if (!request_region(base, 3, "spi-parport-light"))
        return -EBUSY;

    /* Reset hardware to a sane state (SCL and SDA high) */
    parport_setsda(NULL, 1);
    parport_setscl(NULL, 1);
    /* Other init if needed (power on...) */
    if (adapter_parm[type].init.val)
        line_set(1, &adapter_parm[type].init);
    /* CS deselect, if necessary.. */
    if (adapter_parm[type].setcsl.val)
        line_set(0, &adapter_parm[type].setcsl);

    /* Memory for the spi_device struct for this adapter */
    adapter_parm[type].spidev = kzalloc(sizeof(struct spi_device), 
GFP_KERNEL);
    if (!adapter_parm[type].spidev) {
        printk(KERN_ERR "%s: out of memory\n", name);
        release_region(base, 3);
        return -ENOMEM;
    }

    printk(KERN_INFO "%s loaded: adapter type %d (device '%s'), using 
base address 0x%x\n",
            name, type, adapter_parm[type].name, base);

    return 0;
}

/* Module exit : to be called from the specific driver cleanup routine */
static void spi_parport_exit(char *name)
{
    if (adapter_parm[type].spidev)
        kfree (adapter_parm[type].spidev);

    /* Un-init if needed (power off...) */
    if (adapter_parm[type].init.val)
        line_set(0, &adapter_parm[type].init);
   
    release_region(base, 3);
    printk(KERN_INFO "%s unloaded.\n", name);
}
