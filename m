Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030233AbWDOEbk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030233AbWDOEbk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Apr 2006 00:31:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030234AbWDOEbj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Apr 2006 00:31:39 -0400
Received: from smtp.osdl.org ([65.172.181.4]:29663 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030233AbWDOEbj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Apr 2006 00:31:39 -0400
Date: Fri, 14 Apr 2006 21:31:05 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       rpurdie@rpsys.net
Subject: Re: [Linux-fbdev-devel] Behaviour change of /dev/fb0?
Message-Id: <20060414213105.09f0dd8d.akpm@osdl.org>
In-Reply-To: <44404401.3030702@gmail.com>
References: <1145009768.6179.7.camel@localhost.localdomain>
	<44404401.3030702@gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Antonino A. Daplas" <adaplas@gmail.com> wrote:
>
> Richard Purdie wrote:
> > Ignoring whether this is a good idea or not, under 2.6.15 you could run
> > 
> > dd if=/dev/zero of=/dev/fb0
> > 
> > which would clear the framebuffer. It would end up saying "dd: /dev/fb0:
> > No space left on device".
> > 
> > Under 2.6.16 (and a recent git kernel), the same command clears the
> > screen but then hangs. Was the change in behaviour intentional? 
> > 
> > I've noticed this on a couple of ARM based Zaurus handhelds under both
> > w100fb and pxafb.
> > 
> 
> After reading 'man 2 read' more thoroughly, I've adjusted fb_write()'s
> return codes  appropriately.  Can you try this patch and let me know if it
> fixes your problem.
> 
> Tony
> 
> fbdev: Fix return error of fb_write()
> 
> - return -EFBIG if file offset is past the maximum allowable offset

OK.

> - return -EFBIG and write to end of framebuffer if size is bigger than the
>   framebuffer length

We should return the number of bytes written in this case.

> - return -ENOSPC and write to end of framebuffer if size is bigger than the
>   framebuffer length - file offset

Also here.


If we can transfer _any_ bytes, we should do so, then return the number of
bytes transferred.  If no bytes were transferrable then we should return
-Ewhatever.

