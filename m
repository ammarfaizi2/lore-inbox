Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311743AbSCNTZX>; Thu, 14 Mar 2002 14:25:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311744AbSCNTZN>; Thu, 14 Mar 2002 14:25:13 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:59919 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S311743AbSCNTZA>; Thu, 14 Mar 2002 14:25:00 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: IO delay, port 0x80, and BIOS POST codes
Date: Thu, 14 Mar 2002 19:23:20 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <a6qtb8$6fg$1@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0203141802330.1477-100000@biker.pdb.fsc.net> <E16lZg3-0001Ug-00@the-village.bc.nu>
X-Trace: palladium.transmeta.com 1016133873 8660 127.0.0.1 (14 Mar 2002 19:24:33 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 14 Mar 2002 19:24:33 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <E16lZg3-0001Ug-00@the-village.bc.nu>,
Alan Cox  <alan@lxorguk.ukuu.org.uk> wrote:
>> Unfortunately we can't read this information because Linux uses
>> port 80 as "dummy" port for delay operations. (outb_p and friends,
>> actually there seem to be a more hard-coded references to port
>> 0x80 in the code).
>
>The dummy port needs to exist. By using 0x80 we have probably the only
>port we can safely use in this way. We know it fouls old style POST 
>boards on odd occasions.

In fact, port 0x80 is safe exactly _because_ it is used for BIOS POST
codes, which pretty much guarantees that it will never be used for
anything else. That tends to not be as true of any other ports.

Also, it should be noted that to get the 1us delay, the port should be
behind the ISA bridge in a legacy world (in a modern all-PCI system it
doesn't really matter, because the ports that need more delays are
faster too, so this works out ok).  That's why I personally would be
nervous about using some of the well-specified (but irrelevant) ports
that are on the PCI side of a super-IO controller. 

I suspect the _real_ solution is to stop using "inb_p/outb_p" and make
the delay explicit, although it may be that some drivers depend on the
fact that not only is the "outb $0x80" a delay, it also tends to act as
a posting barrier.

			Linus
