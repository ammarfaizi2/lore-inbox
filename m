Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276914AbRKHSF1>; Thu, 8 Nov 2001 13:05:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277341AbRKHSEE>; Thu, 8 Nov 2001 13:04:04 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:509 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S277294AbRKHSCv>;
	Thu, 8 Nov 2001 13:02:51 -0500
Date: Thu, 8 Nov 2001 11:01:09 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Krishna Kumar <kumarkr@us.ibm.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, ak@muc.de, andrewm@uow.edu.au,
        "David S. Miller" <davem@redhat.com>, jgarzik@mandrakesoft.com,
        kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
        owner-netdev@oss.sgi.com, tim@physik3.uni-rostock.de
Subject: Re: [PATCH] net/ipv4/*, net/core/neighbour.c jiffies cleanup
Message-ID: <20011108110108.W5922@lynx.no>
Mail-Followup-To: Krishna Kumar <kumarkr@us.ibm.com>,
	Linus Torvalds <torvalds@transmeta.com>, ak@muc.de,
	andrewm@uow.edu.au, "David S. Miller" <davem@redhat.com>,
	jgarzik@mandrakesoft.com, kuznet@ms2.inr.ac.ru,
	linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
	owner-netdev@oss.sgi.com, tim@physik3.uni-rostock.de
In-Reply-To: <OFE014018A.D6D3430D-ON88256AFE.005C057D@boulder.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <OFE014018A.D6D3430D-ON88256AFE.005C057D@boulder.ibm.com>; from kumarkr@us.ibm.com on Thu, Nov 08, 2001 at 08:55:51AM -0800
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 08, 2001  08:55 -0800, Krishna Kumar wrote:
> > > In short: It is wrong to do
> > >
> > >          if (jiffies <= start+HZ)
> > >
> > > and it is _right_ to do
> > >
> > >          if (jiffies - start <= HZ)
> >
> > Actually this last part is wrong, isn't it ? jiffies <= start + HZ is
> > also a correct way to do it, since start+HZ will overflow to the current
> > value of jiffies when HZ time elapses. So the above two statements are
> > IDENTICAL.
> 
> I am sorry, but I still don't see the difference. I wrote a small program
> with different cases, but the values still come same irrespective of the
> input arguments to the checks. Could you tell under what conditions the
> checks wuold fail ? The 2's complement  works the same for addition and
> subtraction. I have included the test program below.

There are several cases where jiffies comparisons can be incorrect:

	unsigned long start = jiffies;		/* say 0xfffffff8 */
	unsigned long delta = 16;
	unsigned long end = jiffies + delta;	/* wraps to 0x00000008 */

a)	while (jiffies < end) { do something }

If jiffies is near wrap when calculating end, end will wrap and your loop
will never be executed, because 0xfffffff9 is greater than 0x00000008.

b)	while (jiffies - end < 0) { do something }

Fails because both jiffies and end are unsigned, and the difference can
never be negative.

c)	while ((long)jiffies - (long)end < 0) { do something }

Correct.  Hmm, this is just like

	while(time_before(jiffies, end)) { do something }

d) 	while (jiffies - start < delta) { do something }

This will also work because of modulo arithmetic, as long as we know in
advance that "start" is always less than "jiffies".


e)	if (jiffies > end) { fail because of timeout }

Incorrect for the same reason as (a) above, 0xfffffff9 > 0x00000008, where
we really want to wait until 0x00000009 to timeout.

f)	if (jiffies - end > 0) { fail because of timeout }

Fails for the same reason as (b) - both jiffies and end are unsigned, and
the difference can never be negative.

g)	if ((long)jiffies - (long)end > 0) { fail because of timeout }

Correct, which is just like:

	if (time_after(jiffies, end)) { fail because of timeout }


h)	if (jiffies - start > delta) { fail because of timeout }

Correct because of modulo arithmetic, as long as we know in advance that
"start" is less than "jiffies".


So it appears there are lots of ways to get it wrong that appear to be
correct.  This is why I'm pushing for the use of the macros, so that
there is no question about whether the comparison is right or wrong.

This is just the same as Linus' pedantic min() and max() macros - sure
people can get it right by themselves, but sometimes they get it wrong,
and it is easier to just make sure they don't get it wrong.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

