Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265290AbUFAX41@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265290AbUFAX41 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 19:56:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265289AbUFAX41
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 19:56:27 -0400
Received: from hera.cwi.nl ([192.16.191.8]:17080 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S265284AbUFAX4Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 19:56:24 -0400
Date: Wed, 2 Jun 2004 01:55:05 +0200
From: Andries Brouwer <Andries.Brouwer@cwi.nl>
To: "Patrick J. LoPresti" <patl@users.sourceforge.net>
Cc: Sean Estabrooks <seanlkml@sympatico.ca>, szepe@pinerecords.com,
       Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
Subject: Re: 2.6.x partition breakage and dual booting
Message-ID: <20040601235505.GA23408@apps.cwi.nl>
References: <40BA2213.1090209@pobox.com> <20040530183609.GB5927@pclin040.win.tue.nl> <40BA2E5E.6090603@pobox.com> <20040530200300.GA4681@apps.cwi.nl> <s5g8yf9ljb3.fsf@patl=users.sf.net> <20040531180821.GC5257@louise.pinerecords.com> <s5gaczonzej.fsf@patl=users.sf.net> <20040531170347.425c2584.seanlkml@sympatico.ca> <s5gfz9f2vok.fsf@patl=users.sf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5gfz9f2vok.fsf@patl=users.sf.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 01, 2004 at 11:10:27AM -0400, Patrick J. LoPresti wrote:

> Now, starting with 2.6.5 Linux actually invokes INT13/AH=08h during
> real-mode startup and stashes the values away.  They are available via
> Dell's EDD module.  So, to find the Windows-compatible geometry, you
> simply:
> 
>   modprobe edd
>   cat /sys/firmware/edd/int13_dev80/{legacy_heads,legacy_sectors}
> 
> (And add 1 to the "heads" value because the legacy BIOS interface is
> freaky.)

Now that we are discussing this stuff anyway:
The names chosen are really bad, they are an invitation for
confusion and bugs.

We have "sectors" and it gives a count of sectors, like 0x7280b80
(yecch - why in hex??).
But "legacy_sectors" is not a number of sectors, but a number of
sectors per track, just like "default_sectors_per_track".

We have "default_heads" and it is a number of heads, like 0xff
(yecch - why in hex??).
But "legacy_heads" is not a number of heads, it is the largest
head number, that is, one less than the number of heads.

Please, now that this is still unused, fix your names and/or
your code. Names could be legacy_max_head (etc.) if you want
to keep the values, or otherwise add 1 to the values.

Note that sectors are counted from 1 here, so by some coincidence
legacy_max_sectors_per_track is the same as legacy_sectors_per_track.

Also - people will try to match the 0x7280b80 for int13_dev83 with
the 120064896 sectors that dmesg or hdparm -g reports for /dev/hdf.
Life would be easier with values given in decimal, as they are
everywhere else.

Andries


> There is just one catch.  This assumes BIOS device 80h (the boot
> device) is the disk you care about.  If not, you need to figure out
> which BIOS device corresponds to the disk you do care about.  This is
> the hard part, but it is not THAT hard, because the /sys/firmware/edd
> interface exposes lots of information which will help you deduce this
> correspondence.

It is basically impossible, but it is easy to give heuristics
that very often work. Very good that that now is a job left
to user space.
