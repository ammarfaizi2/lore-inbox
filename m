Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272221AbTG3AZU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 20:25:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272295AbTG3AZU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 20:25:20 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:9746 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S272221AbTG3AZL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 20:25:11 -0400
Date: Wed, 30 Jul 2003 02:25:08 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: dean gaudet <dean-list-linux-kernel@arctic.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test2 has i8042 mux problems
Message-ID: <20030730002508.GA2237@win.tue.nl>
References: <Pine.LNX.4.53.0307271906020.18444@twinlark.arctic.org> <20030728035920.GA1660@win.tue.nl> <Pine.LNX.4.53.0307291521520.24801@twinlark.arctic.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0307291521520.24801@twinlark.arctic.org>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 29, 2003 at 03:51:04PM -0700, dean gaudet wrote:

> i've got a box on which 2.4.x works fine, but 2.6.0-test2 gets into a snit
> when it's trying to initialize the i8042.  i can get 2.6.0-test2 to boot
> if i add "i8042_nomux".

> this system has an ali1563 (it's a development board for a new processor).
> 
> serio/i8042.c: d3 -> i8042 (command) [61]
> serio/i8042.c: f0 -> i8042 (parameter) [61]
> serio/i8042.c: 0f <- i8042 (return) [61]
> serio/i8042.c: d3 -> i8042 (command) [107]
> serio/i8042.c: 56 -> i8042 (parameter) [107]
> serio/i8042.c: a9 <- i8042 (return) [107]
> serio/i8042.c: d3 -> i8042 (command) [154]
> serio/i8042.c: a4 -> i8042 (parameter) [154]
> serio/i8042.c: ee <- i8042 (return) [154]
> i8042.c: Detected active multiplexing controller, rev 1.1.

The controller follows the synaptics mux protocol.

> serio/i8042.c: 90 -> i8042 (command) [248]
> serio/i8042.c: a8 -> i8042 (command) [264]
> serio/i8042.c: 91 -> i8042 (command) [279]
> serio/i8042.c: a8 -> i8042 (command) [295]
> serio/i8042.c: 92 -> i8042 (command) [311]
> serio/i8042.c: a8 -> i8042 (command) [326]
> serio/i8042.c: 93 -> i8042 (command) [342]
> serio/i8042.c: a8 -> i8042 (command) [357]

Enable all Aux devices.
Start investigating the first one.

> serio/i8042.c: 90 -> i8042 (command) [436]
> serio/i8042.c: f2 -> i8042 (parameter) [436]
> serio/i8042.c: fe <- i8042 (interrupt, aux0, 12, timeout) [480]
> serio/i8042.c: 90 -> i8042 (command) [501]
> serio/i8042.c: ed -> i8042 (parameter) [501]
> serio/i8042.c: fe <- i8042 (interrupt, aux0, 12, timeout) [544]

No keyboard.

> serio/i8042.c: 90 -> i8042 (command) [629]
> serio/i8042.c: f2 -> i8042 (parameter) [629]
> serio/i8042.c: fe <- i8042 (interrupt, aux0, 12, timeout) [673]

No mouse.
Only a port.

> serio: i8042 AUX0 port at 0x60,0x64 irq 12

Start investigating the second one. Same results.

> serio: i8042 AUX1 port at 0x60,0x64 irq 12

Start investigating the third one.

> serio/i8042.c: 92 -> i8042 (command) [1168]
> serio/i8042.c: f2 -> i8042 (parameter) [1168]
> serio/i8042.c: fe <- i8042 (interrupt, aux2, 12, bad parity) [1206]
> atkbd.c: frame/parity error: 02

This time the keyboard is really unhappy.
The kernel asks for resend. I think invoking undefined behaviour.

...
> serio/i8042.c: 92 -> i8042 (command) [3242]
> serio/i8042.c: fe -> i8042 (parameter) [3242]
> serio/i8042.c: fe <- i8042 (interrupt, aux2, 0, bad parity) [3274]
> atkbd.c: frame/parity error: 02
> serio/i8042.c: 92 -> i8042 (command) [3305]
> serio/i8042.c: fe -> i8042 (parameter) [3305]

And then the kernel crashes...
[with an interesting interrupt within interrupt crash, to be looked at]

> drivers/inp<1>Unable to handle kernel NULL pointer dereference at virtual address 0000001d

[Since you have some new experimental board, I wonder:

My docs - the numbering has changed, but today it is
 http://www.win.tue.nl/~aeb/linux/kbd/scancodes-8.html#kcc90
know about the commands 90-93 as Synaptics prefixes,
but also about the commands 90-9f that set certain lines
(on VIA chipsets).

Do you know anything about the innards? Is it supposed to follow
this Synaptics protocol?]

Do things go slightly better if you comment out the line
	serio_write(serio, ATKBD_CMD_RESEND);
in atkbd.c?

Andries

