Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275350AbTHSFRk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 01:17:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275340AbTHSFRj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 01:17:39 -0400
Received: from waste.org ([209.173.204.2]:689 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S275350AbTHSFO1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 01:14:27 -0400
Date: Tue, 19 Aug 2003 00:14:00 -0500
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, davej@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: Debug: sleeping function called from invalid context
Message-ID: <20030819051400.GK16387@waste.org>
References: <20030815101856.3eb1e15a.rddunlap@osdl.org> <20030815173246.GB9681@redhat.com> <20030815123053.2f81ec0a.rddunlap@osdl.org> <20030816070652.GG325@waste.org> <20030818140729.2e3b02f2.rddunlap@osdl.org> <20030819001316.GF22433@redhat.com> <20030818171545.5aa630a0.akpm@osdl.org> <32789.4.4.25.4.1061263463.squirrel@www.osdl.org> <20030818203513.393c4a48.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030818203513.393c4a48.akpm@osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 18, 2003 at 08:35:13PM -0700, Andrew Morton wrote:
> "Randy.Dunlap" <rddunlap@osdl.org> wrote:
> >
> > Debug: sleeping function called with interrupts disabled at
> >  include/asm/uaccess.h:473
> 
> OK, now my vague understanding of what's going on is that the app has
> chosen to disable local interupts (via iopl()) and has taken a vm86 trap. 
> I guess we'd see the same thing if the app performed some sleeping syscall
> while interrupts are disabled.

Ok, I think I've managed to reproduce this and show that it's not a
case of calling syscalls with interrupt disabled.

There's a utility called savetextmode that's part of svgalib (apt-get
svgalib-bin for Debian folks). If you configure it to use VESA, it
will call out to your video card bios and reproduce the error, just as
I expected.

I had kgdb handy and already running on a machine, so I set a
breakpoint in sys_vm86old (X would use sys_vm86, but the results would
be the same) and traced into it. About the first thing it does is call
copy_from_user, which checks might_sleep, which remained silent.

-- 
Matt Mackall : http://www.selenic.com : of or relating to the moon
