Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265124AbUGCOPu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265124AbUGCOPu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jul 2004 10:15:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265125AbUGCOPu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jul 2004 10:15:50 -0400
Received: from mail-ext.curl.com ([66.228.88.132]:45828 "HELO
	mail-ext.curl.com") by vger.kernel.org with SMTP id S265124AbUGCOPs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jul 2004 10:15:48 -0400
To: Andrew Clausen <clausen@gnu.org>
Cc: Szakacsits Szabolcs <szaka@sienet.hu>,
       Andries Brouwer <Andries.Brouwer@cwi.nl>,
       Steffen Winterfeldt <snwint@suse.de>, linux-kernel@vger.kernel.org,
       Thomas Fehr <fehr@suse.de>, bug-parted@gnu.org
Subject: Re: [RFC] Restoring HDIO_GETGEO semantics (was: Re: workaround for BIOS / CHS stuff)
References: <s5gwu1mwpus.fsf@patl=users.sf.net>
	<Pine.LNX.4.21.0407021528150.21499-100000@mlf.linux.rulez.org>
	<20040703013552.GA630@gnu.org>
From: "Patrick J. LoPresti" <patl@users.sourceforge.net>
Message-ID: <s5g8ye1qjg9.fsf@patl=users.sf.net>
Date: 03 Jul 2004 10:15:47 -0400
In-Reply-To: <20040703013552.GA630@gnu.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Clausen <clausen@gnu.org> writes:

> > > Parted needs a mechanism to let me FORCE the geometry it uses.
> > > Every other partitioning tool has this, usually via command-line
> > > switch.
> 
> Would this solve any problems?  The people who get hit aren't going
> to use the switch, right?

You are thinking of Parted as an end-user tool.  But there are 1000
times as many people using Parted without even knowing it, every time
they install Linux.

Parted is primarily a component of larger systems; namely, the
RedHat/Suse/etc. installers.  Those larger systems can figure out the
correct geometry (using whatever logic/heuristics/knowledge they have)
and pass it to the tools which need it, of which Parted is just one.

In my case, my software *knows* the geometry because it got it from
/sys/firware/edd.  Right now, I use a hack (/proc/ide/hda/settings) to
override the values returned by HDIO_GETGEO.  I run Parted once to
blow away the partition table, then run it again.  With no partition
table to help it "guess", Parted falls back on the HDIO_GETGEO values,
thus using the geometry I specify.

It works, but I would rather just pass the geometry to Parted when I
run it.

I am suggesting that you cater to the 99.9% case.  This means
providing some way, any way, to override Parted's notion of the
geometry.  In my opinion, you should simply gut the logic for guessing
the geometry, because it really does not belong in Parted.  But I do
not really care as long as I have a way to bypass it.

(Note that this would also provide a way for end users to fix their
partition tables if/when they broke.  Right now, the stock solution
for disks which Parted "broke" is "sfdisk -d | sfdisk -C# -H# -S#".
Wouldn't it be nice if people could use Parted instead?)

> > 1) and 2) need a way to get a "sane" geometry from the BIOS or kernel.
> 
> Shouldn't we just use LBA?  (i.e. x/255/63)

IBM Thinkpads use x/240/63.  In theory, other BIOSes could use
anything.

But x/255/63 is usually a better guess than HDIO_GETGEO.  Except in my
application, which I could fix if Parted had command-line options to
specify the geometry.

 - Pat
