Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262707AbTJNSR7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 14:17:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262719AbTJNSR7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 14:17:59 -0400
Received: from vana.vc.cvut.cz ([147.32.240.58]:39833 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id S262707AbTJNSQV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 14:16:21 -0400
Date: Tue, 14 Oct 2003 20:16:06 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: vojtech@suse.cz
Cc: Zwane Mwaikambo <zwane@linuxpower.ca>, linux-kernel@vger.kernel.org
Subject: Re: Another keyboard woes with 2.6.0...
Message-ID: <20031014181606.GD21740@vana.vc.cvut.cz>
References: <20030912165044.GA14440@vana.vc.cvut.cz> <Pine.LNX.4.53.0309121341380.6886@montezuma.fsmlabs.com> <20030916232318.A1699@pclin040.win.tue.nl> <20031006220847.GA5139@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031006220847.GA5139@vana.vc.cvut.cz>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 07, 2003 at 12:08:47AM +0200, Petr Vandrovec wrote:
> On Tue, Sep 16, 2003 at 11:23:18PM +0200, Andries Brouwer wrote:
> > 
> > I am especially interested in cases where people can reproduce
> > an unwanted key repeat. The question is: is this a bug in our timer code
> > or use of timers, or did the keyboard never send the key release code?
> > 
> > (#define DEBUG in i8042.c)
> 
> Hi,
>   after three weeks running with DEBUG enabled I decided (well, I lost this patch
> somewhere while patching my kernel sometime last week) to disable it - and kaboom, I
> got (twice, but yesterday I rebooted box hard, as I thought that it is dead)
> strange lockup, where box stoped reacting on keyboard. After playing with
> mouse's cut&paste I was able to get at dmesg, and after 'setleds -V +num' keyboard
> returned back to live.
> 
>   And it looks to me like a genuine race. When I was switching from console
> with numlock enabled to console with numlock disabled, message below was printed
> by kernel, and keyboard stopped working (probably waiting for second byte from
> setleds command). I'll now reenable DEBUG in i8042, and problem will hopefully
> disappear...
> 
> atkbd.c: Unknown key released (translated set 2, code 0x165, data 0xfa, on isa0060/serio0).

Got it again. This time with detailed logging. We start sending ED xx when we were
in the middle of E0 xx sequence, and things went downhill. Reconnecting keyboard
was only way to go. 

As far as I can see, my keyboard stops sending scancodes when it receives ED command, and continues
only when it receives second data byte, for making life easier for driver writters (or maybe
it is specced that way, who knows). Unfortunately we never sent second byte of command.

Kernel was 2.6.0-test7-bk5 (or something simillar, from yesterday's evening bitkeeper).
								Petr Vandrovec


Oct 14 19:59:17 ppc kernel: drivers/input/serio/i8042.c: e0 <- i8042 (interrupt, kbd, 1) [30114238]
Oct 14 19:59:17 ppc kernel: drivers/input/serio/i8042.c: 4b <- i8042 (interrupt, kbd, 1) [30114244]
Oct 14 19:59:17 ppc kernel: drivers/input/serio/i8042.c: e0 <- i8042 (interrupt, kbd, 1) [30114336]
Oct 14 19:59:17 ppc kernel: drivers/input/serio/i8042.c: cb <- i8042 (interrupt, kbd, 1) [30114347]
Oct 14 19:59:17 ppc kernel: drivers/input/serio/i8042.c: e0 <- i8042 (interrupt, kbd, 1) [30114733]
Oct 14 19:59:17 ppc kernel: drivers/input/serio/i8042.c: 4d <- i8042 (interrupt, kbd, 1) [30114738]
Oct 14 19:59:17 ppc kernel: drivers/input/serio/i8042.c: e0 <- i8042 (interrupt, kbd, 1) [30114823]
Oct 14 19:59:17 ppc kernel: drivers/input/serio/i8042.c: cd <- i8042 (interrupt, kbd, 1) [30114834]
Oct 14 19:59:18 ppc kernel: drivers/input/serio/i8042.c: e0 <- i8042 (interrupt, kbd, 1) [30115068]
Oct 14 19:59:18 ppc kernel: drivers/input/serio/i8042.c: 4d <- i8042 (interrupt, kbd, 1) [30115073]
Oct 14 19:59:18 ppc kernel: drivers/input/serio/i8042.c: ed -> i8042 (kbd-data) [30115074]
Oct 14 19:59:18 ppc kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [30115077]
Oct 14 19:59:18 ppc kernel: drivers/input/serio/i8042.c: 02 -> i8042 (kbd-data) [30115077]
Oct 14 19:59:18 ppc kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [30115081]
Oct 14 19:59:18 ppc kernel: drivers/input/serio/i8042.c: e0 <- i8042 (interrupt, kbd, 1) [30115148]
Oct 14 19:59:18 ppc kernel: drivers/input/serio/i8042.c: cd <- i8042 (interrupt, kbd, 1) [30115159]
Oct 14 19:59:18 ppc kernel: drivers/input/serio/i8042.c: e0 <- i8042 (interrupt, kbd, 1) [30115293]
Oct 14 19:59:18 ppc kernel: drivers/input/serio/i8042.c: 2a <- i8042 (interrupt, kbd, 1) [30115298]
Oct 14 19:59:18 ppc kernel: drivers/input/serio/i8042.c: e0 <- i8042 (interrupt, kbd, 1) [30115304]
Oct 14 19:59:18 ppc kernel: drivers/input/serio/i8042.c: 4d <- i8042 (interrupt, kbd, 1) [30115309]
Oct 14 19:59:18 ppc kernel: drivers/input/serio/i8042.c: e0 <- i8042 (interrupt, kbd, 1) [30115325]
Oct 14 19:59:18 ppc kernel: drivers/input/serio/i8042.c: cd <- i8042 (interrupt, kbd, 1) [30115335]
Oct 14 19:59:18 ppc kernel: drivers/input/serio/i8042.c: e0 <- i8042 (interrupt, kbd, 1) [30115341]
Oct 14 19:59:18 ppc kernel: drivers/input/serio/i8042.c: ed -> i8042 (kbd-data) [30115342]
Oct 14 19:59:18 ppc kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [30115346]
Oct 14 19:59:18 ppc kernel: atkbd.c: Unknown key released (translated set 2, code 0x165, data 0xfa, on isa0060/serio0).
Oct 14 19:59:35 ppc kernel: drivers/input/serio/i8042.c: 28 <- i8042 (interrupt, aux, 12) [30131884]
Oct 14 19:59:35 ppc kernel: drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux, 12) [30131885]
Oct 14 19:59:35 ppc kernel: drivers/input/serio/i8042.c: ff <- i8042 (interrupt, aux, 12) [30131887]
Oct 14 19:59:35 ppc kernel: drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux, 12) [30131888]
Oct 14 19:59:35 ppc kernel: drivers/input/serio/i8042.c: 18 <- i8042 (interrupt, aux, 12) [30131894]
Oct 14 19:59:35 ppc kernel: drivers/input/serio/i8042.c: fd <- i8042 (interrupt, aux, 12) [30131895]
... removed dozens of lines where I was moving mouse ...
Oct 14 19:59:53 ppc kernel: drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux, 12) [30150297]
Oct 14 19:59:53 ppc kernel: drivers/input/serio/i8042.c: 08 <- i8042 (interrupt, aux, 12) [30150317]
Oct 14 19:59:53 ppc kernel: drivers/input/serio/i8042.c: 01 <- i8042 (interrupt, aux, 12) [30150318]
Oct 14 19:59:53 ppc kernel: drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux, 12) [30150319]
Oct 14 19:59:53 ppc kernel: drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux, 12) [30150320]
[disconnected & connected back keyboard]
Oct 14 20:00:25 ppc kernel: drivers/input/serio/i8042.c: ff <- i8042 (interrupt, kbd, 1, timeout) [30182119]
Oct 14 20:00:25 ppc kernel: atkbd.c: Unknown key released (translated set 2, code 0x6e, data 0xff, on isa0060/serio0).
Oct 14 20:00:25 ppc kernel: drivers/input/serio/i8042.c: aa <- i8042 (interrupt, kbd, 1) [30182791]
Oct 14 20:00:25 ppc kernel: drivers/input/serio/i8042.c: 60 -> i8042 (command) [30182791]
Oct 14 20:00:25 ppc kernel: drivers/input/serio/i8042.c: 46 -> i8042 (parameter) [30182791]
Oct 14 20:00:25 ppc kernel: drivers/input/serio/i8042.c: 60 -> i8042 (command) [30182791]
Oct 14 20:00:25 ppc kernel: drivers/input/serio/i8042.c: 47 -> i8042 (parameter) [30182791]
Oct 14 20:00:25 ppc kernel: drivers/input/serio/i8042.c: f2 -> i8042 (kbd-data) [30182791]
Oct 14 20:00:25 ppc kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [30182795]
Oct 14 20:00:25 ppc kernel: drivers/input/serio/i8042.c: ab <- i8042 (interrupt, kbd, 1) [30182796]
Oct 14 20:00:25 ppc kernel: drivers/input/serio/i8042.c: 41 <- i8042 (interrupt, kbd, 1) [30182798]
Oct 14 20:00:25 ppc kernel: drivers/input/serio/i8042.c: ed -> i8042 (kbd-data) [30182798]
Oct 14 20:00:25 ppc kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [30182801]
Oct 14 20:00:25 ppc kernel: drivers/input/serio/i8042.c: 00 -> i8042 (kbd-data) [30182801]
Oct 14 20:00:25 ppc kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [30182805]
Oct 14 20:00:25 ppc kernel: drivers/input/serio/i8042.c: f3 -> i8042 (kbd-data) [30182805]
Oct 14 20:00:25 ppc kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [30182809]
Oct 14 20:00:25 ppc kernel: drivers/input/serio/i8042.c: 00 -> i8042 (kbd-data) [30182809]
Oct 14 20:00:25 ppc kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [30182812]
Oct 14 20:00:25 ppc kernel: drivers/input/serio/i8042.c: f4 -> i8042 (kbd-data) [30182812]
Oct 14 20:00:25 ppc kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [30182816]
Oct 14 20:00:25 ppc kernel: input: AT Translated Set 2 keyboard on isa0060/serio0
Oct 14 20:00:29 ppc kernel: drivers/input/serio/i8042.c: 45 <- i8042 (interrupt, kbd, 1) [30186679]
Oct 14 20:00:29 ppc kernel: drivers/input/serio/i8042.c: ed -> i8042 (kbd-data) [30186679]
Oct 14 20:00:29 ppc kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [30186683]
Oct 14 20:00:29 ppc kernel: drivers/input/serio/i8042.c: 02 -> i8042 (kbd-data) [30186683]
Oct 14 20:00:29 ppc kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [30186687]
Oct 14 20:00:29 ppc kernel: drivers/input/serio/i8042.c: c5 <- i8042 (interrupt, kbd, 1) [30186770]
Oct 14 20:00:30 ppc kernel: drivers/input/serio/i8042.c: 45 <- i8042 (interrupt, kbd, 1) [30186986]
Oct 14 20:00:30 ppc kernel: drivers/input/serio/i8042.c: ed -> i8042 (kbd-data) [30186986]
Oct 14 20:00:30 ppc kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [30186991]
Oct 14 20:00:30 ppc kernel: drivers/input/serio/i8042.c: 00 -> i8042 (kbd-data) [30186991]
Oct 14 20:00:30 ppc kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [30186994]
Oct 14 20:00:30 ppc kernel: drivers/input/serio/i8042.c: c5 <- i8042 (interrupt, kbd, 1) [30187057]
