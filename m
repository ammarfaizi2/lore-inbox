Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751607AbVLABHY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751607AbVLABHY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 20:07:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751608AbVLABHY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 20:07:24 -0500
Received: from ns2.suse.de ([195.135.220.15]:32171 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751551AbVLABHX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 20:07:23 -0500
To: Devin Bayer <devin@freeshell.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] allow core_patten to be a FIFO, kernel 2.6.14
References: <438E4307.10508@freeshell.org>
From: Andi Kleen <ak@suse.de>
Date: 30 Nov 2005 22:35:56 -0700
In-Reply-To: <438E4307.10508@freeshell.org>
Message-ID: <p73hd9tfkg3.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Devin Bayer <devin@freeshell.org> writes:
> 
> I'm looking for comments, testing and inclusion in the next release.
> I have tested it in UML and one i686 build. The coredump files
> produced were valid.

I did a similar patch some time ago, but it allowed to execute a program
instead of allowing fifos with the core on stdin. IMHO that's a better
usage model because it doesn't require a daemon (and if you want one
you can use a trivial forwarder) 

I didn't post it because it still needed some cleanup and
double checking of a few corner cases and ran out of time for that.

I agree it's very useful. In my case the idea was to do 
automatic crash reporting. I wrote some simpleminded backup
scripts for that.

If there is interest I can dig it out. I think it was already
in better shape than your patch ;-)

>  {
> -	if (file->f_op->llseek) {
> +	if (off == file->f_pos) +		return 1;
> +	if (file->f_op->llseek == no_llseek && off > file->f_pos) {
> +		int nr = off - file->f_pos;
> +		char zeros[nr];
> +
> +		memset(zeros,0,nr);
> +		return dump_write(file, zeros, nr);

That's a exploitable root hole and a likely crash I think.

> +	    if (do_truncate(file->f_dentry, 0) != 0)
> +		    goto close_fail;
> +	}
>  	retval = binfmt->core_dump(signr, regs, file);
>  +	if(S_ISFIFO(inode->i_mode))
> +	    spin_unlock(&fifo_core_lock);

You're holding a spinlock over operations that can sleep like
write or truncate? That's totally wrong.

-Andi
