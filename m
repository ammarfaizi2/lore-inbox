Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263592AbUAMB41 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 20:56:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263584AbUAMB41
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 20:56:27 -0500
Received: from wombat.indigo.net.au ([202.0.185.19]:47630 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S263642AbUAMByl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 20:54:41 -0500
Date: Tue, 13 Jan 2004 09:54:06 +0800 (WST)
From: Ian Kent <raven@themaw.net>
X-X-Sender: <raven@wombat.indigo.net.au>
To: Mike Waychison <Michael.Waychison@Sun.COM>
cc: Jim Carter <jimc@math.ucla.edu>,
       autofs mailing list <autofs@linux.kernel.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [autofs] [RFC] Towards a Modern Autofs
In-Reply-To: <4002D248.2070304@sun.com>
Message-ID: <Pine.LNX.4.33.0401130932460.10047-100000@wombat.indigo.net.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-5.6, required 8, AWL,
	BAYES_10, EMAIL_ATTRIBUTION, IN_REP_TO, QUOTED_EMAIL_TEXT,
	REPLY_WITH_QUOTES, USER_AGENT_PINE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Jan 2004, Mike Waychison wrote:

> >
> >And I have another question concerning namespaces.
> >
> >Given that there may be several namespaces, each of which may or may not
> >have a trigger on this dentry, is there some sort of list of triggers?
> >
> >How do the triggers know who owns them?
> >
> >
> >
> >
> This is the reason I went with using distinct filesystems to perform the
> triggers.  If we use follow_link logic, we will have a reference to the
> respective vfsmount.  Dentry's themselves know nothing about the
> triggers, as the triggers just look like a mounted filesystem.   The
> vfsmount information has enough information for autofs to call a
> userspace agent through hotplug and have userspace handle the mount.  In
> effect, there is no daemon so nobody 'owns' a trigger in the same sense
> as with autofs3/4.

I'm not familiar with the follow_link mechanism (no prob. I'll pick it up
as I go).

Correct me if I'm wrong but, the only thing that I can see that is
duplicated in cloning a namespace is the root dentry. The rest of the
dentries on the system remain the same. The increase in complexity to the
VFS to change this would be prohibitive.

I see we want the triggers in the vfsmount struct. Is this a good idea?
The vfsmount struct has always been difficult to get hold of during lookup
and revalidate for me (someone like to help here).

>
> As far as userspace is concerned, an autofs filesystem is mounted as is
> any other filesystem.  All that is required is a proper set of mount
> options.  For example, mounting auto_home on /home is:
>
> mount -t autofs -o maptype=indirect,mapname=auto_home auto_home /home
>
> Whenever somebody traverses into a subdir in /home within any namespace
> this autofs filesystem has been inherited, userspace is invoked (in that
> namespace) to perform the mount.  Again, there is no 'ownership' other
> than maybe calling the namespace it resides it the 'owner', as you would
> for any other mountpoint.

The "mount all automount entries" has always been the simpler option but,
as you know, the kernel still allows only 255 anonymous mounts. This would
have to be the first order of business. Ohh, I was supposed to be working
on sysctl inerface for that. I'll just be quiet now.

Also, something needs to be done about mount table noise. Several hundred
entries is very bad from an administration viewpoint.

Except for the cross namespace issues, which I'm still digesting, I can't
see why your design can't be done entirely as a filesystem using dentries
instead of vfsmount, including expirey. Perhaps you could reinterate a few
of the reasons for this.

Ian


