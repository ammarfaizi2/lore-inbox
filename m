Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266486AbUIIRlH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266486AbUIIRlH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 13:41:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266366AbUIIRg5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 13:36:57 -0400
Received: from the-village.bc.nu ([81.2.110.252]:29099 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S266488AbUIIRbS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 13:31:18 -0400
Subject: Re: The Serial Layer
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: arjanv@redhat.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040909125705.GA5658@thunk.org>
References: <1094582980.9750.12.camel@localhost.localdomain>
	 <1094587598.2801.24.camel@laptop.fenrus.com>
	 <1094584456.9745.14.camel@localhost.localdomain>
	 <20040909125705.GA5658@thunk.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1094747324.14623.49.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 09 Sep 2004 17:28:46 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-09-09 at 13:57, Theodore Ts'o wrote:
> Calling ldisc.receive_buf directly() should be OK as long as you're
> not in an interrupt handler.  (For example the comtrol driver polls in
> a timer bottom-half, so it's OK to call ldisc.receive_buf).
> Unfortunately, some drivers don't quite follow the rules.

If the driver calls ldisc->receive_buf it means it bypasses the
TTY_DONT_FLIP locking used by the n_tty driver. Am I missing something
here.

> The hangup handling needs to be completely redone, so that we don't
> force serial drivers to do a completely shutdown of the port in an
> interrupt context.  If the drivers are careful, it can be safe, but
> it's too hard to handle hangup correctly.  

Most of that I think comes out in the wash with the ldisc locking. 
Once the driver uses tty_ldisc_ref() it'll get NULL back in the case
where the hangup raced the driver. I'm also no longer dropping back
to N_TTY in the hangup path. I couldn't see any reason this was
neccessary since the release will clean it up anyway ?

Alan

