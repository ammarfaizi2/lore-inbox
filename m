Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136322AbRDWA3F>; Sun, 22 Apr 2001 20:29:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136324AbRDWA2z>; Sun, 22 Apr 2001 20:28:55 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:37130 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S136322AbRDWA2n>;
	Sun, 22 Apr 2001 20:28:43 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15075.30495.165442.571060@tango.linuxcare.com.au>
Date: Mon, 23 Apr 2001 10:28:15 +1000 (EST)
To: "Tim Wilson" <timwilson@mediaone.net>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] ppp_generic, kernel 2.4.3
In-Reply-To: <NEBBLAAHELEKOBCCJHLHCEGACCAA.timwilson@mediaone.net>
In-Reply-To: <15074.30971.184067.341145@gargle.gargle.HOWL>
	<NEBBLAAHELEKOBCCJHLHCEGACCAA.timwilson@mediaone.net>
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Wilson writes:

> Thanks for your reply. It seems I am finally talking to the right person (I
> had previously tried posting this on the pptp-server mailing list, and I
> also tried sending it to you directly, but no luck).

Sorry, life has been a little turbulent for me over the last couple of
months.

> Well, I do know that people set up Linux gateways as PPTP servers, and that
> they use MPPE to allow win98 clients to connect to those servers. That's
> what I was trying to do anyway. After the connect, the gateway log says that
> MPPE is negotiated, and the win98 client claims MPPE is being used, so all
> looks OK, but the gateway sends PPP frames in cleartext. If that's not a
> security hole, it is certainly not a Good Thing.

Well, it's a consequence of using a knife to drive in a nail. :)

Neither CCP nor the Linux CCP implementation are really designed to
support encryption.  There is a fairly strong assumption that if
things go pear-shaped you can always take CCP down and send stuff
uncompressed - it will be slower but it will still work.

> As my patch shows, the fix
> is quite easy, so reqardless of what we call it, might as well fix it.

Sure, we can fix the problem you've pointed out, but that won't make
for a secure MPPE implementation.  (Is that an oxymoron, actually?)
What I am saying is that even with your fix there is still a lot more
work to do if you want to make sure that you never send or accept
unencypted PPP frames.

>      Server			Client
> 1)   <----------------ConfReq
> 2)   ConfAck-------------->
> 3)   ConfReq-------------->
> 4)   <----------------ConfAck
> 
> 
> The existing code (correctly) enables the compressor when it sends the
> ConfAck (2). Then, it (incorrectly) disables the compressor when sending the
> ConfReq in (3). With my fix, that doesn't happen; the compressor is disabled
> at by reception of the ConfReq at(1), but it's not enabled yet anyway, so no
> harm done.

Good point.

> 	if( ppp->flags & SC_CCP_UP) {
> 		ppp->rstate &= ~SC_DECOMP_RUN;
> 		ppp->xstate &= ~SC_COMP_RUN;
> 		ppp->flags &= ~SC_CCP_UP;
> 	}

Yep, with the exception that I wouldn't clear SC_CCP_UP, since that is
set and cleared by pppd.

Here is an updated patch.

Paul.

diff -urN linux/drivers/net/ppp_generic.c pmac/drivers/net/ppp_generic.c
--- linux/drivers/net/ppp_generic.c	Sun Apr 22 17:07:28 2001
+++ pmac/drivers/net/ppp_generic.c	Mon Apr 23 10:12:27 2001
@@ -1993,10 +1993,10 @@
 		/*
 		 * CCP is going down - disable compression.
 		 */
-		if (inbound)
+		if (ppp->flags & SC_CCP_UP) {
 			ppp->rstate &= ~SC_DECOMP_RUN;
-		else
 			ppp->xstate &= ~SC_COMP_RUN;
+		}
 		break;
 
 	case CCP_CONFACK:
@@ -2054,7 +2054,7 @@
 		ppp->xc_state = 0;
 	}
 
-	ppp->xstate &= ~SC_DECOMP_RUN;
+	ppp->rstate &= ~SC_DECOMP_RUN;
 	if (ppp->rc_state) {
 		ppp->rcomp->decomp_free(ppp->rc_state);
 		ppp->rc_state = 0;
