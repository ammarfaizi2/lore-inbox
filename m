Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261384AbVB0V4O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261384AbVB0V4O (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 16:56:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261321AbVB0V4O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 16:56:14 -0500
Received: from ffm.saftware.de ([217.20.127.95]:14827 "EHLO ffm.saftware.de")
	by vger.kernel.org with ESMTP id S261387AbVB0Vzs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 16:55:48 -0500
Subject: Re: [PATCH] possible bug in i2c-algo-bit's inb function
From: Andreas Oberritter <obi@saftware.de>
To: LM Sensors <sensors@stimpy.netroedge.com>,
       LKML <linux-kernel@vger.kernel.org>
Cc: Greg KH <greg@kroah.com>
In-Reply-To: <20050227195226.23aa5a51.khali@linux-fr.org>
References: <E1D5GN2-0000Bi-KG@localhost.localdomain>
	 <20050227103538.218fa1b0.khali@linux-fr.org>
	 <1109528034.4564.16.camel@localhost.localdomain>
	 <20050227195226.23aa5a51.khali@linux-fr.org>
Content-Type: text/plain
Date: Sun, 27 Feb 2005 22:55:47 +0100
Message-Id: <1109541347.4948.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-02-27 at 19:52 +0100, Jean Delvare wrote:
> > Here's my I2C code:
> > (...)
> 
> Looks sane.
> 
> > The bus master is a so called Pluto2 by SCM (part of a DVB-T card sold
> > by Satelco). If this is a hardware bug, is it possible to add a flag
> > to struct i2c_algo_bit_data to workaround this bug?
> 
> I would try to find out whether the culprit is setscl or getsda
> (assuming I am correct and either of these actually is the problem).
> Once you know which it is, you could modifiy that function to restore
> the SDA line, that should do the trick.
> 
> Hope that helps,

Thank you, using the workaround below makes it possible to use the
bitbanging code without modifications. It tries to detect i2c_inb() and
resets SDA to high after SCL has been set to high and then to low.

static void pluto_setscl(void *data, int state)
{
        struct pluto *pluto = data;

        if (state)
                pluto_rw(pluto, REG_SLCS, SLCS_SCL, SLCS_SCL);
        else
                pluto_rw(pluto, REG_SLCS, SLCS_SCL, 0);

        if ((state) && (pluto->i2cbug == 0)) {
                pluto->i2cbug = 1;
        } else {
                if ((!state) && (pluto->i2cbug == 1))
                        pluto_setsda(pluto, 1);
                pluto->i2cbug = 0;
        }
}

Regards,
Andreas

