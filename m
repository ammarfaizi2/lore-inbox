Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131365AbRAQU6L>; Wed, 17 Jan 2001 15:58:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132061AbRAQU6B>; Wed, 17 Jan 2001 15:58:01 -0500
Received: from palrel1.hp.com ([156.153.255.242]:55814 "HELO palrel1.hp.com")
	by vger.kernel.org with SMTP id <S131365AbRAQU5o>;
	Wed, 17 Jan 2001 15:57:44 -0500
Message-ID: <3A660746.543226B@cup.hp.com>
Date: Wed, 17 Jan 2001 12:57:42 -0800
From: Rick Jones <raj@cup.hp.com>
Organization: the Unofficial HP
X-Mailer: Mozilla 4.75 [en] (X11; U; HP-UX B.11.00 9000/785)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [Fwd: [Fwd: Is sendfile all that sexy? (fwd)]]
In-Reply-To: <Pine.LNX.4.30.0101171231420.16292-100000@twinlark.arctic.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Hmm, I would think that nagle would only come into play if those files
> > were each less than MSS and there were no intervening application level
> > reply/request messages for each.
> 
> actually the problem isn't nagle...  nagle needs to be turned off for
> efficient servers anyhow.  

i'm not sure I follow that. could you expand on that a bit?

> but once it's turned off, the standard socket
> API requires (or rather allows) the kernel to flush packets to the wire
> after each system call.

most definitely allows, not requires.

> consider the case where you're responding to a pair of pipelined HTTP/1.1
> requests.  with the HPUX and BSD sendfile() APIs you end up forcing a
> packet boundary between the two responses.  this is likely to result in
> one small packet on the wire after each response.

i _possibly_ have a packet boundary. if the last small bit of the first
file is handed to the transport when there is sufficient clasic and
congestion window to send it or that window "arrives" before the first
chunk of the second file is sent.

on the topic of pipelining - do the pipelined requests tend to be send
or arrive together? 

> with the linux TCP_CORK API you only get one trailing small packet.  in
> case you haven't heard of TCP_CORK -- when the cork is set, the kernel is
> free to send any maximum size packets it can form, but has to hold on to
> the stragglers until userland gives it more data or pops the cork.

i'd heard interesting generalities but no specifics. for instance, when
the send is small, does TCP wait exclusively for the app to flush, or is
there an "if all else fails" sort of timer running?

> (the heuristic i use in apache to decide if i need to flush responses in a
> pipeline is to look if there are any more requests to read first, and if
> there are none then i flush before blocking waiting for new requests.)

how often to you find yourself flushing the little bits anyhow?

> > As for the header/trailer stuff, you're right, I should have spec'd a
> > separate iovec for each :)
> 
> well, if you've got low system call overhead (such as linux ;), and you
> add TCP_CORK ... then you don't even need to combine all those system
> calls into one monster syscall.

how low is the system call overhead to check for the next request before
you flush?

(i'm not sure that I'd say HP-UX sendfile() was a combination of system
calls - i'd probably say it was a (partial) replacement for writev())

rick jones
-- 
ftp://ftp.cup.hp.com/dist/networking/misc/rachel/
these opinions are mine, all mine; HP might not want them anyway... :)
feel free to email, OR post, but please do NOT do BOTH...
my email address is raj in the cup.hp.com domain...
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
