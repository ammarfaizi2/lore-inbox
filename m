Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281185AbRKHAiZ>; Wed, 7 Nov 2001 19:38:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281197AbRKHAiM>; Wed, 7 Nov 2001 19:38:12 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:20220 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S281185AbRKHAh0>;
	Wed, 7 Nov 2001 19:37:26 -0500
Date: Wed, 7 Nov 2001 17:36:27 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: "David S. Miller" <davem@redhat.com>
Cc: tim@physik3.uni-rostock.de, jgarzik@mandrakesoft.com, andrewm@uow.edu.au,
        linux-kernel@vger.kernel.org, torvalds@transmeta.com,
        netdev@oss.sgi.com, ak@muc.de, kuznet@ms2.inr.ac.ru
Subject: Re: [PATCH] net/ipv4/*, net/core/neighbour.c jiffies cleanup
Message-ID: <20011107173626.S5922@lynx.no>
Mail-Followup-To: "David S. Miller" <davem@redhat.com>,
	tim@physik3.uni-rostock.de, jgarzik@mandrakesoft.com,
	andrewm@uow.edu.au, linux-kernel@vger.kernel.org,
	torvalds@transmeta.com, netdev@oss.sgi.com, ak@muc.de,
	kuznet@ms2.inr.ac.ru
In-Reply-To: <Pine.LNX.4.30.0111080003320.29364-100000@gans.physik3.uni-rostock.de> <20011107.160950.57890584.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <20011107.160950.57890584.davem@redhat.com>; from davem@redhat.com on Wed, Nov 07, 2001 at 04:09:50PM -0800
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 07, 2001  16:09 -0800, David S. Miller wrote:
>    From: Tim Schmielau <tim@physik3.uni-rostock.de>
> 
>    jiffies cleanup patch of the day follows. Mostly boring changes of jiffies
>    comparisons to use time_{before,after} in order to handle jiffies
>    wraparound correctly.
> 
> These cases handle wraparound correctly!!!!
> 
> Please stop sending these changes, start thinking about what the
> code is doing.
> 
> It is comparing a "DIFFERRENCE" not raw jiffy values with each other.
> It works just fine.

No, only a limited number of them cast to a signed value, which means
that a large number of them get the comparison wrong in the case of
jiffies wrap (where the difference is a large unsigned value, and not
a small negative number).


This is not just idle change.  Tim has problems when jiffies is
initialized to a pre-wrap value at boot, and changing everything to
use time_{before,after} is the only easy way to audit all of the code
(and know that it is done).

As I sent to Alan privately (and he agreed), there are three reasons to
change this code (even if it is correct) to using time_{before,after}:

1) because it is non-obvious what "correct" is when dealing with jiffies wrap
   (some of the changes that Alan previously complained about as being already
   correct were in fact broken, and if _he_ can't get it right, who can?)
2) so that people see it more and are more likely to get it correct, instead
   of always adding in code that only breaks after 497 days of uptime
3) to isolate code from any changes if jiffies moves to a 64-bit value (where
   casts to "(long)" may not be appropriate anymore)

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

