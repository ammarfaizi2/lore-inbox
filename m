Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262328AbVAZP0T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262328AbVAZP0T (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 10:26:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262329AbVAZP0T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 10:26:19 -0500
Received: from rproxy.gmail.com ([64.233.170.202]:21808 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262328AbVAZP0O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 10:26:14 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=ghsbzvvbhAc/p/2kibzPoAW71dFSfCuDiX+SmSE/egTXI0ZdgBuGEw5jFaGMVCFp0QR0J1lmBLIKnXUbkts0beSgySqkkMKpFvOG4q1LFJEHrxYcmYMUaPoelYUrRUO9Au/+XIltzrEDChmYB81WDulNM2qzgk52pnVQJ93R+D8=
Message-ID: <d120d5000501260726714e8251@mail.gmail.com>
Date: Wed, 26 Jan 2005 10:26:13 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: johnpol@2ka.mipt.ru
Subject: Re: 2.6.11-rc2-mm1
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       greg@kroah.com, linux-kernel@vger.kernel.org
In-Reply-To: <1106751547.5257.162.camel@uganda>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050124021516.5d1ee686.akpm@osdl.org>
	 <d120d5000501250811295c298e@mail.gmail.com>
	 <20050126001443.7f91bbbb@zanzibar.2ka.mipt.ru>
	 <200501252357.08946.dtor_core@ameritech.net>
	 <1106727902.5257.109.camel@uganda>
	 <d120d5000501260546536647e7@mail.gmail.com>
	 <1106751547.5257.162.camel@uganda>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jan 2005 17:59:07 +0300, Evgeniy Polyakov
<johnpol@2ka.mipt.ru> wrote:

> Each superio chip has the same logical devices inside.
> With your approach we will have following schema:
> 
> bus:
> superio1 - voltage, temp, gpio, rtc, wdt, acb
> superio2 - voltage, temp, gpio, rtc, wdt, acb
> superio3 - voltage, temp, gpio, rtc, wdt, acb
> superio4 - voltage, temp, gpio, rtc, wdt, acb
> 
> Each logical device driver (for existing superio schema)
> is about(more than) 150 lines of code.
> With your approach above example will be 150*6*4 +
> 4*superio_chip_driver_size bytes
> of the code.

????? Let's count again, shall we? Suppose we have:
> superio1 - voltage, temp, gpio, rtc, wdt, acb
> superio2 - voltage, temp, gpio, rtc, wdt, acb
superio1 is driven by scx200 hardware, superio2 is driven by pc8736x
or whatever. So here, you have 2 drivers to manage chips. Plus you
have 6 superio interface drivers - gpio, acb, etc...
It is exactly the same as your cheme size-wise.

There is no need to many-to-many relationship. Each chip is bound to
only one chip driver which registers several interfaces. Each
interface is bound to only one interface driver. Interface driver is
not chip specific, it knows how to run a specific interface (gpio,
temp) and relies on chip driver to properly manage access to the
hardware. Each combination of inetrface + interface driver produce one
class_device (call it sio, serio, whatever). Class device provides
unified view of the interface to the userspace.

What am I missing?

-- 
Dmitry
