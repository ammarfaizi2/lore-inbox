Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261159AbUBTXCi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 18:02:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261419AbUBTXCf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 18:02:35 -0500
Received: from gate.crashing.org ([63.228.1.57]:46763 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261159AbUBTXCc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 18:02:32 -0500
Subject: Re: fb_console_init fix.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: James Simmons <jsimmons@infradead.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0402202156340.6798-100000@phoenix.infradead.org>
References: <Pine.LNX.4.44.0402202156340.6798-100000@phoenix.infradead.org>
Content-Type: text/plain
Message-Id: <1077317816.9623.20.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 21 Feb 2004 09:56:56 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-02-21 at 08:58, James Simmons wrote:
> Hi!
> 
>   This patch fixes fb_console_init from being called twice. I still need 
> to fix set_con2fb but this helps but this is still important to get in.

I hate those #ifdef MODULE. They are plaguing the drivers too, because
of our crazy initialization scheme...

(Linus: that patch should still go in, doing better is probably a
2.7 target in this case).

If we want the fb stuff to be initialized before other drivers, we
probably want to create an init step before devices and after PCI
probe, but is that really necessary ?

The core fbdev should just need a subsys initcall. fbcon could use
that too and register a notifier. Then we could use the notifier
mecanism to notify fbcon when fbdev's are added (from
register_framebuffer) and get rid of all of the init crap

The only remaining junk is to deal with the setup= stuff, but
then, it could be done by having the drivers provide their
"name" string & setup function in the ops structure passed
on register, and have us call back the driver straight away,
though that's a big change of the way drivers are initialized.

Or we could add an fb_check_setup("name", my_driver_setup) call
to be done by the drivers before register_framebuffer is called


Ben
.


