Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751249AbWHBFbE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751249AbWHBFbE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 01:31:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751250AbWHBFbE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 01:31:04 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:34275
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751249AbWHBFbD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 01:31:03 -0400
Date: Tue, 01 Aug 2006 22:31:10 -0700 (PDT)
Message-Id: <20060801.223110.56811869.davem@davemloft.net>
To: davej@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: frequent slab corruption (since a long time)
From: David Miller <davem@davemloft.net>
In-Reply-To: <20060801.220538.89280517.davem@davemloft.net>
References: <20060802021617.GH22589@redhat.com>
	<20060801.220538.89280517.davem@davemloft.net>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Tue, 01 Aug 2006 22:05:38 -0700 (PDT)

> The corruption is always a 32-bit 0xffffffff followed by
> a 32-bit 0x00000000, 12 bytes into the object.

This analysis is wrong, it's "0xb0 + 12" bytes into the object
which is 188 bytes.  For x86, this lands us at the "count"
member of the tty_struct, and it shows that the tty count
has decremented to -1 (0xffffffff) which is a serious bug.

Note also that the ws_row and ws_col fields of the tty->winsize are
next and has been zero'd out (0x00000000) by the corruption.

There aren't too many places that write to tty->winsize,
the most notable is tiocswinsz(), called from tty_ioctl.

For a PTY with sub-type PTY_TYPE_MASTE, which is very likely
the case we have here, it assigns the user provided winsize
to both tty->winsize and tty->link->winsz (via the real_tty)
argument to tiocswinsz().

Actually, there is one other notable spot that writes to
tty->winsize, drivers/char/vt.c:vc_resize(), which copies
it to vc->vc_tty->winsize.

Perhaps this is a clue... but wait there is a better clue.

con_open() sets values there, and in particular it only
assigns the ws_row and ws_col members, which matches up
with the fact that we see only the first two members of
tty->winsize spammed to zero.

If the guilty code path involved vc_resize() or tiocswinsz()
we'd see 8 bytes, not 4 bytes, of the tty->winsize set to
something other than the SLAB free poison chars.

So it seems, from this perspective, that con_open()'s assignments
which are causing the corruption.  This is backed up by the trace
found in bugzilla #200928 being early during bootup.

But even this doesn't add up because con_open() has to be seeing
zero's there at the time it runs, not the poison values, since it's
assignments are guarded like this:

	if (!tty->winsize.ws_row && !tty->winsize.ws_col) {
		tty->winsize.ws_row = vc_cons[currcons].d->vc_rows;
		tty->winsize.ws_col = vc_cons[currcons].d->vc_cols;
	}

Hmmm...
