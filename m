Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264884AbUHHA2T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264884AbUHHA2T (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 20:28:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264903AbUHHA2T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 20:28:19 -0400
Received: from ozlabs.org ([203.10.76.45]:41659 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S264884AbUHHA2R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 20:28:17 -0400
Date: Sun, 8 Aug 2004 10:23:55 +1000
From: Anton Blanchard <anton@samba.org>
To: linux-kernel@vger.kernel.org
Cc: chrisw@osdl.org, sds@epoch.ncsc.mil, jmorris@redhat.com
Subject: SELINUX performance issues
Message-ID: <20040808002355.GA24690@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

During SLES9 testing we noticed SELINUX caused rather large performance
regressions in network benchmarks. To retest this, I fired up
2.6.8-rc3-BK on a small POWER5 box (3 CPUs).

I enabled a bunch of stuff in my .config:

CONFIG_SECURITY=y
CONFIG_SECURITY_NETWORK=y
CONFIG_SECURITY_CAPABILITIES=y
CONFIG_SECURITY_ROOTPLUG=y
CONFIG_SECURITY_SELINUX=y
CONFIG_SECURITY_SELINUX_BOOTPARAM=y
CONFIG_SECURITY_SELINUX_DISABLE=y
CONFIG_SECURITY_SELINUX_DEVELOP=y
CONFIG_SECURITY_SELINUX_MLS=y

I then ran a number of copies of socklib to localhost. Socklib is a tool
from tridge which just pumps bytes down a TCP stream. Very simple stuff.
I found just over a 15% regression between enabling and disabling
selinux (using the same kernel, just specifying the selinux=off boot
option).

Oprofile shows where the problems are:

%       function
3.0880  avc_has_perm_noaudit
1.7677  selinux_socket_sock_rcv_skb
0.8400  avc_has_perm
0.5687  security_node_sid
0.5324  security_port_sid
0.5164  sel_netif_lookup
0.5141  avc_lookup
0.5003  sel_netif_put
0.3001  sel_netif_find
0.2899  selinux_file_permission

The biggest problem is the global lock:

avc_has_perm_noaudit:
        spin_lock_irqsave(&avc_lock, flags);

Any chance we can get rid of it? Maybe with RCU?

Anton
