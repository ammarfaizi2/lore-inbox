Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266408AbUBFVM1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 16:12:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266461AbUBFVM1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 16:12:27 -0500
Received: from host-64-65-253-246.alb.choiceone.net ([64.65.253.246]:26808
	"EHLO gaimboi.tmr.com") by vger.kernel.org with ESMTP
	id S266408AbUBFVMW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 16:12:22 -0500
Message-ID: <402403A5.4090708@tmr.com>
Date: Fri, 06 Feb 2004 16:14:13 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jim Faulkner <jfaulkne@ccs.neu.edu>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       kraxel@bytesex.org, davem@redhat.com, manmower@signalmarketing.com
Subject: Re: major network performance difference between 2.4 and 2.6.2-rc2
References: <20040204125444.3f2b5e79.akpm@osdl.org> <Pine.GSO.4.58.0402042248300.27381@denali.ccs.neu.edu>
In-Reply-To: <Pine.GSO.4.58.0402042248300.27381@denali.ccs.neu.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jim Faulkner wrote:

> Thanks to Andrew's suggestion of profiling my kernel, I've figured out
> what is happening here.  It is my fault, it is not a bug.
> 
> I use this iptables script generator:
> http://ftp.berlios.de/pub/mldonkey/pango/goodies/ipblacklist_convert
> in combination with this blacklist:
> http://www.peerguardian.net/pgipdb/guarding.p2p
> 
> I had already modified the script so everything on my LAN interface was
> accepted, however I didn't realize that the scipt was using "-I INPUT 1"
> for all of its blacklist rules.  iptables was going through around 5300
> rules for each and every packet that came in through my LAN interface,
> which is definately not what I intended.
> 
> I fixed my firewall script, and my LAN throughput is back up at 10
> megabytes per second, with nowhere near the load.

This does point out an issue, as a 2.7 enhancement it would be really 
useful to have a better way to handle a large number of rules, when what 
you want is one rule applied to many IP values. I ran into this when 
fighting a DDoS attack, and by the time I got the attack stopped, even 
only dropping or rejecting --syn packets I had most of a CPU in system 
time running ~10k rules.

I wrote a perl script to break it into multiple level tables, but it was 
still pretty slow and uglier than a hedgehog's rectum.

What would be nice is some kind of table approach, hash or tree, which 
allows operations to be matches against all of the IPs in a group, and 
obviously to add/delete entries. I think for simplicity individual IPs 
rather than CIDR blocks are desirable.

In any case, if a network person is looking for something really neat 
for 2.7, blactlists of various types are getting more common, and an 
efficient solution would be good.


-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
