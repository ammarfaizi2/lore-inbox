Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261913AbVCANyi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261913AbVCANyi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 08:54:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261909AbVCANyh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 08:54:37 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:31962 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S261916AbVCANx7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 08:53:59 -0500
Subject: Re: [Lse-tech] Re: A common layer for Accounting packages
From: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
To: Kaigai Kohei <kaigai@ak.jp.nec.com>
Cc: Evgeniy Polyakov <johnpol@2ka.mipt.ru>, hadi@cyberus.ca,
       Thomas Graf <tgraf@suug.ch>, Andrew Morton <akpm@osdl.org>,
       marcelo.tosatti@cyclades.com, "David S. Miller" <davem@redhat.com>,
       jlan@sgi.com, LSE-Tech <lse-tech@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>, netdev@oss.sgi.com,
       elsa-devel <elsa-devel@lists.sourceforge.net>
In-Reply-To: <42247051.7070303@ak.jp.nec.com>
References: <4221E548.4000008@ak.jp.nec.com>
	 <20050227140355.GA23055@logos.cnet> <42227AEA.6050002@ak.jp.nec.com>
	 <1109575236.8549.14.camel@frecb000711.frec.bull.fr>
	 <20050227233943.6cb89226.akpm@osdl.org>
	 <1109592658.2188.924.camel@jzny.localdomain>
	 <20050228132051.GO31837@postel.suug.ch>
	 <1109598010.2188.994.camel@jzny.localdomain>
	 <20050228135307.GP31837@postel.suug.ch>
	 <1109599803.2188.1014.camel@jzny.localdomain>
	 <20050228142551.GQ31837@postel.suug.ch>
	 <1109604693.1072.8.camel@jzny.localdomain>
	 <20050228191759.6f7b656e@zanzibar.2ka.mipt.ru>
	 <1109665299.8594.55.camel@frecb000711.frec.bull.fr>
	 <42247051.7070303@ak.jp.nec.com>
Date: Tue, 01 Mar 2005 14:53:56 +0100
Message-Id: <1109685236.8594.75.camel@frecb000711.frec.bull.fr>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 01/03/2005 15:02:56,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 01/03/2005 15:02:59,
	Serialize complete at 01/03/2005 15:02:59
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-03-01 at 22:38 +0900, Kaigai Kohei wrote:
> > I tested without user space listeners and the cost is negligible. I will
> > test with a user space listeners and see the results. I'm going to run
> > the test this week after improving the mechanism that switch on/off the
> > sending of the message.
> 
> I'm also trying to mesure the process-creation/destruction performance on following three environment.
> Archtechture: i686 / Distribution: Fedora Core 3
> * Kernel Preemption is DISABLE
> * SMP kernel but UP-machine / Not Hyper Threading
> [1] 2.6.11-rc4-mm1 normal
> [2] 2.6.11-rc4-mm1 with PAGG based Process Accounting Module
> [3] 2.6.11-rc4-mm1 with fork-connector notification (it's enabled)
> 
> When 367th-fork() was called after fork-connector notification, kernel was locked up.
> (User-Space-Listener has been also run until 366th-fork() notification was received)

I don't see this limit on my computer. I'm currently running the lmbench
with a new fork connector patch (one that enable/disable fork connector)
on an SMP computer. I will send results and the new patch tomorrow
because the test takes a while...

I'm using a small patch provided by Evgeniy and not included in the
2.6.11-rc4-mm1 tree.

Best regards,
Guillaume

--- orig/connector.c
+++ mod/connector.c
@@ -168,12 +168,11 @@
        group = NETLINK_CB((skb)).groups;
        msg = (struct cn_msg *)NLMSG_DATA(nlh);

-       if (msg->len != nlh->nlmsg_len - sizeof(*msg) - sizeof(*nlh)) {
+       if (NLMSG_SPACE(msg->len + sizeof(*msg)) != nlh->nlmsg_len) {
                printk(KERN_ERR "skb does not have enough length: "
-                               "requested msg->len=%u[%u], nlh->nlmsg_len=%u[%u], skb->len=%u[must be %u].\n",
-                               msg->len, NLMSG_SPACE(msg->len),
-                               nlh->nlmsg_len, nlh->nlmsg_len - sizeof(*nlh),
-                               skb->len, msg->len + sizeof(*msg));
+                               "requested msg->len=%u[%u], nlh->nlmsg_len=%u, skb->len=%u.\n",
+                               msg->len, NLMSG_SPACE(msg->len + sizeof(*msg)),
+                               nlh->nlmsg_len, skb->len);
                kfree_skb(skb);
                return -EINVAL;
        }


