Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317606AbSHUAzX>; Tue, 20 Aug 2002 20:55:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317619AbSHUAzX>; Tue, 20 Aug 2002 20:55:23 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:64267 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317606AbSHUAzW>;
	Tue, 20 Aug 2002 20:55:22 -0400
Message-ID: <3D62E5ED.6020707@mandrakesoft.com>
Date: Tue, 20 Aug 2002 20:59:25 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Feldman, Scott" <scott.feldman@intel.com>
CC: "'Troy Wilson'" <tcw@tempest.prismnet.com>, linux-kernel@vger.kernel.org,
       Martin.Bligh@us.ibm.com, tcw@prismnet.com,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: mdelay causes BUG, please use udelay
References: <288F9BF66CD9D5118DF400508B68C4460283E4AF@orsmsx113.jf.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Feldman, Scott wrote:
>>-    msec_delay(10);
>>+    usec_delay(10000);
> 
> 
> Jeff, 10000 seems on the border of what's OK.  If it's acceptable, then
> let's go for that.  Otherwise, we're going to have to chain several
> mod_timer callbacks together to do a controller reset.


That definitely wants fixing.  Since I like doing resets and similar 
slow-paths in process context -- sleep for as long as you want -- I 
would say kick over to a function called via schedule_task()

Just make sure other parts of the driver that may be called 
asynchronously, such as ethtool ioctls, are disabled.  Remember that 
tx_timeout holds the dev->xmit_lock as well, so spending a long time in 
there is a bad idea in general.

I would probably call netif_carrier_off() first thing in tx_timeout, too.

	Jeff



