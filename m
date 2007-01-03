Return-Path: <linux-kernel-owner+w=401wt.eu-S1750985AbXACR1I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750985AbXACR1I (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 12:27:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750987AbXACR1I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 12:27:08 -0500
Received: from smtp010.mail.ukl.yahoo.com ([217.12.11.79]:29535 "HELO
	smtp010.mail.ukl.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750986AbXACR1H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 12:27:07 -0500
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Wed, 03 Jan 2007 12:27:06 EST
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=eRkykNIYTyceQkkEaD+J6QvdlQfbE5S46j55+RxxmtX56VeHUo+CHrbxfsrjGCOKFk49KxnI8oskSfyGk+ivHmuqyJYVfurrhKVFTdCMfZ4pk8v7pAYEtA5EsRL3WHRzVoElyFfryHkMOB4D361eU6tLci+TE2pwkBIMg9BAK54=  ;
X-YMail-OSG: eT83WocVM1mA1G8TC2mhmYoyrNcBB9iHM4PRR2SsanQNk1DiZEYsH0QxRSGRNu4TzJFf8rDp8AT.bzNez0yjjKhZa5x1KdHIKqblRA7yIgqmxzPQ3OnWr8L9CgTgdpFQRNUW2E21AuR9
From: Blaisorblade <blaisorblade@yahoo.it>
To: user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] [PATCH 1/6] UML - Console locking fixes
Date: Wed, 3 Jan 2007 16:07:34 +0100
User-Agent: KMail/1.9.5
Cc: Jeff Dike <jdike@addtoit.com>, akpm@osdl.org, linux-kernel@vger.kernel.org
References: <200612292341.kBTNfR3s005529@ccure.user-mode-linux.org>
In-Reply-To: <200612292341.kBTNfR3s005529@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701031607.34683.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 30 December 2006 00:41, Jeff Dike wrote:
> Clean up the console driver locking.  There are various problems here,
> including sleeping under a spinlock and spinlock recursion, some of
> which are fixed here.  This patch deals with the locking involved with
> opens and closes.  The problem is that an mconsole request to change a
> console's configuration can race with an open.  Changing a
> configuration should only be done when a console isn't opened.  Also,
> an open must be looking at a stable configuration.  In addition, a get
> configuration request must observe the same locking since it must also
> see a stable configuration.  With the old locking, it was possible for
> this to hang indefinitely in some cases because open would block for a
> long time waiting for a connection from the host while holding the
> lock needed by the mconsole request.
>
> As explained in the long comment, this is fixed by adding a spinlock
> for the use count and configuration and a mutex for the actual open
> and close.
>
> Signed-off-by: Jeff Dike <jdike@addtoit.com>

> +
>  int line_open(struct line *lines, struct tty_struct *tty)
>  {
> -	struct line *line;
> +	struct line *line = &lines[tty->index];
>  	int err = -ENODEV;
>
> -	line = &lines[tty->index];
> -	tty->driver_data = line;
> +	spin_lock(&line->count_lock);
> +	if(!line->valid)
> +		goto out_unlock;
> +
> +	err = 0;
> +	if(tty->count > 1)
> +		goto out_unlock;
>
> -	/* The IRQ which takes this lock is not yet enabled and won't be run
> -	 * before the end, so we don't need to use spin_lock_irq.*/
> -	spin_lock(&line->lock);
> +	mutex_lock(&line->open_mutex);
> +	spin_unlock(&line->count_lock);

This is an obnoxious thing to do unless you specifically prove otherwise. You 
cannot take a mutex (and possibly sleep) while holding a spinlock.

You must have either:
+	spin_unlock(&line->count_lock);
+	mutex_lock(&line->open_mutex);

or take count_lock inside open_mutex (which looks like being correct here).

In the first solution, you can create a OPENING flag (via a state variable), 
and add the rule that (unlike the count) nobody but the original setter is 
allowed to change it, and that who finds it set (say a concurrent open) must 
return without touching it.

The state diagram is like:
CLOSED -> OPENING -> OPEN
(only the function which triggered the transition from CLOSED to OPENING can 
trigger the transition from OPENING to OPEN). It can probably be simplified 
to OPENING <-> ! OPENING.
-- 
Inform me of my mistakes, so I can add them to my list!
Paolo Giarrusso, aka Blaisorblade
http://www.user-mode-linux.org/~blaisorblade

Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 
