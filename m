Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266703AbUJIL3k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266703AbUJIL3k (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 07:29:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266704AbUJIL3k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 07:29:40 -0400
Received: from us1.server44secre01.de ([80.190.243.163]:10468 "EHLO
	us1.server44secre01.de") by vger.kernel.org with ESMTP
	id S266703AbUJIL3h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 07:29:37 -0400
Date: Sat, 9 Oct 2004 13:28:39 +0200
To: Gerd Knorr <kraxel@bytesex.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: video_usercopy() enforces change of VideoText IOCTLs since 2.6.8
Message-ID: <20041009112839.GA2908@t-online.de>
References: <20041007165410.GA2306@t-online.de> <20041008105219.GA24842@bytesex> <20041008140056.72b177d9.akpm@osdl.org> <20041009092801.GC3482@bytesex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041009092801.GC3482@bytesex>
User-Agent: Mutt/1.3.28i
From: linux@MichaelGeng.de (Michael Geng)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 09, 2004 at 11:28:01AM +0200, Gerd Knorr wrote:
> > >  	/*  Copy arguments into temp kernel buffer  */
> > >  	switch (_IOC_DIR(cmd)) {
> > >  	case _IOC_NONE:
> > > -		parg = NULL;
> > > +		parg = (void*)arg;
> > >  		break;
> > 
> > (the typecast is unneeded)
> > 
> > Seems that with this change we are now sometimes passing a user pointer
> > into (*func)().  And we're sometimes passing a kernel pointer, yes?
> 
> Assuming that ioctls passing _pointers_ are declared correctly with _IO*
> that shouldn't be the case:  _IOC_DIR(cmd) == _IOC_NONE means _IO()
> means no pointer passed in.
> 
> > Are all the implementations of (*func)() handling that correctly?
> 
> Hmm, it broke for videotext, checking ...
> 
> Ok, you can drop it.  The videotext ioctls (include/videotext.h) don't
> use the _IO*() macros but pass around pointers anyway, thats bad.
> 
> Michael, you'll have to fix the saa5246a driver.  video_usercopy() will
> not work for you because the videotext ioctls doesn't use the _IO()
> macros.  You have to do the userspace copying in the driver yourself.

I would prefer fixing the IOCTLs in include/linux/videotext.h. These definitions
are older than the _IO macros in linux/ioctl.h AFAIK. So it is clear that they 
can't conform to that definition. I would prefer redefining them with respect
to the arguments passed to the IOCTLs.

This would be a little step towards unifying the kernel. Implementing a private
usercopy in saa5246a.c and saa5249.c would be the opposite. 

The concept with the _IO() macros is good and helps preventing errors in the
use of IOCTLs. So also the videotext drivers should use it.

Nevertheless there is one big disadvantage: The userspace programs 
have to be recompiled because they of course have to use the same IOCTL 
definitions. 

Nevertheless, affected are only saa5246a.c and saa5249.c. I think that there
are not many people left in the world using these drivers. So I think we can
afford to make a break here.

Do you agree? If so then I will work out a patch.

Michael
