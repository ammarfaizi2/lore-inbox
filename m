Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263490AbTKKNjF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 08:39:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263496AbTKKNjF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 08:39:05 -0500
Received: from users.linvision.com ([62.58.92.114]:36844 "HELO bitwizard.nl")
	by vger.kernel.org with SMTP id S263490AbTKKNjA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 08:39:00 -0500
Date: Tue, 11 Nov 2003 14:38:59 +0100
From: Rogier Wolff <R.E.Wolff@BitWizard.nl>
To: Albert Cahalan <albert@users.sf.net>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       davide.rossetti@roma1.infn.it, filia@softhome.net,
       jesse@cats-chateau.net, dwmw2@infradead.org, moje@vabo.cz,
       kakadu_croc@yahoo.com
Subject: Re: OT: why no file copy() libc/syscall ??
Message-ID: <20031111133859.GA11115@bitwizard.nl>
References: <1068512710.722.161.camel@cube>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1068512710.722.161.camel@cube>
User-Agent: Mutt/1.3.28i
Organization: BitWizard.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 10, 2003 at 08:05:11PM -0500, Albert Cahalan wrote:
> So open the file, change context, and then:
> 
> long copy_fd_to_file(int fd, const char *name, ...)
> 
> (if you can no longer read from the OPEN fd,
> either we override that or we just don't care
> about such mostly-fictional cases)


Actually, I think we should have a: 

	long copy_fd_to_fd (int src, int dst, int len)

type of systemcall. 

It should do something like:

	while ((nbytes = read (src, buf, BUFSIZE)) >= 0) {
		if (write (dst, buf, nbytes) < 0) 
			return totbytes; 
		totbytes += nbytes;
	}

but it allows kernel-space to optimize this whenever possible. Kernel
then becomes responsible for detecting and handling the optimizable
cases. 

The kernel then becomes something

	if (islocalfile (src) && issocket (dst)) 
		/* Call the old sendfile */ 
		return sendfile (....);

	if (isCIFS (src), isCIFS(dst))
		/* Tell remote host to copy the file. */
		return CIFS_copy_file (....); 

	...

and then the default implementation. This is nice and expandible, and
provides a default for the case that cannot be optimized. 

And if you don't want the extra code, we could enclose the different
optimizations with ifdefs.

But alas, last time Linus didn't agree with me and decided we should
do something like "sendfile", which is IMHO just a special case of
this one.


If we implement this in kernel (at first just the copy_fd_fd and the
default implementation), then we can get "cp" to use this, and then
suddenly whenever we upgrade the kernel, cp can use the newly
optimized copying mechanism. (e.g. whenever we manage to specify a
socket as the destination, cp would suddenly start to use
"sendfile"!!)

(It might be better to include a "buffer" argument in the interface,
freeing the implementation of allocating a buffer when an optimization
is not possible).

		Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2600998 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
**** "Linux is like a wigwam -  no windows, no gates, apache inside!" ****
