Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964867AbWDDJwD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964867AbWDDJwD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 05:52:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964898AbWDDJwD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 05:52:03 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:50190 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S964883AbWDDJwA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 05:52:00 -0400
Date: Tue, 4 Apr 2006 10:51:54 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: "Hyok S. Choi" <hyok.choi@samsung.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.17-rc1] [SERIAL] DCC(JTAG) serial and the console emulation support(revised#2)
Message-ID: <20060404095154.GC8573@flint.arm.linux.org.uk>
Mail-Followup-To: "Hyok S. Choi" <hyok.choi@samsung.com>,
	linux-kernel@vger.kernel.org
References: <20060403112410.14105.55427.stgit@hyoklinux.sec.samsung.com> <200604041127.07290.hyok.choi@samsung.com> <20060404082005.GB8573@flint.arm.linux.org.uk> <200604041846.46366.hyok.choi@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200604041846.46366.hyok.choi@samsung.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 04, 2006 at 06:46:45PM +0900, Hyok S. Choi wrote:
> On Tuesday 04 April 2006 05:20 pm, Russell King wrote:
> > Why do you think you need such complexity?
> > 
> > cancel_rearming_delayed_work() will wait until the poll task has
> > completed and has been removed from the system.  It's explicitly
> > designed for work handlers which self-rearm.
> 
> Hmm.. Maybe you're right, because dcc_shutdown and dcc_startup, which
> are the only functions that initiate or stop the work, will never be
> called concurrently by different callers?

RTFD.  This behaviour _is_ documented.  Documentation/serial/driver:

  startup(port)
	Grab any interrupt resources and initialise any low level driver
	state.  Enable the port for reception.  It should not activate
	RTS nor DTR; this will be done via a separate call to set_mctrl.

	Locking: port_sem taken.
	Interrupts: globally disabled.

  shutdown(port)
	Disable the port, disable any break condition that may be in
	effect, and free any interrupt resources.  It should not disable
	RTS nor DTR; this will have already been done via a separate
	call to set_mctrl.

	Locking: port_sem taken.
	Interrupts: caller dependent.

If the port semaphore is taken prior to calling either function...

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
