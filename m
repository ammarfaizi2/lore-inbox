Return-Path: <linux-kernel-owner+w=401wt.eu-S1755020AbXACJCd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755020AbXACJCd (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 04:02:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755024AbXACJCd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 04:02:33 -0500
Received: from mailfront2.netatonce.net ([217.10.96.66]:35041 "EHLO
	mailfront2.citynet.nu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755004AbXACJCc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 04:02:32 -0500
X-Greylist: delayed 1698 seconds by postgrey-1.27 at vger.kernel.org; Wed, 03 Jan 2007 04:02:31 EST
Date: Wed, 3 Jan 2007 09:34:10 +0100 (CET)
From: Martin Josefsson <gandalf@wlug.westbo.se>
X-X-Sender: gandalf@tux.rsn.bth.se
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: "MalteSch@gmx.de" <MalteSch@gmx.de>, linux-kernel@vger.kernel.org,
       Patrick McHardy <kaber@trash.net>, berni@birkenwald.de,
       netfilter-devel@lists.netfilter.org
Subject: Re: [BUG] panic 2.6.20-rc3 in nf_conntrack
In-Reply-To: <200701020228_MC3-1-D707-115D@compuserve.com>
Message-ID: <Pine.LNX.4.58.0701030913470.8163@tux.rsn.bth.se>
References: <200701020228_MC3-1-D707-115D@compuserve.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Count: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Jan 2007, Chuck Ebbert wrote:

> > [  336.476284] EIP is at device_cmp+0x1b/0x2e [ipt_MASQUERADE]
> > [  336.476344] eax: de6d4000   ebx: 00000000   ecx: d944b7a0   edx: dd664d48
> > [  336.476404] esi: 00000004   edi: 00001f58   ebp: 000003eb   esp: de6d4e90
> > [  336.476464] ds: 007b   es: 007b   ss: 0068
> > [  336.476520] Process pppd (pid: 3846, ti=de6d4000 task=deda4a90 task.ti=de6d4000)
> > [  336.476580] Stack: dd664c7c dd664c84 dfe8990d 00000004 dff16044 00000000 dff16b18 c164b000
> > [  336.477024]        00000002 dff16041 c011c79f c164b000 000010d0 00001091 00000000 c01ea41a
> > [  336.477527]        c164b000 c01e99d5 d98b49e0 00000000 d98b4a0c ddc100c0 c022200b c164b000
> > [  336.478030] Call Trace:
> > [  336.478132]  [<dfe8990d>] nf_ct_iterate_cleanup+0x62/0xda [nf_conntrack]
> > [  336.478259]  [<dff16044>] device_cmp+0x0/0x2e [ipt_MASQUERADE]
> > [  336.478366]  [<dff16041>] masq_device_event+0x12/0x15 [ipt_MASQUERADE]
> > [  336.478468]  [<c011c79f>] notifier_call_chain+0x19/0x29
> > [  336.478576]  [<c01ea41a>] dev_close+0x5c/0x60
>
> AFAICT 'nat' is zero here because bit 2 of i->features is zero:
>
> static inline int
> device_cmp(struct ip_conntrack *i, void *ifindex)
> {
> #ifdef CONFIG_NF_NAT_NEEDED
>         struct nf_conn_nat *nat = nfct_nat(i);
> #endif
>         int ret;
>
>         read_lock_bh(&masq_lock);
> #ifdef CONFIG_NF_NAT_NEEDED
>         ret = (nat->masq_index == (int)(long)ifindex);  <===============
> #else
>         ret = (i->nat.masq_index == (int)(long)ifindex);
> #endif
>         read_unlock_bh(&masq_lock);
>
>         return ret;
> }

I saw your (correct) analysis after having made the patch below, it has
been tested successfully by Bernhard Schmidt. (Netfilter bugzilla #528)

Check the return value of nfct_nat() in device_cmp(), we might very well
have non NAT conntrack entries as well.

Signed-off-by: Martin Josefsson <gandalf@wlug.westbo.se>

--- linux-2.6.20-rc3/net/ipv4/netfilter/ipt_MASQUERADE.c.orig	2007-01-02 22:47:14.000000000 +0100
+++ linux-2.6.20-rc3/net/ipv4/netfilter/ipt_MASQUERADE.c	2007-01-02 22:57:11.000000000 +0100
@@ -127,10 +127,13 @@
 static inline int
 device_cmp(struct ip_conntrack *i, void *ifindex)
 {
+	int ret;
 #ifdef CONFIG_NF_NAT_NEEDED
 	struct nf_conn_nat *nat = nfct_nat(i);
+
+	if (!nat)
+		return 0;
 #endif
-	int ret;

 	read_lock_bh(&masq_lock);
 #ifdef CONFIG_NF_NAT_NEEDED
