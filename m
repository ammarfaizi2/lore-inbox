Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964994AbVLFSXX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964994AbVLFSXX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 13:23:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932529AbVLFSXX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 13:23:23 -0500
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:20108 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932437AbVLFSXW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 13:23:22 -0500
Subject: Re: copy_from_user/copy_to_user question
From: Steven Rostedt <rostedt@goodmis.org>
To: Vinay Venkataraghavan <raghavanvinay@yahoo.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20051206175301.34596.qmail@web32110.mail.mud.yahoo.com>
References: <20051206175301.34596.qmail@web32110.mail.mud.yahoo.com>
Content-Type: text/plain
Date: Tue, 06 Dec 2005 13:23:14 -0500
Message-Id: <1133893394.6724.88.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-12-06 at 09:53 -0800, Vinay Venkataraghavan wrote:
> Thanks to Steve and everybody who sent such detailed
> and timely responses to my question. 
> 
> The motivation for the copy to user question is due to
> the handling of ioctl calls in the driver for a chip
> that is widely used. I just could not beleive that
> they would/could commit such a mistake. 
> 
> It looks like the old driver code still seems to work
> even without performing copy_to_user and
> copy_from_user.

How old is this driver? The old days, we had memcpy_fromfs, which I
believe was replaced with copy_from_user in 2.2 (and thus would no
longer work).

> 
> But this brings about another scenario. What if the
> case statement in the ioctl call only needs to have
> access to the members of the structure passed in
> through the arg pointer but does not need to modify
> these values and return values. 
> 
> Is this still a problem if copy_to_user and
> copy_from_user is not used?
> 

If what it is looking at is just a standard type (char, short, int,
long) within the struct, it can use get_user, and not the bigger cousin
copy_from_user.  The arg value passed in for the ioctl is OK to read
itself.  That is if you are just reading the arg as unsigned long.  But
if this arg is dereferenced as a pointer, then you must use one of the
*_user functions.

If it isn't using any of the *_user functions then most likely this
works with just plain luck.  The chance of having the page swap out from
the time the user updates the struct to the time the kernel reads it is
very slim.  So memcpy would unfortunately work. (I say unfortunately
because if it didn't work, the author of this crap would not have done
so).  It also seems to trust the user application to work properly.

So instead of asking these questions, I would suggest writing a user
application that passes in a bad pointer for one of these arguments and
seeing if the machine crashes.  If/When it does, then go blame the
vendor of this crap.

-- Steve


