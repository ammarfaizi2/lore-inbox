Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271186AbRHZAry>; Sat, 25 Aug 2001 20:47:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271200AbRHZAro>; Sat, 25 Aug 2001 20:47:44 -0400
Received: from alpo.casc.com ([152.148.10.6]:57797 "EHLO alpo.casc.com")
	by vger.kernel.org with ESMTP id <S271186AbRHZAra>;
	Sat, 25 Aug 2001 20:47:30 -0400
From: John Stoffel <stoffel@casc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15240.18121.972361.669914@gargle.gargle.HOWL>
Date: Sat, 25 Aug 2001 20:46:01 -0400
To: Rik van Riel <riel@conectiva.com.br>
Cc: "Marc A. Lehmann" <pcg@goof.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Roger Larsson <roger.larsson@skelleftea.mail.telia.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [resent PATCH] Re: very slow parallel read performance
In-Reply-To: <Pine.LNX.4.33L.0108251752010.5646-100000@imladris.rielhome.conectiva>
In-Reply-To: <20010825213536.D18523@cerebro.laendle>
	<Pine.LNX.4.33L.0108251752010.5646-100000@imladris.rielhome.conectiva>
X-Mailer: VM 6.95 under Emacs 20.6.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Rik> On Sat, 25 Aug 2001, Marc A. Lehmann wrote:
>> On Sat, Aug 25, 2001 at 08:15:44PM +0100, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>> > How much disk and bandwidth can you afford. With vsftpd its certainly over
>> > 1000 parallal downloads on a decent PII box

>> exactly this is a point: my disk can do 5mb/s with almost random
>> seeks, and linux indeed reads 5mb/s from it. but the userpsace
>> process doing read() only ever sees 2mb/s because the kernel throes
>> away all the nice pages.

Rik> The trick here is for the kernel to throw away the pages the
Rik> processes have already used and keep in memory the data we have
Rik> not yet used.

Ummm... is this really more of an agreement that Daniel's used-once
patch is a good idea on a system.  Keep a page around if it's used
once, but drop it quickly if only used once?  But you seem to be
saying that in this one case (serving lots of files to multiple
clients) that you should be reading in as fast as possible, but then
dropping those read in pages right away.

If so, shouldn't this be more of an application level type of
optimization here, and not so much the VM's problem?  The VM needs to
be general and fair over a large spread of loads, I can't imagine that
we'll get it right for every single possible load out there.  

Maybe what would help here is having some type of VM simulator written
where we could plug in the current Linux VM and instrument it and
watch what it does under a variety of loads and make it react in a
smooth fashion.  Right now it looks like people are just tweaking
stuff left and right (though since I don't know the core code at all,
it's just my impression) without having a good theoretical
understanding of what's really happening.

I've been following this VM discussion for a while now, and I'm not
sure we're really closer to fixing the corner case where the load gets
out of hand.  But I do think Daniel is on the right case in terms of
trying to wake up and free as many pages as were allocated in a
quanta.  Trying to wakeup once a wall clock second doesn't seem as
realistic.  Under very light loads, you're just spending time doing
work that isn't needed.  Under heavy loads, you may be reacting way
too slowly.  

As we get closer to being out of free pages, we should work harder,
but also do less work as the percentage of free pages goes up and the
system VM load goes down.  

Enough of my rambling, and please realize I appreciate all the work
and words that have been flowing around this topic, it's getting
better all the time and we've got enough veiwpoints going to keep
everyone honest and working to the same goal.

John

