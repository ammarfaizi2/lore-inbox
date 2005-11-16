Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965204AbVKPDaN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965204AbVKPDaN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 22:30:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965209AbVKPDaM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 22:30:12 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:62924
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S965204AbVKPDaK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 22:30:10 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 12/18] shared mount handling: bind and rbind
Date: Tue, 15 Nov 2005 21:29:03 -0600
User-Agent: KMail/1.8
Cc: Ram Pai <linuxram@us.ibm.com>, Miklos Szeredi <miklos@szeredi.hu>,
       Al Viro <viro@ftp.linux.org.uk>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
References: <E1EZInj-0001Ez-AV@ZenIV.linux.org.uk> <1131561849.5400.384.camel@localhost> <Pine.LNX.4.64.0511091054290.3247@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0511091054290.3247@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511152129.04079.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 09 November 2005 12:59, Linus Torvalds wrote:
> > no. I said application _should_not_ depend on it, because it is a
> > undefined semantics.
>
> It's definitely neither unusual nor undefined. I do all my umounts by
> directory (in fact, doing it by anything else really _is_ badly defined,
> since a block device can be mounted in many places), and the only sane
> semantics would be to peel off the last mount on that directory.

I noticed this upgrading busybox mount a few months back.  I was trying to 
figure out if the correct semantics for umount /dev/block were to umount 
_all_ instances of this block device, or umount just the most recent one.  I 
wound up just passing it through to the kernel and letting it decide, but I 
wasn't sure why it did what it did.

The 2.6 multiple mount semantics are still new enough that the tools are just 
now catching up.  Last I checked, the standard mount was kind of unhappy with 
--bind and --move mounts (they were corrupting /etc/mtab):

http://www.busybox.net/lists/busybox/2005-August/015285.html

The side effects of mount can be really non-obvious at times.  For example, 
while implementing busybox's switch_root I found out that this snippet of 
klibc's run-init.c is slightly wrong:
  if ( chdir(realroot) )
    die("chdir to new root");
/* snip */
  /* Overmount the root */
  if ( mount(".", "/", NULL, MS_MOVE, NULL) )
    die("overmounting root");

  /* chroot, chdir */
  if ( chroot(".") || chdir("/") )
    die("chroot");

The || fallback in the third part won't work.  chroot(".") will get you to the 
new filesystem, but chdir("/") still gets you to the old one, even though 
we've overmounted it.  (I have no idea why.  I assume it's because / is 
special.)

Rob
