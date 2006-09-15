Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750727AbWIOIRy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750727AbWIOIRy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 04:17:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750724AbWIOIRy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 04:17:54 -0400
Received: from ironport-c10.fh-zwickau.de ([141.32.72.200]:54901 "EHLO
	ironport-c10.fh-zwickau.de") by vger.kernel.org with ESMTP
	id S1750722AbWIOIRx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 04:17:53 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AQAAAJ/9CUWLagEBDQ
X-IronPort-AV: i="4.09,168,1157320800"; 
   d="scan'208"; a="3085934:sNHT34962716"
Date: Fri, 15 Sep 2006 10:17:51 +0200
From: Joerg Roedel <joro-lkml@zlug.org>
To: Philip Craig <philipc@snapgear.com>
Cc: Patrick McHardy <kaber@trash.net>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, davem@davemloft.net
Subject: Re: [PATCH] EtherIP tunnel driver (RFC 3378)
Message-ID: <20060915081751.GA2441@zlug.org>
References: <20060911204129.GA28929@zlug.org> <4508AE92.1090202@snapgear.com> <20060914095205.GA23405@zlug.org> <45092ADB.9060808@trash.net> <4509E05A.7010306@snapgear.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4509E05A.7010306@snapgear.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2006 at 09:06:02AM +1000, Philip Craig wrote:
> Patrick McHardy wrote:
> > Joerg Roedel wrote:
> >> On Thu, Sep 14, 2006 at 11:21:22AM +1000, Philip Craig wrote:
> >>
> >>> Joerg Roedel wrote:
> >>>
> >>>> +	 To configure tunnels an extra tool is required. You can download
> >>>> +	 it from http://zlug.fh-zwickau.de/~joro/projects/ under the
> >>>> +	 EtherIP section. If unsure, say N.
> >>> To obtain a list of tunnels, this tool calls SIOCGETTUNNEL
> >>> (SIOCDEVPRIVATE + 0) for every device in /proc/net/dev. I don't think
> >>> this is safe, but I don't have a solution for you.
> >>
> >> You are right. But this is the way the ipip driver does it. In the case
> >> of ipip it is safe, because it is visible as a tunnel interface to
> >> userspace. But my driver registers its devices as Ethernet (it has to,
> >> otherwise the devices will not be usable in a bridge). There is no safe
> >> way to distinguish between real Ethernet devices and devices registered
> >> by my driver. I think about implementing an ioctl to fetch a list of
> >> all EtherIP tunnel devices from the driver.
> > 
> > 
> > Just do what ipip and gre do, use a network device with a fixed name
> > for the ioctl (you already have the ethip0 device for this purpose it
> > appears).
> 
> That fixed name device isn't used to get a list of tunnels. Instead,
> ipip and gre read /proc/net/dev, and check for ARPHRD_TUNNEL or
> ARPHRD_IPGRE. This won't work for etherip because it uses ARPHRD_ETHER,
> which isn't specific to etherip tunnels. A new ioctl to get a list could
> be added (this ioctl would use the fixed name device), is that acceptable?

The problem is that the ethip0 device also uses ARPHDR_ETHER. The usage
of that device is also unsafe. As I see the situation there are 2
solutions for this problem. First use some other Type identifier for
ethip0. But this is only a quick hack. I think about a new device type
ARPHRD_ETHERIP. This makes the tunnel devices incompatible with the
bridging code. But I think it is possible to convince the bridge code to
accept the special tunnel devices too.
Unfortunately I didn't saw the problem when implementing the driver...

Regards,
    Joerg Roedel
