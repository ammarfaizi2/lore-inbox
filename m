Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932318AbVKYBIl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932318AbVKYBIl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 20:08:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932679AbVKYBIl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 20:08:41 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:6552 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932318AbVKYBIl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 20:08:41 -0500
Date: Fri, 25 Nov 2005 02:08:35 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: David Woodhouse <dwmw2@infradead.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: RFC: Kill -ERESTART_RESTARTBLOCK.
In-Reply-To: <1132859323.11921.110.camel@baythorne.infradead.org>
Message-ID: <Pine.LNX.4.61.0511250110470.1610@scrub.home>
References: <1132859323.11921.110.camel@baythorne.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 24 Nov 2005, David Woodhouse wrote:

> I'm looking at implementing ppoll() and pselect(), and the existing
> restartblock stuff isn't sufficient for that -- we don't get to store
> enough args, and although it could possibly be expanded, I just don't
> much like restarting syscalls that way.

What arguments do you need to store?
Instead of messing with the signal delivery it may be better to slightly 
change the restart logic. Instead of calling a separate function, we could 
call the original function with all the arguments, which would reduce the 
state required to be saved.
In the case of nanosleep this could look like this:

sys_nanosleep()
{
	...
	if (restart_block) {
		expire = restart_block->arg0;
	} else {
		if (copy_from_user(&t, rqtp, sizeof(t)))
		...
	}
	expire = schedule_timeout_interruptible(expire);
	if (expire) {
		...
		restart_block->arg0 = expire;
		ret = -ERESTART_RESTARTBLOCK;
	}
}

AFAICT only the timeout argument needs to saved over a restart, the rest 
can be reinitialized from the original arguments.
The main problem would be to prevent an incorrect restart, e.g. if the 
debugger pokes around in the registers.

bye, Roman
