Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316682AbSHBRZk>; Fri, 2 Aug 2002 13:25:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316684AbSHBRZk>; Fri, 2 Aug 2002 13:25:40 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:17161 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S316682AbSHBRZj>; Fri, 2 Aug 2002 13:25:39 -0400
Date: Fri, 2 Aug 2002 10:29:51 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
cc: Benjamin LaHaise <bcrl@redhat.com>, Roman Zippel <zippel@linux-m68k.org>,
       David Woodhouse <dwmw2@infradead.org>,
       David Howells <dhowells@redhat.com>, <alan@redhat.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: manipulating sigmask from filesystems and drivers
In-Reply-To: <20020802181300.B29814@kushida.apsleyroad.org>
Message-ID: <Pine.LNX.4.44.0208021023040.914-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 2 Aug 2002, Jamie Lokier wrote:
>
> Linus Torvalds wrote:
> > Sending somebody a SIGKILL (or any signal that kills the process) is
> > different (in my opinion) from a signal that interrupts a system call in
> > order to run a signal handler.
>
> So it's ok to have truncated log entries (or more realistically,
> truncated simple database entries) if the logging program is killed?

This is why I said

 "Which is what we want in generic_file_read() (and _probably_
  generic_file_write() as well, but that's slightly more debatable)"

The "slightly more debatable" comes exactly from the thing you mention.

The thing is, "read()" on a file doesn't have any side effects outside the
process that does it, so if you kill the process, doing a partial read is
always ok (yeah, you can come up with thread examples etc where you can
see the state, but I think those are so contrieved as to not really merit
much worry and certainly have no existing programs issues).

With write(), you have to make a judgement call. Unlike read, a truncated
write _is_ visible outside the killed process. But exactly like read()
there _are_ system management reasons why you may really need to kill
writers. So the debatable point comes from whether you want to consider a
killing signal to be "exceptional enough" to warrant the partial write.

I can see both sides. I personally think I'd prefer the "if I kill a
process, I want it dead _now_" approach, but this definitely _is_ up for
discussion (unlike the signal handler case).

		Linus

