Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751210AbWE2Fwa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751210AbWE2Fwa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 01:52:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751211AbWE2Fwa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 01:52:30 -0400
Received: from xenotime.net ([66.160.160.81]:5837 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751210AbWE2Fw3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 01:52:29 -0400
Date: Sun, 28 May 2006 22:55:06 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Con Kolivas <kernel@kolivas.org>, kraxel@suse.de
Cc: anemo@mba.ocn.ne.jp, linux-kernel@vger.kernel.org, sam@ravnborg.org
Subject: Re: gcc 4.1.1 issues with 2.6.17-rc5
Message-Id: <20060528225506.2ad0979b.rdunlap@xenotime.net>
In-Reply-To: <200605291452.26423.kernel@kolivas.org>
References: <200605281255.49821.kernel@kolivas.org>
	<20060527223945.05cd5b5b.rdunlap@xenotime.net>
	<20060529.013226.108739444.anemo@mba.ocn.ne.jp>
	<200605291452.26423.kernel@kolivas.org>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 May 2006 14:52:25 +1000 Con Kolivas wrote:

> On Monday 29 May 2006 02:32, Atsushi Nemoto wrote:
> > On Sat, 27 May 2006 22:39:45 -0700, "Randy.Dunlap" <rdunlap@xenotime.net> 
> wrote:
> > > > and a missed one:
> > > > WARNING: drivers/usb/storage/usb-storage.o - Section mismatch:
> > > > reference to .exit.text: from .smp_locks after '' (at offset 0x40)
> > >
> > > Yep, Jesper posted that one.
> > > I also see it in ieee1394.o.
> > >
> > > So where does the .smp_locks section come from?
> > > Is this just a section checker bug/issue?
> >
> > The .smp_locks section comes from LOCK_PREFIX on x86.  I think the
> > warnings was not shown previously just because the modpost did not
> > check SHT_REL sections.
> >
> > Maybe we should fix the modpost to ignore it, but I'm not sure.  Is it
> > really safe to ignore?  I'm not a x86 expert ...
> 
> A "scary but harmless" comment from someone in the know would be nice.

Yes, I understand your remark.
I have looked at the twisty maze of alternatives code, but Gerd
(added to To:) is really who needs to reply IMO.

Based on my source code reading, it is just scary but harmless.
alternatives_smp_unlock() and alternatives_smp_lock() are passed
beginning and end addresses of text sections and they ignore
(init/exit) code addresses that are outside of the text code
range.
One comment says:
	/* .text segment, needed to avoid patching init code ;) */
and the code does appear to implement that.

I would make one small change to the code, however.
In alternatives_smp_lock() and alternatives_smp_unlock(), change

		if (*ptr > text_end)
			continue;
to
		if (*ptr >= text_end)
			continue;
because text_end is text_start + text_size, so text_end could be
the beginning of the next section.  However, in practice this
may not matter.

---
~Randy
