Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264832AbUEYJtw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264832AbUEYJtw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 05:49:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264827AbUEYJtw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 05:49:52 -0400
Received: from web13906.mail.yahoo.com ([216.136.175.69]:4868 "HELO
	web13906.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264833AbUEYJtf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 05:49:35 -0400
Message-ID: <20040525094933.37642.qmail@web13906.mail.yahoo.com>
X-RocketYMMF: knobi.rm
Date: Tue, 25 May 2004 02:49:33 -0700 (PDT)
From: Martin Knoblauch <knobi@knobisoft.de>
Reply-To: knobi@knobisoft.de
Subject: Re: Multicast problems between 2.4.20 and 2.4.21?
To: Frank Lind <flind@haystack.mit.edu>, linux-kernel@vger.kernel.org
Cc: knobi@knobisoft.de
In-Reply-To: <40B25CFA.3000105@haystack.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Frank Lind <flind@haystack.mit.edu> wrote:
> Hi,
> 
> Was there ever a resolution to the multicast issues with kernels
> beyond 
> 2.4.20?
>
Hi Frank,

 no real resolution in my case, just a gross hack :-) With help from
some network folks and a lot of experiments we found out that somehow
IGMPv3 did cause the problems. The new protocol was introduced in
2.4.20 or 2.4.21.

 The problem only shows up when using MC groups different from
224.0.0.1. Assuming the correctness of the IGMPv3 code, the suspects
were the switch (some CISCO 6000, with the latest - v3 capable-
Firmware) or the network card (tg3). *I* am almost sure it is not the
card. Exchanging the driver from a "working" kernel into the new kernel
(and vice versa) did not change anything. The new kernel did not work
with the old driver, and the old kernel worked fine with the new
driver. So it is likely the switch.

 Solution for me was to force IGMPv2 instead of v3. The patch for taht
looks like:

--- ../../../linux-2.4.23/net/ipv4/igmp.c       Fri Nov 28 19:26:21
2003
+++ ./igmp.c    Fri Jan  9 16:59:21 2004
@@ -124,8 +124,13 @@

 #define IGMP_V1_SEEN(in_dev) ((in_dev)->mr_v1_seen && \
                time_before(jiffies, (in_dev)->mr_v1_seen))
+#if 0
 #define IGMP_V2_SEEN(in_dev) ((in_dev)->mr_v2_seen && \
                time_before(jiffies, (in_dev)->mr_v2_seen))
+#else
+#define IGMP_V2_SEEN(in_dev) (1)
+#endif
+

 The same problem occured on another cluster (again tg3 cards - maybe
there is something ...) and an HP/Procurve-41xx switch. Here we just
switched to using 224.0.0.1 to solve the problem (we could not reboot
to use a patched kernel).

B^hCheers
Martin

=====
------------------------------------------------------
Martin Knoblauch
email: k n o b i AT knobisoft DOT de
www:   http://www.knobisoft.de
