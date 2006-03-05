Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751893AbWCEWJ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751893AbWCEWJ2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 17:09:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751888AbWCEWJ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 17:09:28 -0500
Received: from mail.homelink.ru ([81.9.33.123]:61631 "EHLO eltel.net")
	by vger.kernel.org with ESMTP id S1751880AbWCEWJ1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 17:09:27 -0500
Date: Mon, 6 Mar 2006 01:09:09 +0300
From: Andrew Zabolotny <zap@homelink.ru>
To: Richard Purdie <rpurdie@rpsys.net>
Cc: adaplas@gmail.com, linux-fbdev-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: RFC: Backlight Class sysfs attribute behaviour
Message-Id: <20060306010909.190f06fe.zap@homelink.ru>
In-Reply-To: <1141571334.6521.38.camel@localhost.localdomain>
References: <1141571334.6521.38.camel@localhost.localdomain>
Organization: home
X-Mailer: Sylpheed version 2.0.0beta6 (GTK+ 2.6.7; i686-pc-linux-gnu)
X-Face: #%`a@cSvZ:n@M%n/to$C^!{JE%'%7_0xb("Hr%7Z0LDKO7?w=m~CU#d@-.2yO<l^giDz{>9
 epB|2@pe{%4[Q3pw""FeqiT6rOc>+8|ED/6=Eh/4l3Ru>qRC]ef%ojRz;GQb=uqI<yb'yaIIzq^NlL
 rf<gnIz)JE/7:KmSsR[wN`b\l8:z%^[gNq#d1\QSuya1(
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 05 Mar 2006 15:08:53 +0000
Richard Purdie <rpurdie@rpsys.net> wrote:

> The solution might be to have brightness always return the user
> requested value y and have a new attribute returning the brightness as
> determined by the driver once it accounts for all the factors it needs
> to consider. Naming of such an attribute is tricky -
> "driver_brightness" perthaps?
Maybe by analogy to sound card there can be a 'master' control, and one
'user' control. But it's not clear how many of these strings you will
need for every 'real' attribute. Why two and not three? Why three and
not ten?

But I don't think that's a kernel-side problem. I think it would be
better to have some daemon controlling these attributes (and keeping
track of as many factors as needed) and programming the final, 'true'
kernel value. Then a set of user-mode tools could be provided to alter
them, and a simple API.

> The same problem applies to the power attribute. This could easily
> confused with the other forms of power attribute in sysfs but ignoring
> that, should this report:
> 
> * The last user requested power state
> * The current power state accounting for FB blanking.
> * The current power state for device suspend/resume
Well with power it's simple: LCD is either powered or it's not. After
resuming the LCD should be always powered on, and the program can then
turn it back off if it's desired. FB blanking isn't a issue with X11/
Qtopia, as far as I understand? And finally, the 'user' requested power
state has to be tracked by the program that does the blanking (say an
audio player or such).

> Should the FB blanking override the user requested values? At the
> moment it only does unless a user changes an attributes whilst the
> display is blanked in which case the user's change overrides. This
> could be classed as a bug but solving it as straight forward as it
> sounds using only the existing backlight class functions.
Before a program changes the attribute it must check the attribute. If
it is not 0, it means the display is blanked for some reason, so the
program should not change it, unless it really wants to power up the
LCD.

> Also, at the moment this attribute reports VESA power states which can
> be confusing (0 = on, [1-3] = off).
Well it's documented in a lot of places, and besides, end-user will
never have to program lcd power attribute directly.

> Again, the solution would appear to be to return the last user
> requested power state. The driver_brightness attribute would tell you
> if the display was blanked for any other reason (although not why).
I don't think all this bookkeeping has to be done in kernel.

-- 
Greetings,
   Andrew

P.S. A wild idea: Every requester could tag it's request with its
own alphanumeric tag. That is, if GPE wants to set brightness to 50 and
turn the power on, it writes 'GPE:50' and 'GPE:1' to 'brightness' and
'power' attributes respectively. Then user' scripts would put
'JOHN:100' into brightness, and some player would put
'OpieMediaPlayer:0' into 'power'. This way the driver will always know
who wants what and could integrate all these values into one.

But I personally don't think it's worth the trouble.
