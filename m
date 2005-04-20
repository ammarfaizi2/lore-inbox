Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261295AbVDTEAn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261295AbVDTEAn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 00:00:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261321AbVDTEAn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 00:00:43 -0400
Received: from ip22-176.tor.istop.com ([66.11.176.22]:27275 "EHLO
	lapdance.christiehouse.net") by vger.kernel.org with ESMTP
	id S261295AbVDTEAd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 00:00:33 -0400
Message-ID: <4265D39D.2010301@waychison.com>
Date: Tue, 19 Apr 2005 23:59:25 -0400
From: Mike Waychison <mike@waychison.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Eric Van Hensbergen <ericvh@gmail.com>
CC: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, hch@infradead.org, akpm@osdl.org,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [RFC] FUSE permission modell (Was: fuse review bits)
References: <3Ki1W-2pt-1@gated-at.bofh.it> <3S8oN-So-25@gated-at.bofh.it>	 <3S8oN-So-27@gated-at.bofh.it> <3S8oM-So-7@gated-at.bofh.it>	 <3UmnD-6Fy-7@gated-at.bofh.it>	 <E1DNJZD-0006vK-11@be1.7eggert.dyndns.org>	 <a4e6962a050419045752cc8be0@mail.gmail.com>	 <Pine.LNX.4.58.0504191647320.3652@be1.lrz>	 <a4e6962a05041908262df343f1@mail.gmail.com>	 <Pine.LNX.4.58.0504191756200.3929@be1.lrz> <a4e6962a05041912293ba87710@mail.gmail.com>
In-Reply-To: <a4e6962a05041912293ba87710@mail.gmail.com>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Van Hensbergen wrote:
> Somewhat related question for Viro/the group:
> 
> Why is CLONE_NEWNS considered a priveledged operation?  Would placing
> limits on the number of private namespaces a user can own solve any
> resource concerns or is there something more nefarious I'm missing?
> -
> To unsubscribe from this list: send the line "unsubscribe linux-fsdevel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

Likely because its a chroot vulnerability.

It allows a process to obtain a reference to the root vfsmount that
doesn't have chroot checks performed on it.

Consider the following pseudo example:

main():
chdir("/");
fd = open(".", O_RDONLY);
clone(cloned_func, cloned_stack, CLONE_NEWNS, NULL);

cloned_func:
fchdir(fd);
chdir("..");

if main is run within a chroot where it's "/" is on the same vfsmount as
 it's "..", then the application can step out of the chroot using clone(2).

Note: using chdir in a vfsmount outside of your namespace works, however
you won't be able to walk off that vfsmount (to its parent or children).

Mike Waychison
