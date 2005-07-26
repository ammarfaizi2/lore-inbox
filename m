Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261748AbVGZMiH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261748AbVGZMiH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 08:38:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261751AbVGZMiH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 08:38:07 -0400
Received: from web30313.mail.mud.yahoo.com ([68.142.201.231]:1150 "HELO
	web30313.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S261748AbVGZMiG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 08:38:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=4CvTHT8QUeZ52vvlXozJR4Lpi/p7PYHeWirDyEY5MkpAHn6vRAwXcVoFyzuvt3i/9hejZhF19t4dMwvY42Q9ITd9Mn1dcy6nGcznSCahnaGhHLI1Fl59Rbcg5rDcqxwCita5OmcPPt7efwpamZujcJRIilqWSbwW91SHC6dtrvo=  ;
Message-ID: <20050726123802.54412.qmail@web30313.mail.mud.yahoo.com>
Date: Tue, 26 Jul 2005 13:38:02 +0100 (BST)
From: Mark Underwood <basicmark@yahoo.com>
Subject: Re: Linux tty layer hackery: Heads up and RFC
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Rogier Wolff <R.E.Wolff@BitWizard.nl>, linux-kernel@vger.kernel.org
In-Reply-To: <1122376291.2542.15.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

Thanks for your help, I might give this ago once I've
fixed some flow control problems in my driver.

On a loosely related topic I have extended
serial_core.c to handle DMA UARTS (only the TX path is
effected). Once I'm happy with my changes I post a
patch.

Best Regards,

Mark

--- Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> On Maw, 2005-07-26 at 10:55 +0100, Mark Underwood
> wrote:
> > What my driver would like to do is to handle its
> own
> > input buffers. It would pass the buffer to the tty
> > layer when it is full and the tty layer would pass
> the
> 
> In theory you can do that already, although the
> locking is a bit screwed
> up for it. Actually all the tty locking is broken
> for rx I believe.
> Everyone should be holding the tty read lock when
> updating flip buffers
> but right now we don't
> 
> > buffer back once it has drained the data from it.
> > The problem is that I don't always receive a block
> > worth of characters so I also need to pass the tty
> > layer a buffer (which I'm still DMAing into) with
> a
> > count of how many chars there are in the buffer
> and a
> > offset of where to start from.
> 
> You can do this now providing you don't do it
> blindly from IRQ context.
> 
> >From a workqueue do
> 
> 	struct tty_ldisc *ld = tty_ldisc_ref(tty);
> 	int space;
> 
> 	if(ld == NULL)	/* Bin/defer */
> 		return;
> 	space = ld->receive_room(tty);
> 	if(count > space) count = space;
> 
> 	ld->receive_buf(tty, charbuf, flagbuf, count);
> 
> 
> There is a corner case if TTY_DONT_FLIP is set where
> you should queue
> but not all drivers do this and the DONT_FLIP hack
> 'has to die' 
> 
> -
> To unsubscribe from this list: send the line
> "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at 
> http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 



		
___________________________________________________________ 
How much free photo storage do you get? Store your holiday 
snaps for FREE with Yahoo! Photos http://uk.photos.yahoo.com
