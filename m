Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282378AbRLICeM>; Sat, 8 Dec 2001 21:34:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282392AbRLICdx>; Sat, 8 Dec 2001 21:33:53 -0500
Received: from mail.xmailserver.org ([208.129.208.52]:44552 "EHLO
	mail.xmailserver.org") by vger.kernel.org with ESMTP
	id <S282378AbRLICds>; Sat, 8 Dec 2001 21:33:48 -0500
Date: Sat, 8 Dec 2001 18:35:28 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Rusty Russell <rusty@rustcorp.com.au>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, <anton@samba.org>, <davej@suse.de>,
        <marcelo@conectiva.com.br>, lkml <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: Linux 2.4.17-pre5 
In-Reply-To: <E16CtEp-0007Jb-00@wagner>
Message-ID: <Pine.LNX.4.40.0112081824210.1019-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 Dec 2001, Rusty Russell wrote:

> With HMT/hyperthread:
> 	Fifth process scheduled on 4 (shared with 0).
>
> 	When processes on 1, 2, or 3 schedule(), that processor sits
> 	idle, while processor 0/4 is doing double work (ie. only 2 in
> 	5 chance that the right process will schedule() first).
>
> 	Finally, 0 or 4 will schedule() then wakeup, and be pulled
> 	onto another CPU (unless they are all busy again).

It's not easy to get this right anyway.
Using the scheduler i'm working on and setting a trigger load level of 2,
as soon as the idle is scheduled it'll go to grab the task waiting on the
other cpu and it'll make it running.
But this is not always right and, more difficult, it's very problematic to
understand when it's right and when it's not to behave in that way.
Think about a task that has built its own cache image on that cpu and that
it's veru likely that it's going to be woken up very soon.
By picking up another task you're going to trash its cache image.
What i'm thinking is to have the idle, instead of permanently halt()ed
waiting for an IPI, to be woken up at each timer tick to check the overall
balancing status.
Each time an unbalancing is discovered a counter ( on the idle cpu ) is
increased and, when this counter will become above a certain value, the
move is actually performed.
In this way we'll have a value that will make the scheduler to bahave
differently depending on its settings.




- Davide


