Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265245AbUHMKOp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265245AbUHMKOp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 06:14:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269049AbUHMKOp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 06:14:45 -0400
Received: from mail-relay-2.tiscali.it ([213.205.33.42]:64134 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S265245AbUHMKOj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 06:14:39 -0400
Message-ID: <411C944A.3040907@eidetix.com>
Date: Fri, 13 Aug 2004 12:13:30 +0200
From: "David N. Welton" <davidw@eidetix.com>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040805)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
CC: Sascha Wilde <wilde@sha-bang.de>,
       Dmitry Torokhov <dtor_core@ameritech.net>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6 kernel won't reboot on AMD system - 8042 problem?
References: <20040811141408.17933.qmail@web81304.mail.yahoo.com> <20040811175613.GA829@kenny.sha-bang.local> <411BA214.2060306@eidetix.com> <20040812201344.GA270@ucw.cz>
In-Reply-To: <20040812201344.GA270@ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:

> All in all, 0x65 is what one would expect to be in the CTR register
> after boot on a normal machine without a PS/2 mouse installed.

Sure, if you search google on the results from the 20 command, you see a 
lot of things like 0x64 0x64 0x75 0x74 and similar values.

> 0x9a doesn't make sense _AT_ALL_, though!

Right.

> And there comes a thought ... 
> 
> In i8042_command(), we do this:
> 
>       if (!retval)
>                 for (i = 0; i < ((command >> 8) & 0xf); i++) {
>                         if ((retval = i8042_wait_read())) break;
>                         if (i8042_read_status() & I8042_STR_AUXDATA)
>                                 param[i] = ~i8042_read_data();
>                         else
>                                 param[i] = i8042_read_data();
>                         dbg("%02x <- i8042 (return)", param[i]);
>                 }
> 
> to distinguish whether a response came from the AUX interface instead of
> the KBD or controller itself. We _negate_ the value if the AUXDATA bit is
> set in he status register.

Oh, yep, there we go... that's what's switching it around.

> So I think what happens is that the controller sets the AUXDATA bit for
> some reason (or at least we read a status byte with the AUXDATA bit
> set), which negates the value when we read the initial CTR. 

> Then when we write that nonsensical CTR back to the controller on
> reboot, we're screwed, since the i8042 is the more important CPU in the
> system and can do many nasty things to it. ;)

> Now, the question is, where does that AUXDATA bit come from?

I noticed that the FreeBSD folks attempt to flush both kbd and aux:

http://fxr.watson.org/fxr/source/dev/kbd/atkbdc.c#L790

I tried doing that like so:

	while ((i8042_read_status() & (I8042_STR_OBF | I8042_STR_AUXDATA)) && 
(i++ < I8042_BUFFER_SIZE)) {
		data = i8042_read_data();
		dbg("%02x <- i8042 (flush, %s)", data,
			i8042_read_status() & I8042_STR_AUXDATA ? "aux" : "kbd");
	}

with different variations, and it seems as if it will go on reading 
forever if you let it.  So it keeps reporting AUXDATA as being 
present...  Hrm...

-- 
David N. Welton
davidw@eidetix.com
