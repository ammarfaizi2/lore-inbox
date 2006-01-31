Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751403AbWAaT3g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751403AbWAaT3g (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 14:29:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751406AbWAaT3g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 14:29:36 -0500
Received: from mtiwmhc12.worldnet.att.net ([204.127.131.116]:27864 "EHLO
	mtiwmhc12.worldnet.att.net") by vger.kernel.org with ESMTP
	id S1751403AbWAaT3f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 14:29:35 -0500
Message-ID: <43DFBA93.3090103@lwfinger.net>
Date: Tue, 31 Jan 2006 13:29:23 -0600
From: Larry Finger <Larry.Finger@lwfinger.net>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix compile error in latest git pull - post 2.6.16-rc1-git4
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After doing a git pull from linux/kernel/git/torvalds/linux-2.6.git, I get the following compiler error:

   CC      net/ipv4/igmp.o
net/ipv4/igmp.c: In function ‘igmp_rcv’:
net/ipv4/igmp.c:973: error: label at end of compound statement

Using git bisect, the patch that introduces this error is:

  c5d90e000437a463440c1fe039011a02583a9ee5 is first bad commit
diff-tree c5d90e000437a463440c1fe039011a02583a9ee5 (from e2c2fc2c8f3750e1f7ffbb3ac2b885a49416110c)
Author: Dave Jones <davej@redhat.com>
Date:   Mon Jan 30 20:27:17 2006 -0800

     [IPV4] igmp: remove pointless printk

     This is easily triggerable by sending bogus packets,
     allowing a malicious user to flood remote logs.

     Signed-off-by: Dave Jones <davej@redhat.com>
     Signed-off-by: David S. Miller <davem@davemloft.net>


I suspect this error arises due to differences between gcc 4.0.2 and earlier releases. The patch is 
as follows:

diff --git a/net/ipv4/igmp.c b/net/ipv4/igmp.c
index f70ba62..0b4e95f 100644
--- a/net/ipv4/igmp.c
+++ b/net/ipv4/igmp.c
@@ -970,6 +970,7 @@ int igmp_rcv(struct sk_buff *skb)
         case IGMP_MTRACE_RESP:
                 break;
         default:
+               break;
         }

  drop:


Larry Finger
