Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265212AbUHMM6n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265212AbUHMM6n (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 08:58:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265222AbUHMM6n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 08:58:43 -0400
Received: from mail-relay-1.tiscali.it ([213.205.33.41]:19586 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S265212AbUHMM6h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 08:58:37 -0400
Message-ID: <411CBADE.6060402@eidetix.com>
Date: Fri, 13 Aug 2004 14:58:06 +0200
From: "David N. Welton" <davidw@eidetix.com>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040805)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
CC: Sascha Wilde <wilde@sha-bang.de>,
       Dmitry Torokhov <dtor_core@ameritech.net>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6 kernel won't reboot on AMD system - 8042 problem?
References: <20040811141408.17933.qmail@web81304.mail.yahoo.com> <20040811175613.GA829@kenny.sha-bang.local> <411BA214.2060306@eidetix.com> <20040812201344.GA270@ucw.cz> <411C944A.3040907@eidetix.com> <20040813120357.GA907@ucw.cz>
In-Reply-To: <20040813120357.GA907@ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:

> Now I think the problem lies in that that on your i8042 issuing a
> command doesn't clear the AUXDATA bit. It's only cleared by data from
> the keyboard.

> This is likely a bug in you i8042 firmware (or hw, if it's just an
> ASIC).

Well, that has always seemed likely to me, given that rebooting without 
a keyboard is something that works on pretty much everyone else's 
machines!  But to some degree the bug ought to be worked around.

> I suppose we can get rid of the checking of data source and negation and
> be done with it.

That helps, but there are still situation(s?) where it's not a complete 
solution.  It's good enough for what I need, though.

Starting with no keyboard, plug one in:

$ drivers/input/serio/i8042.c: aa <- i8042 (interrupt, aux, 0) [161928] 

drivers/input/serio/i8042.c: 60 -> i8042 (command) [162009] 

drivers/input/serio/i8042.c: 46 -> i8042 (parameter) [162009] 

drivers/input/serio/i8042.c: d4 -> i8042 (command) [162151] 

drivers/input/serio/i8042.c: f2 -> i8042 (parameter) [162151] 

drivers/input/serio/i8042.c: fe <- i8042 (interrupt, aux, 0) [162343] 

drivers/input/serio/i8042.c: d4 -> i8042 (command) [162424] 

drivers/input/serio/i8042.c: ed -> i8042 (parameter) [162424] 

drivers/input/serio/i8042.c: fe <- i8042 (interrupt, aux, 0) [162616] 

drivers/input/serio/i8042.c: 60 -> i8042 (command) [162697] 

drivers/input/serio/i8042.c: 44 -> i8042 (parameter) [162697] 

drivers/input/serio/i8042.c: aa <- i8042 (interrupt, aux, 0) [162989] 

drivers/input/serio/i8042.c: 60 -> i8042 (command) [163070] 

drivers/input/serio/i8042.c: 46 -> i8042 (parameter) [163070] 

drivers/input/serio/i8042.c: d4 -> i8042 (command) [163212] 

drivers/input/serio/i8042.c: f2 -> i8042 (parameter) [163212] 

drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 0) [163404] 

drivers/input/serio/i8042.c: ab <- i8042 (interrupt, kbd, 0) [163485] 

drivers/input/serio/i8042.c: 41 <- i8042 (interrupt, kbd, 0) [163566] 

drivers/input/serio/i8042.c: d4 -> i8042 (command) [163792] 

drivers/input/serio/i8042.c: ed -> i8042 (parameter) [163792] 

drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 0) [163983] 

drivers/input/serio/i8042.c: 60 -> i8042 (command) [164209] 

drivers/input/serio/i8042.c: 44 -> i8042 (parameter) [164209]

Oops, it doesn't respond to anything... We unplug it and plug it back in 
again.  This time it's ok:

$ drivers/input/serio/i8042.c: aa <- i8042 (interrupt, kbd, 0) [191951] 

drivers/input/serio/i8042.c: 60 -> i8042 (command) [192032] 

drivers/input/serio/i8042.c: 45 -> i8042 (parameter) [192032] 

drivers/input/serio/i8042.c: f2 -> i8042 (kbd-data) [192174] 

drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [192247] 

drivers/input/serio/i8042.c: ab <- i8042 (interrupt, kbd, 1) [192329] 

drivers/input/serio/i8042.c: 41 <- i8042 (interrupt, kbd, 1) [192410] 

drivers/input/serio/i8042.c: ed -> i8042 (kbd-data) [192491] 

drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [192565] 

drivers/input/serio/i8042.c: 00 -> i8042 (kbd-data) [192646] 

drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [192719] 

drivers/input/serio/i8042.c: f3 -> i8042 (kbd-data) [192801] 

drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [192874] 

drivers/input/serio/i8042.c: 00 -> i8042 (kbd-data) [192956] 

drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [193029] 

drivers/input/serio/i8042.c: f4 -> i8042 (kbd-data) [193110] 

drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [193184] 

input: AT Translated Set 2 keyboard on isa0060/serio0

This, because it checks in i8042_interrupt to see if the nefarious 
STR_AUXDATA is set, which it is...  According to your hypothesis, 
plugging the keyboard in and hitting a few keys would have cleared the 
AUXDATA bit, so the next time around it works fine.

Thanks,
-- 
David N. Welton
davidw@eidetix.com
