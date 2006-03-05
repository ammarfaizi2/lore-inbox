Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751869AbWCEV7R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751869AbWCEV7R (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 16:59:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751861AbWCEV7R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 16:59:17 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:32516 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1751869AbWCEV7R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 16:59:17 -0500
Date: Sun, 5 Mar 2006 22:58:53 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Keith Ownes <kaos@ocs.com.au>
Subject: Re: kbuild - status on section mismatch warnings
Message-ID: <20060305215853.GA14998@mars.ravnborg.org>
References: <20060305193012.GA14838@mars.ravnborg.org> <20060305200659.GD27946@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060305200659.GD27946@ftp.linux.org.uk>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Al.

> Now try x86 with sd.o non-modular.  And see
> 
> 
> __init foo()
> {
> ....
> 	switch(n) {
> 	....
> 	....
> 	}
> }
Hmm, in my tree sd.o has no switch in the init function. But that does
not change your point which is valid indeed.

> compiling essentially into
> 
> 	if (n < lower || n > upper)
> 		goto Ldefault;
> 	addr = const_array_of_labels[n - lower];
> 	goto addr;
> 
> with const_array_of_labels sitting in .rodata and its contents pointing
> inside foo(), i.e. into .init.text.  And yes, .init.text is discarded,
> while .rodata is left intact.  Since the only reference to that array
> disappears along with .init.text *and* section where array goes into is
> hardwired into gcc, we
> 	a) are actually OK and
> 	b) can't do anything about that false positive, AFAICS.

For the same reason references to .init.text from .rodata are not warned
upon - there are simply too many compielr generated false positives.

Following is the original comment from reference_init.pl:

* Unfortunately references to read only data that referenced .init
* sections had to be excluded. Almost all of these are false
* positives, they are created by gcc. The downside of excluding rodata
* is that there really are some user references from rodata to
* init code, e.g. drivers/video/vgacon.c:
*
* const struct consw vga_con = {
*        con_startup:            vgacon_startup,
*
* where vgacon_startup is __init.  If you want to wade through
* the false
* positives, take out the check for rodata.

And this is unfortunate since we cannot do a full check, but we do a
better job than before and warn for many of the trivial cases.
Judging the amount of warnings already generated this is worth checking.

	Sam

