Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932155AbVILVx6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932155AbVILVx6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 17:53:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932277AbVILVx6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 17:53:58 -0400
Received: from 66-23-228-155.clients.speedfactory.net ([66.23.228.155]:51893
	"EHLO kevlar.burdell.org") by vger.kernel.org with ESMTP
	id S932155AbVILVx5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 17:53:57 -0400
Date: Mon, 12 Sep 2005 17:49:45 -0400
From: Sonny Rao <sonny@burdell.org>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: "Andrew Morton <Andrew Morton" <akpm@osdl.org>, <""@osdl.org>,
       linux-kernel@vger.kernel.org, linuxppc64-dev@ozlabs.org
Subject: Re: 2.6.13-mm3
Message-ID: <20050912214945.GA17729@kevlar.burdell.org>
Mail-Followup-To: Sonny Rao <sonny@burdell.org>,
	Jiri Slaby <jirislaby@gmail.com>,
	"Andrew Morton <Andrew Morton" <akpm@osdl.org>, <""@osdl.org>,
	linux-kernel@vger.kernel.org, linuxppc64-dev@ozlabs.org
References: <20050912194032.GA12426@kevlar.burdell.org> <200509122106.j8CL6WPk006092@wscnet.wsc.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509122106.j8CL6WPk006092@wscnet.wsc.cz>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 12, 2005 at 11:06:32PM +0200, Jiri Slaby wrote:
> > I'm getting some build errors on ppc64 in drivers/char/hvc_console.c
> > 
> > 
> >   CC      drivers/char/hvc_console.o
> > drivers/char/hvc_console.c: In function `hvc_poll':
> > drivers/char/hvc_console.c:600: error: `count' undeclared (first use in this
> > function)
> > drivers/char/hvc_console.c:600: error: (Each undeclared identifier is reported
> > only once
> > drivers/char/hvc_console.c:600: error: for each function it appears in.)
> > drivers/char/hvc_console.c:636: error: structure has no member named `flip'
> > make[1]: *** [drivers/char/hvc_console.o] Error 1
> > make: *** [_module_drivers/char] Error 2
> > 
> > The count undeclared one was easy to fix but I coldn't fix the filp
> > structure element in 2-3 minutes so I'm punting.
> > 
> > Anyone have a patch to fix this driver?
> 
> Try this:
> ---

Hmm, that didn't build.  I made my own version based on yours,
unfortunately I don't know if it boots because all my network just went
down.  Hopefully, someone will confirm that the fix is correct.


--- linux-2.6.13-mm3/drivers/char/hvc_console.c~orig	2005-09-12 16:37:14.434077464 -0500
+++ linux-2.6.13-mm3/drivers/char/hvc_console.c	2005-09-12 16:37:25.466998360 -0500
@@ -597,7 +597,7 @@ static int hvc_poll(struct hvc_struct *h
 
 	/* Read data if any */
 	for (;;) {
-		count = tty_buffer_request_room(tty, N_INBUF);
+		int count = tty_buffer_request_room(tty, N_INBUF);
 
 		/* If flip is full, just reschedule a later read */
 		if (count == 0) {
@@ -633,7 +633,7 @@ static int hvc_poll(struct hvc_struct *h
 			tty_insert_flip_char(tty, buf[i], 0);
 		}
 
-		if (tty->flip.count)
+		if (tty->buf.tail->used)
 			tty_schedule_flip(tty);
 
 		/*

