Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267487AbUIJPsY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267487AbUIJPsY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 11:48:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267518AbUIJPq2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 11:46:28 -0400
Received: from [69.25.196.29] ([69.25.196.29]:24192 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S267487AbUIJPm0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 11:42:26 -0400
Date: Fri, 10 Sep 2004 10:32:11 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: arjanv@redhat.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: The Serial Layer
Message-ID: <20040910143211.GA7342@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, arjanv@redhat.com,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1094582980.9750.12.camel@localhost.localdomain> <1094587598.2801.24.camel@laptop.fenrus.com> <1094584456.9745.14.camel@localhost.localdomain> <20040909125705.GA5658@thunk.org> <1094747324.14623.49.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1094747324.14623.49.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 09, 2004 at 05:28:46PM +0100, Alan Cox wrote:
> On Iau, 2004-09-09 at 13:57, Theodore Ts'o wrote:
> > Calling ldisc.receive_buf directly() should be OK as long as you're
> > not in an interrupt handler.  (For example the comtrol driver polls in
> > a timer bottom-half, so it's OK to call ldisc.receive_buf).
> > Unfortunately, some drivers don't quite follow the rules.
> 
> If the driver calls ldisc->receive_buf it means it bypasses the
> TTY_DONT_FLIP locking used by the n_tty driver. Am I missing something
> here.

Um, yes, you're right.  The direct calls to ldisc->receive_buf predate
TTY_DONT_FLIP; TTY_DONT_FLIP was added by Bill Hawes (if I remember
correctly) in an attempt to fix various locking problems, but
unfortunately the direct callers weren't fixed.

> Most of that I think comes out in the wash with the ldisc locking. 
> Once the driver uses tty_ldisc_ref() it'll get NULL back in the case
> where the hangup raced the driver. I'm also no longer dropping back
> to N_TTY in the hangup path. I couldn't see any reason this was
> neccessary since the release will clean it up anyway ?

We needed to close the line discpline in order to prevent a line
discipline (such as ppp) from trying to write to the tty.  Given there
was an invariant that a tty always had a line discpline always, we
reassigned it back to N_TTY.  The right answer is probably to be to
add checks to the line discpline code before they attempt to send data
to the tty.

						- Ted
