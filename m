Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262750AbVA1U4Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262750AbVA1U4Q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 15:56:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262709AbVA1U4O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 15:56:14 -0500
Received: from canuck.infradead.org ([205.233.218.70]:44048 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S262760AbVA1Ury (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 15:47:54 -0500
Subject: Re: [PATCH] OpenBSD Networking-related randomization port
From: Arjan van de Ven <arjan@infradead.org>
To: Lorenzo =?ISO-8859-1?Q?Hern=E1ndez_?=
	 =?ISO-8859-1?Q?Garc=EDa-Hierro?= <lorenzo@gnu.org>
Cc: Stephen Hemminger <shemminger@osdl.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Chris Wright <chrisw@osdl.org>, netdev@oss.sgi.com,
       Hank Leininger <hlein@progressive-comp.com>
In-Reply-To: <1106944492.3864.30.camel@localhost.localdomain>
References: <1106932637.3778.92.camel@localhost.localdomain>
	 <20050128100229.5c0e4ea1@dxpl.pdx.osdl.net>
	 <1106937110.3864.5.camel@localhost.localdomain>
	 <20050128105217.1dc5ef42@dxpl.pdx.osdl.net>
	 <1106944492.3864.30.camel@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Date: Fri, 28 Jan 2005 21:47:45 +0100
Message-Id: <1106945266.7776.41.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 8bit
X-Spam-Score: 4.1 (++++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
	Content analysis details:   (4.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.3 RCVD_NUMERIC_HELO      Received: contains a numeric HELO
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-01-28 at 21:34 +0100, Lorenzo Hernández García-Hierro
wrote:
> Hi,
> 
> Attached the new patch following Arjan's recommendations.
> I'm sorry about not making it "inlined", but my mail agent messes up the
> diffs if I do so.
> Still waiting for the OSDL STP tests results, they will take a while to
> finish.
> 
> Cheers,

lots better already! Some more comments (now that the patch got a lot
easier to read :)

 static inline __u32 tcp_v4_init_sequence(struct sock *sk, struct
sk_buff *skb)
 {
-       return secure_tcp_sequence_number(skb->nh.iph->daddr,
-                                         skb->nh.iph->saddr,
-                                         skb->h.th->dest,
-                                         skb->h.th->source);
+
+               return ip_randomisn();
 }

is there a reason for the weird indentation?

+       if (!tp->write_seq) {
+                       tp->write_seq = ip_randomisn();
+       }

spare { } pare that's not needed, also looks like one tab too many


as for obsd_get_random_long().. would it be possible to use the
get_random_int() function from the patches I posted the other day? They
use the existing random.c infrastructure instead of making a copy...

I still don't understand why you need a obsd_rand.c and can't use the
normal random.c


  
 static inline u32 xprt_alloc_xid(struct rpc_xprt *xprt)
 {
-       return xprt->xid++;
+       /* Return randomized xprt->xid instead of prt->xid++ */
+       return (u32) obsd_get_random_long();
+
 }
 

that cast looks quite redundant...





