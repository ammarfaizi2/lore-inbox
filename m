Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265115AbUFRLbF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265115AbUFRLbF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 07:31:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265117AbUFRLbF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 07:31:05 -0400
Received: from [195.23.16.24] ([195.23.16.24]:11179 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S265115AbUFRLa7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 07:30:59 -0400
Subject: Re: mode data=journal in ext3. Is it safe to use?
From: Paulo Marques <pmarques@grupopie.com>
Reply-To: pmarques@grupopie.com
To: Oleg Drokin <green@linuxhacker.ru>
Cc: Helge Hafting <helge.hafting@hist.no>, Petter Larsen <pla@morecom.no>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       ext3 <ext3-users@redhat.com>
In-Reply-To: <20040618101520.GA2389@linuxhacker.ru>
References: <40FB8221D224C44393B0549DDB7A5CE83E31B1@tor.lokal.lan>
	 <1087322976.1874.36.camel@pla.lokal.lan>
	 <200406160734.i5G7YZwV002051@car.linuxhacker.ru>
	 <1087460837.2765.31.camel@pla.lokal.lan>
	 <20040617170939.GO2659@linuxhacker.ru> <40D2B8C3.8090908@hist.no>
	 <20040618101520.GA2389@linuxhacker.ru>
Content-Type: text/plain
Organization: Grupo PIE
Message-Id: <1087558255.25904.14.camel@pmarqueslinux>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Fri, 18 Jun 2004 12:30:55 +0100
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.25.0.62; VDF: 6.25.0.101; host: bipbip)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-06-18 at 11:15, Oleg Drokin wrote:
> Hello!
> 
> On Fri, Jun 18, 2004 at 11:41:23AM +0200, Helge Hafting wrote:
> 
> > >If you can reproduce a garbage in files in ordered journal mode, that 
> > >would be a
> > >bug that should be fixed then.
> > Hard to _produce_, but consider:
> > 1. Write data to an existing file
> > 2. Sync metadata
> > 3. data is forced out because of ordered mode, a powerout crash happens
> >    in the middle of this. The file now has a block with a mix of new 
> > and old,
> 
> Well, this is not much worse than having two blocks, one from old file
> and one from new after a crash.

Agree. If the application needs consistency it must do some journaling
itself. At least, until the time when an application can say "start
transaction" "commit transaction" to the file system itself.

> >    it may even be unreadable due to a bad sector checksum.
> 
> Well, in data journaled mode you may get unreadable journal, is this much
> better? (Also original question was about CF flash media, so no bad sector
> problems I presume).

You got it wrong here. The sentence was "bad sector checksum", not "bad
sector". If the sector was "half written", then the checksum would not
match.

If the journal is "half written" then it is just discarded (or at least
it should be).

> > With data journalling you either get the old data (because the crash 
> > happened
> > during a write to the journal) or new data (crash happened during data 
> > write,
> 
> Well, while with data journaling mode your granularity is one block,
> with data ordered it is one sector.

Imagine that you request a 2Mb write to an ext3 filesystem with an 1Mb
journal. There is *no way* the filesystem can do the write in an atomic
operation. (there would be if the filesystem wrote the data to free
blocks and updated the metadata through the journal)

The point is, there is no concept of "atomic operation" at the file
system level, so the application must do journaling itself if it wants
to have some concept of "transactions".

>From my experience with CF cards, there are some brands that do
wear-leveling (I know that at least the TwinMOS ones do, and probably
SanDisk too) and others that don't (Kingmax). 

With a bad CF card and an ext3 filesystem you can get bad sectors in a
couple of hours doing some intensive writing. 

A good CF card will sustain "normal use" (2 writes per minute average)
and an ext3 filesystem for months (maybe years, I still didn't went that
far in time :)

Just my two cents,

-- 
Paulo Marques - www.grupopie.com
"In a world without walls and fences who needs windows and gates?"

