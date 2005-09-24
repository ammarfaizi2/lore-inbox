Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751399AbVIXEoM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751399AbVIXEoM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Sep 2005 00:44:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751408AbVIXEoL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Sep 2005 00:44:11 -0400
Received: from zproxy.gmail.com ([64.233.162.196]:58417 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751399AbVIXEoL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Sep 2005 00:44:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JSdolfY6orWcSccyjZ1SNfWXDsftXzYA+2G+9tAHVqbRPqeq6rMUxHts/tnQkwXhV252atI8Rp2JY0qYoENWcOlM7Qu80u3Q5/TENeMNt9OiIIltcaTr9QrWPBtK6oCS6kuCXqgGtxfttLlpq6c0Z3i/ICoBYt1/VYezbw7drOk=
Message-ID: <29495f1d05092321447417503@mail.gmail.com>
Date: Fri, 23 Sep 2005 21:44:10 -0700
From: Nish Aravamudan <nish.aravamudan@gmail.com>
Reply-To: Nish Aravamudan <nish.aravamudan@gmail.com>
To: Willy Tarreau <willy@w.ods.org>
Subject: Re: [patch] sys_epoll_wait() timeout saga ...
Cc: Davide Libenzi <davidel@xmailserver.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20050924040534.GB18716@alpha.home.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.63.0509231108140.10222@localhost.localdomain>
	 <20050924040534.GB18716@alpha.home.local>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/23/05, Willy Tarreau <willy@w.ods.org> wrote:
> Hi Davide,
>
> On Fri, Sep 23, 2005 at 11:13:30AM -0700, Davide Libenzi wrote:
> >
> > The sys_epoll_wait() function was not handling correctly negative
> > timeouts (besides -1), and like sys_poll(), was comparing millisec to
> > secs in testing the upper timeout limit.
> >
> >
> > Signed-off-by: Davide Libenzi <davidel@xmailserver.org>
> >
> >
> > - Davide
>
> > --- a/fs/eventpoll.c  2005-09-23 10:56:57.000000000 -0700
> > +++ b/fs/eventpoll.c  2005-09-23 11:00:06.000000000 -0700
> > @@ -1507,7 +1507,7 @@
> >        * and the overflow condition. The passed timeout is in milliseconds,
> >        * that why (t * HZ) / 1000.
> >        */
> > -     jtimeout = timeout == -1 || timeout > (MAX_SCHEDULE_TIMEOUT - 1000) / HZ ?
> > +     jtimeout = timeout < 0 || (timeout / 1000) >= (MAX_SCHEDULE_TIMEOUT / HZ) ?
> >               MAX_SCHEDULE_TIMEOUT: (timeout * HZ + 999) / 1000;
>
> Here, I'm not certain that gcc will optimize the divide. It would be better
> anyway to write this which is equivalent, and a pure integer comparison :
>
> +       jtimeout = timeout < 0 || timeout >= 1000 * MAX_SCHEDULE_TIMEOUT / HZ ?
> >               MAX_SCHEDULE_TIMEOUT: (timeout * HZ + 999) / 1000;

Just a question here, maybe it's dumb.

* and / have the same priority in the order of operations, yes? If so,
won't the the 1000 * MAX_SCHEDULE_TIMEOUT overflow
(MAX_SCHEDULE_TIMEOUT is LONG_MAX)? I really think this code just move
to the same thing that sys_poll() does to avoid overlflow (I fixed the
bug Alexey was experiencing, so I think the changes are safe now). In
any case, this code is approaching unreadable with lots of jiffies
<--> human-time units manipulations done in non-standard ways, which
the updated sys_poll() also tries to avoid.

Thanks,
Nish
