Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261882AbUCDNN2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 08:13:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261883AbUCDNN2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 08:13:28 -0500
Received: from ns.suse.de ([195.135.220.2]:7406 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261882AbUCDNN0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 08:13:26 -0500
Date: Thu, 4 Mar 2004 14:13:19 +0100
From: Andi Kleen <ak@suse.de>
To: Arkadiusz Miskiewicz <arekm@pld-linux.org>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: ip a flush problem on 2.6 kernels (fine on 2.4 kernels)
Message-Id: <20040304141319.2d1cb112.ak@suse.de>
In-Reply-To: <200403040308.15880.arekm@pld-linux.org>
References: <200403040308.15880.arekm@pld-linux.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Mar 2004 03:08:15 +0100
Arkadiusz Miskiewicz <arekm@pld-linux.org> wrote:

> The problem is that
> 
> ip a a 192.168.0.1/24 dev eth0
> ip link set eth0 down
> ip a flush dev eth0
> 
> Here on my vanilla 2.6.2 it locks eating CPU - it does netlink 
> communication over and over. This ,,hang'' doesn't happen when 
> interface is in UP state. Also doesn't happen on 2.4 kernels.

I fixed it with this patch for iproute2 here. It's not clear to me at 
all how it ever worked before. The loop seems to be just wrong.

-Andi

diff -u iproute2/ip/ipaddress.c~ iproute2/ip/ipaddress.c
--- iproute2/ip/ipaddress.c~	2004-03-07 20:54:52.000000000 +0100
+++ iproute2/ip/ipaddress.c	2004-03-07 21:02:12.000000000 +0100
@@ -623,6 +623,9 @@
 				fflush(stdout);
 				return 0;
 			}
+#if 1
+			break; 
+#else
 			round++;
 			if (flush_update() < 0)
 				exit(1);
@@ -630,6 +633,7 @@
 				printf("\n*** Round %d, deleting %d addresses ***\n", round, filter.flushed);
 				fflush(stdout);
 			}
+#endif
 		}
 	}
 
