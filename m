Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264093AbUECVyi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264093AbUECVyi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 17:54:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264076AbUECVyi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 17:54:38 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:25767 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264093AbUECVyg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 17:54:36 -0400
Date: Mon, 3 May 2004 22:54:34 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       davidm@hpl.hp.com, bunk@fs.tum.de, eyal@eyal.emu.id.au,
       linux-dvb-maintainer@linuxtv.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-rc3: modular DVB tda1004x broken
Message-ID: <20040503215434.GI17014@parcelfarce.linux.theplanet.co.uk>
References: <20040501201342.GL2541@fs.tum.de> <Pine.LNX.4.58.0405011536300.18014@ppc970.osdl.org> <20040501161035.67205a1f.akpm@osdl.org> <Pine.LNX.4.58.0405011653560.18014@ppc970.osdl.org> <20040501175134.243b389c.akpm@osdl.org> <16534.35355.671554.321611@napali.hpl.hp.com> <Pine.LNX.4.58.0405031336470.1589@ppc970.osdl.org> <20040503140251.274e1239.akpm@osdl.org> <20040503211607.GG17014@parcelfarce.linux.theplanet.co.uk> <20040503212450.GC31580@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040503212450.GC31580@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 03, 2004 at 11:24:50PM +0200, Jörn Engel wrote:
> On Mon, 3 May 2004 22:16:07 +0100, viro@parcelfarce.linux.theplanet.co.uk wrote:
> > 
> > I'd rather kill open() completely - we only have a handful of in-tree users
> > and there's no good reason to keep that crap, AFAICS.  I'm gathering the
> > list of in-tree callers of open()/lseek()/close() and so far a lot of them
> > look buggy.  More on that later...
> 
> Do you know how many of those exist purely for the purpose of passing
> a struct file to one of the various read/write functions?

Let's see...  Leaving aside obvious userland code (arch/*/boot/*, scripts/*,
drivers/char/ip2/ helpers) and arch/um/* instances that are, AFAICS, in
userland code too and refer to libc open(2), we have
	a) drivers/media/dvb/frontends pile (AFAICS, loading firmware)
	b) systemcfg_init() in asm-ppc64/systemcfg.h (WTF is that about?)
	c) sound/isa/wavefront/wavefront_synth.c (loading firmware)
	d) sound/oss/wavfront.c (loading firmware)
	e) odd calls of sys_close() in binfmt_elf.c, eventpoll.c and socket.c
	f) potentially racy flush_unauthorized_files() in selinux code - uses
sys_close() in a strange way.

That's it.  And I suspect that we ought to switch the firmware loaders to
use of existing helper.
