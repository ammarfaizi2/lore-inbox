Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261205AbUK2NxW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261205AbUK2NxW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 08:53:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261373AbUK2NxW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 08:53:22 -0500
Received: from gaz.sfgoth.com ([69.36.241.230]:51926 "EHLO gaz.sfgoth.com")
	by vger.kernel.org with ESMTP id S261205AbUK2NxQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 08:53:16 -0500
Date: Mon, 29 Nov 2004 05:55:59 -0800
From: Mitchell Blank Jr <mitch@sfgoth.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] relinquish_fs() syscall
Message-ID: <20041129135559.GC33900@gaz.sfgoth.com>
References: <20041129114331.GA33900@gaz.sfgoth.com> <1101729087.20223.14.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1101729087.20223.14.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.2.2 (gaz.sfgoth.com [127.0.0.1]); Mon, 29 Nov 2004 05:56:03 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> A priviledged user can ioperm/iopl their way out.

OK, good point, at least on i386/x86_64.  So before jailing itself a task
will have to take CAP_SYS_RAWIO out of its permitted set.  That shouldn't
be too bad of a restriction for most programs to live with.

> On Llu, 2004-11-29 at 11:43, Mitchell Blank Jr wrote:
> > This has several benefits:
> > 
> >  * Considerably safer against root users in cage
> 
> Pardon. Its equally ineffectual. It might take someone a week longer to
> write the exploit but an hour after that its no different.

OK, could you please describe other attacks against it then?

> >    This is a big deal for privilege separation; currently it's hard to
> >    implement except in a daemon that starts its life as root.  Now the
> >    same techniques can be used by any process.
> 
> That doesn't do name lookup, character set translation, or time (and a
> few other things).

Alan - have you looked at privsep implementation in, say, opensshd.  The
way privsep works is that you have two processes communicating over a
UNIX domain socket.  One then jails itself and handles all the hairy
untrusted data.  The unjailed process handles requests from inside as
needed.  So if the program needs to do DNS lookups then your privsep
protocol would include a primitive for doing that.

Some information on openssh privsep, including the USENIX paper:
  http://www.citi.umich.edu/u/provos/ssh/privsep.html

Frankly, if a program is touching lots of untrusted data AND it also needs
lots of external stuff then it's a perfect candidate for privsep.

> >    Imagine, for example, a jpeg decoder that after opening its input and
> >    output files called relinquish_fs().  Now if the decoder has a flaw and
> 
> Imagine a jpeg decoder using an SELinux policy. 

SELinux is great but it's a pretty orthoginal issue.  There's no reason the
two can't coexist.

-Mitch
