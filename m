Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261159AbUFQRKX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261159AbUFQRKX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 13:10:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261181AbUFQRKX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 13:10:23 -0400
Received: from linuxhacker.ru ([217.76.32.60]:38322 "EHLO shrek.linuxhacker.ru")
	by vger.kernel.org with ESMTP id S261159AbUFQRKP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 13:10:15 -0400
Date: Thu, 17 Jun 2004 20:09:39 +0300
From: Oleg Drokin <green@linuxhacker.ru>
To: Petter Larsen <pla@morecom.no>
Cc: linux-kernel@vger.kernel.org, ext3 <ext3-users@redhat.com>
Subject: Re: mode data=journal in ext3. Is it safe to use?
Message-ID: <20040617170939.GO2659@linuxhacker.ru>
References: <40FB8221D224C44393B0549DDB7A5CE83E31B1@tor.lokal.lan> <1087322976.1874.36.camel@pla.lokal.lan> <200406160734.i5G7YZwV002051@car.linuxhacker.ru> <1087460837.2765.31.camel@pla.lokal.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1087460837.2765.31.camel@pla.lokal.lan>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Thu, Jun 17, 2004 at 10:27:17AM +0200, Petter Larsen wrote:
> > PL> Can anybody of you acknowledge or not if mode data=journal in ext3 is
> > PL> safe to use in Linux kernel 2.6.x?
> > PL> Wee need to have a very consistent and integrity for our filesystem, and
> > PL> it would then be desired to journal both data and metadata.
> > OLEG> Actually data=journal mode would gain you mostly zero extra consistency compared
> > to data=ordered mode. (the only more consistency bit that you get is
> > correct mtime on files that have their pages overwritten, I think).
> > You have zero control over transaction boundaries in ext3, so you still need
> > to design your applications in such a way that they have their own
> > sort of transactions (if this is needed).
> So your conclusion is that data=journal mode is useless if you do not
> want a correct mtime?

Well, yes.

> It would be a littles sense in developing the data=journal mode if this
> is the only benefit, don't you think?
> >From the Linux/Documentation/filesystems/ext3.txt
> data=journal            All data are committed into the journal prior
>                         to being written into the main file system.
> data=ordered    (*)     All data are forced directly out to the main
> file                    system prior to its metadata being committed to
>                         the journal.
> My problem is that ext3 in the latest kernel, 2.6.x and the latest
> 2.4.x, are not well documented around the web. Whitepapers and so are
> pretty old. Much have changed I belive in ext3 since it was first
> introduced by Dr. Tweedie. The first release was journaling both data
> and metadata, se also the transcript from Dr. Tweedie from the Ottawa
> Linux Symposium 20th July 2000.
> http://olstrans.sourceforge.net/release/OLS2000-ext3/OLS2000-ext3.html
> There he says that they are journaling both metadata and data, but that
> the design goal is not to do that. So can this be interpreted that mode
> data=journal is only there for historic reasons?

May be so. Also fsync heavy loads on real disk devices with large journals
tend to benefit from journaled data mode as well.

> > PL> Data integrity is much more important for us than speed.
> > 
> > OLEG> It is not clear what sort of extra data integrity do you expect from data
> > journaling mode and why do you think it is there.
> I would belive that the goal for such a mode data=journal would gain
> extra data integrity because it also journals data. Why should it not? I

Well, actually I bet you do not care if the data goes through journal or not
as long as it is not lost.
In case of ordered journaling mode, data is written first before metadata
updates, mostly the same happens with data journal mode, only with the latter
case date is written into journal and if transaction was not committed, after
a reboot it won't be copied to where it should be, same scenario in ordered
journal mode will result in data getting where it should be, but due to
lack of metadata updates, you won't see it. (this is in case of append,
for overwrite it will be a little bit different, but still you have no
control over how much of stuff will be overwritten).

> would belive that it makes sense to have these different modes so people
> can choose the best mode for there applications.

True.

> > OLEG> Garbage in files should not happen in data ordered mode as data pages are
> > written first before metadata updates are committed.
> Are you sure?

If you can reproduce a garbage in files in ordered journal mode, that would be a
bug that should be fixed then.

Bye,
    Oleg
