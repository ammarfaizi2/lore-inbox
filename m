Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261329AbTD3Qh0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 12:37:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261383AbTD3Qh0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 12:37:26 -0400
Received: from mail.eskimo.com ([204.122.16.4]:32265 "EHLO mail.eskimo.com")
	by vger.kernel.org with ESMTP id S261329AbTD3QhZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 12:37:25 -0400
Date: Wed, 30 Apr 2003 09:46:41 -0700
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, vda@port.imtp.ilyichevsk.odessa.ua,
       Nick Piggin <piggin@cyberone.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Bug in linux kernel when playing DVDs.
Message-ID: <20030430164641.GA8731@eskimo.com>
References: <3EABB532.5000101@superbug.demon.co.uk> <200304290538.h3T5cLu16097@Port.imtp.ilyichevsk.odessa.ua> <3EAE220D.4010602@cyberone.com.au> <200304301202.h3UC2eu23935@Port.imtp.ilyichevsk.odessa.ua> <1051704438.19573.20.camel@dhcp22.swansea.linux.org.uk> <3EAFEA83.9030301@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EAFEA83.9030301@superbug.demon.co.uk>
User-Agent: Mutt/1.5.4i
From: Elladan <elladan@eskimo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 30, 2003 at 04:23:47PM +0100, James Courtier-Dutton wrote:
> Alan Cox wrote:
> >
> >NOTABUG
> >
> >User space keeps asking it to read so it keeps using CPU, fix the user
> >space
> 
> The application does an initial seek() command, which succeeds.
> It then just does read() commands for then on.
> For bug tracking, I have put printf statements in my application.
> I.e.
>
> [...]
> 
> When an error occurs on the DVD, "read done" message is never printed on 
> the console and all applications fail to respond to user input. This is 
> why I thought that the kernel hogs CPU 100% and the application never 
> receives the error message.
> If I force a different error "tray open", by using a pin in the manual 
> eject hole on the front of the dvd rom device, I then see the "read 
> done" message and everything comes back to life.

Are you sure it never returns, ever?

The behavior most people seem to see here 90% of the time seems to be
that the IDE layer retries the request a few dozen times before
returning an error result.  This usually takes 1-5 minutes.

So, does it return if you, say, go to lunch and then come back?

Of course, the other 10% of the time, things do seem to become
completely broken.  I've certainly observed this sort of behavior
before.

Not to mention, blocking for 1-5 minutes even on a CD-ROM read is
broken, and is certainly very unwanted for the task of playing a DVD.  I
think there needs to be a documented call to tell the kernel that the
application prefers to get I/O errors immediately instead of retries,
and it should always use a lot fewer retries on removable devices where
damaged media is common.

The other bug here is that the IDE layer seems uninterruptible in
software while it's doing this.  The tasks go into uninterruptible sleep
for up to 5 minutes at a time (sometimes forever), and can't be stopped
except by forcing a hardware exception eg. with eject.  You really need
to be able to kill a task and interrupt the file operation somehow when
it's in some sort of long-term CD error recovery situation.

-J
