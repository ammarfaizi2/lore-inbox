Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283756AbRK3Skl>; Fri, 30 Nov 2001 13:40:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283757AbRK3Skd>; Fri, 30 Nov 2001 13:40:33 -0500
Received: from vti01.vertis.nl ([145.66.4.26]:59153 "EHLO vti01.vertis.nl")
	by vger.kernel.org with ESMTP id <S283756AbRK3SkX>;
	Fri, 30 Nov 2001 13:40:23 -0500
Content-Type: text/plain;
  charset="iso-8859-1"
From: Rolf Fokkens <fokkensr@linux06.vertis.nl>
To: Stephan von Krawczynski <skraw@ithnet.com>
Subject: Re: [PATCH] vanilla 2.4.15 iptables/REDIRECT kernel oops
Date: Fri, 30 Nov 2001 19:33:19 -0800
X-Mailer: KMail [version 1.2]
In-Reply-To: <20011128165224.5f3dcd8e.skraw@ithnet.com> <01112822302000.01349@home01> <20011130151342.0ef3f171.skraw@ithnet.com>
In-Reply-To: <20011130151342.0ef3f171.skraw@ithnet.com>
Cc: davem@redhat.com, rusty@rustcorp.com.au, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <01113019331901.04864@home01>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 30 November 2001 06:13, Stephan von Krawczynski wrote:
> we have a problem: I talked to David Miller (one of the network
> maintainers), and he told me, that sk _must_ be non NULL in this code. He
> states netfilter is broken.
> So our patch won't make it. We have to investigate the cause of sk=NULL.
> Can you describe a possible test-setup?

I think I know what may have caused the problem: I patch from Rusty Russell 
that I forgot about. I use RPM to build kernels, and I forgot to deactivate 
this patch. So it wasn't a vanilla kernel.

    Stuped me!

Sorry about the confusion. I'll forward you the patch, just for your 
information:

Rolf

On Mon, 29 Oct 2001 21:31:57 -0800 (PST)
"David S. Miller" <davem@redhat.com> wrote:

>    From: Rusty Russell <rusty@rustcorp.com.au>
>    Date: Tue, 30 Oct 2001 15:28:12 +1100
>    
>    should the NAT layer be doing skb_unshare() before altering the packet?
> 
> I think it should.


Agreed.  The 2.2 masq code didn't do this, and hence the "don't tcpdump on 
masq host"
recommendation.

Please try this patch (compiles at least),
Rusty.

diff -urN -I \$.*\$ --exclude TAGS -X 
/home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal 
linux-2.4.13-official/net/ipv4/netfilter/ip_fw_compat.c 
working-2.4.13-nfunshare/net/ipv4/netfilter/ip_fw_compat.c
--- linux-2.4.13-official/net/ipv4/netfilter/ip_fw_compat.c      Sat Apr 28 
07:15:01 2001
+++ working-2.4.13-nfunshare/net/ipv4/netfilter/ip_fw_compat.c   Wed Oct 31 
17:05:53 2001
@@ -78,11 +78,19 @@
 {
         int ret = FW_BLOCK;
         u_int16_t redirpt;
+        struct sk_buff *nskb;
 
         /* Assume worse case: any hook could change packet */
         (*pskb)->nfcache |= NFC_UNKNOWN | NFC_ALTERED;
         if ((*pskb)->ip_summed == CHECKSUM_HW)
                 (*pskb)->ip_summed = CHECKSUM_NONE;
+
+        /* Firewall rules can alter TOS: raw socket may have clone of
+           skb: don't disturb it --RR */
+        nskb = skb_unshare(*pskb, GFP_ATOMIC);
+        if (!nskb)
+                return NF_DROP;
+        *pskb = nskb;
 
         switch (hooknum) {
         case NF_IP_PRE_ROUTING:
diff -urN -I \$.*\$ --exclude TAGS -X 
/home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal 
linux-2.4.13-official/net/ipv4/netfilter/ip_nat_core.c 
working-2.4.13-nfunshare/net/ipv4/netfilter/ip_nat_core.c
--- linux-2.4.13-official/net/ipv4/netfilter/ip_nat_core.c       Thu May 17 
03:31:27 2001
+++ working-2.4.13-nfunshare/net/ipv4/netfilter/ip_nat_core.c    Wed Oct 31 
16:52:06 2001
@@ -734,6 +734,15 @@
           synchronize_bh()) can vanish. */
         READ_LOCK(&ip_nat_lock);
         for (i = 0; i < info->num_manips; i++) {
+                struct sk_buff *nskb;
+                /* raw socket may have clone of skb: don't disturb it --RR */
+                nskb = skb_unshare(*pskb, GFP_ATOMIC);
+                if (!nskb) {
+                        READ_UNLOCK(&ip_nat_lock);
+                        return NF_DROP;
+                }
+                *pskb = nskb;
+
                 if (info->manips[i].direction == dir
                    && info->manips[i].hooknum == hooknum) {
                         DEBUGP("Mangling %p: %s to %u.%u.%u.%u %u\n",
diff -urN -I \$.*\$ --exclude TAGS -X 
/home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal 
linux-2.4.13-official/net/ipv4/netfilter/ipt_TCPMSS.c 
working-2.4.13-nfunshare/net/ipv4/netfilter/ipt_TCPMSS.c
--- linux-2.4.13-official/net/ipv4/netfilter/ipt_TCPMSS.c        Mon Oct  1 
05:26:08 2001
+++ working-2.4.13-nfunshare/net/ipv4/netfilter/ipt_TCPMSS.c     Wed Oct 31 
17:00:42 2001
@@ -48,6 +48,13 @@
         u_int16_t tcplen, newtotlen, oldval, newmss;
         unsigned int i;
         u_int8_t *opt;
+        struct sk_buff *nskb;
+
+        /* raw socket may have clone of skb: don't disturb it --RR */
+        nskb = skb_unshare(*pskb, GFP_ATOMIC);
+        if (!nskb)
+                return NF_DROP;
+        *pskb = nskb;
 
         tcplen = (*pskb)->len - iph->ihl*4;
 
diff -urN -I \$.*\$ --exclude TAGS -X 
/home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal 
linux-2.4.13-official/net/ipv4/netfilter/ipt_TOS.c 
working-2.4.13-nfunshare/net/ipv4/netfilter/ipt_TOS.c
--- linux-2.4.13-official/net/ipv4/netfilter/ipt_TOS.c   Mon Oct  1 05:26:08 
2001
+++ working-2.4.13-nfunshare/net/ipv4/netfilter/ipt_TOS.c        Wed Oct 31 
17:03:11 2001
@@ -19,7 +19,14 @@
         const struct ipt_tos_target_info *tosinfo = targinfo;
 
         if ((iph->tos & IPTOS_TOS_MASK) != tosinfo->tos) {
+                struct sk_buff *nskb;
                 u_int16_t diffs[2];
+
+                /* raw socket may have clone of skb: don't disturb it --RR */
+                nskb = skb_unshare(*pskb, GFP_ATOMIC);
+                if (!nskb)
+                        return NF_DROP;
+                *pskb = nskb;
 
                 diffs[0] = htons(iph->tos) ^ 0xFFFF;
                 iph->tos = (iph->tos & IPTOS_PREC_MASK) | tosinfo->tos;
