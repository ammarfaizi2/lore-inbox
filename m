Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965073AbVI0VA5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965073AbVI0VA5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 17:00:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965076AbVI0VA4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 17:00:56 -0400
Received: from 81-174-32-62.f5.ngi.it ([81.174.32.62]:36573 "HELO develer.com")
	by vger.kernel.org with SMTP id S965073AbVI0VAz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 17:00:55 -0400
Message-ID: <4339B2F3.5040206@develer.com>
Date: Tue, 27 Sep 2005 23:00:35 +0200
From: Bernardo Innocenti <bernie@develer.com>
User-Agent: Mozilla Thunderbird 1.0.6-5 (X11/20050818)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bernardo Innocenti <bernie@develer.com>
CC: Patrick McHardy <kaber@trash.net>, lkml <linux-kernel@vger.kernel.org>,
       netfilter-devel@lists.netfilter.org
Subject: Re: Intermittent NAT failure when multiple hosts send UDP packets
References: <432B8702.3060801@develer.com> <432CD386.201@develer.com> <43306484.2060103@develer.com> <43307BDC.8060602@trash.net> <4330A51D.20009@develer.com>
In-Reply-To: <4330A51D.20009@develer.com>
X-Enigmail-Version: 0.91.0.0
OpenPGP: id=FC6A66CA;
	url=https://www.develer.com/~bernie/gpgkey.txt
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernardo Innocenti wrote:
> Patrick McHardy wrote:
>>Bernardo Innocenti wrote:
>>
>>>It's quite hard to trigger, but after it does, packets
>>>are consistently routed with the source IP untranslated.
>>
>>Please try "echo 255 >
>>/proc/sys/net/ipv4/netfilter/ip_conntrack_log_invalid"
>>and modprobe ipt_LOG to see if conntrack ignores them because
>>of invalid checksums or something.
> 
> It doesn't seem to be the case.  I only see a few occasional
> errors, probably caused by miserable hosts crawling with worms:


PROBLEM SOLVED!  I'm glad to say It's *almost* not a kernel bug,
more like a missing feature.


In my ip-up.local script, I do:

        echo "Loading NAT modules:"
        /sbin/modprobe ip_conntrack
        /sbin/modprobe ip_conntrack_ftp
        /sbin/modprobe ip_conntrack_irc
        /sbin/modprobe iptable_nat
        /sbin/modprobe ip_nat_ftp
        /sbin/modprobe ip_nat_irc

	[...several filtering and QoS rules...]

	$iptab -A POSTROUTING -t nat -o $IFNAME -j SNAT --to-source $IPLOCAL


My ip-down.local attempts to do the opposite:

        echo "Flushing all current rules:"
        $iptab -F
        $iptab -F -t nat
        echo "Clearing all chains:"
        $iptab -X
        $iptab -Z
        $iptab -X -t nat
        $iptab -Z -t nat

        echo "Removing NAT modules:"
        /sbin/rmmod ip_nat_ftp ip_nat_irc iptable_nat ip_conntrack ip_conntrack_ftp ip_conntrack_irc


Note the order of the modules in the last line: ip_conntrack cannot
be unloaded because it's still being used by ip_conntrack_ftp and
ip_conntrack_irc.

So, whenever the PPP link goes down, ip_conntrack remains loaded with
all connections still being tracked until the timer expires!

If ppp0 goes up again soon enough, the script reloads the ip_nat modules,
but the existing connections are no longer being translated.

Would it be possible to do something at module initialization time
to recover those connections?  Meanwhile, I've fixed my rmmod to make
sure ip_conntrack really gets unloaded.

-- 
  // Bernardo Innocenti - Develer S.r.l., R&D dept.
\X/  http://www.develer.com/

