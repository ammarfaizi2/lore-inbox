Return-Path: <linux-kernel-owner+w=401wt.eu-S1753691AbWLPNa3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753691AbWLPNa3 (ORCPT <rfc822;w@1wt.eu>);
	Sat, 16 Dec 2006 08:30:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753690AbWLPNa3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Dec 2006 08:30:29 -0500
Received: from [139.30.44.16] ([139.30.44.16]:18739 "EHLO
	gockel.physik3.uni-rostock.de" rhost-flags-FAIL-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1751967AbWLPNa2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Dec 2006 08:30:28 -0500
Date: Sat, 16 Dec 2006 14:30:26 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: "Robert P. J. Day" <rpjday@mindspring.com>
cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Stefan Richter <stefanr@s5r6.in-berlin.de>,
       Zach Brown <zach.brown@oracle.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: lots of code could be simplified by using ARRAY_SIZE()
In-Reply-To: <Pine.LNX.4.64.0612160651140.3946@localhost.localdomain>
Message-ID: <Pine.LNX.4.63.0612161359370.21852@gockel.physik3.uni-rostock.de>
References: <Pine.LNX.4.64.0612131450270.5979@localhost.localdomain>
 <2F8F687E-C5E5-4F7D-9585-97DA97AE1376@oracle.com>
 <Pine.LNX.4.64.0612141721580.10217@localhost.localdomain>
 <4581DAB0.2060505@s5r6.in-berlin.de> <Pine.LNX.4.61.0612151135330.22867@yvahk01.tjqt.qr>
 <Pine.LNX.4.64.0612151547290.6136@localhost.localdomain>
 <Pine.LNX.4.63.0612152351360.16895@gockel.physik3.uni-rostock.de>
 <Pine.LNX.4.64.0612160651140.3946@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Dec 2006, Robert P. J. Day wrote:
> On Fri, 15 Dec 2006, Tim Schmielau wrote:
> >
> > It might be interesting to grep for anything that divides two
> > sizeofs and eyeball the result for possible mistakes. This would
> > provide some real benefit beyond the cosmetical changes.
> 
> i did that a while ago and it's amazing the variation that you find
> beyond the obvious:
> 
> $ grep -Er "sizeof.*/.*sizeof" . | less
> 
> ...
> ./net/key/af_key.c:     sa->sadb_sa_len = sizeof(struct sadb_sa)/sizeof(uint64_t);
> ./net/xfrm/xfrm_policy.c:       int len = sizeof(struct xfrm_selector) / sizeof(u32);
> ./net/core/flow.c:      const int n_elem = sizeof(struct flowi) / sizeof(flow_compare_t);
> ./net/ipv4/netfilter/arp_tables.c:      for (i = 0; i < sizeof(*arp)/sizeof(__u32); i++)
> ./net/ipv4/af_inet.c:#define INETSW_ARRAY_LEN (sizeof(inetsw_array) / sizeof(struct inet_protosw))
> ./drivers/net/wireless/ray_cs.c:        .num_standard   = sizeof(ray_handler)/sizeof(iw_handler),
> 

Of the above, af_inet.c and ray_cs.c seem to be good candidates for 
ARRAY_SIZE. You might even remove the INETSW_ARRAY_LEN #define in 
af_inet.c altogether, since ARRAY_SIZE(inetsw_array) is quite readable.

xfrm_policy.c, flow.c and arp_tables.c seem to be reasonably readable 
trickery that can be left as-is.

>From a first glance, af_key.c is ok but might profit from a comment 
in include/linux/pfkeyv2.h saying that sadb_msg_len is measured in 64-bit 
words per RFC 2367. Though documenting the structs in pfkeyv2.h would be
quite a bit different from what you initially intended...

So, if you have some time to spend on this, manual inspection would 
probably be the most useful thing, since any automatic sed tricks will 
only replace what a human ready would easily understand as well.

If you manually generate cleanup patches, it would be very good to check 
that compilation with allyesconfig generates identical code before and 
after before feeding them through the respective maintainers.

If you want to find genuine bugs by this, it might be more worthwhile to 
start with drivers/, as davem is just too clever to make any mistakes. 

Not that I want to make you spend you time on this. It's just beause you 
asked.

Tim
