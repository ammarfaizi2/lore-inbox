Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266089AbUFJBYn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266089AbUFJBYn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 21:24:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266086AbUFJBYn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 21:24:43 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:54495 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266089AbUFJBYm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 21:24:42 -0400
Date: Thu, 10 Jun 2004 02:24:41 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: "Robert T. Johnson" <rtjohnso@eecs.berkeley.edu>
Cc: linux-fbdev-devel@lists.sourceforge.net,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: 2.6.7-rc3 drivers/video/fbmem.c: user/kernel pointer bugs
Message-ID: <20040610012441.GY12308@parcelfarce.linux.theplanet.co.uk>
References: <1086821199.32054.111.camel@dooby.cs.berkeley.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1086821199.32054.111.camel@dooby.cs.berkeley.edu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 09, 2004 at 03:46:39PM -0700, Robert T. Johnson wrote:
> Since sprite is a user pointer, reading sprite->mask or sprite->image.data 
> requires unsafe dereferences.  Let me know if you have any questions or if 
> I've made a mistake.

Nice catch.  IMO drivers/video/* is too damn scary to get in there and look
for now - as long as there are less nasty areas to deal with ;-)

BTW, had con_font_op() shown up in your checks?  It _does_ avoid dereferencing
userland pointers in a very similar scenario, but proving that is not something
I'd wish on any code.  Short version of the story:
	* console_font_op ->data can be a userland pointer.  It is obtained
from ioctls on many paths; all end up passing the (kernel) pointer to
structure to con_font_op().
	* a lot of code in drivers uses struct console_font_op.  And
dereferences ->data.
	* con_font_op() checks op->op and if it is KD_FONT_OP_[SG]ET, op->data
gets moved to kernel.  In any case, op is passed to the same method -
->con_font_op().  In some cases - with kernel pointer in ->data, in some -
with userland one.
	* ->con_font_op() in drivers does not dereference op->data unless
op->op is one of those two.

Oh, and to make life even funnier, struct console_font_op is also misused to
store current font.

I wonder what did cqual say about that one - it sure as hell should raise a lot
of red flags and the last item (none of the drivers dereference ->data unless
->op is one of KD_FONT_OP_{S,G}ET) is going to be hell on anything short of
full AI.  sparse does *not* figure out that it's safe and raises hell over
->data not being declared as userland pointer while getting copy_..._user()
on it.

	FWIW, I think we should reduxe mixing of ioctl and kernel structures.
console_font_op is a particulary obnoxious example, but lots of the stuff
in drivers/video is not much better.
