Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750794AbWEKVQD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750794AbWEKVQD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 17:16:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750795AbWEKVQD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 17:16:03 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:22173 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750794AbWEKVQB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 17:16:01 -0400
Date: Thu, 11 May 2006 14:16:15 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Cc: Linux kernel <linux-kernel@vger.kernel.org>, staubach@redhat.com
Subject: Re: Linux poll() <sigh> again
Message-ID: <20060511211615.GA8485@us.ibm.com>
References: <Pine.LNX.4.61.0605111023030.3729@chaos.analogic.com> <20060511204741.GG22741@us.ibm.com> <Pine.LNX.4.61.0605111659580.5484@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0605111659580.5484@chaos.analogic.com>
X-Operating-System: Linux 2.6.17-rc2 (x86_64)
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.05.2006 [17:04:46 -0400], linux-os (Dick Johnson) wrote:
> 
> On Thu, 11 May 2006, Nishanth Aravamudan wrote:
> 
> > On 11.05.2006 [10:25:29 -0400], linux-os (Dick Johnson) wrote:
> >>
> >>
> >> Hello,
> >>
> >> I'm trying to fix a long-standing bug which has a
> >> work-around that has been working for a year or
> >> so.
> >
> > <snip valiant efforts>
> >
> >> Here is relevent code:
> >>
> >>              for(;;) {
> >>                  mem->pfd.fd = fd;
> >>                  mem->pfd.events = POLLIN|POLLERR|POLLHUP|POLLNVAL;
> >>                  mem->pfd.revents = 0x00;
> >
> > Hrm, in looking at the craziness that is sys_poll() for a bit, I think
> > it's the underlying f_ops that are responsible for not setting POLLHUP,
> > that is:
> >
> >                        if (file != NULL) {
> >                                mask = DEFAULT_POLLMASK;
> >                                if (file->f_op && file->f_op->poll)
> >                                        mask = file->f_op->poll(file, *pwait);
> >                                mask &= fdp->events | POLLERR | POLLHUP;
> >                                fput_light(file, fput_needed);
> >                        }
> >
> > and file->f_op->poll(file, *pwait) is not setting POLLHUP on the
> > disconnect. What filesystem is this?
> 
> I think that's the problem. A socket isn't a file-system and the
> code won't set either bits if it isn't. Perhaps, the kernel code
> needs to consider a socket as a virtual file of some kind? Surely
> one needs to use poll() on sockets, no?

Duh, I'm not reading well today -- for sockets, we do

file->f_op->poll() -> (socket_file_ops) sock_poll() -> sock->ops->poll()

So, now I need to know what kind of socket is this to go from there ...

Thanks,
Nish

-- 
Nishanth Aravamudan <nacc@us.ibm.com>
IBM Linux Technology Center
