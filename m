Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932087AbWH0MuW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932087AbWH0MuW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 08:50:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932101AbWH0MuW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 08:50:22 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:45266 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932087AbWH0MuV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 08:50:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=sdNppIuhShNWu+oL5tHtTiZRlQlIRmq2HWQAEw+0J0o6ZFtHRWqH0Rv++9dpwlzwbhGBB3//pEPN7F+Y8KvxG1w8444cYccGj80dUr82HTe8++diLunHTC4QIyYHIQH5CL7m0dNBIOyUwSlO9gIveCU8MrNvBLO3m3vG9bZCyv8=
Message-ID: <40f323d00608270550y2b4706a8i95990344f0eccad1@mail.gmail.com>
Date: Sun, 27 Aug 2006 14:50:20 +0200
From: "Benoit Boissinot" <benoit.boissinot@ens-lyon.fr>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: 2.6.18-rc4-mm3
Cc: linux-kernel@vger.kernel.org, "Pablo Neira Ayuso" <pablo@netfilter.org>,
       "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060826160922.3324a707.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060826160922.3324a707.akpm@osdl.org>
X-Google-Sender-Auth: d4724635b01d457a
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/27/06, Andrew Morton <akpm@osdl.org> wrote:
>
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc4/2.6.18-rc4-mm3/
>
> Changes since 2.6.18-rc4-mm2:
>
>  git-net.patch

It introduces a new warning for me:
net/netfilter/xt_CONNMARK.c: In function 'target':
net/netfilter/xt_CONNMARK.c:59: warning: implicit declaration of
function 'nf_conntrack_event_cache'

The warning is due to the following .config:
CONFIG_IP_NF_CONNTRACK=m
CONFIG_IP_NF_CONNTRACK_MARK=y
# CONFIG_IP_NF_CONNTRACK_EVENTS is not set
CONFIG_IP_NF_CONNTRACK_NETLINK=m

This change was introduced by:
http://www.kernel.org/git/?p=linux/kernel/git/davem/net-2.6.19.git;a=commit;h=76e4b41009b8a2e9dd246135cf43c7fe39553aa5

Proposed solution (based on the define in
include/net/netfilter/nf_conntrack_compat.h:

Signed-off-by: Benoit Boissinot <benoit.boissinot@ens-lyon.org>

Index: linux/net/netfilter/xt_CONNMARK.c
===================================================================
--- linux.orig/net/netfilter/xt_CONNMARK.c
+++ linux/net/netfilter/xt_CONNMARK.c
@@ -53,7 +53,7 @@ target(struct sk_buff **pskb,
 			newmark = (*ctmark & ~markinfo->mask) | markinfo->mark;
 			if (newmark != *ctmark) {
 				*ctmark = newmark;
-#ifdef CONFIG_IP_NF_CONNTRACK_EVENTS
+#if defined(CONFIG_IP_NF_CONNTRACK) || defined(CONFIG_IP_NF_CONNTRACK_MODULE)
 				ip_conntrack_event_cache(IPCT_MARK, *pskb);
 #else
 				nf_conntrack_event_cache(IPCT_MARK, *pskb);
@@ -65,7 +65,7 @@ target(struct sk_buff **pskb,
 				  ((*pskb)->nfmark & markinfo->mask);
 			if (*ctmark != newmark) {
 				*ctmark = newmark;
-#ifdef CONFIG_IP_NF_CONNTRACK_EVENTS
+#if defined(CONFIG_IP_NF_CONNTRACK) || defined(CONFIG_IP_NF_CONNTRACK_MODULE)
 				ip_conntrack_event_cache(IPCT_MARK, *pskb);
 #else
 				nf_conntrack_event_cache(IPCT_MARK, *pskb);
