Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261200AbVB0SQr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261200AbVB0SQr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 13:16:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261465AbVB0SQV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 13:16:21 -0500
Received: from ffm.saftware.de ([217.20.127.95]:56553 "EHLO ffm.saftware.de")
	by vger.kernel.org with ESMTP id S261200AbVB0SN5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 13:13:57 -0500
Subject: Re: [PATCH] possible bug in i2c-algo-bit's inb function
From: Andreas Oberritter <obi@saftware.de>
To: LM Sensors <sensors@stimpy.netroedge.com>,
       LKML <linux-kernel@vger.kernel.org>
Cc: Greg KH <greg@kroah.com>
In-Reply-To: <20050227103538.218fa1b0.khali@linux-fr.org>
References: <E1D5GN2-0000Bi-KG@localhost.localdomain>
	 <20050227103538.218fa1b0.khali@linux-fr.org>
Content-Type: text/plain
Date: Sun, 27 Feb 2005 19:13:54 +0100
Message-Id: <1109528034.4564.16.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean,

On Sun, 2005-02-27 at 10:35 +0100, Jean Delvare wrote:
> > while writing a driver for a cardbus card which is supposed to use the
> > bit-banging algorithm I noticed that communication with the I2C slave
> > (Philips TDA10046) would fail without this patch. It forces SDA to
> > high for every bit in i2c_inb() instead of once per byte. Can this
> > patch go into the mainline kernel or will this break other drivers? I
> > am using Kernel version 2.6.10.
> 
> There is no reason why this would be necessary. Once SDA is set high on
> the master's side, the client will be controlling it for the rest of the
> byte (transferred from client to master). Setting SDA high again on the
> master's side for each bit shouldn't have any effet, let alone the
> substantial slowdown. If it changes something for you, then either your
> implementation of setscl or getsda is broken and does actually change
> SDA as a side effect, or what really helps is the additional delay, not
> setting SDA high per se. In the former case, check your code. If you
> can't figure out what's wrong, post it here and I'll take at look.
> What's your bus master BTW? In the latter case, you might simply need to
> lower the bus speed (increase udelay).

Increasing udelay from 10us to 100us, 1ms, 10ms or 100ms did not help.

Here's my I2C code:

#define REG_SLCS                0x003c
#define SLCS_SCL                (0x0001 <<  7)
#define SLCS_SDA                (0x0001 <<  6)

static inline u32 pluto_readreg(struct pluto *pluto, u32 reg)
{
        return readl(&pluto->io_mem[reg]);
}

static inline void pluto_writereg(struct pluto *pluto, u32 reg, u32 val)
{
        writel(val, &pluto->io_mem[reg]);
}

static inline void pluto_rw(struct pluto *pluto, u32 reg, u32 mask, u32
bits)
{
        u32 val = pluto_readreg(pluto, reg);
        val &= ~mask;
        val |= bits;
        pluto_writereg(pluto, reg, val);
}

static void pluto_setsda(void *data, int state)
{
        struct pluto *pluto = data;

        if (state)
                pluto_rw(pluto, REG_SLCS, SLCS_SDA, SLCS_SDA);
        else
                pluto_rw(pluto, REG_SLCS, SLCS_SDA, 0);
}

static void pluto_setscl(void *data, int state)
{
        struct pluto *pluto = data;

        if (state)
                pluto_rw(pluto, REG_SLCS, SLCS_SCL, SLCS_SCL);
        else
                pluto_rw(pluto, REG_SLCS, SLCS_SCL, 0);
}

static int pluto_getsda(void *data)
{
        struct pluto *pluto = data;

        return pluto_readreg(pluto, REG_SLCS) & SLCS_SDA;
}

static int pluto_getscl(void *data)
{
        struct pluto *pluto = data;

        return pluto_readreg(pluto, REG_SLCS) & SLCS_SCL;
}

in the pci probe function:

        i2c_set_adapdata(&pluto->i2c_adap, pluto);
        strcpy(pluto->i2c_adap.name, DRIVER_NAME);
        pluto->i2c_adap.owner = THIS_MODULE;
        pluto->i2c_adap.id = I2C_ALGO_BIT;
        pluto->i2c_adap.class = I2C_CLASS_TV_DIGITAL;
        pluto->i2c_adap.dev.parent = &pdev->dev;
        pluto->i2c_adap.algo_data = &pluto->i2c_bit;
        pluto->i2c_bit.data = pluto;
        pluto->i2c_bit.setsda = pluto_setsda;
        pluto->i2c_bit.setscl = pluto_setscl;
        pluto->i2c_bit.getsda = pluto_getsda;
        pluto->i2c_bit.getscl = pluto_getscl;
        pluto->i2c_bit.udelay = 10;
        pluto->i2c_bit.timeout = 10;

        /* Raise SCL and SDA */
        pluto_setsda(pluto, 1);
        pluto_setscl(pluto, 1);

	ret = i2c_bit_add_bus(&pluto->i2c_adap);

The bus master is a so called Pluto2 by SCM (part of a DVB-T card sold
by Satelco). If this is a hardware bug, is it possible to add a flag to
struct i2c_algo_bit_data to workaround this bug?

Regards,
Andreas

