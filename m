Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264429AbUFJDuv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264429AbUFJDuv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 23:50:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264430AbUFJDuv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 23:50:51 -0400
Received: from relay2.EECS.Berkeley.EDU ([169.229.60.28]:43166 "EHLO
	relay2.EECS.Berkeley.EDU") by vger.kernel.org with ESMTP
	id S264429AbUFJDus (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 23:50:48 -0400
Subject: Re: PATCH: 2.6.7-rc3 drivers/video/fbmem.c: user/kernel pointer bugs
From: "Robert T. Johnson" <rtjohnso@eecs.berkeley.edu>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: linux-fbdev-devel@lists.sourceforge.net,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040610012441.GY12308@parcelfarce.linux.theplanet.co.uk>
References: <1086821199.32054.111.camel@dooby.cs.berkeley.edu> 
	<20040610012441.GY12308@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 09 Jun 2004 20:50:33 -0700
Message-Id: <1086839438.14179.340.camel@dooby.cs.berkeley.edu>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-06-09 at 18:24, viro@parcelfarce.linux.theplanet.co.uk
wrote:
> On Wed, Jun 09, 2004 at 03:46:39PM -0700, Robert T. Johnson wrote:
> > Since sprite is a user pointer, reading sprite->mask or sprite->image.data 
> > requires unsafe dereferences.  Let me know if you have any questions or if 
> > I've made a mistake.
> 
> Nice catch.  IMO drivers/video/* is too damn scary to get in there and look
> for now - as long as there are less nasty areas to deal with ;-)
> 
> BTW, had con_font_op() shown up in your checks?  It _does_ avoid dereferencing
> userland pointers in a very similar scenario, but proving that is not something
> I'd wish on any code.  Short version of the story:

Yep.  I remember that code.  CQual does complain about it.

A similar situation arises in tty code, which passes around a flag
"from_user" to indicate whether another pointer is a user pointer or
kernel pointer.  See, for example, drivers/char/pty.c:pty_write(). 
CQual complains about that, too.  How about sparse?

We describe two ways of fixing this kind of code in the "Working around
false positives" section of that paper.  The simpler workaround will
probably work for sparse.  Basically rewrite the function

static int pty_write(struct tty_struct * tty, int from_user,
		       const unsigned char *buf, int count);

as

static int pty_write(struct tty_struct * tty, int from_user,
		       const unsigned char __user   *ubuf, 
                       const unsigned char __kernel *kbuf,
                       int count)

(In this case, you can even eliminate the from_user flag by just
checking which of ubuf and kbuf is non-NULL).

The slicker work-around involves passing a function pointer for
accessing the buffer, like in the example I gave in the other email. 
This works for cqual, but probably wouldn't help sparse.

> I wonder what did cqual say about that one - it sure as hell should raise a lot
> of red flags and the last item (none of the drivers dereference ->data unless
> ->op is one of KD_FONT_OP_{S,G}ET) is going to be hell on anything short of
> full AI.  sparse does *not* figure out that it's safe and raises hell over
> ->data not being declared as userland pointer while getting copy_..._user()
> on it.

I agree it would be difficult.  I have some vague ideas how to prove
this safe automatically, but nothing I plan to implement any time soon.

> 	FWIW, I think we should reduxe mixing of ioctl and kernel structures.
> console_font_op is a particulary obnoxious example, but lots of the stuff
> in drivers/video is not much better.

I think the key point is to make pointers either be always user pointers
or always kernel pointers.  Their type shouldn't depend on some other
flag.

I fear that completely separating ioctl and kernel data structures would
result in lots of redundant structure definitions, which will lead to
code maintainence problems and their own host of bugs.  Would it be
better to just design a bug finding tool that's capable of keeping track
of different structure instances separately?

Best,
Rob


