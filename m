Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278041AbRJOTPo>; Mon, 15 Oct 2001 15:15:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278040AbRJOTPe>; Mon, 15 Oct 2001 15:15:34 -0400
Received: from cs181088.pp.htv.fi ([213.243.181.88]:15488 "EHLO
	cs181088.pp.htv.fi") by vger.kernel.org with ESMTP
	id <S278030AbRJOTPS>; Mon, 15 Oct 2001 15:15:18 -0400
Message-ID: <3BCB35CA.4D9D2952@welho.com>
Date: Mon, 15 Oct 2001 22:15:22 +0300
From: Mika Liljeberg <Mika.Liljeberg@welho.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.10-ac10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: kuznet@ms2.inr.ac.ru
CC: ak@muc.de, davem@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: TCP acking too fast
In-Reply-To: <200110151840.WAA24000@ms2.inr.ac.ru>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kuznet@ms2.inr.ac.ru wrote:
> > Well, I think this "problem" is way overstated.
> 
> Understated. :-)
> 
> Actually, people who designed all this engine always kept in the mind
> only two cases: ftp and telnet. Who did care that some funny
> protocols sort of smtp work thousand times slower than they could?

Well, if you ask me, it's smtp that is a prime example of braindead
protocol design. It's a wonder we're still using it. If you put that
many request-reply interactions into a protocol that could easily be
done in one you're simply begging for a bloody nose. Nagle or not, smtp
sucks. :)

Anyway, Minshall's version of Nagle is ok with smtp as long as the smtp
implementation isn't stupid enough to emit two remants in one go (yeah,
right).

Anyway, it would be interesting to try a (even more) relaxed version of
Nagle that would allow a maximum of two remnants in flight. This would
basically cover all TCP request/reply cases (leading AND trailing
remnant). Coupled with large initial window to get rid of  small-cwnd
interactions, it might be almost be all right.

Assuming the above, we woulnd't need your ack-every-pushed-remnant
policy, except for the following pathological bidirection case:

A and B send two remnants to each other at the same time. Then both
block waiting for ack, until finally one of them sends a delay ack. You
could break this deadlock by using the following rule:

- if we're blocked on Nagle (two remnants out) and the received segment
has PSH, send ACK immediately

In other cases you wouldn't need to ack pushed segments. What do you
think? :-) 

> Alexey

Regards,

	MikaL
