Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135275AbRDRTxM>; Wed, 18 Apr 2001 15:53:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135276AbRDRTwx>; Wed, 18 Apr 2001 15:52:53 -0400
Received: from asooo.flowerfire.com ([63.104.96.247]:20668 "EHLO
	asooo.flowerfire.com") by vger.kernel.org with ESMTP
	id <S135275AbRDRTwt>; Wed, 18 Apr 2001 15:52:49 -0400
Message-Id: <200104181952.OAA04177@asooo.flowerfire.com>
Date: Wed, 18 Apr 2001 12:52:46 -0700
Content-Type: text/plain;
	format=flowed;
	charset=us-ascii
Mime-Version: 1.0 (Apple Message framework v387)
From: brownfld@irridia.com
To: linux-kernel@vger.kernel.org
X-Mailer: Apple Mail (2.387)
Content-Transfer-Encoding: 7bit
Subject: Persistent 2.4.x stability problem
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since 2.4.0-test1 (didn't use 2.3.x) we have been struggling with a 
persistent stability issue with the 2.4.x kernels.  I've been trying to 
track down this persistent culprit for months, so I'm getting 
desperate.  I haven't found any reports of this issue on the net or in 
FAQs, so I'm hoping my posting here isn't inappropriate.  Using any 
2.2.x kernel with basically identical configs is absolutely rock solid, 
including the exact situations and machines that cause 2.4.x issues.

The symptoms are:
	
After a period of time from an hour to a few days, but usually less than 
a week, the machine will become sluggish (like very heavy swapping, 
although there is no OOM situation and typically zero swap in use), 
processes will stop responding, network daemons will stop responding, 
and eventually the machine will stop pinging, all over the course of a 
few minutes.  Syslog writes stop cold (with no errors) and the console 
remains blank and unresponsive, requiring a reset or power cycle.

Sysrq commands work and log to syslog but not console.  I've placed a 
copy of the sysrq-t output (and other diagnosis info) at 
"http://web.irridia.com/linux/" from a 2.4.4-pre4 kernel (with the 
recent d_flags patch, thus 2.4.4-pre4a).  What is most interesting is 
that all syslog writes from sysrq happen at the same second the machine 
stopped responding -- even when the sysrq commands were hit from console 
almost an hour later, they still show up in syslog as originating at the 
time of the hang.

This behaviour occurs under fair to heavy loads in various situations, 
including:

	khttpd serving about 5Mbit (or more) of static-only traffic
	  (no other activity)
	Large batch jobs accessing a remote database and
	writing to NFS
	  (no other activity)
	Stronghold serving CGI and static pages, with back-end
	network connections
	  (no other activity)

Effected hardware includes:

	HP Netserver LPr (256-1024MB RAM,2xP3) * Source of debugging output *
		NCR or SYM SCSI drivers
		2.4.x or Intel's EtherExpress drivers	
	HP Netserver LP1000r (1.25GB RAM, 2xP3)
		AMI MegaRAID
		EtherExpress
	HP Netserver LH6000r (5GB RAM, 6xP3Xeon)
		AMI MegaRAID
		Mylex DAC
		EtherExpress

It's the only hardware I have available that I can load in a real-life 
way, unfortunately.  Artificial load-testing doesn't seem to trigger the 
problem -- fair to heavy persistent real-life load seems necessary.

The only proc tweaks I make are to turn on tcp_syncookies and turn off 
tcp_ecn if it exists in /proc.  I've used clean RH6.2 and RH7.0 
distributions for both compilation and run-time with the same problem.  
I have /usr/include/linux symlinked to the linux 2.2.x source tree, 
though the RH6.2 default (symlink to 2.4.x in /usr/src/linux) doesn't 
change the behaviour.

I'm wondering if nmi_watchdog is on by default and if HP hardware 
suffers from the same kind of nmi issues that I've heard IBM's Netfinity 
servers suffer from.  Because of the syslog timestamping issue, I'm 
wondering if the HPs have clock problems with Linux and whether the 
enhanced rtc is involved.  I'm also suspicious of the various tcp_mem, 
rmem_max, wmem_max, etc settings and especially the anemic and now 
unchangable freepages settings.  I've increased the mem settings with no 
clear-cut effect, but I'm still suspicious of them.

I'm also suspicious of rt_cache, ip_dst_cache, and syncookies, since the 
instability seems to roughly but not always follow the size and breadth 
of incoming web traffic.  I've tried tweaking about every run-time 
kernel parameter there is to no avail, however.

I plan on experimenting with RH7.1 as soon as I can in case it's an 
obscure compiler/tools/glibc issue with distributions built around 
2.2.x.  But I would imagine that more people would have reported this 
issue had it been specific to RH6.2 or RH7.0.

Any ideas at all would be helpful, including hints on how to go about 
debugging this issue further.  Falling back to the 2.2.x kernel has been 
acceptable so far, but soon 2.2.x is going to fall behind and I already 
have >2GB machines that I need to support.  Debugging is a major PITA 
because there's no oops and absolutely no errors are being reported.

If you're in the SF bay area, dinner and my firstborn is on me if you 
can help me find my way out of the maze.

Again, I have pertinent data in "http://web.irridia.com/linux/" but 
please let me know if other information would be helpful.

Immense thanks,
--
Ken.
brownfld@irridia.com
