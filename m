Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266068AbUALGuL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 01:50:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266069AbUALGuL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 01:50:11 -0500
Received: from waste.org ([209.173.204.2]:8349 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S266068AbUALGuD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 01:50:03 -0500
Date: Mon, 12 Jan 2004 00:49:23 -0600
From: Matt Mackall <mpm@selenic.com>
To: George Anzinger <george@mvista.com>
Cc: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>,
       "Amit S. Kale" <amitkale@emsyssoft.com>
Subject: Re: kgdb cleanups
Message-ID: <20040112064923.GX18208@waste.org>
References: <20040109183826.GA795@elf.ucw.cz> <3FFF2304.8000403@mvista.com> <20040110044722.GY18208@waste.org> <3FFFB3D6.1050505@mvista.com> <20040110175607.GH18208@waste.org> <400233A5.8080505@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <400233A5.8080505@mvista.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 11, 2004 at 09:41:57PM -0800, George Anzinger wrote:
> For the internal kgdb stuff I have created kdgb_local.h which I intended to 
> be local to the workings of kgdb and not to contain anything a user would 
> need.

Agreed, I just haven't touched it since you last mentioned it.

> >+struct kgdb_hook {
> >+	char *sendbuf;
> >+	int maxsend;
> 
> I don't see the need of maxsend, or sendbuff, for that matter, as kgdb uses 
> it now (for the eth code) it is redundant, in that the eth putchar also 
> does the same thing as is being done in the kgdb_stub.c code.  I think this 
> should be removed from the stub and the limit in the ethcode relied upon.

Fair enough.

> > void
> > putDebugChar(int c)
> > {
> >-	if (!kgdboe) {
> >-		tty_putDebugChar(c);
> >-	} else {
> >-		eth_putDebugChar(c);
> >-	}
> >+	if (kh)
> >+		kh->putchar(c);
> > }
> 
> I was thinking that this might read something like:
>          if (xxx[kh].putchar(c))
>                 xxx[kh].putchar(c);
> 
> One might further want to do something like:
>          if (!xxx[kh].putchar(c))
>                 kh = 0;
> 
> In otherwords, an array (xxx must, of course, be renamed) of stuct 
> kgdb_hook (which name should also be changed to relate to I/O, 
> kgdb_IO_hook, for example). Then reserve entry 0 for the rs232 I/O code.  

Dunno about that. Probably should work more like the console code,
whoever registers first wins. Early boot will probably be the
exclusive province of serial for a while yet, but designing it in is
probably short-sighted.

>  An alternate possibility is an array of pointer to struct kgdb_hook which 
> allows one to define the struct contents as below and to build the array, 
> all at compile/link time.  A legal entry MUST define get and put, but why 
> not define them all, using dummy functions for the ones that make no sense 
> in a particular interface.

Throwing all the stubs in a special section could work well too. Then
we could add an avail() function so that early boot debugging could
discover if each one was available. The serial code could use this to
kickstart itself while the eth code could test a local initialized
flag and say "not a chance". Which gives us all the architecture to
throw in other trivial interfaces (parallel, bus-snoopers, etc.).

-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
