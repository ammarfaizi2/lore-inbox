Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262580AbUKQWYy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262580AbUKQWYy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 17:24:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262632AbUKQWUt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 17:20:49 -0500
Received: from colino.net ([213.41.131.56]:44022 "EHLO paperstreet.colino.net")
	by vger.kernel.org with ESMTP id S262574AbUKQWNU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 17:13:20 -0500
Date: Wed, 17 Nov 2004 23:12:53 +0100
From: Colin Leroy <colin@colino.net>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: hotplug_path no longer exported
Message-ID: <20041117231253.1ec92e6f.colin@colino.net>
In-Reply-To: <20041117214824.GA1291@kroah.com>
References: <20041117203139.7c9f5e95.colin@colino.net>
	<20041117214824.GA1291@kroah.com>
X-Mailer: Sylpheed-Claws 0.9.12cvs142.2 (GTK+ 2.4.9; powerpc-unknown-linux-gnu)
X-Face: Fy:*XpRna1/tz}cJ@O'0^:qYs:8b[Rg`*8,+o^[fI?<%5LeB,Xz8ZJK[r7V0hBs8G)*&C+XA0qHoR=LoTohe@7X5K$A-@cN6n~~J/]+{[)E4h'lK$13WQf$.R+Pi;E09tk&{t|;~dakRD%CLHrk6m!?gA,5|Sb=fJ=>[9#n1Bu8?VngkVM4{'^'V_qgdA.8yn3)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 17 Nov 2004 at 13h11, Greg KH wrote:

Hi, 

> > hotplug_path is no longer exported, is this on purpose ?
> 
> Yes.
> 
> > It breaks linux-wlan-ng. If it is on purpose, I suppose
> > linux-wlan-ng should use kobject_hotplug() ?
> 
> Yes it should.  Why was it not useing that function in the first
> place?

Dunno. This driver has a reputation of being the worse wlan driver for
prism2 chipsets out there, but it's the only one supporting USB devices.

> No, please use kobject_hotplug().  Actually, what are they doing that
> they need to call kobject_hotplug() in the first place?

To propagate events to scripts, I think:
void    p80211_suspend(wlandevice_t *wlandev)
{
	p80211_run_sbin_hotplug(wlandev, WLAN_HOTPLUG_SUSPEND);
}
int register_wlandev(wlandevice_t *wlandev)
{
	netdevice_t	*dev = wlandev->netdev;
...	if (register_netdev(dev)) {
		return -EIO;
	}
...
	p80211_run_sbin_hotplug(wlandev, WLAN_HOTPLUG_REGISTER);
}

With p80211_run_sbin_hotplug doing stuff to call /sbin/hotplug... 
The one that will write a correct patch to linux-wlan-ng will have to
figure out the different events they use: "register" (instead of "add"),
"startup", "shutdown", "resume", "suspend"...

-- 
Colin
  http://www.colino.net/
