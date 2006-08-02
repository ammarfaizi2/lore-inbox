Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932111AbWHBR7F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932111AbWHBR7F (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 13:59:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932117AbWHBR7F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 13:59:05 -0400
Received: from caffeine.uwaterloo.ca ([129.97.134.17]:55453 "EHLO
	caffeine.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S932111AbWHBR7D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 13:59:03 -0400
Date: Wed, 2 Aug 2006 13:58:34 -0400
To: Jim Cromie <jim.cromie@gmail.com>
Cc: Robert Schwebel <r.schwebel@pengutronix.de>, Chris Boot <bootc@bootc.net>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Proposal: common kernel-wide GPIO interface
Message-ID: <20060802175834.GA13641@csclub.uwaterloo.ca>
References: <44CA7738.4050102@bootc.net> <20060730130811.GI10495@pengutronix.de> <44CFC6CC.8020106@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44CFC6CC.8020106@gmail.com>
User-Agent: Mutt/1.5.9i
From: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: lsorense@csclub.uwaterloo.ca
X-SA-Exim-Scanned: No (on caffeine.csclub.uwaterloo.ca); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01, 2006 at 03:25:32PM -0600, Jim Cromie wrote:
> this is cool to see.  Using a class-driver is very different from the 
> vtable-approach
> that I used (struct nsc_gpio_ops) in pc8736x_gpio and scx200_gpio.
> 
> Are any of the limitation youve cited above related to the 
> /sys/class/gpio paths below ?
> 
> +	  To set pin 63 to low (to start the motor) do a:
> +	   $ echo 0 > /sys/class/gpio/gpio63/level
> +	  Or to stop the motor again:
> +	   $ echo 1 > /sys/class/gpio/gpio63/level
> +	  To get the level of the key (pin 8) do:
> +	   $ cat /sys/class/gpio/gpio8/level
> +	  The result will be 1 or 0.
> +
> +	  To add new GPIO pins at runtime (lets say pin 88 should be an 
> input)
> +	  you can do a:
> +	   $ echo 88:in > /sys/class/gpio/map_gpio
> +	  The same with a new GPIO pin 95, it should be an output and at 
> high level:
> +	   $ echo 95:out:hi > /sys/class/gpio/map_gpio
> +

How do you deal with having multiple places that provide GPIOs then?  I
may have 8 pins on a PCI UART chip, 22 on my super io chip, 16 on my
cpu, etc.  How would this be mapped if you only have one map_gpio
method?  It is much simpler to code for knowing pin 0 to 7 of device
uartgpio is where my UART pins are, and some other device has 22 pins
for the super io chip.  If they all ended up in one place with
consequative numbers it would be a real pain.  

Sometimes it is also nice to be able to control multiple pins as a block,
which only a few gpio interfaces seem to provide (they all seem to think
they should only be moved one pin at a time, which makes for a lot more
system calls to get things done).

Right now I am working on adding some stuff to the jsm driver to use an
Exar uart along with using the gpios, and so far I added gpio access
similar to how scx200_gpio does things, using minors 0 to 7 for the 8
pins on the first uart, 8 to 15 for the second, and so on.  What to name
the /dev entries is a different issue.  I can identify which device to
look for based on the /sys info for which pci slot the uart is connected
to.  I am not sure how this would tie into a generic gpio design.

Does your gpio design deal with all the things gpios often do:
input/output/tristate
high/low
generate interrupt
edge/level trigger
high or low level/leading or trailing edge trigger

--
Len Sorensen
