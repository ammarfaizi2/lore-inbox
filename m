Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261798AbVE3XAv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261798AbVE3XAv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 19:00:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261816AbVE3XAu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 19:00:50 -0400
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:41685 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP id S261798AbVE3Wz5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 18:55:57 -0400
X-ORBL: [69.107.40.98]
From: David Brownell <david-b@pacbell.net>
To: linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] Re: [BUG] oops while completing async USB via usbdevio
Date: Mon, 30 May 2005 15:55:39 -0700
User-Agent: KMail/1.7.1
Cc: Harald Welte <laforge@gnumonks.org>, linux-kernel@vger.kernel.org
References: <20050530194443.GA22760@sunbeam.de.gnumonks.org> <20050530212641.GE25536@sunbeam.de.gnumonks.org>
In-Reply-To: <20050530212641.GE25536@sunbeam.de.gnumonks.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505301555.39985.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 30 May 2005 2:26 pm, Harald Welte wrote:
> On Mon, May 30, 2005 at 09:44:44PM +0200, Harald Welte wrote:
> > I think there is currently no protection/locking/refcounting going on.
> > 
> > If a process issues an URB from userspace and starts to terminate before
> > the URB comes back, we run into the issue described above.  This is
> > because the urb saves a pointer to "current" when it is posted to the
> > device, but there's no guarantee that this pointer is still valid
> > afterwards.  

The logic closing an open usbfs file -- which is done before any task
exits with such an open file -- is supposed to block till all its URBs
complete.  So the pointer to the task "should" be valid for as long as
any URB it's submitted is active.

There have been some changes in that code since last I looked at it.
One obvious change was switching to usb_kill_urb(), but there've been
others too.


> > I'm not familiar with the scheduler code to decide what fix
> > is the way to go.  Is it sufficient to do {get,put}_task_struct() from
> > the usb code?

It's worth making that change in any case, to avoid such questions in
the future.  And if it does any good, more power to the patch!

Not that it helps at all, but I've never really trusted the usbfs async
I/O code.  "Real AIO" could be a lot more obviously correct.  And smaller.


> mh. it appears like it's sighand which disappears, not the task itself.
> ...

Odd.  Isn't that nulled only in __exit_sighand(), which gets called only
when the task itself is finally being freed?

- Dave

