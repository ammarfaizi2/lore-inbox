Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265814AbUGHGhK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265814AbUGHGhK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 02:37:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265811AbUGHGhJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 02:37:09 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:4018 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S265812AbUGHGhB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 02:37:01 -0400
Date: Thu, 8 Jul 2004 08:37:00 +0200
From: bert hubert <ahu@ds9a.nl>
To: Jamie Lokier <jamie@shareable.org>, "David S. Miller" <davem@redhat.com>,
       Stephen Hemminger <shemminger@osdl.org>, netdev@oss.sgi.com,
       linux-net@vger.kernel.org, linux-kernel@vger.kernel.org,
       ALESSANDRO.SUARDI@ORACLE.COM
Subject: window tracking firewall involved, was: Re: preliminary conclusions regarding window size issues
Message-ID: <20040708063700.GA23496@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Jamie Lokier <jamie@shareable.org>,
	"David S. Miller" <davem@redhat.com>,
	Stephen Hemminger <shemminger@osdl.org>, netdev@oss.sgi.com,
	linux-net@vger.kernel.org, linux-kernel@vger.kernel.org,
	ALESSANDRO.SUARDI@ORACLE.COM
References: <20040707232757.GA14471@outpost.ds9a.nl> <20040708014443.GE17266@mail.shareable.org> <20040708060326.GA22258@outpost.ds9a.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040708060326.GA22258@outpost.ds9a.nl>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 08, 2004 at 08:03:26AM +0200, bert hubert wrote:

[ theory that a window tracking firewall drops packets for which it thinks
  the intended recipient has no room, as they are larger than the window size
  it sees, where it neglects to scale that window size ]

> We could verify this assumption by checking if lowering the MTU to say 700
> allows wscale=3 to work. 

This has now been confirmed with the packages.gentoo.org firewall!

Setting MTU does not help because the kernel adjusts the window size too.
However, fiddling with MSS helps.

Setting wscale to 3 breaks connectivity to packages.gentoo.org, but one can
restore it with:

# iptables -t mangle -A OUTPUT -p tcp -o wlan0 -d 198.63.211.232 -j TCPMSS \
	--set-mss=742 --tcp-flags SYN,RST SYN

742 is the limit value, note how this is pretty close to the scaled window
size of 730.

Trace of succesful connection:

08:29:54.799158 192.168.1.4.33116 > 198.63.211.232.80: S 258776237:258776237(0) 
	win 5840 <mss 742,sackOK,timestamp 5528023 0,nop,wscale 3> 
	(DF)
08:29:54.935830 198.63.211.232.80 > 192.168.1.4.33116: S 3729725382:3729725382(0) 
	ack 258776238 win 5792 <mss 1460,sackOK,timestamp 824466134 5528023,nop,wscale 0> 
	(DF)
08:29:54.935997 192.168.1.4.33116 > 198.63.211.232.80: 
	. ack 1 win 730 <nop,nop,timestamp 5528160 824466134> 
	(DF)
08:29:54.936116 192.168.1.4.33116 > 198.63.211.232.80: P 1:107(106) 
	ack 1 win 730 <nop,nop,timestamp 5528160 824466134> 
	(DF)
08:29:55.058090 198.63.211.232.80 > 192.168.1.4.33116: . 
	ack 107 win 5792 <nop,nop,timestamp 824466159 5528160> (DF)
08:29:55.058325 198.63.211.232.80 > 192.168.1.4.33116: . 1:731(730) 
	ack 107 win 5792 <nop,nop,timestamp 824466160 5528160> 
	(DF)
08:29:55.058425 192.168.1.4.33116 > 198.63.211.232.80: . 
	ack 731 win 912 <nop,nop,timestamp 5528283 824466160> 
	(DF)
08:29:55.181172 198.63.211.232.80 > 192.168.1.4.33116: . 731:1461(730) 
	ack 107 win 5792 <nop,nop,timestamp 824466184 5528283> 
	(DF)

Packages.gentoo.org is behind a
Running: Cisco IOS 12.X
OS details: Cisco 7200 router running IOS 12.1(14)E6
OS Fingerprint:

Not sure if that would be the culprit though.

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
