Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261586AbVB1NUm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261586AbVB1NUm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 08:20:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261587AbVB1NUm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 08:20:42 -0500
Received: from eth0-0.arisu.projectdream.org ([194.158.4.191]:61128 "EHLO
	b.mx.projectdream.org") by vger.kernel.org with ESMTP
	id S261586AbVB1NUf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 08:20:35 -0500
Date: Mon, 28 Feb 2005 14:20:51 +0100
From: Thomas Graf <tgraf@suug.ch>
To: jamal <hadi@cyberus.ca>
Cc: Andrew Morton <akpm@osdl.org>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>,
       kaigai@ak.jp.nec.com, marcelo.tosatti@cyclades.com,
       "David S. Miller" <davem@redhat.com>, jlan@sgi.com,
       lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, elsa-devel@lists.sourceforge.net
Subject: Re: [Lse-tech] Re: A common layer for Accounting packages
Message-ID: <20050228132051.GO31837@postel.suug.ch>
References: <421CEC38.7010008@sgi.com> <421EB299.4010906@ak.jp.nec.com> <20050224212839.7953167c.akpm@osdl.org> <20050227094949.GA22439@logos.cnet> <4221E548.4000008@ak.jp.nec.com> <20050227140355.GA23055@logos.cnet> <42227AEA.6050002@ak.jp.nec.com> <1109575236.8549.14.camel@frecb000711.frec.bull.fr> <20050227233943.6cb89226.akpm@osdl.org> <1109592658.2188.924.camel@jzny.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1109592658.2188.924.camel@jzny.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Havent seen the beginnings of this thread. But whatever you are trying
> to do seems to suggest some complexity that you are trying to
> workaround. What was wrong with just going ahead and just always
> invoking your netlink_send()?

I guess parts of the wheel are broken and need to be reinvented ;->

> If there are nobody in user space (or kernel) listening, it wont go anywhere.

Additional you may want to extend netlink a bit to check whether
there is a listener before creating the messages. The method to do so
depends on whether you use netlink_send() or netlink_brodacast(). The
latter is more flexiable because you can add more groups later on
and the userspace applications can decicde which ones they want to
listen to. Both methods handle dying clients perfectly fine, the
association to the netlink socket gets destroyed as soon as the socket
is closed. Therefore you can simply check mc_list of the netlink
protocol you use to see if there are any listeners registered:

static inline int netlink_has_listeners(struct sock *sk)
{
	int ret;

	read_lock(&nl_table_lock);
	ret = list_empty(&nl_table[sk->sk_protocol].mc_list)
	read_unlock(&nl_table_lock);

	return !ret;
}

This is simplified and ignores the actual group assignments, i.e. you
might want to extend it to have it check if there are listeners for
a certain group.
