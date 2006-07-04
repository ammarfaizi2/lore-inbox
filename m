Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932351AbWGDTnB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932351AbWGDTnB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 15:43:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932352AbWGDTnB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 15:43:01 -0400
Received: from perninha.conectiva.com.br ([200.140.247.100]:30353 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S932351AbWGDTnA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 15:43:00 -0400
Date: Tue, 4 Jul 2006 16:42:57 -0300
From: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
To: Paul Fulghum <paulkf@microgate.com>
Cc: Greg KH <gregkh@suse.de>, Russell King <rmk+lkml@arm.linux.org.uk>,
       Pete Zaitcev <zaitcev@redhat.com>, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: Serial-Core: USB-Serial port current issues.
Message-ID: <20060704164257.03e70301@doriath.conectiva>
In-Reply-To: <1151369349.2600.19.camel@localhost.localdomain>
References: <20060613192829.3f4b7c34@home.brethil>
	<20060614152809.GA17432@flint.arm.linux.org.uk>
	<20060620161134.20c1316e@doriath.conectiva>
	<20060620193233.15224308.zaitcev@redhat.com>
	<20060621133500.18e82511@doriath.conectiva>
	<20060621164336.GD24265@flint.arm.linux.org.uk>
	<20060621181513.235fc23c@doriath.conectiva>
	<20060622082939.GA25212@flint.arm.linux.org.uk>
	<20060623142842.2b35103b@home.brethil>
	<20060626222628.GC29325@suse.de>
	<1151369349.2600.19.camel@localhost.localdomain>
Organization: Mandriva
X-Mailer: Sylpheed-Claws 2.4.0-rc2 (GTK+ 2.9.4; i586-mandriva-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 Hi Paul,

On Mon, 26 Jun 2006 19:49:09 -0500
Paul Fulghum <paulkf@microgate.com> wrote:

| On Mon, 2006-06-26 at 15:26 -0700, Greg KH wrote:
| > On Fri, Jun 23, 2006 at 02:28:42PM -0300, Luiz Fernando N. Capitulino wrote:
| > > On Thu, 22 Jun 2006 09:29:40 +0100
| > > Russell King <rmk+lkml@arm.linux.org.uk> wrote:
| > > 
| > > | 
| > > | Consider this scenario with what you're proposing:
| > > | 
| > > | 	thread				irq
| > > | 
| > > | 	take mutex
| > > | 	get_mctrl
| > > | 					cts changes state
| > > | 					take port lock
| > > | 					mctrl state read
| > > | 					tty->hw_stopped changed state
| > > | 					release port lock
| > > | 	releaes mutex
| > > | 	take port lock
| > > | 	update tty->hw_stopped
| > > | 	release port lock
| > > | 
| > > | Now, tty->hw_stopped does not reflect the hardware state, which will be
| > > | buggy and can cause a loss of transmission.
| > > | 
| > > | I'm not sure what to suggest on this one since for USB drivers you do
| > > | need to be able to sleep in this method... but for UARTs you must not.
| 
| What about this ugly fragment?
| (assuming get_mctrl not called from IRQ)

 What's the problem with get_mctrl() being called from IRQ?

 Note that get_mctrl() is a callback and the driver is free to call _its_
get_mctrl() from IRQ if it wants to.

|   take mutex
|   take port lock
| again:
|   save local copy of icount
|   release port lock
|   get_mctrl
|   take port lock
|   if (icount changed)
|     goto again
|   update tty->hw_stopped
|   release port lock
|   release mutex

 Well, I think it'd work. But how can we keep track of 'icount'?
Should the driver add 1 if it updates 'tty->hw_stopped'?

PS: Sorry for the long delay, I was off last week.

-- 
Luiz Fernando N. Capitulino
