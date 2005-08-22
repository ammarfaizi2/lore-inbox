Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751227AbVHVVZe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751227AbVHVVZe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 17:25:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751226AbVHVVZe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 17:25:34 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:64237 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751225AbVHVVZc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 17:25:32 -0400
Subject: Re: [PATCH] race condition with drivers/char/vt.c (bug in
	vt_ioctl.c)
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: mhw@wittsend.com, LKML <linux-kernel@vger.kernel.org>,
       Marcel Holtmann <marcel@holtmann.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <20050822071330.GA18456@elte.hu>
References: <1124508087.18408.79.camel@localhost.localdomain>
	 <20050822071330.GA18456@elte.hu>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Mon, 22 Aug 2005 09:50:57 -0400
Message-Id: <1124718657.5647.17.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-08-22 at 09:13 +0200, Ingo Molnar wrote:

> 
> cool fix. I'm wondering, there's a whole lot of other 'tty->count == 1' 
> checks in drivers/char/*.c, could some of those be racy too?

I checked them out.  The main problem is that tty->count == 1 is not
reliable in the open function call. Of the 22 files that use tty->count
== 1, only 4 of them (not including vt.c) have a potential race.

Three of the 4, have the race only if an error occurred. 

synclink.c
synclink_cs.c
synclinkmp.c

The code in these three have something like this:


static int open(struct tty_struct *tty, struct file *filp)
{
   ...
	if (/* some error */) {
		retval = /* something bad */
		goto cleanup;
	}
   ...

cleanup:
	if (retval) {
		if (tty->count == 1)
			info->tty = NULL; /* tty layer will release tty struct */
		if(info->count)
			info->count--;
	}

	return retval;
}

So, the info->tty has a chance of not being set to NULL.  I don't know
how bad that is, but this is probably a bug.

The fourth file "ip2main.c" is a little more of a problem.

It's open has the following code:

noblock:

	/* first open - Assign termios structure to port */
	if ( tty->count == 1 ) {
		i2QueueCommands(PTYPE_INLINE, pCh, 0, 2, CMD_CTSFL_DSAB, CMD_RTSFL_DSAB);
		/* Now we must send the termios settings to the loadware */
		set_params( pCh, NULL );
	}

So, there's a chance that tty->count does not equal 1 here when it
should.  The way to fix this would probably be to set driver_data to
NULL with some locking around it, and check that instead.  Like what was
done for vt.c. Since I don't have an ip2 device that I know of, I won't
be fixing this code.

-- Steve


