Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267146AbUBMSaZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 13:30:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267154AbUBMSaZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 13:30:25 -0500
Received: from smtp810.mail.sc5.yahoo.com ([66.163.170.80]:6738 "HELO
	smtp810.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S267146AbUBMS14 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 13:27:56 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Strange atkbd messages with missing keyboard
Date: Fri, 13 Feb 2004 13:27:46 -0500
User-Agent: KMail/1.6
Cc: Meelis Roos <mroos@linux.ee>, Vojtech Pavlik <vojtech@suse.cz>
References: <Pine.GSO.4.44.0402131509160.18344-100000@math.ut.ee>
In-Reply-To: <Pine.GSO.4.44.0402131509160.18344-100000@math.ut.ee>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200402131327.46543.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 13 February 2004 08:12 am, Meelis Roos wrote:
> > Meelis, can you please enable DEBUG in i8042.c, so that I can check
> > where these unexpected NAKs come from?
> 
> Here is full dmesg (though probably only the serio and atkbd lines are
> interesting).
> 

> drivers/input/serio/i8042.c: d4 -> i8042 (command) [3]
> drivers/input/serio/i8042.c: f2 -> i8042 (parameter) [3]
> drivers/input/serio/i8042.c: d4 -> i8042 (command) [109]
> drivers/input/serio/i8042.c: ed -> i8042 (parameter) [109]
> drivers/input/serio/i8042.c: fe <- i8042 (interrupt, aux, 12, timeout) [122]
> drivers/input/serio/i8042.c: 60 -> i8042 (command) [122]
> drivers/input/serio/i8042.c: 54 -> i8042 (parameter) [122]
> drivers/input/serio/i8042.c: fe <- i8042 (interrupt, aux, 12, timeout) [240]
> atkbd.c: Unknown key pressed (raw set 0, code 0x17e on isa0060/serio1).
> atkbd.c: Use 'setkeycodes 7e <keycode>' to make it known.

I see that we are not getting a NAK when querying ID but getting it while
setting LEDs (or even writing to the control register later). It seems
like controller's timeout is longer than our internal one so we getting
timeout signal from keyboard (which we convert to a NAK) too late.

I wonder if changing timeout in atkbd_sendbyte to 400 or 500 ms will
cure the problem.

-- 
Dmitry
