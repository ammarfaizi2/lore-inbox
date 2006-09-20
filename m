Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751896AbWITQzK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751896AbWITQzK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 12:55:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751924AbWITQzK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 12:55:10 -0400
Received: from xenotime.net ([66.160.160.81]:21141 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751896AbWITQzI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 12:55:08 -0400
Date: Wed, 20 Sep 2006 09:56:08 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Robin Getz <rgetz@blackfin.uclinux.org>
Cc: linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com
Subject: Re: drivers/char/random.c exported interfaces
Message-Id: <20060920095608.8a1227a2.rdunlap@xenotime.net>
In-Reply-To: <6.1.1.1.0.20060918091937.01ec6eb0@ptg1.spd.analog.com>
References: <6.1.1.1.0.20060918091937.01ec6eb0@ptg1.spd.analog.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Sep 2006 09:27:59 -0400 Robin Getz wrote:

> It says in the comments in drivers/char/random.c that:
> 
>    * Exported interfaces ---- input
>    * ==============================
>    *
>    * The current exported interfaces for gathering environmental noise
>    * from the devices are:
>    *
>    * 	void add_input_randomness(unsigned int type, unsigned int code,
>    *                                unsigned int value);
>    * 	void add_interrupt_randomness(int irq);
>    *
>    * add_input_randomness() uses the input layer interrupt timing, as well as
>    * the event type information from the hardware.
>    *
> [..snip..]
> 
> If "add_input_randomness" is an "Exported interface" why is it not an
> exported symbol?
> 
> If I build drivers/input/input.ko, I get the error:
> 
> ** Warning: "add_input_randomness" [drivers/input/input.ko] undefined!

Yep, confirmed (after disabling CONFIG_VT and CONFIG_USB_HID)
(on 2.6.18).

On x86_64, I get both of these:

WARNING: "kobject_get_path" [drivers/input/input.ko] undefined!
WARNING: "add_input_randomness" [drivers/input/input.ko] undefined!

With USB_HID enabled, I also get:

  LD      .tmp_vmlinux1
drivers/built-in.o: In function `hidinput_disconnect':
(.text+0x10741e): undefined reference to `input_unregister_device'
drivers/built-in.o: In function `hidinput_connect':
(.text+0x107526): undefined reference to `input_allocate_device'
drivers/built-in.o: In function `hidinput_connect':
(.text+0x107547): undefined reference to `input_free_device'
drivers/built-in.o: In function `hidinput_connect':
(.text+0x1091a2): undefined reference to `input_register_device'
drivers/built-in.o: In function `hidinput_connect':
(.text+0x1091f2): undefined reference to `input_register_device'
drivers/built-in.o: In function `hidinput_hid_event':
(.text+0x10942f): undefined reference to `input_event'
drivers/built-in.o: In function `hidinput_hid_event':
(.text+0x1094bd): undefined reference to `input_event'
drivers/built-in.o: In function `hidinput_hid_event':
(.text+0x109507): undefined reference to `input_event'
drivers/built-in.o: In function `hidinput_hid_event':
(.text+0x109577): undefined reference to `input_event'
drivers/built-in.o: In function `hidinput_hid_event':
(.text+0x10959b): undefined reference to `input_event'
drivers/built-in.o:(.text+0x1095dc): more undefined references to `input_event' follow

so using INPUT=m has a few problems.

ISTM that we should at least fix the first 2 (by EXPORTing them).
or we don't allow INPUT=m.

You want to send a patch?

---
~Randy
