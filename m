Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131638AbRDPRGb>; Mon, 16 Apr 2001 13:06:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131643AbRDPRGV>; Mon, 16 Apr 2001 13:06:21 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:9478 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131638AbRDPRGF>; Mon, 16 Apr 2001 13:06:05 -0400
Date: Mon, 16 Apr 2001 10:05:57 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: <yodaiken@fsmlabs.com>
cc: David Howells <dhowells@cambridge.redhat.com>,
        Andrew Morton <andrewm@uow.edu.au>, Ben LaHaise <bcrl@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: rw_semaphores
In-Reply-To: <20010416083912.C4036@hq.fsmlabs.com>
Message-ID: <Pine.LNX.4.31.0104160957340.32030-100000@cesium.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 16 Apr 2001 yodaiken@fsmlabs.com wrote:
>
> I'm trying to imagine a case where 32,000 sharing a semaphore was anything but a
> major failure and I can't. To me: the result of an attempt by the 32,768th locker
> should be a kernel panic. Is there a reasonable scenario where this is wrong?

Hint: "I'm trying to imagine a case when writing all zeroes to /etc/passwd
is anything but a major failure, but I can't. So why don't we make
/etc/passwd world-writable?"

Right. Security.

There is _never_ any excuse for panic'ing because of some inherent
limitation of the data structures. You can return -ENOMEM, -EAGAIN or
somehting like that, but you must _not_ allow a panic (or a roll-over,
which would just result in corrupted kernel data structures).

Note that the limit is probably really easy to work around even without
extending the number of bits: a sleeper that notices that the count is
even _halfway_ to rolling around could easily do something like:

 - undo "this process" action
 - sleep for 1 second
 - try again from the beginning.

I certainly agree that no _reasonable_ pattern can cause the failure, but
we need to worry about people who are malicious. The above trivial
approach would take care of that, while not penalizing any non-malicious
users.

So I'm not worried about this at all. I just want people _always_ to think
about "how could I mis-use this if I was _truly_ evil", and making sure it
doesn't cause problems for others on the system.

(NOTE: This does not mean that the kernel has to do anything _reasonable_
under all circumstances. There are cases where Linux has decided that
"this is not something a reasonable program can do, and if you try to do
it, we'll give you random results back - but they will not be _security_
holes". We don't need to be _nice_ to unreasonable requests. We just must
never panic, otherwise crash or allow unreasonable requests to mess up
_other_ people)

		Linus

