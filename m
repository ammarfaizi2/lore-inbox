Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293673AbSCESOH>; Tue, 5 Mar 2002 13:14:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293667AbSCESN5>; Tue, 5 Mar 2002 13:13:57 -0500
Received: from ithilien.qualcomm.com ([129.46.51.59]:3284 "EHLO
	ithilien.qualcomm.com") by vger.kernel.org with ESMTP
	id <S293663AbSCESNs>; Tue, 5 Mar 2002 13:13:48 -0500
Message-Id: <5.1.0.14.2.20020305095825.01b61fd8@mail1.qualcomm.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Tue, 05 Mar 2002 10:13:28 -0800
To: jt@hpl.hp.com, Paul Mackerras <paulus@samba.org>
From: Maksim Krasnyanskiy <maxk@qualcomm.com>
Subject: Re: PPP feature request (Tx queue len + close)
Cc: linux-ppp@vger.kernel.org,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20020305094535.A792@bougret.hpl.hp.com>
In-Reply-To: <15492.21937.402798.688693@argo.ozlabs.ibm.com>
 <20020304144200.A32397@bougret.hpl.hp.com>
 <15492.13788.572953.6546@argo.ozlabs.ibm.com>
 <20020304191947.A32730@bougret.hpl.hp.com>
 <15492.21937.402798.688693@argo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

> > It doesn't exist at the moment, but it would be easy enough to add
> > it.  In the short term, you could even add an ifconfig to your
> > /etc/ppp/ip-up script to set the transmit queue length there.
>
>         Will try that.
>         Actually, this is why I ask you in advance, so that we have
>the time to think about it without rushing...
That's what exactly what I do to increase txqueue length.
         ifconfig $1 txqueuelen 20

> > > > Could you produce some numbers showing better throughput, fewer
> > > > retransmissions, or whatever, with a smaller transmit queue length?
> > >
> > >     Don't have number, but I don't need number to know that.
> >
> > Your case for wanting something done will be so much stronger if you
> > show that there is a measurable benefit as opposed to just a gut 
> feeling. :)
>
>         Well, it's pretty obvious when watching tcpdump. You see all
>the Tx clustered together and then nothing get Tx until the TCP window
>opens again. In other word, you have a full TCP window queued in PPP
>and IrDA.
>         This is pretty bad for latency. Actually, you can verify that
>by doing ping while a TCP connection is active, you will see huge
>roundtrips.
Setting txqueuelen to 1 will pretty much kill TCP performance as soon as 
window will grow
to more than 1 segment. Because net layer just drops packet if txqueue is 
full and TCP will
have to re-transmit. Don't trust your gut feeling ;-).
I did some experiments with PPP over HDR links here in Qualcomm. And I had 
to increase
queue just because stuff was dropped even before it reaches serial driver. 
I can even claim
that for todays fast links like PPPoE, PPPoATM, HDR, etc txqueuelen == 3 is 
way to small.

btw You might want to use tcptrace. Watching tcpdump on the fly is no fun. 
tcptrace will
give you nice graphs of what happens and when.

> > My gut feeling is that the transmit queue length is already about as
> > short as we want it, and that if we make it any shorter then we will
> > start dropping a lot of packets at the transmit queue, and lose
> > performance because of that.  But I could be wrong - any networking
> > gurus care to comment ?
>
>         I believe that you won't drop packet, but just flow control
>TCP (which in turn will flow control the application). At least, this
>is the way it's happening within the IrDA stack.
You _will_ drop it, if txqueue is full. TCP will back off and re-transmit
but this will not allow TCP window to grow and you TCP performance will
be pretty bad.

I totally agree with Paul. Just decrease buffering below PPP.

Max

