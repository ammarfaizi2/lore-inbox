Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261267AbVCGWzH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261267AbVCGWzH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 17:55:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261256AbVCGWya
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 17:54:30 -0500
Received: from cpc1-oxfd2-6-0-cust43.oxfd.cable.ntl.com ([81.103.191.43]:18441
	"EHLO fluffy.bear-cave.org.uk") by vger.kernel.org with ESMTP
	id S261854AbVCGWJ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 17:09:27 -0500
Message-ID: <XFMail.20050307220832.jim.hague@acm.org>
X-Mailer: XFMail 1.5.4 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
MIME-Version: 1.0
In-Reply-To: <Pine.LNX.4.60.0503072119420.6636@poirot.grange>
Date: Mon, 07 Mar 2005 22:08:32 -0000 (GMT)
X-Face: #e_3/{lz7I8PY]c%cr|7\sfMTD|Ar*F0e~U%InA`aG0^}hG2hT`H9Lr=R?Nl,9-cP)_o}BN
 DAB"m_&V"ntfjv%6q30^]Q\<YL5[mLMi"X_qm`eA^AA?-SC>NTny77`@0?P@FpO{b*dM409XvO$kmP
 [~W=-Cm~|#49QE;@'K}LGK}??aD=>|x=B:n6"`}!9FIrtfOx%`hTC5#VFORluPrtN_#-_6b,Cu^NF|
 :D=97AFz\(mw=K
Organization: The Bear Cave
From: Jim Hague <jim.hague@acm.org>
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [2.6.11 Permedia-2 Framebuffer] driver broken (?).
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guennadi,

> Thanks for the patch. Yes, it does fix switching between X and VT.

OK, good.

> As for colours / graphics, disabling CONFIG_FB_PM2_FIFO_DISCONNECT fixes
> that too, but it worked under 2.6.10-rc2 with that option on too. What does
> it do and why I cannot use it under 2.6.11 any more? The help text to this 
> option is not very enlightening...

(To be honest, I've never looked closely at this but inherited it from Illo's
2.4 driver. Cue scrabbling around in manuals...)

pm2fb programs the Permedia registers by writing to a FIFO. Normally if you
attempt to write to the FIFO and the FIFO is full, the write is lost. So pm2fb
checks before writing that there is sufficient space in the FIFO to hold the
full command sequence, and if not it loops waiting for the FIFO to empty
sufficiently.

Enabling FIFO_DISCONNECT enables PCI Disconnect. In this mode, if a write to
the FIFO occurs when the FIFO is full, the Permedia chip enables PCI Disconnect
which causes the processor to keep retrying the write cycle until the FIFO
empties and the write succeeds.

On the one hand this allows faster download to the Permedia because you don't
have to check the FIFO space, but at a cost of hogging the PCI bus (and possibly
causing interrupt loss) until the Permedia is ready. The programmers manual
cautions that it should only be used when you know that the Permedia can
consume data faster than the host can generate it and/or where there are no
time-critical periperals on the PCI bus.

All of which sounds to me like enabling PCI Disconnect isn't a great idea and
offers at best infinitesimal speedups. Having said that, the X driver does seem
to turn it on, which probably shows how much I know. As to why it's suddenly
stopped working, I have no idea. I'll try it out and see if I see the same
problems.

-- 
Jim Hague - jim.hague@acm.org          Never trust a computer you can't lift.
