Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265727AbUGDPXz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265727AbUGDPXz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jul 2004 11:23:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265736AbUGDPXz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jul 2004 11:23:55 -0400
Received: from [213.146.154.40] ([213.146.154.40]:41937 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S265727AbUGDPXx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jul 2004 11:23:53 -0400
Date: Sun, 4 Jul 2004 16:23:52 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Bernd Schubert <bernd-schubert@web.de>, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
Subject: Re: 2.6.7: sk98lin unload oops
Message-ID: <20040704152352.GA5243@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Bernd Schubert <bernd-schubert@web.de>,
	linux-kernel@vger.kernel.org, netdev@oss.sgi.com
References: <200407041342.18821.bernd-schubert@web.de> <20040704151509.GA5100@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040704151509.GA5100@infradead.org>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 04, 2004 at 04:15:09PM +0100, Christoph Hellwig wrote:
> > Fortunality everything still works fine (I'm running the script over the 
> > network of the syskonnect cards).
> > 
> > This machine has two of those syskonnect cards, on another machine which has 
> > only one syskonnect card this oops doesn't occur.
> 
> As a colleteral damage the following huge patch should fix it, and I need
> testers for it anyway ;-)

Actually the problem sits deeper.  sk98line tries to register a procfile with
the interfacename of the struct net_device.  The patch below (ontop of
the previous one) makes it work unless you change the interface name manually,
but as Linux explicitly allows that the interface is fundamentally broken and
probably should just go away.


--- drivers/net/sk98lin/skge.c~	2004-07-04 19:15:43.219326648 +0200
+++ drivers/net/sk98lin/skge.c	2004-07-04 19:18:21.562254864 +0200
@@ -5119,9 +5119,12 @@
 	if ((pAC->GIni.GIMacsFound == 2) && pAC->RlmtNets == 2)
 		have_second_mac = 1;
 
+	remove_proc_entry(dev->name, pSkRootDir);
 	unregister_netdev(dev);
-	if (have_second_mac)
+	if (have_second_mac) {
+		remove_proc_entry(pAC->dev[1]->name, pSkRootDir);
 		unregister_netdev(pAC->dev[1]);
+	}
 
 	SkGeYellowLED(pAC, pAC->IoBase, 0);
 
