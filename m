Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265854AbSKYWxH>; Mon, 25 Nov 2002 17:53:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265857AbSKYWxH>; Mon, 25 Nov 2002 17:53:07 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:2188 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S265854AbSKYWxF>; Mon, 25 Nov 2002 17:53:05 -0500
X-AuthUser: davidel@xmailserver.org
Date: Mon, 25 Nov 2002 15:01:15 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: John Myers <jgmyers@netscape.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [rfc] new poll callback'd wake up hell ...
In-Reply-To: <Pine.LNX.4.50.0211251451060.1793-100000@blue1.dev.mcafeelabs.com>
Message-ID: <Pine.LNX.4.50.0211251458220.1793-100000@blue1.dev.mcafeelabs.com>
References: <3DE29EB9.9050301@netscape.com>
 <Pine.LNX.4.50.0211251433200.1793-100000@blue1.dev.mcafeelabs.com>
 <Pine.LNX.4.50.0211251451060.1793-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Nov 2002, Davide Libenzi wrote:

> On Mon, 25 Nov 2002, Davide Libenzi wrote:
>
> > On Mon, 25 Nov 2002, John Myers wrote:
> >
> > > Davide Libenzi writes:
> > >  > 1) Move the wake_up() call done inside the poll callback outside the lock
> > >
> > > You can't.  You need to hold the lock over the callback or your callback
> > > could end up accessing a freed epitem.
> >
> > No, look at the code :
> >
> > http://www.xmailserver.org/linux-patches/sys_epoll-2.5.49-0.58.diff
> >
> > The function ep_collect_ready_items() increases the usage count under
> > lock. So the epintem is protected, and the file* cannot desappear because
> > of the read lock on epsem.
>
> Ops, I understood the f_op->poll() not the wake_up(). It can be solved in
> the same way. I'll do it now.

The only place where a protection is needed is inside ep_insert() and not
because of the wake_up() outsize the lock. Because of this :

        /* Add the current item to the list of active epoll hook for this file */
        spin_lock(&tfile->f_ep_lock);
        list_add_tail(&epi->fllink, &tfile->f_ep_links);
        spin_unlock(&tfile->f_ep_lock);



- Davide

