Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262081AbVCHTpg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262081AbVCHTpg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 14:45:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262145AbVCHTpe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 14:45:34 -0500
Received: from rproxy.gmail.com ([64.233.170.204]:57368 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262081AbVCHTcu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 14:32:50 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=P5efXK9d8Kc7OYpAdbTf7+UHdqHaY5AHCMdBdPDMLHKFRNhIBgkO2hhy9EoKWMXlD5jgtOLSHOEnTiozgxhENcOYbGpjogjAht0CamhSbNpAs6RpzqbbkCIEUh9kPIZr16J6Pq0BJToW+Vzl5sDPYKYmvsJ17YJ+1SfVvN+T/Jc=
Message-ID: <8783be6605030811326dc8f89b@mail.gmail.com>
Date: Tue, 8 Mar 2005 11:32:43 -0800
From: Ross Biro <ross.biro@gmail.com>
Reply-To: Ross Biro <ross.biro@gmail.com>
To: "Peter W. Morreale" <peter_w_morreale@hotmail.com>
Subject: Re:
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <BAY101-F396925B373DD3925D37BFEC1500@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <BAY101-F396925B373DD3925D37BFEC1500@phx.gbl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 08 Mar 2005 09:32:48 -0700, Peter W. Morreale
<peter_w_morreale@hotmail.com> wrote:
> 
> This seems wrong since we've mixed locking primitives.
> 
> Is it?

It's not really wrong, it just wastes time turning interrupts off over
and over again.
> ....
> foo()
> {
>     unsigned long lflags;

At this point, interrupts are off, the lock is held.
> 
>     spin_unlock(global_lock);

Interrupts are still off, the lock is no longer held.
>     ...
>     {
>         spin_lock_irqsave(global_lock, &lflags);

Interrupts are still off, and just to be sure we turned them off
again.  The lock is held.
>                 .
>                 .
>         spin_unlock_irqrestore(global_lock, &lflags);
Interrupts are still off, but we restored them to the off state they
were in before
we grabbed the lock the last time.  The lock is no longer held.
>     }
> 
>     spin_lock_irq(global_lock);
Turn off interrupts again just to be extra sure they are off.  The
lock is held again.

>From the looks of this code, the locking will work.  But it's not what
it should be.

If you know foo is only called with interrupts off, then there is no
reason to turn them off over and over again.  Just use the standard
spin_lock and spin_unlock and comment that interrupts are already off.

You should also question if interrupts need to be disabled at all.  If
the spin lock is never grabbed at interrupt time (and probably won't
be in the near future), then there is no point in turning interrupts
on and off at all.

    Ross
