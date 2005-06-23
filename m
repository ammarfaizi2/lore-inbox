Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262707AbVFWVIR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262707AbVFWVIR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 17:08:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262662AbVFWVIR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 17:08:17 -0400
Received: from warden2-p.diginsite.com ([209.195.52.120]:55259 "HELO
	warden2.diginsite.com") by vger.kernel.org with SMTP
	id S262710AbVFWVFd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 17:05:33 -0400
From: David Lang <david.lang@digitalinsight.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Netdev List <netdev@vger.kernel.org>
X-X-Sender: dlang@dlang.diginsite.com
Date: Thu, 23 Jun 2005 14:04:57 -0700 (PDT)
X-X-Sender: dlang@dlang.diginsite.com
Subject: Re: [git patch] urgent e1000 fix
In-Reply-To: <42BA7FB5.5020804@pobox.com>
Message-ID: <Pine.LNX.4.62.0506231402340.18154@qynat.qvtvafvgr.pbz>
References: <42BA7FB5.5020804@pobox.com>
MIME-Version: 1.0
Content-Type: MULTIPART/Mixed; boundary=------------010705020707050403070901
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--------------010705020707050403070901
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed

hmm, I know I'm not that experianced with patch, but when I saved this to 
a file and did patch -p1 <file the hunk was rejected, the reject file is 
saying

***************
*** 2307,2312 ****
          tso = e1000_tso(adapter, skb);
          if (tso < 0) {
                  dev_kfree_skb_any(skb);
                  return NETDEV_TX_OK;
          }

--- 2307,2313 ----
          tso = e1000_tso(adapter, skb);
          if (tso < 0) {
                  dev_kfree_skb_any(skb);
+                spin_unlock_irqrestore(&adapter->tx_lock, flags);
                  return NETDEV_TX_OK;
          }

I manually put the line in and am compiling it now to test it, but is 
someone could take a few seconds and teach me what I did wrong it would be 
appriciated.

David Lang

  On Thu, 23 Jun 2005, Jeff Garzik wrote:

> Date: Thu, 23 Jun 2005 05:24:05 -0400
> From: Jeff Garzik <jgarzik@pobox.com>
> To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
> Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
>     Netdev List <netdev@vger.kernel.org>
> Subject: [git patch] urgent e1000 fix
> 
> Please pull from 'misc-fixes' branch of
> rsync://rsync.kernel.org/pub/scm/linux/kernel/git/jgarzik/netdev-2.6.git
>
> to obtain the spinlock fix described in the attached text.
>
>
>

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare


--------------010705020707050403070901
Content-Type: TEXT/PLAIN; name=netdev-2.6.txt
Content-Description: 
Content-Disposition: inline; filename=netdev-2.6.txt


 drivers/net/e1000/e1000_main.c |    1 +
 1 files changed, 1 insertion(+)


Mitch Williams:
  e1000: fix spinlock bug


diff --git a/drivers/net/e1000/e1000_main.c b/drivers/net/e1000/e1000_main.c
--- a/drivers/net/e1000/e1000_main.c
+++ b/drivers/net/e1000/e1000_main.c
@@ -2307,6 +2307,7 @@ e1000_xmit_frame(struct sk_buff *skb, st
 	tso = e1000_tso(adapter, skb);
 	if (tso < 0) {
 		dev_kfree_skb_any(skb);
+		spin_unlock_irqrestore(&adapter->tx_lock, flags);
 		return NETDEV_TX_OK;
 	}
 

--------------010705020707050403070901--
