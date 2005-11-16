Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030388AbVKPQS6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030388AbVKPQS6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 11:18:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030396AbVKPQS6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 11:18:58 -0500
Received: from smtp.osdl.org ([65.172.181.4]:65156 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030388AbVKPQS5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 11:18:57 -0500
Date: Wed, 16 Nov 2005 08:18:25 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Rob Landley <rob@landley.net>
cc: Ram Pai <linuxram@us.ibm.com>, Miklos Szeredi <miklos@szeredi.hu>,
       Al Viro <viro@ftp.linux.org.uk>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 12/18] shared mount handling: bind and rbind
In-Reply-To: <200511160241.20016.rob@landley.net>
Message-ID: <Pine.LNX.4.64.0511160808430.13959@g5.osdl.org>
References: <E1EZInj-0001Ez-AV@ZenIV.linux.org.uk> <200511152129.04079.rob@landley.net>
 <Pine.LNX.4.64.0511151948570.13959@g5.osdl.org> <200511160241.20016.rob@landley.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 16 Nov 2005, Rob Landley wrote:
> 
> So does mounting over / actually accomplish anything?  Or is it sort of an 
> undermount instead of an overmount, resulting in a mounted but inaccessible 
> filesystem?

I'd say that _usually_ you're better off using chroot() than mounting over 
"/".

> So all chroot(2) really does is reset the "/" reference?

Yes. Literally. Everything else stays the same, including any open files 
(and cwd).

It's a "flaw" in chroot if you consider it a jail, but it's used for so 
much more than that.  In fact, you shouldn't consider it jail: it's really 
just a small _part_ of the notion of limiting somebody to a specific area.

(The smallest part, in fact. And you should be aware that root can always 
get out of a chdir() if he just has enough tools - and the tools aren't 
even very big. "mknod" + "mount" will do it even in the absense of a way 
to add binaries, as will /proc access).

Note that the most common use of chroot isn't actually the "jail" kind of 
usage, but building and installation environments (ie a lot of package 
building stuff end up using chroot as a way to create the "target 
environment").

> In the specific case of "mount --move . /" || chroot ("."), I don't see why we 
> need a chdir afterwards, because cwd points to the correct filesystem.  (In 
> fact, for a moment there between the mount move and the chroot it's the 
> _only_ reference we have to this filesystem.)
> 
> Perhaps ".." isn't correct unless we chdir again...?

Indeed. The issue ends up being ".." and "getcwd()", which both want to 
know what your root is in order to know where to stop.

		Linus
