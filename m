Return-Path: <linux-kernel-owner+w=401wt.eu-S964964AbWLTJpj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964964AbWLTJpj (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 04:45:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964965AbWLTJpj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 04:45:39 -0500
Received: from smtp-out001.kontent.com ([81.88.40.215]:39109 "EHLO
	smtp-out.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964964AbWLTJpi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 04:45:38 -0500
From: Oliver Neukum <oliver@neukum.org>
To: J <jhnlmn@yahoo.com>, linux-usb-devel@lists.sourceforge.net,
       Greg KH <gregkh@suse.de>
Subject: Re: Possible race condition in usb-serial.c
Date: Wed, 20 Dec 2006 10:47:20 +0100
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org
References: <695571.36956.qm@web32904.mail.mud.yahoo.com>
In-Reply-To: <695571.36956.qm@web32904.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612201047.20842.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 19. Dezember 2006 23:33 schrieb J:
> Thank you for the response.
> 
> > This code depends on protection from BKL.
> 
> Really? I cannot find many lock_kernel calls in 
> USB directory and those, which I can find, 
> don't appear to protect usb_serial_disconnect
> and serial_close from being called at the same time.

serial_close is safe because serial_disconnect lowers the refcount
by one. usb_serial_probe() and usb_serial_open() both increment
the refcount; the former implicitly.

> May be the protection is at a higher level? 
> Personally I don't beleive it.
> If you know how this thing is supposed to work,
> please, tell me.

The data structure to protect is serial_table. Everything else is
protected by refcounts. Therefore the interesting race is between
open and disconnect. Open is called with BKL (fs/char_dev.c::chrdev_open)

Now, regarding disconnect. It used to be called with BKL held. I haven't been
able to verify that this is still the case. If not, then there's a race.

In addition usb_serial_probe() uses get_free_serial() early in the process
before the device is ready. Without BKL, this too, races with open.

People, do we take BKL in khubd?

	Regards
		Oliver
