Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267528AbUJUNYn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267528AbUJUNYn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 09:24:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268458AbUJUNYg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 09:24:36 -0400
Received: from h-68-165-86-241.dllatx37.covad.net ([68.165.86.241]:28497 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S270471AbUJUNUO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 09:20:14 -0400
Subject: Re: Linux v2.6.9 (Strange tty problem?)
From: Paul Fulghum <paulkf@microgate.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Paul <set@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <1098349651.17067.3.camel@localhost.localdomain>
References: <Pine.LNX.4.58.0410181540080.2287@ppc970.osdl.org>
	 <20041021024132.GB6504@squish.home.loc>
	 <1098349651.17067.3.camel@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1098364808.2815.38.camel@deimos.microgate.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 21 Oct 2004 08:20:09 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-10-21 at 04:07, Alan Cox wrote:
> Thats a PPP LCP conf request as far as I can decode it. You've got
> a stuck pppd somewhere - thats a minor bug in 2.6.9rc and 2.6.9 that got
> introduced by the tty changes. I'll try and fix it ASAP if Paul doesn't
> beat me to it.

I'm just about to start.

I was thinking a reasonable solution would be
to queue work in tty_do_hangup() if ldisc->hangup()
is not defined (== NULL) to switch the ldisc back to N_TTY.

It looks like Alan may have tried something similar
with tty_deferred_ldisc_switch(N_TTY).

If tty_set_ldisc() is called before the work runs
then the work is cancelled. This also cancels
the work if close is called before it runs.
(close sets back to N_TTY anyways)

This restores the original behavior for
devices that have not yet implemented ldisc->hangup()
and should work with the new locking.

-- 
Paul Fulghum
paulkf@microgate.com

