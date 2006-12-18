Return-Path: <linux-kernel-owner+w=401wt.eu-S1753333AbWLRBGJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753333AbWLRBGJ (ORCPT <rfc822;w@1wt.eu>);
	Sun, 17 Dec 2006 20:06:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753336AbWLRBGJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Dec 2006 20:06:09 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:42080 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753333AbWLRBGI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Dec 2006 20:06:08 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <4585E967.6000706@s5r6.in-berlin.de>
Date: Mon, 18 Dec 2006 02:05:43 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.8) Gecko/20061202 SeaMonkey/1.0.6
MIME-Version: 1.0
To: Gene Heskett <gene.heskett@verizon.net>
CC: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       linux1394-devel@lists.sourceforge.net
Subject: Re: ieee1394 in 2.6.20-rc1 (was Re: Linux 2.6.20-rc1)
References: <Pine.LNX.4.64.0612131744290.5718@woody.osdl.org> <200612171404.56278.gene.heskett@verizon.net> <4585A6C3.6010107@s5r6.in-berlin.de> <200612171834.59624.gene.heskett@verizon.net>
In-Reply-To: <200612171834.59624.gene.heskett@verizon.net>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gene Heskett wrote:
> The camera has been turned back off, but yes, it works absolutely normally 
> now.  With no dv1394 in memory!
> 
> Then with the camera on and kino controlling it:
> [root@coyote ~]# lsmod|grep 1394
> raw1394                32264  4
> ohci1394               39088  0
> ieee1394              305624  2 raw1394,ohci1394
> 
> So we still don't appear to have any use of/for ohci1394.  What the heck 
> is it supposed to be doing?

What's missing in our implementation is that the use count of ohci1394
goes up too once a "high-level driver" uses resources of a host driven
by ohci1394.

The FireWire stack has three layers: Low level (ohci1394 and pcilynx;
control the host bus adapter), mid level (the ieee1394 core) and high
level (protocol drivers: dv1394, eth1394, sbp2, video1394; and the
multi-purpose bridge to userspace: raw1394). The mid level is supposed
to isolate high-level drivers from hardware-specific drivers.

However dv1394 and video1394 break this architecture. Parts of them
access ohci1394 directly. And in practice, sbp2 indirectly breaks this
architecture too because it never got decent DMA mapping implemented,
and what it got in this department bitrotted to a degree that it is
currently not really usable with pcilynx. (AFAIK, I don't have a PCILynx
controller.)

BTW, sbp2 had the same problem with missing use count of ohci1394 too
until Linux < 2.6.17. But it's a little bit harder to get right in raw1394.

> Now, do I need dv1394 to do the export if I were to want to re-write the 
> edited video back to the tape in the camera?

I suppose Kino is exporting DV via raw1394 nowadays too. Raw1394
definitely has the means for it.

Anyway, I'm glad it sort of works for you now.
-- 
Stefan Richter
-=====-=-==- ==-- =--=-
http://arcgraph.de/sr/
