Return-Path: <linux-kernel-owner+w=401wt.eu-S1752486AbWLVT6H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752486AbWLVT6H (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 14:58:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752451AbWLVT6F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 14:58:05 -0500
Received: from smtp-out001.kontent.com ([81.88.40.215]:55657 "EHLO
	smtp-out.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752433AbWLVT6D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 14:58:03 -0500
From: Oliver Neukum <oliver@neukum.org>
To: J <jhnlmn@yahoo.com>
Subject: Re: Possible race condition in usb-serial.c
Date: Fri, 22 Dec 2006 20:59:50 +0100
User-Agent: KMail/1.8
Cc: Greg KH <gregkh@suse.de>, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
References: <20061222190800.3167.qmail@web32909.mail.mud.yahoo.com>
In-Reply-To: <20061222190800.3167.qmail@web32909.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612222059.50652.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 22. Dezember 2006 20:08 schrieb J:
> > This problem will need some deeper surgery probably
> > involving
> > removal of the refcounting.
> 
> Refcounting may be OK if used consistently. 
> It is not OK when some pointers are ref-counted, 
> but other (in serial_table) are not (like it is
> in the current version).

No, this is a fundamental problem. You don't refcount
a pointer, you refcount a data structure. But this is
insufficient. We need to make sure the pointer points to valid
memory.
The problem with the current scheme is that serial_table
needs a lock. It needs to be taken in four places
- disconnect()
- open()
- probe()
- read_proc()

Refcounting solves only the race between disconnect() and close()
There's little use in a second locking mechanism if you use it
only in a minority of occasions.
Refcounting is a great idea if the number of references follows
a clear up -> maximum -> down -> free scheme, like for
skbs, etc..

> 
> As for the deeper surgery, what do you think about my
> earlier suggestion to start by rewriting
> usb_serial_probe
> to fully initialize usb_serial before it is added to 
> serial_table? 

Good suggestion. However, if done right, we'd go for a spin lock.

	Regards
		Oliver
