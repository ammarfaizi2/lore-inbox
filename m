Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135336AbRDVHaV>; Sun, 22 Apr 2001 03:30:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135333AbRDVHaL>; Sun, 22 Apr 2001 03:30:11 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:57092 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S135336AbRDVH3z>;
	Sun, 22 Apr 2001 03:29:55 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15074.30971.184067.341145@gargle.gargle.HOWL>
Date: Sun, 22 Apr 2001 16:23:55 +1000 (EST)
To: Tim Wilson <timwilson@mediaone.net>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] ppp_generic, kernel 2.4.3
In-Reply-To: <3AE22CEC.8C000984@mediaone.net>
In-Reply-To: <3AE22CEC.8C000984@mediaone.net>
X-Mailer: VM 6.75 under Emacs 20.4.1
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Wilson writes:

> The bug can cause PPP to NOT install and use a compressor  module for
> sending,  even though the compressor is sucessfully negotiated by CCP.
> Since encryption is sometimes implemented as a compressor module (e.g.
> MPPE), this bug can cause PPP to send cleartext even though encryption
> appears to be sucessfully negotiated.

Hmmm... using CCP to negotiate encryption is a Bad Idea IMHO.  I know
Microsoft does, but that isn't really a recommendation. :)  Certainly
pppd and the Linux PPP kernel driver don't include support for some of
the things that the MPPE spec says you have to do, like taking down
the link if MPPE doesn't get negotiated successfully, and not sending
or receiving any data before MPPE is up.

All of which goes to say that MPPE support is not a "feature point" of
the Linux PPP implementation.  So a potential insecurity in an MPPE
implementation is hardly a bug.

Anyway...

> The bug does not always show up--it depends on the order of CCP messages
> exchanged during establishment, and therefore is not deterministic.

The bug is only going to show up if CCP gets re-negotiated, i.e. if
CCP get negotiated and comes up and then one side starts sending
Configure-requests to renegotiate the compression method and
parameters.

> The specific problem is handling a sent or received CCP ConfReq. A sent
> ConfReq should reset my decompressor; a received ConfReq should reset my
> compressor. The original code had this logic exactly reversed.

Actually, after having another look at RFC 1962 I think that either
sending or receiving a ConfReq takes CCP out of Opened state and
should stop compression in *both* directions.  So on balance I would
change it like you have for TermReq and TermAck, but make the same
change for ConfReq as well.

BTW, the spacing/indentation in the patch you sent was broken; the
patch seemed to have 1-space indentation whereas it should be 1-tab
indentation.  Does your mailer convert tabs to single spaces maybe?

Paul.
