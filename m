Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261168AbTFQIpZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 04:45:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261169AbTFQIpZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 04:45:25 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:3598 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261168AbTFQIpY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 04:45:24 -0400
Date: Tue, 17 Jun 2003 09:59:16 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Wiktor Wodecki <wodecki@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Still problems with PCMCIA in 2.5.72
Message-ID: <20030617095916.B25452@flint.arm.linux.org.uk>
Mail-Followup-To: Wiktor Wodecki <wodecki@gmx.de>,
	linux-kernel@vger.kernel.org
References: <20030617084622.GA623@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030617084622.GA623@gmx.de>; from wodecki@gmx.de on Tue, Jun 17, 2003 at 10:46:23AM +0200
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 17, 2003 at 10:46:23AM +0200, Wiktor Wodecki wrote:
> there are still issues with pcmcia in 2.5 series.

I believe I have them all sorted.  However, I only received confirmation
that the latest problem was solved this morning.

It appears that some cardbus bridges don't properly debounce the card
detect signals from the sockets, which sounds similar to the problem
you're reporting.  Could you check whether this patch solves your issue?

diff -Nru a/drivers/pcmcia/cs.c b/drivers/pcmcia/cs.c
--- a/drivers/pcmcia/cs.c	Tue Jun 17 09:16:20 2003
+++ b/drivers/pcmcia/cs.c	Tue Jun 17 09:16:20 2003
@@ -816,7 +816,8 @@
 				if ((skt->state & SOCKET_PRESENT) &&
 				     !(status & SS_DETECT))
 					socket_shutdown(skt);
-				if (status & SS_DETECT)
+				if (!(skt->state & SOCKET_PRESENT) &&
+				    (status & SS_DETECT))
 					socket_insert(skt);
 			}
 			if (events & SS_BATDEAD)

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

