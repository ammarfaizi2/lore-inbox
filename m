Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261151AbTFIUBj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 16:01:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261169AbTFIUBj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 16:01:39 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:24210 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id S261151AbTFIUBi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 16:01:38 -0400
Date: Mon, 9 Jun 2003 15:15:02 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Christoph Hellwig <hch@infradead.org>
cc: Jaroslav Kysela <perex@suse.cz>, LKML <linux-kernel@vger.kernel.org>,
       ALSA development <alsa-devel@alsa-project.org>,
       <kbuild-devel@lists.sourceforge.net>
Subject: Re: 2.5 kbuild: use of '-z muldefs' for LD?
In-Reply-To: <20030609130438.A6417@infradead.org>
Message-ID: <Pine.LNX.4.44.0306091512110.19484-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Jun 2003, Christoph Hellwig wrote:

> On Mon, Jun 09, 2003 at 01:56:59PM +0200, Jaroslav Kysela wrote:
> > one object file for more targets. Example:
> > 
> > ------
> > snd-ice1712-objs := ice1712.o delta.o hoontech.o ews.o ak4xxx.o
> > snd-ice1724-objs := ice1724.o amp.o revo.o aureon.o ak4xxx.o
> > 
> > # Toplevel Module Dependency
> > obj-$(CONFIG_SND_ICE1712) += snd-ice1712.o
> > obj-$(CONFIG_SND_ICE1724) += snd-ice1724.o
> > ------
> > 
> > The ak4xxx.o module is shared and has defined a few public functions.
> > Unfortunately, the default build-in.o rule fails when targets are 
> > requested to be included into the solid kernel because the public 
> > functions are duplicated in snd-ice1712.o and snd-ice17124.o.
> > 
> > I can instruct the ld compiler to ignore the multiple definitions using 
> > '-z muldefs':
> > 
> > EXTRA_LDFLAGS = -z muldefs
> > 
> > But it seems like a hack for me.
> > Does anybody have another idea to solve my problem?
> 
> Move ak4xxx.o out of the multi-obj rules.  Just declare a new helper-
> config option CONFIG_SND_AK4XXX that gets defined by all drivers
> using it and add
> 
> obj-$(CONFIG_SND_AK4XXX)	+= ak4xxx.o

I basically second this, though you don't even need a new config variable.

	snd-ice1712-objs := ice1712.o delta.o hoontech.o ews.o
	snd-ice1724-objs := ice1724.o amp.o revo.o aureon.o

	# Toplevel Module Dependency
	obj-$(CONFIG_SND_ICE1712) += snd-ice1712.o ak4xxx.o
	obj-$(CONFIG_SND_ICE1724) += snd-ice1724.o ak4xxx.o

If you think the functions are too trivial to justify a module of their
own, you may want to consider to put them as static inline into a header
file, as someone else suggested.

--Kai



