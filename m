Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751806AbWFWRZD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751806AbWFWRZD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 13:25:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751809AbWFWRZC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 13:25:02 -0400
Received: from perninha.conectiva.com.br ([200.140.247.100]:37508 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S1751806AbWFWRZB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 13:25:01 -0400
Date: Fri, 23 Jun 2006 14:28:42 -0300
From: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Pete Zaitcev <zaitcev@redhat.com>, gregkh@suse.de,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: Serial-Core: USB-Serial port current issues.
Message-ID: <20060623142842.2b35103b@home.brethil>
In-Reply-To: <20060622082939.GA25212@flint.arm.linux.org.uk>
References: <20060613192829.3f4b7c34@home.brethil>
	<20060614152809.GA17432@flint.arm.linux.org.uk>
	<20060620161134.20c1316e@doriath.conectiva>
	<20060620193233.15224308.zaitcev@redhat.com>
	<20060621133500.18e82511@doriath.conectiva>
	<20060621164336.GD24265@flint.arm.linux.org.uk>
	<20060621181513.235fc23c@doriath.conectiva>
	<20060622082939.GA25212@flint.arm.linux.org.uk>
Organization: Mandriva
X-Mailer: Sylpheed-Claws 1.0.4 (GTK+ 1.2.10; x86_64-mandriva-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Jun 2006 09:29:40 +0100
Russell King <rmk+lkml@arm.linux.org.uk> wrote:

| On Wed, Jun 21, 2006 at 06:15:13PM -0300, Luiz Fernando N. Capitulino wrote:
|
| > | With get_mctrl(), the situation is slightly more complicated, because
| > | we need to atomically update tty->hw_stopped in some circumstances
| > | (that may also be modified from irq context.)  Therefore, to give
| > | the driver a consistent locking picture, the spinlock is _always_
| > | held.
| > 
| >  Is it too bad (wrong?) to only protect the tty->hw_stopped update
| > by the spinlock? Then the call to get_mctrl() could be protected by
| > a mutex, or is it messy?
| 
| Consider this scenario with what you're proposing:
| 
| 	thread				irq
| 
| 	take mutex
| 	get_mctrl
| 					cts changes state
| 					take port lock
| 					mctrl state read
| 					tty->hw_stopped changed state
| 					release port lock
| 	releaes mutex
| 	take port lock
| 	update tty->hw_stopped
| 	release port lock
| 
| Now, tty->hw_stopped does not reflect the hardware state, which will be
| buggy and can cause a loss of transmission.
| 
| I'm not sure what to suggest on this one since for USB drivers you do
| need to be able to sleep in this method... but for UARTs you must not.

 Neither do I. :((

 I thought we could move the 'tty->hw_stopped' update to a workqueue
but it has the same problem you explained above...

 Greg, any suggestions?

-- 
Luiz Fernando N. Capitulino
