Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131515AbRASDgF>; Thu, 18 Jan 2001 22:36:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132764AbRASDf4>; Thu, 18 Jan 2001 22:35:56 -0500
Received: from twinlark.arctic.org ([204.107.140.52]:31755 "HELO
	twinlark.arctic.org") by vger.kernel.org with SMTP
	id <S132661AbRASDf2>; Thu, 18 Jan 2001 22:35:28 -0500
Date: Thu, 18 Jan 2001 19:35:27 -0800 (PST)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: Andrea Arcangeli <andrea@suse.de>
cc: Linus Torvalds <torvalds@transmeta.com>, Ingo Molnar <mingo@elte.hu>,
        Rick Jones <raj@cup.hp.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [Fwd: [Fwd: Is sendfile all that sexy? (fwd)]]
In-Reply-To: <Pine.LNX.4.30.0101181918280.16292-100000@twinlark.arctic.org>
Message-ID: <Pine.LNX.4.30.0101181929560.16292-100000@twinlark.arctic.org>
X-comment: visit http://arctic.org/~dean/legal for information regarding copyright and disclaimer.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ok i'm spouting lots today sorry! :)

can i just say this solves even more problems?

there's a problem with the current apache pipeline code where if a
pipeline consists of, say, a light request followed by a heavy request. a
"light" request is say, a static file, something that essentially is
served immediately.  a "heavy" request could be a dynamic request which
has to go off and fetch something from a distant database.

the heavy request may take several seconds to get the info and form its
response.  all that time apache is delaying the final packet of the first
light request *hoping* that it'll be able to form a nice big buffer for
the kernel.

with SIOCPUSH and nagle this problem disappears.  apache can make sure to
write() to the kernel at the end of each request, no matter how small.
it will SIOCPUSH the response out if there's nothing more in the pipeline,
otherwise it'll proceed to the next request in the pipeline.  if the next
request is heavy, the kernel will eventually push the last request out
when the nagle timer expires... rather than after several seconds or
whenever the heavy response starts to be written.

damn that's sweet.  now if only i had a portable version of this :)

-dean

On Thu, 18 Jan 2001, dean gaudet wrote:

> huh -- i think with this apache could solve the problem documented in
> heidemann's paper while also leaving nagle on... which would solve the CGI
> dribbler vs. bulk problem i just posted about.
>
> at the end of a request apache would check first if it can get another
> request without blocking; if it would block then it issues a SIOCPUSH and
> drops into poll() waiting for a new request.
>
> this means the final packet of a response isn't ever delayed (which is the
> motivation for turning off nagle); and a multi-request pipeline has
> maximal packets... and a dribbling CGI won't cause as many tiny packets.
>
> this may in fact also eliminate the need for CORK, unless anyone can
> really think of an app that wouldn't even want small packets on the wire
> when the server hasn't sent anything for a while.
>
> i like this one :)
>
> -dean
>
> On Thu, 18 Jan 2001, Andrea Arcangeli wrote:
>
> > diff -urN -X /home/andrea/bin/dontdiff 2.4.1pre8/net/ipv4/tcp.c SIOCPUSH/net/ipv4/tcp.c
> > --- 2.4.1pre8/net/ipv4/tcp.c	Wed Jan 17 04:02:38 2001
> > +++ SIOCPUSH/net/ipv4/tcp.c	Thu Jan 18 19:10:14 2001
> > @@ -671,6 +671,11 @@
> >  		else
> >  			answ = tp->write_seq - tp->snd_una;
> >  		break;
> > +	case SIOCPUSH:
> > +		lock_sock(sk);
> > +		__tcp_push_pending_frames(sk, tp, tcp_current_mss(sk), 1);
> > +		release_sock(sk);
> > +		break;
> >  	default:
> >  		return(-ENOIOCTLCMD);
> >  	};
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
>

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
