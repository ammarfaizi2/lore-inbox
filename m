Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932150AbWIIF0S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932150AbWIIF0S (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 01:26:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932154AbWIIF0S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 01:26:18 -0400
Received: from smtp.osdl.org ([65.172.181.4]:57799 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932150AbWIIF0P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 01:26:15 -0400
Date: Fri, 8 Sep 2006 22:26:09 -0700
From: Andrew Morton <akpm@osdl.org>
To: Nick Orlov <bugfixer@list.ru>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-netdev <linux-netdev@vger.kernel.org>,
       "David S. Miller" <davem@davemloft.net>
Subject: Re: netdevice name corruption is still present in 2.6.18-rc6-mm1
Message-Id: <20060908222609.20745379.akpm@osdl.org>
In-Reply-To: <20060909032939.GA3087@nickolas.homeunix.com>
References: <20060909032939.GA3087@nickolas.homeunix.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 08 Sep 2006 23:29:39 -0400
Nick Orlov <bugfixer@list.ru> wrote:

> Andrew,
> 
> I would like to confirm that issue with netdevice name corruption
> is still present in 2.6.18-rc6-mm1 and extremely easy to reproduce
> (at least on my system) with 100% hit rate.
> 
> All I have to do is 'sudo /etc/init.d/networking stop'. And here we go:
> 
> Sep  8 22:50:11 nickolas kernel: [events/1:7]: Changing netdevice name from [ath0] to [\200^C^Bб\206]
> 
> Does not look like an userspace issue at all...
> 
> Last kernel which is known to be working (for me) is 2.6.18-rc1-mm2.
> Sorry, I now that a lot of things had changed since then,
> but I was somewhat busy last couple of months...
> 
> Please let me know if I can help somehow to debug it.
> 
> Thank you,
> 	Nick Orlov.
> 
> P.S. I admit that I'm using "binary only atheros driver" which makes
> this report a lot less legit. But seems like people experiencing the
> very same issue w/o any closed-source drivers loaded...
> 
> P.P.S I don't even have NetworkManager executable on my system
> (Debian unstable updated on daily basis), so NetworkManager have
> nothing to do with it.
> 

No idea what's happened here then.  That was with Dave's patch applied:

From: David Miller <davem@davemloft.net>

A debugging patch like this one should help figure out the culprit.

If we don't see the gibberish netdevice name printed in the kernel
logs, then likely something is corrupting the netdevice structure or
the memory holding the name.


Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 net/core/dev.c |    5 +++++
 1 file changed, 5 insertions(+)

diff -puN net/core/dev.c~dev_change_name-debug net/core/dev.c
--- a/net/core/dev.c~dev_change_name-debug
+++ a/net/core/dev.c
@@ -738,6 +738,11 @@ int dev_change_name(struct net_device *d
 
 	if (!dev_valid_name(newname))
 		return -EINVAL;
+#if 1
+	printk("[%s:%d]: Changing netdevice name from [%s] to [%s]\n",
+	       current->comm, current->pid,
+	       dev->name, newname);
+#endif
 
 	if (strchr(newname, '%')) {
 		err = dev_alloc_name(dev, newname);
_

