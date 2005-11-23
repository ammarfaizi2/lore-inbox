Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750734AbVKWMHG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750734AbVKWMHG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 07:07:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750740AbVKWMHG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 07:07:06 -0500
Received: from perninha.conectiva.com.br ([200.140.247.100]:48769 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S1750734AbVKWMHD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 07:07:03 -0500
Date: Wed, 23 Nov 2005 10:07:08 -0200
From: Luiz Fernando Capitulino <lcapitulino@mandriva.com.br>
To: Eduardo Pereira Habkost <ehabkost@mandriva.com>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net, akpm@osdl.org
Subject: Re: [PATCH 2/2] - usbserial: race-condition fix.
Message-Id: <20051123100708.6319df27.lcapitulino@mandriva.com.br>
In-Reply-To: <20051123115633.GS14440@duckman.conectiva>
References: <20051122195926.18c3221c.lcapitulino@mandriva.com.br>
	<20051122221353.GA10311@suse.de>
	<20051123093655.5555f23e.lcapitulino@mandriva.com.br>
	<20051123115633.GS14440@duckman.conectiva>
Organization: Mandriva
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i386-conectiva-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Nov 2005 09:56:33 -0200
Eduardo Pereira Habkost <ehabkost@mandriva.com> wrote:

| On Wed, Nov 23, 2005 at 09:36:55AM -0200, Luiz Fernando Capitulino wrote:
| > On Tue, 22 Nov 2005 14:13:53 -0800
| > Greg KH <gregkh@suse.de> wrote:
| > 
| > | On Tue, Nov 22, 2005 at 07:59:26PM -0200, Luiz Fernando Capitulino wrote:
| > | > @@ -60,6 +61,7 @@ struct usb_serial_port {
| > | >  	struct usb_serial *	serial;
| > | >  	struct tty_struct *	tty;
| > | >  	spinlock_t		lock;
| > | > +	struct semaphore        sem;
| > | 
| > | You forgot to document what this semaphore is used for.
| > 
| >  Okay.
| > 
| > | Hm, can we just use the spinlock already present in the port structure
| > | for this?  Well, drop the spinlock and use the semaphore?  Yeah, that
| > | means grabbing a semaphore for ever write for some devices, but USB data
| > | rates are slow enough it wouldn't matter :)
| > 
| >  As far as I read the code, I found that spinlock is only used by the
| > generic driver, in the
| > drivers/usb/serial/generic.c:usb_serial_generic_write() function.
| > 
| >  Can we drop the spinlock there and use our new semaphore? Or should we
| > create a new spinlock just to use there?
| 
| The spin_lock is used only to protect write_urb_busy. An atomic_t seem
| to be more appropriate for it. If we do that, I guess we can remove the
| (then unused) spinlock.

 Ok, but, hmm.. I found the spinklock is actually used by other drivers too.

 I didn't catch this before because I wasn't compiling then. Sorry, my fault.

| So we have three proposed changes:
| 
| - Add semaphore to serialize close()/open() (properly documented)
| - Replace write_urb_busy with an atomic_t
| - Remove the spinlock

 Since the spinlock seems to be only used to protect 'write_urb_busy', I agree
with those changes.

 Greg, do you? If so, I suggested we should add the semaphore first, because
it is a bug fix.

 I can do the 'write_urb_busy' type replace next week (yes, I will replace all
the drivers).

-- 
Luiz Fernando N. Capitulino
