Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262380AbSKDHu5>; Mon, 4 Nov 2002 02:50:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263794AbSKDHu5>; Mon, 4 Nov 2002 02:50:57 -0500
Received: from smtp-out-2.wanadoo.fr ([193.252.19.254]:10708 "EHLO
	mel-rto2.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S262380AbSKDHu4>; Mon, 4 Nov 2002 02:50:56 -0500
From: <benh@kernel.crashing.org>
To: "Linus Torvalds" <torvalds@transmeta.com>, "Pavel Machek" <pavel@ucw.cz>
Cc: "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: swsusp: don't eat ide disks
Date: Mon, 4 Nov 2002 08:57:09 +0100
Message-Id: <20021104075709.20542@smtp.wanadoo.fr>
In-Reply-To: <Pine.LNX.4.44.0211031439330.11657-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0211031439330.11657-100000@home.transmeta.com>
X-Mailer: CTM PowerMail 4.0.1 carbon <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Just send a request down the request list, and make sure that
>
> - the command is marked as being non-mergeable or re-orderable by 
>   software (as all special commands are)
>
> - the command is not re-orderable / mergeable by hardware (and since the
>   command in question would be something like "flush" or "spindown",
>   hardware really would be quite broken if it re-ordered it ;)
>
>and then just wait for its completion.

Ok, good, this is exactly what I was talking about in a
previous mail, escept you have the real code ;)

Though I do insist of this beeing bus ordering driven, that
is this command is to be sent down the queue by the ide-disk driver
itself, when asked for suspend by it's parent, whataver it is
(typically the PCI based controller driver).

That would exactly provide the implementation for the save_state
callback. Though there is still a small issue in using synchronize
cache vs. standby.

Our model currently specify we have save_state (which blocks IOs),
then later on, suspend, which does the actual power off. While this
is actually a good things (especially with swsusp, that should allow
us to not poweroff devices on the path to the disk, a future
optimisation avoiding a full wakeup of all devices), in this specific
case, it also means we can't use the queue at the suspend() state
to send the STANDBY command. If we send the STANDBY command (to
spin off the platters) at save_state() time instead, we get the
chance of have to wait again for re-spinning up on suspend to
disk.

Maybe the fix is as simple as doing sync. cache in save_state, standby
in suspend(), but the later beeing done without using the queue (which
is what I do in my current pmac implementation in 2.4, direct ATA reg.
blasting, ugh !). Or maybe we can find a way to carry a "hint" during
the suspend process so that save_state "knows" the device is marked
as the target for a later suspend to disk process, and "avoids"
doing a standby in that case.

What do you think ?

Ben.


