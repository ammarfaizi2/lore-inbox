Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271491AbTGQPUS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 11:20:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271497AbTGQPUR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 11:20:17 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:524 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S271491AbTGQPTX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 11:19:23 -0400
Date: Thu, 17 Jul 2003 17:34:13 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Walt H <waltabbyh@comcast.net>, arjanv@redhat.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       davzaffiro@tasking.nl
Subject: Re: [PATCH] pdcraid and weird IDE geometry
Message-ID: <20030717173413.A2393@pclin040.win.tue.nl>
References: <3F160965.7060403@comcast.net> <1058431742.5775.0.camel@laptop.fenrus.com> <3F16B49E.8070901@comcast.net> <1058453918.9055.12.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1058453918.9055.12.camel@dhcp22.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Thu, Jul 17, 2003 at 03:58:38PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 17, 2003 at 03:58:38PM +0100, Alan Cox wrote:
> On Iau, 2003-07-17 at 15:37, Walt H wrote:
> 
> > On the second drive, it's like this:
> > capacity = 80418240, head=255, sect = 63
> > lba = capacity / (head * sect) = 5005 int or 5005.80 float
> > lba = lba * (head * sect) = 80405325 int or 80418240.01 float
> > lba = lba - sect = 80405262 int or 80418177 float
> 
> Would fixed point solve this. Start from capacity <<= 16 and then
> do the maths. That would put lba in 65536ths of a sector which
> should have the same result as your float maths

Ach Alan - I have not seen these earlier posts, but float or
fixed point here is just nonsense.

The purpose of
	A = B/C;
	A *= C;
can only be to round B down to the largest multiple of C below it.
Using infinite precision just turns this into
	A = B;

He needs the first sector of the last cylinder, in a setup where
cylinders have size 16*63 or so, but the surrounding software
thinks that it is 255*63, a mistake.

I don't know anything about these RAIDs, but possibly it would
help to give boot parameters for this disk.

Maybe he is victim of the completely ridiculous
	drive->head = 255;
in ide-disk.c.
(We have drive->head, the number of physical heads, and
drive->bios_head, the translation presently used by the BIOS -
or at least that is the intention. It is a bug if the former
is larger than 16. The latter may well be 255.)

Andries

