Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281146AbRKKWvE>; Sun, 11 Nov 2001 17:51:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281139AbRKKWuy>; Sun, 11 Nov 2001 17:50:54 -0500
Received: from oyster.morinfr.org ([62.4.22.234]:6273 "EHLO oyster.morinfr.org")
	by vger.kernel.org with ESMTP id <S281146AbRKKWur>;
	Sun, 11 Nov 2001 17:50:47 -0500
Date: Sun, 11 Nov 2001 23:50:40 +0100
From: Guillaume Morin <guillaume@morinfr.org>
To: Nicolas Mailhot <Nicolas.Mailhot@LaPoste.net>
Cc: linux-kernel@vger.kernel.org, netfilter@lists.samba.org,
        alan@lxorguk.ukuu.org.uk
Subject: Re: Iptables & ECN
Message-ID: <20011111235040.A2672@morinfr.org>
Mail-Followup-To: Nicolas Mailhot <Nicolas.Mailhot@LaPoste.net>,
	linux-kernel@vger.kernel.org, netfilter@lists.samba.org,
	alan@lxorguk.ukuu.org.uk
In-Reply-To: <1005518494.5895.0.camel@rousalka.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1005518494.5895.0.camel@rousalka.dyndns.org>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dans un message du 11 nov à 23:41, Nicolas Mailhot écrivait :
> 	I'm afraid I've just run in an embarassing iptables « bug » on
> 2.4.13-ac7. When I tell iptables to drop unclean packets with ecn on I
> can no longuer connect to ftp.kernel.org, and get a lot of ipt_unclean:
> TCP reserved bits not zero in the logs. Shouldn't iptables be made
> ecn-aware ?

It is a known bug. Upgrade to 2.4.14+ and apply this patch will fix
fix the problem (and another ipt_unclean glitch)

diff -uNr linux-2.4.14-pre8/net/ipv4/netfilter/ipt_unclean.c linux-tcprb-fixed/net/ipv4/netfilter/ipt_unclean.c
--- linux-2.4.14-pre8/net/ipv4/netfilter/ipt_unclean.c	Wed Oct 31 14:38:23 2001
+++ linux-tcprb-fixed/net/ipv4/netfilter/ipt_unclean.c	Sun Nov  4 08:30:58 2001
@@ -257,6 +257,8 @@
 #define	TH_PUSH	0x08
 #define	TH_ACK	0x10
 #define	TH_URG	0x20
+#define	TH_ECE	0x40
+#define	TH_CWR	0x80
 
 /* TCP-specific checks. */
 static int
@@ -328,9 +330,10 @@
 	}
 
 	/* CHECK: TCP flags. */
-	tcpflags = ((u_int8_t *)tcph)[13];
+	tcpflags = (((u_int8_t *)tcph)[13] & ~(TH_ECE|TH_CWR));
 	if (tcpflags != TH_SYN
 	    && tcpflags != (TH_SYN|TH_ACK)
+		&& tcpflags != TH_RST
 	    && tcpflags != (TH_RST|TH_ACK)
 	    && tcpflags != (TH_RST|TH_ACK|TH_PUSH)
 	    && tcpflags != (TH_FIN|TH_ACK)


I hope the netfilter core team will merge it soon.

Regards,

-- 
Guillaume Morin <guillaume@morinfr.org>

                    Sometimes I find I need to scream (RHCP)
