Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272322AbRHXUkd>; Fri, 24 Aug 2001 16:40:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272323AbRHXUkN>; Fri, 24 Aug 2001 16:40:13 -0400
Received: from postfix2-1.free.fr ([213.228.0.9]:5901 "HELO postfix2-1.free.fr")
	by vger.kernel.org with SMTP id <S272322AbRHXUkB> convert rfc822-to-8bit;
	Fri, 24 Aug 2001 16:40:01 -0400
Date: Fri, 24 Aug 2001 22:37:28 +0200 (CEST)
From: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr>
X-X-Sender: <groudier@gerard>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>,
        "Marc A. Lehmann" <pcg@goof.com>, <linux-kernel@vger.kernel.org>,
        <oesi@plan9.de>
Subject: Re: [resent PATCH] Re: very slow parallel read performance
In-Reply-To: <Pine.LNX.4.33L.0108241600410.31410-100000@duckman.distro.conectiva>
Message-ID: <20010824221456.U981-100000@gerard>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 24 Aug 2001, Rik van Riel wrote:

> On Fri, 24 Aug 2001, Roger Larsson wrote:
>
> > Not having the patch gives you another effect - disk arm is
> > moving from track to track in a furiously tempo...
>
> Fully agreed, but remember that when you reach the point
> where the readahead windows are pushing each other out
> you'll be off even worse.
>
> I guess in the long run we should have automatic collapse
> of the readahead window when we find that readahead window
> thrashing is going on, in the short term I think it is
> enough to have the maximum readahead size tunable in /proc,
> like what is happening in the -ac kernels.

There is some minimal heuristics in the readahead code that tries to
reduce the windows if things donnot work as expected. I donnot remember
exactly as they work. May-be I should re-read the code. What the code
wants is to perform *asynchronous* read-ahead in order to elimate IO
latency for sequential IO streaming patterns.

For hard disks connected to a fast HBA, large read-ahead is not necessary.
For example, un Cheetah drive can handle more than 8000 short IOs per
second and a SYMBIOS chip using the SYM53C8XX driver can handle more than
15000 short IOs per seconds.

The larger the read-ahead chunks, the more likely trashing will occur. In
my opinion, using more than 128 K IO chunks will not improve performances
with modern hard disks connected to a reasonnably fast controller, but
will increase memory pressure and probably thrashing.

It is a different story for some external RAID boxes that may perform
better using hudge IO chunks. Such boxes have poor firmware in my opinion.

Some tunability of the read-ahead algorithm will be useful for sure, but
not that much, in my opinion. I am under the impression that using some
MAX READ AHEAD value in the range 64K-128K and given the current
heuristics in the code, a subsystem using hard disks connected to a decent
controller will perform close to the best for most IO patterns. This let
me think, that there is no miracle to expect from a tunability of the
read-ahead. (Excepted if stupid external RAID boxes are involved,
obviously).

Regards,
  Gérard.

