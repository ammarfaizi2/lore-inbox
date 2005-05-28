Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261759AbVE1DiC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261759AbVE1DiC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 23:38:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261820AbVE1DiC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 23:38:02 -0400
Received: from mail.dvmed.net ([216.237.124.58]:29666 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261759AbVE1Dhw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 23:37:52 -0400
Message-ID: <4297E78A.4030906@pobox.com>
Date: Fri, 27 May 2005 23:37:46 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jiri Benc <jbenc@suse.cz>
CC: NetDev <netdev@oss.sgi.com>, LKML <linux-kernel@vger.kernel.org>,
       pavel@suse.cz
Subject: Re: [2/5] ieee80211: ieee80211_device alignment fix and cleanup
References: <20050524150711.01632672@griffin.suse.cz> <20050524151117.5e059d1d@griffin.suse.cz>
In-Reply-To: <20050524151117.5e059d1d@griffin.suse.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Comments on the remaining patches in this series:

1) I am not convinced that the subclassing of net_device should be done 
in this manner.  Read drivers/net/wan/hdlc_generic.c and .../pc300_drv.c 
for examples of how hdlc_device is handled.

Comments and thoughts welcome.


2) Please put all the new, protocol-layer functions 
ieee80211_type_trans(), ieee80211_change_mtu(), ieee80211_header(), etc. 
in their own file.


3) Temporary or not, the following construct is simply not necessary. 
Modify the definition rather than repeating this two-call piece of code 
in multiple areas:

	ieee80211_priv(netdev_priv(dev));


4) A low-level wireless hardware driver should look like other net 
drivers, and use the existing driver API.  The low level driver should 
implement its own dev->hard_start_xmit().

  	ieee = netdev_priv(dev);
-	dev->hard_start_xmit = ieee80211_xmit;
-
  	ieee->dev = dev;
+	ieee->priv = ieee80211_priv(ieee);
+	
+	dev->hard_start_xmit = ieee80211_xmit;

Certainly, the driver will make many calls to generic ieee80211_xxx 
functions to get things done.

I understand this was not your change; you simply moved the 
dev->hard_start_xmit() assignment down.  I just wanted to take this 
opportunity to make a point.


5) The wireless code in -mm all sourced directly from my netdev-2.6.git 
tree.  I strongly encourage everyone who wants to work on wireless to 
download git (read http://lkml.org/lkml/2005/5/26/11) and check out 
branches 'we18' (wireless ex 18), 'we18-ieee80211' (we18 + ieee80211), 
and 'we18-ieee80211-wifi' (we18 + ieee80211 + hostAP) of
rsync://rsync.kernel.org/pub/scm/linux/kernel/git/jgarzik/netdev-2.6.git




