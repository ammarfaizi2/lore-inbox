Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261662AbUKXBcn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261662AbUKXBcn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 20:32:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261670AbUKXBcn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 20:32:43 -0500
Received: from [62.206.217.67] ([62.206.217.67]:385 "EHLO kaber.coreworks.de")
	by vger.kernel.org with ESMTP id S261662AbUKXBcj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 20:32:39 -0500
Message-ID: <41A3E4B4.8080401@trash.net>
Date: Wed, 24 Nov 2004 02:32:36 +0100
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.3) Gecko/20041008 Debian/1.7.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: =?ISO-8859-15?Q?Marcin_Gibu=B3a?= <mg@iceni.pl>
CC: linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       "David S. Miller" <davem@davemloft.net>
Subject: Re: ipsec hang
References: <200411240134.50314@senat>
In-Reply-To: <200411240134.50314@senat>
Content-Type: multipart/mixed;
 boundary="------------000507000605040608010207"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000507000605040608010207
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8bit

Marcin Gibu³a wrote:

>Hi,
>today I tried to configure ipsec on my linux workstation (with openswan) and 
>it hanged just after the init had run /etc/rc.d/init.d/ipsec start. 
>It was on linux-2.6.10-rc1-bk20, so I upgraded to 2.6.10-rc2-mm3 but it didn't 
>make any difference. 
>
>The alt-sysrq-p shows the following call trace:
>xfrm_policy_insert
>xfrm_netlink_rcv
>netlink_data_ready
>netlink_sendmsg
>sock_aio_write
>do_sync_write
>sock_map_fd
>sys_select
>vfs_write
>system_call
>
>The full trace (with regs, etc) is available at 
>http://www.iceni.pl/marcin/lockup.jpg 
>
>.config attached. This hang is 100%-reproductible for me. I can attach 
>openswan config if needed.
>
This patch should fix it. The patch "Fix policy update bug when increasing
priority of last policy" broke this, when a policy with lower priority than
an existing policy is inserted xfrm_policy_insert loops forever.

Regards
Patrick


--------------000507000605040608010207
Content-Type: text/plain;
 name="x"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="x"

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/11/24 02:25:16+01:00 kaber@coreworks.de 
#   [XFRM]: Fix endless loop in xfrm_policy_insert
#   
#   Signed-off-by: Patrick McHardy <kaber@trash.net>
# 
# net/xfrm/xfrm_policy.c
#   2004/11/24 02:25:07+01:00 kaber@coreworks.de +1 -0
#   [XFRM]: Fix endless loop in xfrm_policy_insert
#   
#   Signed-off-by: Patrick McHardy <kaber@trash.net>
# 
diff -Nru a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
--- a/net/xfrm/xfrm_policy.c	2004-11-24 02:31:08 +01:00
+++ b/net/xfrm/xfrm_policy.c	2004-11-24 02:31:08 +01:00
@@ -353,6 +353,7 @@
 			newpos = p;
 		if (delpol)
 			break;
+		p = &pol->next;
 	}
 	if (newpos)
 		p = newpos;

--------------000507000605040608010207--
