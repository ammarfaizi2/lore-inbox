Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261317AbVEQDOV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261317AbVEQDOV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 23:14:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261310AbVEQDOV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 23:14:21 -0400
Received: from fire.osdl.org ([65.172.181.4]:63402 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261662AbVEQDOA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 23:14:00 -0400
Date: Mon, 16 May 2005 20:15:49 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Andrew Morton <akpm@osdl.org>, Netdev <netdev@oss.sgi.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [git patches] 2.6.x net driver fixes
In-Reply-To: <42892F2B.8090908@pobox.com>
Message-ID: <Pine.LNX.4.58.0505162006590.18337@ppc970.osdl.org>
References: <42892F2B.8090908@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 16 May 2005, Jeff Garzik wrote:
>
> Here's a first experimental git push from me.  The git URL is
> rsync://rsync.kernel.org/pub/scm/linux/kernel/git/jgarzik/netdev-2.6.git
> 
> but it should be noted that I would like you to pull the 'misc-fixes' 
> branch.  I'm told that branches are supposed to live in .git/refs/heads, 
> so there you will find netdev-2.6.git/refs/heads/misc-fixes.
> 
> Does that work?

Yes. Merged and pushed out.

> Changelog and patch for review attached.

It's wonderful if you also do a "diffstat" on the thing, since my merge 
scripts will always show that to me, and I can verify at a glance that it 
matches what you thought you sent me.

Also, if you are really nervous, the "git-diff-tree" thing is actually
quite good at generating changelogs, so you can do something like this:

	git-rev-tree HEAD ^ORIG_HEAD | cut -d' ' -f2 | git-diff-tree -v -p --stdin | less -S

which means: give me a list of all commits that are in HEAD but not in 
ORIG_HEAD (replace with whatever markers you have, in this case you'd use 
"misc-fixes" instead of HEAD and some marker - maybe the SHA1 - for my 
last base), then take just the SHA1 of that list of commits, and show a 
verbose diff of each of the commits with the patch.

For example, the output of the above command (after I merged from you) is 
appended, so you can see exactly what I merged.

		Linus

----
diff-tree 99718699f5746cc365f3a9ab4769568a1da97635 (from f7a3aae1723e7ffc9c4fcdb489365da7a3d81255)
Author: Geoff Levand <geoffrey.levand@am.sony.com>
Date:   Thu Apr 14 11:20:32 2005 -0700
    
    [PATCH] {PATCH] Fix IBM EMAC driver ioctl bug
    
    Fix IBM EMAC driver ioctl bug.
    
    I found IBM EMAC driver bug.
    So mii-tool command print wrong status.
    
      # mii-tool
      eth0: 10 Mbit, half duplex, no link
      eth1: 10 Mbit, half duplex, no link
    
    I can get correct status on fixed kernel.
    
      # mii-tool
      eth0: negotiated 100baseTx-FD, link okZZ
      eth1: negotiated 100baseTx-FD, link ok
    
    Hiroaki Fuse
    
    Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com> for CELF

--- a/drivers/net/ibm_emac/ibm_emac_core.c
+++ b/drivers/net/ibm_emac/ibm_emac_core.c
@@ -1595,7 +1595,7 @@ static struct ethtool_ops emac_ethtool_o
 static int emac_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
 {
 	struct ocp_enet_private *fep = dev->priv;
-	uint *data = (uint *) & rq->ifr_ifru;
+	uint16_t *data = (uint16_t *) & rq->ifr_ifru;
 
 	switch (cmd) {
 	case SIOCGMIIPHY:

diff-tree c4cc26d3310a6614a20e32276228a5d44159fc9b (from 99718699f5746cc365f3a9ab4769568a1da97635)
Author: Jiri Benc <jbenc@suse.cz>
Date:   Wed Apr 27 08:48:56 2005 +0200
    
    [PATCH] Typo in tulip driver
    
    This patch fixes a typo in tulip driver in 2.6.12-rc3.

--- a/drivers/net/tulip/tulip_core.c
+++ b/drivers/net/tulip/tulip_core.c
@@ -1104,7 +1104,7 @@ static void set_rx_mode(struct net_devic
 			if (entry != 0) {
 				/* Avoid a chip errata by prefixing a dummy entry. Don't do
 				   this on the ULI526X as it triggers a different problem */
-				if (!(tp->chip_id == ULI526X && (tp->revision = 0x40 || tp->revision == 0x50))) {
+				if (!(tp->chip_id == ULI526X && (tp->revision == 0x40 || tp->revision == 0x50))) {
 					tp->tx_buffers[entry].skb = NULL;
 					tp->tx_buffers[entry].mapping = 0;
 					tp->tx_ring[entry].length =

diff-tree c8920ba041c8934b29370f5d62ab9ea8f147966b (from c4cc26d3310a6614a20e32276228a5d44159fc9b)
Author: Daniel Andersen <daniel@linux-user.net>
Date:   Thu May 5 15:14:09 2005 -0700
    
    [PATCH] wireless: 3CRWE154G72 Kconfig help fix
    
    Version 2 of the 3com OfficeConnect 11g Cardbus Card aka 3CRWE154G72 is not
    supported by the prism54 project.  To stop confusion, the kernel
    documentation should state so as 3com made a good job hiding the version.
    
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    
    diff -puN drivers/net/wireless/Kconfig~wireless-3crwe154g72-kconfig-help-fix drivers/net/wireless/Kconfig

--- a/drivers/net/wireless/Kconfig
+++ b/drivers/net/wireless/Kconfig
@@ -323,7 +323,7 @@ config PRISM54
 	  For a complete list of supported cards visit <http://prism54.org>.
 	  Here is the latest confirmed list of supported cards:
 
-	  3com OfficeConnect 11g Cardbus Card aka 3CRWE154G72
+	  3com OfficeConnect 11g Cardbus Card aka 3CRWE154G72 (version 1)
 	  Allnet ALL0271 PCI Card
 	  Compex WL54G Cardbus Card
 	  Corega CG-WLCB54GT Cardbus Card

diff-tree f7a3aae1723e7ffc9c4fcdb489365da7a3d81255 (from 88d7bd8cb9eb8d64bf7997600b0d64f7834047c5)
Author: Al Viro <viro@www.linux.org.uk>
Date:   Sun Apr 3 07:15:52 2005 +0100
    
    [PATCH] drivers/net/wireless enabled by wrong option
    
    	NET_WIRELESS is only a subset of the stuff in drivers/net/wireless;
    NET_RADIO is what covers all of them.
    Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>

--- a/drivers/net/Makefile
+++ b/drivers/net/Makefile
@@ -187,7 +187,7 @@ obj-$(CONFIG_TR) += tokenring/
 obj-$(CONFIG_WAN) += wan/
 obj-$(CONFIG_ARCNET) += arcnet/
 obj-$(CONFIG_NET_PCMCIA) += pcmcia/
-obj-$(CONFIG_NET_WIRELESS) += wireless/
+obj-$(CONFIG_NET_RADIO) += wireless/
 obj-$(CONFIG_NET_TULIP) += tulip/
 obj-$(CONFIG_HAMRADIO) += hamradio/
 obj-$(CONFIG_IRDA) += irda/
