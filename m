Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265806AbSKYXLW>; Mon, 25 Nov 2002 18:11:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265857AbSKYXLW>; Mon, 25 Nov 2002 18:11:22 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:10380 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S265806AbSKYXLV>; Mon, 25 Nov 2002 18:11:21 -0500
X-AuthUser: davidel@xmailserver.org
Date: Mon, 25 Nov 2002 15:19:30 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: John Myers <jgmyers@netscape.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [rfc] new poll callback'd wake up hell ...
In-Reply-To: <3DE2AE4C.6070904@netscape.com>
Message-ID: <Pine.LNX.4.50.0211251515300.1793-100000@blue1.dev.mcafeelabs.com>
References: <3DE29EB9.9050301@netscape.com>
 <Pine.LNX.4.50.0211251433200.1793-100000@blue1.dev.mcafeelabs.com>
 <3DE2AE4C.6070904@netscape.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Nov 2002, John Myers wrote:

> Davide Libenzi wrote:
>
> >No, look at the code :
> >
> >
> Ok, I completely misread what you wrote.  I thought you were suggestiong
> a change to the locking behavior of wake_up() itself.

The problem with the wake_up() is its potential recursion when using the
callback'd version of the wait queue. We can have two scenarios ( given
'->' == CONTAINED-IN ) :

1)
epfd1 -> epfd2 -> ... ->epfdN with N huge

2)
epfd1 -> epfd2 -> ... -> epfd1

Now, when you call wake_up() without using any care you'll blow up the
stack. This should be adressed with the 0.58 version of the patch. Also, I
moved the :

        /* Add the current item to the list of active epoll hook for this file */
        spin_lock(&tfile->f_ep_lock);
        list_add_tail(&epi->fllink, &tfile->f_ep_links);
        spin_unlock(&tfile->f_ep_lock);

before inserting the item in the hash, so I don't need to increase the
usage count in ep_insert().



- Davide

