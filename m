Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965142AbVHZRiA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965142AbVHZRiA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 13:38:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965144AbVHZRiA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 13:38:00 -0400
Received: from [62.206.217.67] ([62.206.217.67]:16607 "EHLO kaber.coreworks.de")
	by vger.kernel.org with ESMTP id S965142AbVHZRh7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 13:37:59 -0400
Message-ID: <430F5376.7060709@trash.net>
Date: Fri, 26 Aug 2005 19:37:58 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.10) Gecko/20050803 Debian/1.7.10-1
X-Accept-Language: en
MIME-Version: 1.0
To: Lukasz Spaleniak <lspaleniak@wroc.zigzag.pl>
CC: linux-kernel@vger.kernel.org, kadlec@netfilter.org, gandalf@netfilter.org
Subject: Re: Conntrack problem, machines freeze
References: <20050825222002.3538af7d.lspaleniak@wroc.zigzag.pl>
In-Reply-To: <20050825222002.3538af7d.lspaleniak@wroc.zigzag.pl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lukasz Spaleniak wrote:
> Hello,
> 
> I have simple linux router with three fastethernet cards (intel , e100
> driver). About two months ago it started hanging. It's completly
> freezing machine (no ooops. First of all when it's booting few
> messages like this appears on screen:
> 
> NF_IP_ASSERT: ip_conntrack_core.c:1128(ip_conntrack_alter_reply)

This one can happen if the NAT module is loaded after ip_conntrack and
there are already existing conntrack entries, but it should be harmless.

> I suppose it's showing before firewall script load rules (simple nat).
> After that somtimes it's working very long, sometimes it's freezing
> after few seconds. One time I've logged this message before it freezes:
> 
> kernel: LIST_DELETE: ip_conntrack_core.c:302 `&ct->tuplehash
> [IP_CT_DIR_REPLY]'(decb6084) not in &ip_conntrack_hash[hr].

This one probably results from the above, when the conntrack is altered
it may end up in a different hash bucket, LIST_DELETE complains if it
doesn't find it on the list where it is to be removed from. Hmm .. so
the above is probably not harmless after all, when freeing the conntrack
we don't remove it from the list if netfilter debugging is enabled.

Does disabling CONFIG_NETFILTER_DEBUG make any difference?
