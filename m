Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267175AbUGMWdB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267175AbUGMWdB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 18:33:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267179AbUGMWdA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 18:33:00 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:1753 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S267175AbUGMWcm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 18:32:42 -0400
Subject: Re: [linux-audio-dev] Re: [announce] [patch] Voluntary Kernel
	Preemption Patch
From: Lee Revell <rlrevell@joe-job.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-audio-dev@music.columbia.edu, mingo@elte.hu, arjanv@redhat.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20040713022919.67c991db.akpm@osdl.org>
References: <20040709182638.GA11310@elte.hu>
	 <20040710222510.0593f4a4.akpm@osdl.org>
	 <1089673014.10777.42.camel@mindpipe>
	 <20040712163141.31ef1ad6.akpm@osdl.org>
	 <1089677823.10777.64.camel@mindpipe>
	 <20040712174639.38c7cf48.akpm@osdl.org>
	 <1089687168.10777.126.camel@mindpipe>
	 <20040712205917.47d1d58b.akpm@osdl.org>
	 <1089707483.20381.33.camel@mindpipe>
	 <20040713014316.2ce9181d.akpm@osdl.org>
	 <1089708818.20381.36.camel@mindpipe>
	 <20040713020025.7400c648.akpm@osdl.org>
	 <1089710638.20381.41.camel@mindpipe>
	 <20040713022919.67c991db.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1089756594.3347.4.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 13 Jul 2004 18:32:41 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-07-13 at 05:29, Andrew Morton wrote:
> Lee Revell <rlrevell@joe-job.com> wrote:
> >
> > On Tue, 2004-07-13 at 05:00, Andrew Morton wrote:
> > > Lee Revell <rlrevell@joe-job.com> wrote:
> > > >
> > > > > framebuffer scrolling inside lock_kernel().  Tricky.  Suggest you use X or
> > > >  > vgacon.  You can try removing the lock_kernel() calls from do_tty_write(),
> > > >  > but make sure you're wearing ear protection.
> > > >  > 
> > > > 
> > > >  OK, I figured this was not an easy one.  I can just not do that.
> > > 
> > > Why not?  You can certainly try removing those [un]lock_kernel() calls.
> > > 
> > 
> > Maybe I missed something.  What exactly do you mean by 'make sure you're
> > wearing ear protection'?
> > 
> 
> It might go boom.  If it does screw up, it probably won't be very seriously
> bad - maybe some display glitches.  Just an experiment.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Seems to work perfectly.  No visible display glitches.

I would imagine that putting a modem on a tty, then stressing the system
and watching for line errors would be a definitive test.

--- drivers/char/tty_io.c.orig  2004-07-13 16:55:28.000000000 -0400
+++ drivers/char/tty_io.c       2004-07-13 16:55:51.000000000 -0400
@@ -684,17 +684,13 @@
                return -ERESTARTSYS;
        }
        if ( test_bit(TTY_NO_WRITE_SPLIT, &tty->flags) ) {
-               lock_kernel();
                written = write(tty, file, buf, count);
-               unlock_kernel();
        } else {
                for (;;) {
                        unsigned long size = max((unsigned long)PAGE_SIZE*2, 16384UL);
                        if (size > count)
                                size = count;
-                       lock_kernel();
                        ret = write(tty, file, buf, size);
-                       unlock_kernel();
                        if (ret <= 0)
                                break;
                        written += ret;

Lee

