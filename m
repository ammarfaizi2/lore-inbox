Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136238AbRDVRx1>; Sun, 22 Apr 2001 13:53:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136241AbRDVRxR>; Sun, 22 Apr 2001 13:53:17 -0400
Received: from elmls01.ce.mediaone.net ([24.131.128.25]:41622 "EHLO
	elmls01.ce.mediaone.net") by vger.kernel.org with ESMTP
	id <S136238AbRDVRxC>; Sun, 22 Apr 2001 13:53:02 -0400
From: "Tim Wilson" <timwilson@mediaone.net>
To: <paulus@samba.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] ppp_generic, kernel 2.4.3
Date: Sun, 22 Apr 2001 12:53:46 -0500
Message-ID: <NEBBLAAHELEKOBCCJHLHCEGACCAA.timwilson@mediaone.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <15074.30971.184067.341145@gargle.gargle.HOWL>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your reply. It seems I am finally talking to the right person (I
had previously tried posting this on the pptp-server mailing list, and I
also tried sending it to you directly, but no luck).

> Hmmm... using CCP to negotiate encryption is a Bad Idea IMHO.  I know
> Microsoft does, but that isn't really a recommendation. :)  Certainly
> pppd and the Linux PPP kernel driver don't include support for some of
> the things that the MPPE spec says you have to do, like taking down
> the link if MPPE doesn't get negotiated successfully, and not sending
> or receiving any data before MPPE is up.
>
> All of which goes to say that MPPE support is not a "feature point" of
> the Linux PPP implementation.  So a potential insecurity in an MPPE
> implementation is hardly a bug.

Well, I do know that people set up Linux gateways as PPTP servers, and that
they use MPPE to allow win98 clients to connect to those servers. That's
what I was trying to do anyway. After the connect, the gateway log says that
MPPE is negotiated, and the win98 client claims MPPE is being used, so all
looks OK, but the gateway sends PPP frames in cleartext. If that's not a
security hole, it is certainly not a Good Thing. As my patch shows, the fix
is quite easy, so reqardless of what we call it, might as well fix it.

> The bug is only going to show up if CCP gets re-negotiated, i.e. if
> CCP get negotiated and comes up and then one side starts sending
> Configure-requests to renegotiate the compression method and
> parameters.

Sorry, that's not the case. Let me see if I can explain using a little ASCII
art. Here's a legal exchange for initially opening CCP:

     Server			Client
1)   <----------------ConfReq
2)   ConfAck-------------->
3)   ConfReq-------------->
4)   <----------------ConfAck


The existing code (correctly) enables the compressor when it sends the
ConfAck (2). Then, it (incorrectly) disables the compressor when sending the
ConfReq in (3). With my fix, that doesn't happen; the compressor is disabled
at by reception of the ConfReq at(1), but it's not enabled yet anyway, so no
harm done.

> Actually, after having another look at RFC 1962 I think that either
> sending or receiving a ConfReq takes CCP out of Opened state and
> should stop compression in *both* directions.  So on balance I would
> change it like you have for TermReq and TermAck, but make the same
> change for ConfReq as well.

I'll take a look at the RFCs myself, but that sounds right. However, you
can't just handle the ConfReq like I was handling the TermReq/TermAck--take
another look at the scenario above. The compressor would get reset at (3),
we'd end up with the same problem. The ConfReq should make CCP go down only
if it's already up, something like this:

...
case CCP_CONFREQ:
case CCP_TERMREQ:
case CCP_TERMACK:
	if( ppp->flags & SC_CCP_UP) {
		ppp->rstate &= ~SC_DECOMP_RUN;
		ppp->xstate &= ~SC_COMP_RUN;
		ppp->flags &= ~SC_CCP_UP;
	}
	break;
...

(This assumes that SC_CCP_UP is the right thing to check--I'm not sure about
the distinction between SC_CCP_UP and SC_CCP_OPEN--haven't studied the code
enough. But you probably know that stuff already).

Incidentally, I looked at the 2.2 code and that's what it does.


> BTW, the spacing/indentation in the patch you sent was broken; the
> patch seemed to have 1-space indentation whereas it should be 1-tab
> indentation.  Does your mailer convert tabs to single spaces maybe?

Sorry. I'll try to fix that for next time. If we can agree on a fix for this
problem, I'll be happy to let you submit the patch. It's your code.

