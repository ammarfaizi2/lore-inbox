Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264113AbTKUCPM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 21:15:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264126AbTKUCPM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 21:15:12 -0500
Received: from dhcp024-209-039-102.neo.rr.com ([24.209.39.102]:54403 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S264113AbTKUCPG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 21:15:06 -0500
Date: Thu, 20 Nov 2003 21:09:53 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Lawrence Walton <lawrence@the-penguin.otak.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Opps on boot 2.6.0-pre9-mm4
Message-ID: <20031120210953.GA25417@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Andrew Morton <akpm@osdl.org>,
	Lawrence Walton <lawrence@the-penguin.otak.com>,
	linux-kernel@vger.kernel.org
References: <20031120193318.GA5578@the-penguin.otak.com> <20031120131945.3cd35911.akpm@osdl.org> <20031120233006.GA1331@the-penguin.otak.com> <20031120160601.6b1fbd53.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031120160601.6b1fbd53.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 20, 2003 at 04:06:01PM -0800, Andrew Morton wrote:
> Lawrence Walton <lawrence@the-penguin.otak.com> wrote:
> >
> > > Looks like it died inside the machine's BIOS.
> > >
> > > Please try reverting the three pnp patches:
> > >
> > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test9/2.6.0-test9-mm4/broken-out/pnp-fix-3.patch
> > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test9/2.6.0-test9-mm4/broken-out/pnp-fix-2.patch
> > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test9/2.6.0-test9-mm4/broken-out/pnp-fix-1.patch
> > >
> > > and let us know?
> > >
> > I reverted these and it works great!
> >
> >
> >
> > > - Upgrade the bios
> > The bios is the latest so updating it would not of been a option.
> >
>
> OK, thanks.   Adam, those pnp patches are suspect...

Hmm, well it couldn't be patch 3 because it relates to isapnp.  Patch
1 is the only patch that changes the PnPBIOS calls, and it has been
known to fix problems for some systems.  Also it does what the actual
specifications recommend.  You may just have a buggy system that's
triggered by the static resource calls.  If so, we could use dynamic
instead resources when the DMI scan matches with this system.  Patch
2 provides an option to disable the PnPBIOS proc interface, but it
should not affect PnPBIOS calls.

Lawrence, could you please test this again, only this time excluding
patch 1 and no others.  If that doesn't work try excluding patch 2.

Thanks,
Adam

P.S.

Andrew, could you please review this patch for your tree.

# --------------------------------------------
# 03/11/15	ambx1@neo.rr.com	1.1447
# [PnP] reserve resources specified by the PnPBIOS properly
#
# A bug prevents the PnP layer from reserving some of the resources
# specified by the PnPBIOS.  As a result some systems will have
# unpredicable (random crashes etc.) problems because of resource
# conflicts, especially when PCMCIA support is enabled.  This patch
# fixes the problem by ensuring that the proper resource data is
# reserved.
# --------------------------------------------
#
diff -Nru a/drivers/pnp/system.c b/drivers/pnp/system.c
--- a/drivers/pnp/system.c	Sun Nov 16 00:25:14 2003
+++ b/drivers/pnp/system.c	Sun Nov 16 00:25:14 2003
@@ -54,7 +54,7 @@
 	int i;

 	for (i=0;i<PNP_MAX_PORT;i++) {
-		if (pnp_port_valid(dev, i))
+		if (!pnp_port_valid(dev, i))
 			/* end of resources */
 			continue;
 		if (pnp_port_start(dev, i) == 0)

