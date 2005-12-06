Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932339AbVLFRQn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932339AbVLFRQn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 12:16:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932447AbVLFRQn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 12:16:43 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:59913 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932339AbVLFRQn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 12:16:43 -0500
Date: Tue, 6 Dec 2005 17:16:34 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Sachin Sant <sachinp@in.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] [PATCH] Adding ctrl-o sysrq hack support to 8250 driver
Message-ID: <20051206171633.GB19664@flint.arm.linux.org.uk>
Mail-Followup-To: Sachin Sant <sachinp@in.ibm.com>,
	lkml <linux-kernel@vger.kernel.org>
References: <438D8A3A.9030400@in.ibm.com> <20051130130429.GB25032@flint.arm.linux.org.uk> <43953440.9070102@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43953440.9070102@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 06, 2005 at 12:18:32PM +0530, Sachin Sant wrote:
> >Why are you doing this and not using uart_handle_break()?
> >
> >Do you realise that this enables sysrq support for _any_ 8250 serial
> >port, be it console or not?
>
> At present we have ctrl-break that works over a serial connection. But 
> there are few instances where the above does not works. Consider the 
> following senarios
> 
> p615, power4, no-hmc configuration.
> 
> I attached an IBM 3153 (a "real" tty) to the serial port.I then observed
> that neither ctrl-o or the tty's ctrl-SysRq_key worked.  (but ctrl-o did 
> still work with the patched kernel, of course).  However, the 
> ctrl-Break_key does work on the native tty, taking the place of the 
> ctrl-o on vterms.

Frown.  Sorry, I'm not sure what "p615", "power4" and "no-hmc" is.  I
also don't know what an IBM 3153 is.

However, you seem to be suggesting that a terminal application somehow
forwards the ctrl-sysrq (and it's actually alt-sysrq).  Maybe it does,
maybe it doesn't.  Probably depends on the terminal application itself.

Eg, with minicom, you need to ask minicom to create the serial break
event itself, normally by (assuming default configuration) <ctrl-a> <f>.

> So in summary, ctrl-Break works. I then re-attached the 
> cu cable (both are defined alike as ttyS0 and give login's) and 
> re-verified that ctrl-Break stopped working.
> 
> In the future, if this configuration is found hung, then (provided sysrq 
> was enabled), attach a physical tty and use ctrl-Break to debug.
> 
> 2nd configuration: p630, hmc-attached, booted in "full-system partition" 
> mode.Everything in the first configuration applied here too.

At around this point, I'm starting to loose track of this email -
please can you format the message better, eg use at least one space
(preferably two) after a full stop and separate up what you want to
say into easy to read paragraphs.

> There is 
> only a slight diff in the way the console works.Since the hmc is 
> attached, the "vterm" on the hmc will be the console.However, when it is 
> booted in "full-system partition" mode, the OS sees that console as 
> ttyS0 - just like a non-hmc attached connection.Unfortunately, neither 
> the ctrl-o nor the ctrl-Break works on this either (just like the cu 
> session above).The only way to get ctrl-Break to work is to "close the 
> terminal" operation on the hmc, and then attach and turn on a real tty 
> onto the lowest serial port (not the "HMC" port) on the p630.  You can't 
> have both running at the same time, because they both configure as 
> ttyS0.  Then with the real tty attached, you can use ctrl-Break to debug.
> 
> So the general idea behind this patch was to make the behaviour of 
> invoking sysrq key more consistent over virtual and real consoles. It's 
> not a must but would be nice to have this functionality.

I don't think you've addressed my concern... but I'm afraid I haven't
been able to properly follow what you're saying.

In any case, applying this patch means that you _permanently_ prevent
the reception of ^O on _ANY_ 8250 serial port, whether it be a serial
console or not.

With this patch, I guess it's tough luck if you have a modem connected
to your PC and you want to run ppp or x,y,z modem protocols.

> >We don't drop the lock when calling uart_handle_sysrq_char() further
> >down in this function.  Why is this needed?  Also, why is this needed
> >to be duplicated?
>
> You are correct. This is not needed. I have removed this piece of code.
> 
> How about the following patch.

I'm still highly concerned about this whole idea.  Applying this patch
_will_ without doubt inconvenience a lot of people who expect ^O to be
received as normal.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
