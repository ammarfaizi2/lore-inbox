Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269099AbUIXTPy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269099AbUIXTPy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 15:15:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269100AbUIXTPy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 15:15:54 -0400
Received: from h-68-165-86-241.dllatx37.covad.net ([68.165.86.241]:41577 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S269099AbUIXTPp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 15:15:45 -0400
Subject: Re: 2.6.9-rc2-mm3
From: Paul Fulghum <paulkf@microgate.com>
To: James Morris <jmorris@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <1096051977.1938.5.camel@deimos.microgate.com>
References: <Xine.LNX.4.44.0409241210220.8009-100000@thoron.boston.redhat.com>
	 <1096051977.1938.5.camel@deimos.microgate.com>
Content-Type: text/plain
Message-Id: <1096053328.1938.11.camel@deimos.microgate.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 24 Sep 2004 14:15:28 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-09-24 at 13:52, Paul Fulghum wrote:
> I am seeing this deadlock also.
> 
> tty_termios_lock is acquired in change_termios(), tty_ioctl.c
> 
> change_termios() calls the driver set_termios callback
> which in turn calls tty_termios_baud_rate(), tty_io.c
> which tries to acquire the lock again.

The core purpose of tty_termios_baud_rate() is
'read only': returning a value from a table referenced
by an index in the termios structure.

It currently also performs a sanity check for
the index and adjusts the index if it is out of bounds.
I assume the lock is held to protect this
possible write access to the termios structure.

Would it not make sense to move the sanity check
to change_termios, which would then allow removal
of the locks from tty_termios_baud_rate()?
(which also removes the deadlock)

-- 
Paul Fulghum
paulkf@microgate.com

