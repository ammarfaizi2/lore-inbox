Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030242AbVKPJLS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030242AbVKPJLS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 04:11:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030248AbVKPJLS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 04:11:18 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:38626
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S1030242AbVKPJLQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 04:11:16 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [PATCH 12/18] shared mount handling: bind and rbind
Date: Wed, 16 Nov 2005 03:10:24 -0600
User-Agent: KMail/1.8
Cc: a1426z@gawab.com, torvalds@osdl.org, linuxram@us.ibm.com,
       viro@ftp.linux.org.uk, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
References: <E1EZInj-0001Ez-AV@ZenIV.linux.org.uk> <200511160835.28636.a1426z@gawab.com> <E1EcIVw-0005ZH-00@dorka.pomaz.szeredi.hu>
In-Reply-To: <E1EcIVw-0005ZH-00@dorka.pomaz.szeredi.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511160310.24807.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 16 November 2005 02:19, Miklos Szeredi wrote:
> > > This is why we have "pivot_root()" and "chroot()", which can both be
> > > used to do what you want to do. You mount the new root somewhere else,
> > > and then you chroot (or pivot-root) to it. And THEN you do 'chdir("/")'
> > > to move the cwd into the new root too (and only at that point have you
> > > "lost" the old root - although you can actually get it back if you have
> > > some file descriptor open to it).
> >
> > Wouldn't this constitute a security flaw?
> >
> > Shouldn't chroot jail you?
>
> No, chroot should just change the root.
>
> If you don't want to be able to get back the old root, just close all
> file descriptors _in addition_ to chroot() and chdir().

If you try the chdir by filedescriptor trick on the stdin/stdout/stderr fed 
into PID 1 when it's started up by the kernel, which filesystem do you wind 
up in?  (rootfs?)

I ask because switch_root redoes those to point to /dev/console from the real 
root (presumably for security reasons), and this happens _before_ the init on 
the real root gets called, and thus before the real root gets to populate 
its' own dynamic /dev.

I suppose initramfs could make a temporary /dev, do the mknods for console and 
the real root, and then mount --move this tmpdir to the real root's /dev once 
that's available (and then let the real root's udev populate it the rest of 
the way).  Or the real root could have a hard /dev/console living in the 
directory that's going to get overmounted by tmpfs later.  Or just leave 
initramfs accessible until init can switch consoles...

Sigh.  I need to document the requirements here...

Rob
