Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264666AbSL1THR>; Sat, 28 Dec 2002 14:07:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264679AbSL1THR>; Sat, 28 Dec 2002 14:07:17 -0500
Received: from aslan.scsiguy.com ([63.229.232.106]:61195 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S264666AbSL1THQ>; Sat, 28 Dec 2002 14:07:16 -0500
Date: Sat, 28 Dec 2002 12:13:38 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: Rik van Riel <riel@conectiva.com.br>, Tomas Szepe <szepe@pinerecords.com>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Samuel Flory <sflory@rackable.com>, Janet Morgan <janetmor@us.ibm.com>,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] aic7xxx bouncing over 4G
Message-ID: <705128112.1041102818@aslan.scsiguy.com>
In-Reply-To: <Pine.LNX.4.50L.0212281131580.26879-100000@imladris.surriel.com>
References: <200212210012.gBL0Cng21338@eng2.beaverton.ibm.com>
 <176730000.1040430221@aslan.btc.adaptec.com> <3E03BB0D.5070605@rackable.com>
 <Pine.LNX.4.50L.0212280331110.30646-100000@freak.distro.conectiva>
 <20021228091608.GA13814@louise.pinerecords.com>
 <Pine.LNX.4.50L.0212281131580.26879-100000@imladris.surriel.com>
X-Mailer: Mulberry/3.0.0b9 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sat, 28 Dec 2002, Tomas Szepe wrote:
> 
>> Marcelo, you've been overlooking these updates for a bit too long now
>> for your "let's throw them at -ac" to sound fair.  IMHO of course.  Also
>> remember those are both production drivers tested thoroughly in FreeBSD,
> 
> Are we talking about the old or the new aic7xxx driver ?
> 
> If it's the new driver, it's breaking on WAY too many
> machines and I have no idea why it got ever merged...
> 
> I have yet to see a machine where the new aic7xxx driver
> works. I'm sure they exist, but it doesn't work on any
> of the machines I have access to.

Thanks for all of your detailed bug reports.  Wait!  I haven't
gotten any from you.  That certainly makes it easy for me to
ignore these problems. 8-)

The main reason why the new driver "breaks" where the old one
doesn't is that the new driver does not perform an extra register
read to work-around chipsets that screw up memory mapped I/O.  There
are four solutions to this problem:

1) Insist that people buy sane hardware.

2) Perform the extra read.

3) Use programmed I/O by default and provide an option for enabling
   mememory mapped I/O.  Adaptec's Windows drivers have worked this way
   forever just because so many chipsets are broken.

4) Devise tests in the driver for catching the broken behavior and
   disabling memory mapped I/O on the fly.  The latest Linux and FreeBSD
   drivers do this and the number of systems that "suddenly work" is
   pretty amazing.

We don't live in a world where most people can tell if they are buying
sane hardware or not, so option 1 is out for the general user.  Option two
is too costly.  It is cheaper (cpu and bus cycle wise) to use PIO than to
perform the extra read on every outgoing write.  This is why the "new"
aic7xxx driver has never done this.  Option 3 makes sense if option 4 isn't
practical, but recent experience has shown that the current tests in the
aic7xxx and aic79xx drivers catch all of the known broken systems.

Unfortunately, the versions of the aic7xxx driver that are in the main
trees (both nearly a year out of date) don't have this test and, like the
"old" driver, they default to memory mapped I/O.  One of the reasons I've
been pushing so hard for this new driver to go into the tree is that 90%
of the complaints about the new driver would go away if it were updated
to a sane revision.

--
Justin

