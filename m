Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261569AbTKHAdh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Nov 2003 19:33:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261555AbTKGWFN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Nov 2003 17:05:13 -0500
Received: from h80ad25c7.async.vt.edu ([128.173.37.199]:50048 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S263907AbTKGGsw (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Fri, 7 Nov 2003 01:48:52 -0500
Message-Id: <200311070648.hA76mRe8007990@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: linux-kernel@vger.kernel.org, netfilter@lists.netfilter.org
Subject: kernel: ipt_hook: happy cracking.
From: Valdis.Kletnieks@vt.edu
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1686567374P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 07 Nov 2003 01:48:27 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1686567374P
Content-Type: text/plain; charset=us-ascii

So I look in my syslogs, and I find a lot of:

Nov  6 14:36:37 turing-police kernel: ipt_hook: happy cracking.

messages. A quick grep finds it's ipv4/netfilter/iptable_filter.c:

        /* root is playing with raw sockets. */
        if ((*pskb)->len < sizeof(struct iphdr)
            || (*pskb)->nh.iph->ihl * 4 < sizeof(struct iphdr)) {
                if (net_ratelimit())
                        printk("ipt_hook: happy cracking.\n");
                return NF_ACCEPT;
        }

The only problem is that root wasn't doing any playing at the time. The real
culprit was an iptables filter with '-j REJECT'. (Yes, usually a '-j DROP' is
my preference, but I get SYN packets from some places on our net where sending
an RST is more polite than waiting for retransmits).

I admit not being positively clear on how this manages to trigger, as
I'm not sure who's supposed to set the ->len field on the new pskb
allocated by ipt_REJECT.c:send_reset() (AFAICT, ->ihl should be OK
after skb_copy_bits() gets called).

Hardly 'cracking' - but after yesterday's CVS scare, I had to double
check this code was in 2.4.18 too before my pulse came down.. :)



--==_Exmh_-1686567374P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/q0A7cC3lWbTT17ARArLXAJ97FvI9hFFBYcl7DevQhy1tTuQCjACdEW0N
t3Hpgyn1Ga9kQh8NQC86f+w=
=7bAP
-----END PGP SIGNATURE-----

--==_Exmh_-1686567374P--
