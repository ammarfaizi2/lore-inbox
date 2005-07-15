Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261915AbVGOUMX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261915AbVGOUMX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 16:12:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261164AbVGOUMQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 16:12:16 -0400
Received: from taxbrain.com ([64.162.14.3]:38744 "EHLO petzent.com")
	by vger.kernel.org with ESMTP id S261206AbVGOULl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 16:11:41 -0400
From: "karl malbrain" <karl@petzent.com>
To: "Russell King" <rmk+lkml@arm.linux.org.uk>
Cc: "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: RE: 2.6.9 chrdev_open: serial_core: uart_open
Date: Fri, 15 Jul 2005 13:11:33 -0700
Message-ID: <NDBBKFNEMLJBNHKPPFILIEALCEAA.karl@petzent.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Importance: Normal
In-Reply-To: <20050715082249.A23102@flint.arm.linux.org.uk>
X-Spam-Processed: petzent.com, Fri, 15 Jul 2005 13:07:48 -0700
	(not processed: message from valid local sender)
X-Return-Path: karl@petzent.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
X-MDAV-Processed: petzent.com, Fri, 15 Jul 2005 13:07:50 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Russell King
> Sent: Friday, July 15, 2005 12:23 AM
> To: karl malbrain
> Cc: Linux-Kernel@Vger. Kernel. Org
> Subject: Re: 2.6.9 chrdev_open: serial_core: uart_open
>
>
> On Thu, Jul 14, 2005 at 04:50:00PM -0700, karl malbrain wrote:
> > chrdev_open issues a lock_kernel() before calling uart_open.
> >
> > It would appear that servicing the blocking open request
> uart_open goes to
> > sleep with the kernel locked.  Would this shut down subsequent access to
> > opening "/dev/tty"???
>
> No.  lock_kernel() is automatically released when a process sleeps.

Drilling down between the uart_open and chrdev_open into tty_open is a
semaphore tty_sem that is being held during the sleep cycle in uart_open.

This would appear to be the problem!!  Is this a new semaphore in 2.6? How
could this have ever worked with tty blocking mode?  It would appear that
tty_sem is going to have to be released before sleeping in uart_open.  What
a mess.

N.b. I don't pretend to understand how uart_change_pm, uart_startup, and
uart_block_til_ready could ALL be on the call stack.  Uart_open calls them
sequentially.  Perhaps you might explain how this works?  Thanks, karl m



