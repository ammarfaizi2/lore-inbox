Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272588AbTG1AUy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 20:20:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272582AbTG1AGJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 20:06:09 -0400
Received: from fw.osdl.org ([65.172.181.6]:61409 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S272475AbTG0XXD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 19:23:03 -0400
Date: Sun, 27 Jul 2003 16:38:12 -0700
From: Andrew Morton <akpm@osdl.org>
To: Chris Ruvolo <chris@ruvolo.net>
Cc: linux-kernel@vger.kernel.org, alsa-devel@lists.sourceforge.net,
       Jaroslav Kysela <perex@suse.cz>, Adam Belay <ambx1@neo.rr.com>
Subject: Re: 2.6.0-t1 garbage in /proc/ioports and oops
Message-Id: <20030727163812.75b98b02.akpm@osdl.org>
In-Reply-To: <20030718150429.GE15716@ruvolo.net>
References: <20030718011101.GD15716@ruvolo.net>
	<20030717211533.77c0f943.akpm@osdl.org>
	<20030718150429.GE15716@ruvolo.net>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Ruvolo <chris@ruvolo.net> wrote:
>
> (adding alsa-devel)
> 
> On Thu, Jul 17, 2003 at 09:15:33PM -0700, Andrew Morton wrote:
> > You could load all those modules one at a time, doing a `cat /proc/ioports'
> > after each one.  One sneaky way of doing that would be to make your
> > modprobe executable be:
> 
> Ok, this let me track it down to the ALSA snd-sbawe module.  I did not have
> isapnp compiled into the kernel and was relying on the userspace isapnp to
> configure the device (carried over from 2.4).  Apparently the module didn't
> like this.

OK, thanks for that.

>From my reading, snd_sb16_probe() is, in the case of !CONFIG_PNP, doing:

	/* block the 0x388 port to avoid PnP conflicts */
	acard->fm_res = request_region(0x388, 4, "SoundBlaster FM");

but this reservation is never undone.  So later, after the module is
unloaded, a read of /proc/ioports is oopsing when trying to access that
string "SoundBlaster FM".  Because it now resides in vfree'd memory.

The fix would be to run release_region() either at the end of
snd_sb16_probe() or on module unload.

Adam or Jaroslav, could you please take care of this?

Thanks.
