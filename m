Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261873AbVBPDMw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261873AbVBPDMw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 22:12:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261890AbVBPDMw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 22:12:52 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:57515 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S261873AbVBPDMu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 22:12:50 -0500
Date: Wed, 16 Feb 2005 04:12:34 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Linus Torvalds <torvalds@osdl.org>
cc: Andreas Schwab <schwab@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: Pty is losing bytes
In-Reply-To: <Pine.LNX.4.58.0502151239160.2330@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.61.0502160405410.15339@scrub.home>
References: <jebramy75q.fsf@sykes.suse.de> <Pine.LNX.4.58.0502151053060.5570@ppc970.osdl.org>
 <je1xbhy3ap.fsf@sykes.suse.de> <Pine.LNX.4.58.0502151239160.2330@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 15 Feb 2005, Linus Torvalds wrote:

> > I've also seen more than one byte missing.  For example when sending a big
> > chunk of bytes down the pty via an Emacs *shell* buffer up to 16 bytes are
> > missing somewhere in the middle.
> 
> If it's NTTY (and I'm pretty certain it is - the generic tty code looks 
> fine, the pty code itself is too simple for words), then I'd actually have 
> expected more variability than a simple off-by-one. 

The patch below seems to do the trick too.
It seems the initial receive_room() call in pty_write() returns 
N_TTY_BUF_SIZE and receive_buf() will happily drop the last byte.

bye, Roman


 n_tty.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6/drivers/char/n_tty.c
===================================================================
--- linux-2.6.orig/drivers/char/n_tty.c	2005-02-16 03:53:53.000000000 +0100
+++ linux-2.6/drivers/char/n_tty.c	2005-02-16 03:56:39.000000000 +0100
@@ -863,7 +863,7 @@ static int n_tty_receive_room(struct tty
 	 * characters will be beeped.
 	 */
 	if (tty->icanon && !tty->canon_data)
-		return N_TTY_BUF_SIZE;
+		return N_TTY_BUF_SIZE - 1;
 
 	if (left > 0)
 		return left;
