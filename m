Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263387AbTKKNxh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 08:53:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263496AbTKKNxh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 08:53:37 -0500
Received: from pix-525-pool.redhat.com ([66.187.233.200]:48417 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S263387AbTKKNxf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 08:53:35 -0500
Date: Tue, 11 Nov 2003 08:53:23 -0500
From: Jakub Jelinek <jakub@redhat.com>
To: Rogier Wolff <R.E.Wolff@BitWizard.nl>
Cc: Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       davide.rossetti@roma1.infn.it, filia@softhome.net,
       jesse@cats-chateau.net, dwmw2@infradead.org, moje@vabo.cz,
       kakadu_croc@yahoo.com
Subject: Re: OT: why no file copy() libc/syscall ??
Message-ID: <20031111085323.M8854@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <1068512710.722.161.camel@cube> <20031111133859.GA11115@bitwizard.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20031111133859.GA11115@bitwizard.nl>; from R.E.Wolff@BitWizard.nl on Tue, Nov 11, 2003 at 02:38:59PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 11, 2003 at 02:38:59PM +0100, Rogier Wolff wrote:
> On Mon, Nov 10, 2003 at 08:05:11PM -0500, Albert Cahalan wrote:
> > So open the file, change context, and then:
> > 
> > long copy_fd_to_file(int fd, const char *name, ...)
> > 
> > (if you can no longer read from the OPEN fd,
> > either we override that or we just don't care
> > about such mostly-fictional cases)
> 
> 
> Actually, I think we should have a: 
> 
> 	long copy_fd_to_fd (int src, int dst, int len)
> 
> type of systemcall. 

We have one, sendfile(2).

> It should do something like:
> 
> 	while ((nbytes = read (src, buf, BUFSIZE)) >= 0) {
> 		if (write (dst, buf, nbytes) < 0) 
> 			return totbytes; 
> 		totbytes += nbytes;
> 	}
> 
> but it allows kernel-space to optimize this whenever possible. Kernel
> then becomes responsible for detecting and handling the optimizable
> cases. 
> 
> The kernel then becomes something
> 
> 	if (islocalfile (src) && issocket (dst)) 
> 		/* Call the old sendfile */ 
> 		return sendfile (....);
> 
> 	if (isCIFS (src), isCIFS(dst))
> 		/* Tell remote host to copy the file. */
> 		return CIFS_copy_file (....); 
> 
> 	...

Can you explain why this cannot be in sys_sendfile?
It doesn't make much sense to provide any default in the kernel,
that's something the userland can handle equally well.
But e.g. the CIFS copy can be done as sendfile hook.

	Jakub
