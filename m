Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261368AbVBRNqg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261368AbVBRNqg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 08:46:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261367AbVBRNqf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 08:46:35 -0500
Received: from [192.58.210.9] ([192.58.210.9]:14819 "EHLO
	crl-mailb.crl.dec.com") by vger.kernel.org with ESMTP
	id S261352AbVBRNqQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 08:46:16 -0500
Message-ID: <4215F1A0.1030805@hp.com>
Date: Fri, 18 Feb 2005 08:46:08 -0500
From: Jamey Hicks <jamey.hicks@hp.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: gpio api
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-HPLC-MailScanner-Information: Please contact the ISP for more information
X-HPLC-MailScanner: Found to be clean
X-HPLC-MailScanner-SpamCheck: not spam (whitelisted),
	SpamAssassin (score=-4.9, required 5, BAYES_00 -4.90)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


GPIO API

Motivation: On many of the little Linux devices I've seen, there are 
multiple
chips providing GPIO and in many cases GPIO pins from one chip are
used to control unrelated functions.  The first approach I took to
solving this problem was to implement a per-function framework.  I
wrote the first version of the lcd_device and backlight_device
framework to separate out the platform-specific parts of a framebuffer
video driver from the framebuffer chip parts.  (That framework was
finished by Andrew Zabolotny and has been accepted into the main
kernel tree.) However, such a framework is quite a bit of overhead for
very simple controls, so I think it would be worthwhile to have a
generic GPIO API.

My initial thought was to provide a synchronous API for configuring
GPIO mode and setting and getting values.  However, GPIOs are
sometimes implemented by chips on slow buses such as I2C and SPI, so
an asynchronous interface should be provided.  For example, a bus
extender such as the MAX7317 provides a set of GPIO pins accessible
via SPI.  There are similar I2C parts.  Since SPI and I2C are much
slower than CPU speeds, it seems best to treat operations on those
GPIO pins as asynchronous.  The SPI bus used to reach the MAX7317
could in turn be implemented by other onchip GPIO pins.  The next
question is to separate the sync and async APIs or combine them. I
have a feeling that if two separate sets of calls are provided that
people using boards with async GPIOs will end up having to rewrite
drivers.

This proposal provides an async interface via a callback registered
via request_gpio.  If a driver supports async operations, it should
provide flags GPIOF_SYNC|GPIOF_ASYNC, a non-NULL callback.  This will
work for both sync and async gpios.  If a driver only supports sync
GPIOs, then it should only provide the GPIOF_SYNC flag and a NULL
callback.  If at runtime the requested gpio is async, then
request_gpio will return -EINVAL.  It is a BUG to go ahead and call
set_gpio_mode, set_gpio_value, or get_gpio_value on an async gpio
without registering a callback.

Platform GPIO Resource

In order to use platform_device to specify the GPIOs used by a device,
we need a definition of IORESOURCE_GPIO.

       #define IORESOURCE_GPIO        0x08000000

An alternative is to reuse IORESOURCE_IRQ with a flag set.
       #define IORESOURCE_IRQ_GPIO    (1<<4)


SYFS Interface to GPIOs

For debugging purposes and for one-off gpio uses, it is very useful to
have a userspace interface to particular gpios.  However, exposing all
gpios this way is a grave security (denial of service) and possibly
safety risk.  The implementation will include an optional sysfs
interface that exposes unrequested GPIOs that have their GPIOF_SYSFS
flag set.

One of the flags could enable a gpio sysfs module to expose the GPIO
to user space.  I am in favor of a sysfs module that only has access
to explicitly exposed GPIOs, as you did in your driver.


GPIO Client Driver API

The first two calls are analogous to request_irq/free_irq, so that
driver can ensure that they have exclusive access to a GPIO and can
specify asynchronous or synchronous access.  I have run into problems
due to out-of-date or misconfigured drivers that would be prevented by
the use of these calls.

   #define GPIOF_SYNC      (1 << 0)
   #define GPIOF_ASYNC     (1 << 1)
   #define GPIOF_SYSFS     (1 << 2)
   #define GPIOF_VALID     (1 << 3)

   int request_gpio(int gpio_num, const char *name,
       void (*callback)(int gpionum, void *devid), int flags, void *devid);
   void free_gpio(int gpio_num, void *devid);

It is a BUG to supply a NULL callback if GPIO is successfully
requested with GPIOF_ASYNCH set.  [Alternatively, split into sync and
async calls and consider it a BUG to use the synchronous calls on a
GPIO requested with GPIOF_ASYNC set.]

    int set_gpio_mode(int gpionum, int modeflags);
    int set_gpio_value(int gpionum, int value);
    int get_gpio_value(int gpionum);

GPIO Provider API

    struct gpiochip {
       int (*set)(struct gpiochip *chip, void *context, int value);
       int (*get)(struct gpiochip *chip void *context);
       int (*mode)(struct gpiochip *chip, void *context, int modeflags);
    };

GPIOs are associated with gpiochip instances by calling set_gpio_chip.
If the -1 is provided as the gpionum, then the next free gpionum is
returned.  If a positive gpionum is provided and it is already
allocated, then -EINVAL is returned.  If there are no free gpionums,
then -ENOMEM is returned.

    int set_gpio_chip(int gpionum, struct gpiochip *chip, void *context, 
int flags);
    int free_gpio_chip(int gpionum);

=end-of-proposal=

