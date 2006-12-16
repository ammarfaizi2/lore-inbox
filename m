Return-Path: <linux-kernel-owner+w=401wt.eu-S1753739AbWLPN76@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753739AbWLPN76 (ORCPT <rfc822;w@1wt.eu>);
	Sat, 16 Dec 2006 08:59:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753752AbWLPN76
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Dec 2006 08:59:58 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:49139 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753749AbWLPN75 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Dec 2006 08:59:57 -0500
X-Originating-Ip: 24.148.236.183
Date: Sat, 16 Dec 2006 08:55:00 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Tim Schmielau <tim@physik3.uni-rostock.de>
cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Stefan Richter <stefanr@s5r6.in-berlin.de>,
       Zach Brown <zach.brown@oracle.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: lots of code could be simplified by using ARRAY_SIZE()
In-Reply-To: <Pine.LNX.4.63.0612161359370.21852@gockel.physik3.uni-rostock.de>
Message-ID: <Pine.LNX.4.64.0612160845140.6231@localhost.localdomain>
References: <Pine.LNX.4.64.0612131450270.5979@localhost.localdomain>
 <2F8F687E-C5E5-4F7D-9585-97DA97AE1376@oracle.com>
 <Pine.LNX.4.64.0612141721580.10217@localhost.localdomain>
 <4581DAB0.2060505@s5r6.in-berlin.de> <Pine.LNX.4.61.0612151135330.22867@yvahk01.tjqt.qr>
 <Pine.LNX.4.64.0612151547290.6136@localhost.localdomain>
 <Pine.LNX.4.63.0612152351360.16895@gockel.physik3.uni-rostock.de>
 <Pine.LNX.4.64.0612160651140.3946@localhost.localdomain>
 <Pine.LNX.4.63.0612161359370.21852@gockel.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-14.754, required 5, ALL_TRUSTED -1.80, BAYES_00 -15.00,
	RCVD_IN_SORBS_DUL 2.05)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(i'm not *trying* to belabour this issue ... i am merely succeeding)

On Sat, 16 Dec 2006, Tim Schmielau wrote:

> On Sat, 16 Dec 2006, Robert P. J. Day wrote:
...
> > ... it's amazing the variation that you find beyond the obvious:
> >
> > $ grep -Er "sizeof.*/.*sizeof" . | less
> >
> > ...
> > ./net/key/af_key.c:     sa->sadb_sa_len = sizeof(struct sadb_sa)/sizeof(uint64_t);
> > ./net/xfrm/xfrm_policy.c:       int len = sizeof(struct xfrm_selector) / sizeof(u32);
> > ./net/core/flow.c:      const int n_elem = sizeof(struct flowi) / sizeof(flow_compare_t);
> > ./net/ipv4/netfilter/arp_tables.c:      for (i = 0; i < sizeof(*arp)/sizeof(__u32); i++)
> > ./net/ipv4/af_inet.c:#define INETSW_ARRAY_LEN (sizeof(inetsw_array) / sizeof(struct inet_protosw))
> > ./drivers/net/wireless/ray_cs.c:        .num_standard   = sizeof(ray_handler)/sizeof(iw_handler),
> >
>
> Of the above, af_inet.c and ray_cs.c seem to be good candidates for
> ARRAY_SIZE. You might even remove the INETSW_ARRAY_LEN #define in
> af_inet.c altogether, since ARRAY_SIZE(inetsw_array) is quite
> readable.

note that the above examples i listed were just a *few* of the
examples that didn't match the most common variants:

  sizeof(fubar) / sizeof(fubar[0])
  sizeof(fubar) / sizeof(*fubar)

i just did that to show that, even if i can run a script to handle the
most common variants, there would be lots of manual cleanup left.

> From a first glance, af_key.c is ok but might profit from a comment
> in include/linux/pfkeyv2.h saying that sadb_msg_len is measured in
> 64-bit words per RFC 2367. Though documenting the structs in
> pfkeyv2.h would be quite a bit different from what you initially
> intended...

in fact, i just emailed a short CodingStyle note to randy dunlap
(since he seemed to be heavily into the coding style stuff),
suggesting that a short note be added strongly recommending that one
should use ARRAY_SIZE wherever possible and, if not possible, a
comment should be added explaining why not, if it seems to be useful.

> So, if you have some time to spend on this, manual inspection would
> probably be the most useful thing, since any automatic sed tricks
> will only replace what a human ready would easily understand as
> well.

true enough, but if the most common variants can be handled
automatically, then the remainder would stand out more obviously and
could be manually handled from there.

> If you manually generate cleanup patches, it would be very good to
> check that compilation with allyesconfig generates identical code
> before and after before feeding them through the respective
> maintainers.

i'm actually in the process of trying that as we speak, at least with
the automatic cleanup.  there's no way i'm going to try to get into
manual cleanup with all of those weird variants.  life's too short for
that.  :-)

rday
