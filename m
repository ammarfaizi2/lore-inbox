Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129800AbRBYDjP>; Sat, 24 Feb 2001 22:39:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129801AbRBYDjF>; Sat, 24 Feb 2001 22:39:05 -0500
Received: from f00f.stub.clear.net.nz ([203.167.224.51]:58381 "HELO
	metastasis.f00f.org") by vger.kernel.org with SMTP
	id <S129800AbRBYDix>; Sat, 24 Feb 2001 22:38:53 -0500
Date: Sun, 25 Feb 2001 16:38:36 +1300
From: Chris Wedgwood <cw@f00f.org>
To: Jan Rekorajski <baggins@sith.mimuw.edu.pl>,
        "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org,
        netdev@oss.sgi.com
Subject: Re: [UPDATE] zerocopy BETA 3
Message-ID: <20010225163836.A12173@metastasis.f00f.org>
In-Reply-To: <14998.2628.144784.585248@pizda.ninka.net> <20010223114249.A27608@sith.mimuw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010223114249.A27608@sith.mimuw.edu.pl>; from baggins@sith.mimuw.edu.pl on Fri, Feb 23, 2001 at 11:42:49AM +0100
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 23, 2001 at 11:42:49AM +0100, Jan Rekorajski wrote:
    
    Could you please make a patch with this fix only? Or is it
    available somewhere?

--- linux-2.4.2/include/net/ip.h	Sun Feb 25 01:15:19 2001
+++ linux-2.4.2+zc-2/include/net/ip.h	Sun Feb 25 01:53:52 2001
@@ -188,11 +188,16 @@
 
 extern void __ip_select_ident(struct iphdr *iph, struct dst_entry *dst);
 
-static inline void ip_select_ident(struct iphdr *iph, struct dst_entry *dst)
+static inline void ip_select_ident(struct iphdr *iph, struct dst_entry *dst, struct sock *sk)
 {
-	if (iph->frag_off&__constant_htons(IP_DF))
-		iph->id = 0;
-	else
+	if (iph->frag_off&__constant_htons(IP_DF)) {
+		/* This is only to work around buggy Windows95/2000
+		 * VJ compression implementations.  If the ID field
+		 * does not change, they drop every other packet in
+		 * a TCP stream using header compression.
+		 */
+		iph->id = (sk ? sk->protinfo.af_inet.id++ : 0);
+	} else
 		__ip_select_ident(iph, dst);
 }
 

FWIW; I am still seeing _really_ bad throughput on a 10M ethernet
segment between 2.4.2+zc-2 and Windows98 SE. Nobody else has
complained so I guess it is something local (mii-tool for Windows
wouldn't be a bad idea), but if the above doesn't work for you I'd
been keen to know about it.



  --cw
