Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262959AbUCKCea (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 21:34:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262960AbUCKCea
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 21:34:30 -0500
Received: from dsl017-049-110.sfo4.dsl.speakeasy.net ([69.17.49.110]:5248 "EHLO
	jm.kir.nu") by vger.kernel.org with ESMTP id S262959AbUCKCe2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 21:34:28 -0500
Date: Wed, 10 Mar 2004 18:31:41 -0800
From: Jouni Malinen <jkmaline@cc.hut.fi>
To: James Ketrenos <jketreno@linux.co.intel.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, jt@hpl.hp.com,
       Christoph Hellwig <hch@infradead.org>,
       "David S. Miller" <davem@redhat.com>, netdev@oss.sgi.com,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6] Intersil Prism54 wireless driver
Message-ID: <20040311023141.GB3738@jm.kir.nu>
References: <20040304023524.GA19453@bougret.hpl.hp.com> <20040310165548.A24693@infradead.org> <20040310172114.GA8867@bougret.hpl.hp.com> <404F5097.4040406@pobox.com> <20040310175200.GA9531@bougret.hpl.hp.com> <404F5744.1040201@pobox.com> <404FA6AC.7040009@linux.co.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <404FA6AC.7040009@linux.co.intel.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2004 at 05:37:16PM -0600, James Ketrenos wrote:

> I'd like to get WEP into IPW2100 as soon as possible, and would like to do 
> so in a way that would make transitioning to a common 802.11 layer seamless 
> (or at least reasonably isolated).  Any suggestions on how to best do this, 
> or where we might be able to help, would be much appreciated.

Host AP driver (http://hostap.epitest.fi/) has generic (i.e., hardware
independent) implementation of IEEE 802.11 encryption for WEP, TKIP, and
CCMP. These functions take in skb's with IEEE 802.11 headers and
encrypt/decrypt the frames. I haven't yet taken a look at your IPW2100
driver, but if you are including IEEE 802.11 headers in the skb's at
some point, I would assume that the WEP implementation from Host AP
driver would work fine with that driver, too.

The current implementation has hardware independent module (hostap.ko)
that exports the crypto functions for IEEE 802.11 skb's. Both client
station and AP is supported. (To be honest, there is probably still
couple of small Prism2-specific parts in hostap.ko, but not in the
crypto parts and I'm in the process of getting rid of the remaining
wlan hardware dependent parts).

I'm in the process of replacing the algorithm parts (RC4, Michael MIC,
AES-CCM) with crypto API versions so that only the IEEE 802.11 specific
parts (like format of the IV/packet number, replay protection,
pseudo-header for authentication) remain in the implementation and
low-level crypto algorithms can share code with other uses. Once this is
done, I would hope to get the code merged into the kernel tree either
with full Host AP driver or separately. One option would be to first add
Host AP driver in its current structure (i.e., everything in
drivers/net/wireless) and then create a new directory (net/ieee80211 ?)
for generic IEEE 802.11 functionality and start moving things like the
IEEE 802.11 encryption into the new location.

-- 
Jouni Malinen                                            PGP id EFC895FA
