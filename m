Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279956AbRJaCcq>; Tue, 30 Oct 2001 21:32:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279962AbRJaCch>; Tue, 30 Oct 2001 21:32:37 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:21912 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S279956AbRJaCcd>;
	Tue, 30 Oct 2001 21:32:33 -0500
Date: Tue, 30 Oct 2001 21:33:09 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: John Levon <moz@compsoc.man.ac.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: rmmod whilst reading/writing sysctl
In-Reply-To: <20011031022104.C22156@compsoc.man.ac.uk>
Message-ID: <Pine.GSO.4.21.0110302128330.3707-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 31 Oct 2001, John Levon wrote:

> 
> Where is the prevention of module unload whilst a sysctl from a module is being read/written ?
> 
> sysctl syscall is protected by BKL, but I can't see similar code for the cat >/proc/sys/...

... and that protection is worth nothing, since we copy data to/from
userland.  Forget about BKL - it doesn't prevent races.

There is a shitload of rmmod (and plain "we remove the object" - it doesn't
have to be a module) races in that area.  Composite trees _suck_.  sysctls,
devfs, ddfs - whatever.  If tree is served by several drivers - it's broken.

In case of sysctls I have an old patch that could be turned into something
working, but that will take a lot of changes in code that exports sysctls,
so that may be very painful.

