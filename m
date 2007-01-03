Return-Path: <linux-kernel-owner+w=401wt.eu-S1030295AbXAEClj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030295AbXAEClj (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 21:41:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030297AbXAEClj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 21:41:39 -0500
Received: from saraswathi.solana.com ([198.99.130.12]:60357 "EHLO
	saraswathi.solana.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030295AbXAECli (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 21:41:38 -0500
Date: Wed, 3 Jan 2007 14:22:59 -0500
From: Jeff Dike <jdike@addtoit.com>
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [uml-devel] [PATCH 1/6] UML - Console locking fixes
Message-ID: <20070103192259.GA5348@ccure.user-mode-linux.org>
References: <200612292341.kBTNfR3s005529@ccure.user-mode-linux.org> <200701031607.34683.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200701031607.34683.blaisorblade@yahoo.it>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 03, 2007 at 04:07:34PM +0100, Blaisorblade wrote:
> > +	spin_lock(&line->count_lock);
> > +	if(!line->valid)
> > +		goto out_unlock;
> > +
> > +	err = 0;
> > +	if(tty->count > 1)
> > +		goto out_unlock;
> >
> > -	/* The IRQ which takes this lock is not yet enabled and won't be run
> > -	 * before the end, so we don't need to use spin_lock_irq.*/
> > -	spin_lock(&line->lock);
> > +	mutex_lock(&line->open_mutex);
> > +	spin_unlock(&line->count_lock);
> 
> This is an obnoxious thing to do unless you specifically prove otherwise. 

Didn't I?  
The proof goes like this:
	we only take the semaphore if tty->count == 1, in which case
we are opening the device for the first time and there can't be anyone
else looking at it, so the mutex_lock won't sleep.

However, now that you're making me think about it again, I'm wondering
about the sanity of introducing a mutex which is guaranteed not to
sleep.

This is starting to make sense, with (tty->count > 1) being the
OPENING flag:

> In the first solution, you can create a OPENING flag (via a state variable), 
> and add the rule that (unlike the count) nobody but the original setter is 
> allowed to change it, and that who finds it set (say a concurrent open) must 
> return without touching it.

Then, I think the mutex can just be thrown away.

				Jeff

-- 
Work email - jdike at linux dot intel dot com
