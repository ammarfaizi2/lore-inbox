Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261823AbVBUKTB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261823AbVBUKTB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 05:19:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261914AbVBUKTB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 05:19:01 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:31761 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261823AbVBUKS7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 05:18:59 -0500
Date: Mon, 21 Feb 2005 10:18:51 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Asier Llano Palacios <a.llano@usyscom.com>
Cc: Jamey Hicks <jamey.hicks@hp.com>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: gpio api
Message-ID: <20050221101851.B28213@flint.arm.linux.org.uk>
Mail-Followup-To: Asier Llano Palacios <a.llano@usyscom.com>,
	Jamey Hicks <jamey.hicks@hp.com>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
References: <4215F1A0.1030805@hp.com> <1108980144.15299.16.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1108980144.15299.16.camel@localhost.localdomain>; from a.llano@usyscom.com on Mon, Feb 21, 2005 at 11:02:24AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2005 at 11:02:24AM +0100, Asier Llano Palacios wrote:
> The GPIOs requesting and numbering should be done by specifying the
> chip, the port and the pin. We should be able to manipulate easily a
> GPIO from one of 3 I2C chips and another one from our microprocessor.

I think there's a problem with this approach:

- I2C chips require you to talk to them via a relatively slow bus.
  The I2C subsystem takes a semaphore, so it can be used from interrupt
  context.
- You may wish to use GPIOs (especially on-chip GPIOs) from interrupt
  context.

Therefore, you don't have a clear locking model for a GPIO subsystem.
You'll probably be in the situation where some GPIOs may be locked by
spinlocks (which are fine to manipulate from interrupt context) and
others which are locked by semaphores - so you don't actually know
what's going on beneath the GPIO API.

This is real bad news in terms of ensuring correctness and being able to
review.

-- 
Russell King

