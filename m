Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268066AbUHFOn6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268066AbUHFOn6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 10:43:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268067AbUHFOn6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 10:43:58 -0400
Received: from c3-1d224.neo.lrun.com ([24.93.233.224]:61570 "EHLO neo.rr.com")
	by vger.kernel.org with ESMTP id S268066AbUHFOnz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 10:43:55 -0400
Date: Fri, 6 Aug 2004 10:35:38 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: linux@dominikbrodowski.de, akpm@osdl.org, rml@ximian.com,
       linux-kernel@vger.kernel.org, linux-pcmcia@lists.infradead.org
Subject: Re: [PATCH] pcmcia driver model support [4/5]
Message-ID: <20040806103538.GG11641@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>, linux@dominikbrodowski.de,
	akpm@osdl.org, rml@ximian.com, linux-kernel@vger.kernel.org,
	linux-pcmcia@lists.infradead.org
References: <20040805222820.GE11641@neo.rr.com> <20040806114320.A13653@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040806114320.A13653@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 06, 2004 at 11:43:20AM +0100, Russell King wrote:
> On Thu, Aug 05, 2004 at 10:28:20PM +0000, Adam Belay wrote:
> > It is not safe to use the skt_sem in pcmcia_validate_mem.  This patch
> > fixes a real world bug, and without it many systems will fail to shutdown
> > properly.
> 
> However, we need to take this semaphore here to prevent the socket state
> changing.  It sounds from your description that we're hitting yet another
> stupid recursion bug in PCMCIA...

It's worth noting that we don't hold skt_sem in pcmcia_get_first_tuple (and
possibly others), but we probably should be.  This may have been to prevent
recursion bugs.

> 
> It sounds like we shouldn't be holding skt_sem when we wait for userspace
> to reply to the ejection request.

The situation is rather complicated.  pcmcia_eject_card itself has to hold
skt_sem to ensure the socket state remains correct.  We could always release
the semaphore while sending the event, and then grab it again.  Of course we
would have to check if the socket is still present a second time in the same
function.  How does this look (untested)?

--- a/drivers/pcmcia/cs.c	2004-08-05 21:28:48.000000000 +0000
+++ b/drivers/pcmcia/cs.c	2004-08-06 09:52:47.000000000 +0000
@@ -2056,11 +2056,17 @@
 			break;
 		}
 
+		up(&skt->skt_sem);
 		ret = send_event(skt, CS_EVENT_EJECTION_REQUEST, CS_EVENT_PRI_LOW);
 		if (ret != 0) {
 			ret = -EINVAL;
 			break;
 		}
+		down(&skt->sem);
+		if (!(skt->state & SOCKET_PRESENT)) {
+			ret = -ENODEV;
+			break;
+		}
 
 		socket_remove(skt);
 		ret = 0;


