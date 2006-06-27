Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964809AbWF0AzS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964809AbWF0AzS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 20:55:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964807AbWF0AzR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 20:55:17 -0400
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:21922
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S964809AbWF0AzP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 20:55:15 -0400
Subject: Re: Serial-Core: USB-Serial port current issues.
From: Paul Fulghum <paulkf@microgate.com>
To: Greg KH <gregkh@suse.de>
Cc: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Pete Zaitcev <zaitcev@redhat.com>, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
In-Reply-To: <20060626222628.GC29325@suse.de>
References: <20060613192829.3f4b7c34@home.brethil>
	 <20060614152809.GA17432@flint.arm.linux.org.uk>
	 <20060620161134.20c1316e@doriath.conectiva>
	 <20060620193233.15224308.zaitcev@redhat.com>
	 <20060621133500.18e82511@doriath.conectiva>
	 <20060621164336.GD24265@flint.arm.linux.org.uk>
	 <20060621181513.235fc23c@doriath.conectiva>
	 <20060622082939.GA25212@flint.arm.linux.org.uk>
	 <20060623142842.2b35103b@home.brethil>  <20060626222628.GC29325@suse.de>
Content-Type: text/plain
Date: Mon, 26 Jun 2006 19:49:09 -0500
Message-Id: <1151369349.2600.19.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-06-26 at 15:26 -0700, Greg KH wrote:
> On Fri, Jun 23, 2006 at 02:28:42PM -0300, Luiz Fernando N. Capitulino wrote:
> > On Thu, 22 Jun 2006 09:29:40 +0100
> > Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> > 
> > | 
> > | Consider this scenario with what you're proposing:
> > | 
> > | 	thread				irq
> > | 
> > | 	take mutex
> > | 	get_mctrl
> > | 					cts changes state
> > | 					take port lock
> > | 					mctrl state read
> > | 					tty->hw_stopped changed state
> > | 					release port lock
> > | 	releaes mutex
> > | 	take port lock
> > | 	update tty->hw_stopped
> > | 	release port lock
> > | 
> > | Now, tty->hw_stopped does not reflect the hardware state, which will be
> > | buggy and can cause a loss of transmission.
> > | 
> > | I'm not sure what to suggest on this one since for USB drivers you do
> > | need to be able to sleep in this method... but for UARTs you must not.

What about this ugly fragment?
(assuming get_mctrl not called from IRQ)

  take mutex
  take port lock
again:
  save local copy of icount
  release port lock
  get_mctrl
  take port lock
  if (icount changed)
    goto again
  update tty->hw_stopped
  release port lock
  release mutex

--
Paul





