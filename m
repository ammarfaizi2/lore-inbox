Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271189AbTG1W6o (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 18:58:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271191AbTG1W6o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 18:58:44 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:36882 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S271189AbTG1W6k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 18:58:40 -0400
Date: Tue, 29 Jul 2003 00:58:38 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Claas Langbehn <claas@rootdir.de>
Cc: dean gaudet <dean-list-linux-kernel@arctic.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test2 has i8042 mux problems
Message-ID: <20030728225838.GA1845@win.tue.nl>
References: <20030728052614.GA5022@rootdir.de> <20030728113626.GA1706@win.tue.nl> <20030728210910.GA832@rootdir.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030728210910.GA832@rootdir.de>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 28, 2003 at 11:09:10PM +0200, Claas Langbehn wrote:
> Hello!
> 
> its strange. After switching debug on, it suddenly works.

Maybe the timing changed?

[It would also be nice to see a log where things failed.
Probably syslog would still work.]

> Below my debug info.

Thanks! Let me comment it.

-------------------------------------------------------------
check_mux: First we probe for a Synaptics mux. Find none.
check_aux: Then we probe for a PS/2 mouse port. Find one.

Good. Found something. Call serio_register_port().
This searches for attached devices.
We know already that it is the PS/2 mouse port, but who knows
what might be connected. Let us try all devices we know about.

Is it perhaps a keyboard?

> drivers/input/serio/i8042.c: d4 -> i8042 (command) [0]
> drivers/input/serio/i8042.c: f2 -> i8042 (parameter) [0]

We wait for 99 jiffies, but no keyboard ID shows up.
Then try to set LEDs.

> drivers/input/serio/i8042.c: d4 -> i8042 (command) [99]
> drivers/input/serio/i8042.c: ed -> i8042 (parameter) [99]
> drivers/input/serio/i8042.c: fe <- i8042 (interrupt, aux, 0, timeout) [99]

Get an error back. This mouse doesnt want to set its LEDs.

Is it perhaps a mouse?

> drivers/input/serio/i8042.c: d4 -> i8042 (command) [113]
> drivers/input/serio/i8042.c: f2 -> i8042 (parameter) [113]

No mouse ID either. No devices connected to this port, but
at least we have a port:

> serio: i8042 AUX port at 0x60,0x64 irq 12

Then we continue, and check the keyboard side of the i8042 controller.
Things work satisfactorily, we detect a keyboard.

Silly enough we set it to scancode Set 2, but nevertheless give
commands that are only meaningful for scancode Set 3.
Keyboards that know only about Set 2 will be unhappy.

> input: AT Set 2 keyboard on isa0060/serio0
> serio: i8042 KBD port at 0x60,0x64 irq 1

OK, found keyboard.
-------------------------------------------------------------

So far the story of your debug file.
What is your actual hardware? Is there a mouse?

Andries

