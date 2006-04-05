Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751157AbWDEH6g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751157AbWDEH6g (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 03:58:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751158AbWDEH6g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 03:58:36 -0400
Received: from smtp.osdl.org ([65.172.181.4]:12203 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751157AbWDEH6f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 03:58:35 -0400
Date: Wed, 5 Apr 2006 00:57:33 -0700
From: Andrew Morton <akpm@osdl.org>
To: Paul Fulghum <paulkf@microgate.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] ptmx fix duplicate idr_remove
Message-Id: <20060405005733.29b6868f.akpm@osdl.org>
In-Reply-To: <1144175731.3485.18.camel@amdx2.microgate.com>
References: <1144175731.3485.18.camel@amdx2.microgate.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Fulghum <paulkf@microgate.com> wrote:
>
> Remove duplicate call to idr_remove() in ptmx_open.
> 
> Error during open can result in call to release_dev()
> followed by call to idr_remove(). release_dev already
> calls idr_remove so the second call can cause a stack
> dump in idr_remove()->sub_remove() flagging an attempt
> to release an already released entry.
> 
> I reproduces this on a machine with a misconfigured
> X server (attempting to restart multiple times rapidly)
> getting the same error as the 1st link below.
> 
> This also seems to be related to:
> http://marc.theaimsgroup.com/?l=selinux&m=110536513426735&w=2
> http://marc.theaimsgroup.com/?l=selinux&m=110596994916785&w=2
> 
> The stack dump can occur on close (as well as open) as shown
> in the 1st instance above, possible from something like:
> process A - open (index=0), open fail to out1,
>   release_dev calls idr_remove (index 0), down(sem) sleeps
> process B - open (index=0), open OK (idr allocated)
> process A - wake and call idr_remove on index 0
> ...
> process B - close, release_dev, stack dump on idr_remove (index=0)
>   because entry already removed
> 
> Comments?
> 
> --- linux-2.6.16/drivers/char/tty_io.c	2006-03-19 23:53:29.000000000 -0600
> +++ b/drivers/char/tty_io.c	2006-04-04 12:52:47.000000000 -0500
> @@ -2188,6 +2188,7 @@ static int ptmx_open(struct inode * inod
>  		return 0;
>  out1:
>  	release_dev(filp);
> +	return retval;
>  out:
>  	down(&allocated_ptys_lock);
>  	idr_remove(&allocated_ptys, index);

Look solid.

Except for this, in release_dev():

	/* check whether both sides are closing ... */
	if (!tty_closing || (o_tty && !o_tty_closing))
		return;

if that's taken, we won't have run idr_remove() at all?
