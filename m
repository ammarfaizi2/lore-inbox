Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271342AbRHOSKE>; Wed, 15 Aug 2001 14:10:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271343AbRHOSJy>; Wed, 15 Aug 2001 14:09:54 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:9995 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S271342AbRHOSJw>; Wed, 15 Aug 2001 14:09:52 -0400
Message-ID: <3B7ABAEC.FA3797F8@zip.com.au>
Date: Wed, 15 Aug 2001 11:09:49 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.8-ac5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Udo A. Steinberg" <reality@delusion.de>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.8-ac5
In-Reply-To: <20010814221556.A7704@lightning.swansea.linux.org.uk> <3B79B43D.B9350226@delusion.de> <3B79C3A9.52562F71@zip.com.au> <3B79D26E.CD912961@delusion.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Udo A. Steinberg" wrote:
> 
> Andrew Morton wrote:
> >
> > Interesting that kpnpbiosd has a ppid of zero, whereas keventd, which
> > is started a few statements later has a ppid of one.  hmmm..
> 
> [...]
> 
> > I bet this ancient reparent-kernel-thread-to-init patch fixes it.  It always
> > does.
> 
> It does indeed. Nice work, Andrew - works like a charm. Formerly the kpnpbios
> thread never exited, which is why the problem never showed, now it exits ok.
> I've rediffed your patch against 2.4.8-ac5, because I was getting rejects -
> in case Alan wants to apply it to his tree.
> 

I think it's not ready.  One possible problem is if a process
starts a kernel thread, then that thread calls daemonize() and
then someone waits on the thread's exit.  With this patch they'll
hang, because the thread switched parents.  I don't know if that
happens at present, but I suspect a better API is to make 
reparent_to_init() a standalone API function, and call that from
places where it's appropriate.

Also, it should do other things like set the thread's UID, scheduling
parameters, etc to something sane (just copy them in from init_task).

So sigh.  I guess I need to finish this off.  But right now
I'm having too much fun writing
prepopulate-the-pagecache-with-stuff-to-make-it-boot-faster.c :)

-
