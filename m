Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268024AbUHXPrk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268024AbUHXPrk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 11:47:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266831AbUHXPrk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 11:47:40 -0400
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:59366 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S268024AbUHXPqs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 11:46:48 -0400
Subject: Re: 2.6.9-rc1: selinux/hooks.c: functions returning unassigned
	variables
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: John Cherry <cherry@osdl.org>, "David S. Miller" <davem@redhat.com>,
       lkml <linux-kernel@vger.kernel.org>, James Morris <jmorris@redhat.com>
In-Reply-To: <20040824153342.GG7019@fs.tum.de>
References: <200408241519.i7OFJS6S027910@cherrypit.pdx.osdl.net>
	 <20040824153342.GG7019@fs.tum.de>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1093362104.1800.156.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 24 Aug 2004 11:41:45 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-08-24 at 11:33, Adrian Bunk wrote:
> On Tue, Aug 24, 2004 at 08:19:28AM -0700, John Cherry wrote:
> >...
> > security/selinux/hooks.c:2825: warning: `ret' might be used uninitialized in this function
> > security/selinux/hooks.c:2886: warning: `ret' might be used uninitialized in this function
> 
> 
> This was
>   [NET]: Add skb_header_pointer, and use it where possible.
> 
> 
> @Dave:
> In both functions ret is returned, but line that assigned a value to ret 
> was removed.

===== security/selinux/hooks.c 1.54 vs edited =====
--- 1.54/security/selinux/hooks.c	2004-08-18 20:14:54 -04:00
+++ edited/security/selinux/hooks.c	2004-08-24 08:43:51 -04:00
@@ -2822,7 +2822,7 @@
 /* Returns error only if unable to parse addresses */
 static int selinux_parse_skb_ipv4(struct sk_buff *skb, struct avc_audit_data *ad)
 {
-	int offset, ihlen, ret;
+	int offset, ihlen, ret = -EINVAL;
 	struct iphdr _iph, *ih;
 
 	offset = skb->nh.raw - skb->data;
@@ -2836,6 +2836,7 @@
 
 	ad->u.net.v4info.saddr = ih->saddr;
 	ad->u.net.v4info.daddr = ih->daddr;
+	ret = 0;
 
 	switch (ih->protocol) {
         case IPPROTO_TCP: {
@@ -2883,7 +2884,7 @@
 static int selinux_parse_skb_ipv6(struct sk_buff *skb, struct avc_audit_data *ad)
 {
 	u8 nexthdr;
-	int ret, offset;
+	int ret = -EINVAL, offset;
 	struct ipv6hdr _ipv6h, *ip6;
 
 	offset = skb->nh.raw - skb->data;
@@ -2893,6 +2894,7 @@
 
 	ipv6_addr_copy(&ad->u.net.v6info.saddr, &ip6->saddr);
 	ipv6_addr_copy(&ad->u.net.v6info.daddr, &ip6->daddr);
+	ret = 0;
 
 	nexthdr = ip6->nexthdr;
 	offset += sizeof(_ipv6h);

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

