Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264972AbSJPOLr>; Wed, 16 Oct 2002 10:11:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264978AbSJPOLr>; Wed, 16 Oct 2002 10:11:47 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:31878 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S264972AbSJPOLo>; Wed, 16 Oct 2002 10:11:44 -0400
X-AuthUser: davidel@xmailserver.org
Date: Wed, 16 Oct 2002 07:25:47 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: John Myers <jgmyers@netscape.com>
cc: Benjamin LaHaise <bcrl@redhat.com>, Dan Kegel <dank@kegel.com>,
       Shailabh Nagar <nagar@watson.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-aio <linux-aio@kvack.org>, Andrew Morton <akpm@digeo.com>,
       David Miller <davem@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Stephen Tweedie <sct@redhat.com>
Subject: Re: [PATCH] async poll for 2.5
In-Reply-To: <3DACAF90.7010803@netscape.com>
Message-ID: <Pine.LNX.4.44.0210160717190.1548-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Oct 2002, John Myers wrote:

> Davide Libenzi wrote:
>
> >Just a simple question : Have you ever used RT-Signal API ? Is it the API
> >"deficent" [...] ?
> >
> No.  Yes.  The (fixed) size of the signal queue is far too small.  One
> either gets catastrophic failure on overload or one has to pay to do
> redundant accounting of interest.
>
> >Do you know the
> >difference between level triggered ( poll() - select() - /dev/poll ) and
> >edge triggered ( /dev/epoll - RT-Signal ) interfaces ?
> >
> >
> Yes.  The registration of interest can itself be considered an edge
> condition.

I knew you were going there, aka you do not understand how edge triggered
API have to be used. Even if the API will drop an event at registration
time you still cannot use this code scheme :

int my_io(...) {

	if (event_wait(...))
		do_io(...);

}

You CAN NOT. And look, it is not an API problem, it's your problem that
you want to use the API like a poll()-like API. The code scheme for an
edge triggered API is :

int my_io(...) {

	while (do_io(...) == EAGAIN)
		event_wait(...);

}

This because you have to consume the I/O space to push the level to 0 so
that a transaction 0->1 can happen and you can happily receive your
events.



- Davide


