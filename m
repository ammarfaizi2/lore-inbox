Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286792AbRLVPE1>; Sat, 22 Dec 2001 10:04:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286796AbRLVPET>; Sat, 22 Dec 2001 10:04:19 -0500
Received: from 213-96-124-18.uc.nombres.ttd.es ([213.96.124.18]:48106 "HELO
	dardhal") by vger.kernel.org with SMTP id <S286792AbRLVPEF>;
	Sat, 22 Dec 2001 10:04:05 -0500
Date: Sat, 22 Dec 2001 16:03:56 +0100
From: =?iso-8859-1?Q?Jos=E9_Luis_Domingo_L=F3pez?= 
	<jdomingo@internautas.org>
To: linux-kernel@vger.kernel.org
Subject: Re: very slow rebuilt for RAID15 and RAID51
Message-ID: <20011222150356.GA2126@dardhal.mired.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20011222103832.B14419@oknodo.bof.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20011222103832.B14419@oknodo.bof.de>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, 22 December 2001, at 10:38:32 +0100,
Patrick Schaaf wrote:

> Then I started the second layer, making a RAID5 set out of the 8 mirror pairs
> out of the "2" partitions, and making a mirror pair out of the two RAID5 sets
> on the "3" partition. Technically, this seems to work, but the initial rebuild
> runs extremely slow, compared to the above rates: the RAID15 rebuild goes
> at about 380kB/s, and the RAID51 build at slightly over 100kB/s. I will report
> on operational characteristics, once these rebuilds are through (in about
> 30 days, for the RAID51...)
> 
There are two kernel tunnables that can modify RAID reconstruction speed:
/proc/sys/dev/raid/speed_limit_min
/proc/sys/dev/raid/speed_limit_max

They both are integer values in KB/s, the latter limiting the absolute
maximun RAID reconstruction speed (200 MB/s if I recall correctly, at
least for prior kernel versions). The former gives you the minimun
guaranteed reconstruction speed, and has a default (again, at least for
kernel kersions up to 2.4.7) of exactly 100 KB/s.

RAID reconstruction code is expected to only "access" disks when there
are no disk activity due to applications, with a guaranteed minimun of
"speed_limit_min". If this RAID code feels disks are busy due to
applications using the disks, reconstruction will take place at just
this minimun guaranteed speed (exactly 100 KB/s).

As far as I remember this happens with "layered" RAIDs, such as the
setup your are trying. To get a minimun reconstruction speed greater
than the default, just (for example):
echo "50000" > /proc/sys/dev/raid/speed_limit_min

Be careful not to give a too high value, because you will get a very
unresponsive system in case you set this parameter too high.

A couple of days ago Ingo Molnar submitted some patches for RAID in the
2.5.x series, with some improvements that maybe will find their way into
2.4.x. Check this threads:
http://marc.theaimsgroup.com/?t=100863779600002&r=1&w=2&n=5
http://marc.theaimsgroup.com/?l=linux-kernel&m=100876771508736&w=2
http://marc.theaimsgroup.com/?l=linux-kernel&m=100876826309961&w=2

-- 
José Luis Domingo López
Linux Registered User #189436     Debian Linux Woody (P166 64 MB RAM)
 
jdomingo AT internautas DOT org  => Spam at your own risk

