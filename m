Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965254AbWJCF3F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965254AbWJCF3F (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 01:29:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965255AbWJCF3B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 01:29:01 -0400
Received: from ns2.suse.de ([195.135.220.15]:31618 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S965254AbWJCF3A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 01:29:00 -0400
Date: Mon, 2 Oct 2006 22:28:39 -0700
From: Greg KH <gregkh@suse.de>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Takashi Iwai <tiwai@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>,
       Joel Becker <Joel.Becker@oracle.com>, Michael Buesch <mb@bu3sch.de>
Subject: Re: debugfs oddity
Message-ID: <20061003052839.GA18989@suse.de>
References: <1159781104.2655.47.camel@ux156>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1159781104.2655.47.camel@ux156>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 02, 2006 at 11:25:04AM +0200, Johannes Berg wrote:
> Recently, I observed (in bcm43xx) that debugfs seems to keep things
> alive when userspace still has a directory open. Consider the following
> sequence of events:
>  (a) kernel code creates a directory in debugfs
>  (b) user changes current directory to that
>  (c) kernel code removes that directory in debugfs
> 
> Now, consider the equivalent sequence in a regular filesystem (or
> tmpfs):
>  (a') user creates directory
>  (b') user cd's into it
>  (c') user deletes directory from a different shell
> 
> The same thing should happen, in both cases the directory is kept around
> in a way until the process that has the current dir in the dead
> directory gives it up.
> 
> Now, however, consider
>  (d') user creates directory with the same name
> 
> This works fine, and the old process sees nothing that happens in the
> new directory, as expected. However,
>  (d) kernel code tries to create a debugfs directory with the same name
> 
> does not work at all.

True, that is because the kernel thinks there is still an active dentry
with that name present in the system.

> Is this expected behaviour? It seems that once a driver requested that a
> directory is removed it can rightfully expect to be able to recreate it
> afterwards even if there's still the need to keep it lingering around
> for a bit.
> 
> Similar things can probably happen when attributes are kept open, but I
> haven't tested this. I have also not tested sysfs or configfs.

sysfs works much differently here, as does configfs.  debugfs just uses
the vfs layer's ramfs stack, so any potential problem here is probably
also present in ramfs.  Have you tried that out?

thanks,

greg k-h
