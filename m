Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266616AbUJIJkd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266616AbUJIJkd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 05:40:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266626AbUJIJkd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 05:40:33 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:6048 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S266616AbUJIJkb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 05:40:31 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Sat, 9 Oct 2004 11:28:01 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux@MichaelGeng.de, linux-kernel@vger.kernel.org,
       "viro@parcelfarce.linux.theplanet.co.uk" 
	<viro@parcelfarce.linux.theplanet.co.uk>
Subject: Re: video_usercopy() enforces change of VideoText IOCTLs since 2.6.8
Message-ID: <20041009092801.GC3482@bytesex>
References: <20041007165410.GA2306@t-online.de> <20041008105219.GA24842@bytesex> <20041008140056.72b177d9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041008140056.72b177d9.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >  	/*  Copy arguments into temp kernel buffer  */
> >  	switch (_IOC_DIR(cmd)) {
> >  	case _IOC_NONE:
> > -		parg = NULL;
> > +		parg = (void*)arg;
> >  		break;
> 
> (the typecast is unneeded)
> 
> Seems that with this change we are now sometimes passing a user pointer
> into (*func)().  And we're sometimes passing a kernel pointer, yes?

Assuming that ioctls passing _pointers_ are declared correctly with _IO*
that shouldn't be the case:  _IOC_DIR(cmd) == _IOC_NONE means _IO()
means no pointer passed in.

> Are all the implementations of (*func)() handling that correctly?

Hmm, it broke for videotext, checking ...

Ok, you can drop it.  The videotext ioctls (include/videotext.h) don't
use the _IO*() macros but pass around pointers anyway, thats bad.

Michael, you'll have to fix the saa5246a driver.  video_usercopy() will
not work for you because the videotext ioctls doesn't use the _IO()
macros.  You have to do the userspace copying in the driver yourself.

  Gerd

-- 
return -ENOSIG;
