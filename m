Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264391AbUAIUzT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 15:55:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264423AbUAIUzT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 15:55:19 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:14597 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S264391AbUAIUyz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 15:54:55 -0500
Message-ID: <3FFF14F9.6030601@zytor.com>
Date: Fri, 09 Jan 2004 12:54:17 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031030
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Mike Waychison <Michael.Waychison@Sun.COM>
CC: Michael Clark <michael@metaparadigm.com>, Ian Kent <raven@themaw.net>,
       autofs mailing list <autofs@linux.kernel.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [autofs] [RFC] Towards a Modern Autofs
References: <Pine.LNX.4.44.0401081827070.285-100000@donald.themaw.net> <3FFD9498.6030905@zytor.com> <3FFDEAE6.4030503@metaparadigm.com> <3FFF0EF0.90807@sun.com>
In-Reply-To: <3FFF0EF0.90807@sun.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Waychison wrote:
> 
> This is an interesting approach to killing off a mountpoint.  However,
> the problem in question is not the destruction of the mountpoints, but
> rather being able to
> check_activity_of_a_hierarchy_of_mountpoints/unmount_them_together
> atomically.  This cannot be done cleanly in userspace even when given an
> interface to do the check, someone can race in before userspace
> initiates the unmounts.  The alternative is to have userspace detach the
> hierarchy of mountpoints using the '-l' option to umount(8), but then we
> may still unneccesarily unmount the filesystem will someone is in it.
> I think that both HPA and I agree that this capability is needed in
> order to support lazy mounting of multimounts properly.    The issue
> that remains is *how* to do it.
> 

I would argue even stronger: allowing the administrator to umount
directories manually is a hard requirement.  This means that partial
hierarchies *will* occur.  Thus, relying on the hierarchy being
atomically destructed in inherently broken.

This means that constructing the hierarchy with direct-mount automount
triggers in between the filesystems is mandatory; you get lazy mounting
for free, then -- it's a userspace policy decision whether or not to
release the waiting processes before the hierarchy is complete or not.

Now, once you recognize that the administrator needs to be able to do
umounts, expiry in userspace becomes quite trivial, since expiry is
inherently probabilistic: it can simply mimic an administrator preening
the trees, and if it fails, stop (or re-mount the submounts, policy
decision.)  Having a simple kernel-assist to avoid needless umount
operations is a good thing if (and only if!) it's cheap, but it doesn't
have to be foolproof.

Again, the atomicity constraint that umounting a filesystem needs to
destroy the mount traps above it derives from the need to cleanly deal
with nonatomic destruction.

>
> The time required to unmount something is constant if we detach the
> mountpoint using a lazy umount.
> 

You probably don't want to do that -- you could end up with some really
odd timing-related bugs if you then re-mount the filesystem.  It's also
unnecessary, since expiry is not a triggered event and therefore doesn't
keep anything that needs to happen from happening.

	-hpa

