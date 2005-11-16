Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965225AbVKPDxx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965225AbVKPDxx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 22:53:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965230AbVKPDxx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 22:53:53 -0500
Received: from smtp.osdl.org ([65.172.181.4]:24704 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965225AbVKPDxv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 22:53:51 -0500
Date: Tue, 15 Nov 2005 19:53:36 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Rob Landley <rob@landley.net>
cc: Ram Pai <linuxram@us.ibm.com>, Miklos Szeredi <miklos@szeredi.hu>,
       Al Viro <viro@ftp.linux.org.uk>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 12/18] shared mount handling: bind and rbind
In-Reply-To: <200511152129.04079.rob@landley.net>
Message-ID: <Pine.LNX.4.64.0511151948570.13959@g5.osdl.org>
References: <E1EZInj-0001Ez-AV@ZenIV.linux.org.uk> <1131561849.5400.384.camel@localhost>
 <Pine.LNX.4.64.0511091054290.3247@g5.osdl.org> <200511152129.04079.rob@landley.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 15 Nov 2005, Rob Landley wrote:
> 
> The || fallback in the third part won't work.  chroot(".") will get you to the 
> new filesystem, but chdir("/") still gets you to the old one, even though 
> we've overmounted it.  (I have no idea why.  I assume it's because / is 
> special.)

'/' is special exactly the same way '.' is: one is shorthand for "current 
process' root", and the other is shorthand for "current process' cwd".

So if you mount over '/', it won't actually do what you think it does: 
because when you open "/", it will continue to open the _old_ "/". Exactly 
the same way that mounting over somebody's cwd won't do what you think it 
does - because the root and the cwd have been looked-up earlier and are 
cached with the process.

This is why we have "pivot_root()" and "chroot()", which can both be used 
to do what you want to do. You mount the new root somewhere else, and then 
you chroot (or pivot-root) to it. And THEN you do 'chdir("/")' to move the 
cwd into the new root too (and only at that point have you "lost" the old 
root - although you can actually get it back if you have some file 
descriptor open to it).

		Linus
