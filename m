Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262672AbREVRNY>; Tue, 22 May 2001 13:13:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262671AbREVRNO>; Tue, 22 May 2001 13:13:14 -0400
Received: from www.microgate.com ([216.30.46.105]:38670 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP
	id <S262670AbREVRNE>; Tue, 22 May 2001 13:13:04 -0400
Message-ID: <01a801c0e2ea$dfffc5c0$0c00a8c0@diemos>
From: "Paul Fulghum" <paulkf@microgate.com>
To: <linux-kernel@vger.kernel.org>
Cc: <paulus@samba.org>
In-Reply-To: <200105221334.f4MDYsc22597@xyzzy.clara.co.uk>
Subject: Re: SyncPPP IPCP/LCP loop problem and patch
Date: Tue, 22 May 2001 12:13:16 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Seems to me that when you get the conf-request in opened state, you
> > should send your conf-request before sending the conf-ack to the
> > peer's conf-request.  I think this would short-circuit the loop (I
> > could be wrong though, it's getting late).
> 
> Thanks but I've already tried that. You get a slightly different pattern
> to the loop but it still loops.

I'm just wondering if the loop that results when
the cfg-req is sent 1st might be a results of 
syncppp not processing a cfg-ack properly when
in the opened state.

RFC1661 state table shows a transition to req-sent
from opened when a (properly formated with 
correct sequence ID) cfg-ack is received.

Syncppp does not do this (from sppp_lcp_input):

 case LCP_CONF_ACK:
  if (h->ident != sp->lcp.confid)
   break;
  sppp_clear_timeout (sp);
  if ((sp->pp_link_state != SPPP_LINK_UP) &&
      (dev->flags & IFF_UP)) {
   /* Coming out of loopback mode. */
   sp->pp_link_state=SPPP_LINK_UP;
   printk (KERN_INFO "%s: protocol up\n", dev->name);
  }
  switch (sp->lcp.state) {
  case LCP_STATE_CLOSED:
   sp->lcp.state = LCP_STATE_ACK_RCVD;
   sppp_set_timeout (sp, 5);
   break;
  case LCP_STATE_ACK_SENT:
   sp->lcp.state = LCP_STATE_OPENED;
   sppp_ipcp_open (sp);
   break;
  }
  break;

Maybe adding:

  case LCP_STATE_OPENED:
   sppp_lcp_open (sp);
   sp->ipcp.state = IPCP_STATE_CLOSED;
   sp->lcp.state = LCP_STATE_REQ_SENT;
   break;

to the above switch statement in addition to
the cfg-req 1st change would cure both loops.

Paul Fulghum paulkf@microgate.com
Microgate Corporation www.microgate.com



