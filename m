Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265960AbUAHTei (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 14:34:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266200AbUAHTeg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 14:34:36 -0500
Received: from pat.uio.no ([129.240.130.16]:439 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S265960AbUAHTcp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 14:32:45 -0500
Message-ID: <33128.141.211.133.197.1073590355.squirrel@webmail.uio.no>
Date: Thu, 8 Jan 2004 20:32:35 +0100 (CET)
Subject: Re: [autofs] [RFC] Towards a Modern Autofs
From: <trond.myklebust@fys.uio.no>
To: <viro@parcelfarce.linux.theplanet.co.uk>, <linux-kernel@vger.kernel.org>
X-Priority: 3
Importance: Normal
Cc: <raven@themaw.net>, <hpa@zytor.com>, <Michael.Waychison@sun.com>,
       <thockin@Sun.COM>
X-Mailer: SquirrelMail (version 1.2.11 - UIO)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning
X-UiO-MailScanner: No virus found
X-UiO-Spam-info: not spam, SpamAssassin (score=-4.74, required 12,
	BAYES_00 -4.90, NO_REAL_NAME 0.16)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På to , 08/01/2004 klokka 13:31, skreiv
viro@parcelfarce.linux.theplanet.co.uk:

> Special vfsmount mounted somewhere; has no superblock associated with
> it; attempt to step on it triggers event; normal result of that event
> is to get a normal mount on top of it, at which point usual chaining
> logics will make sure that we don't see the trap until it's uncovered
> by removal of covering filesystem.  Trap (and everything mounted on
> it, etc.) can be removed by normal lazy umount.
>
> Basically, it's a single-point analog of autofs done entirely in VFS.
> The job of automounter is to maintain the traps and react to events.

What if the trap is set by the filesystem? I'm thinking about AFS
volumes and NFSv4 migration events here.

Both these need something that goes beyond the current autofs "daemon
waiting on top of a single trap" thinking.

In the NFSv4 migration case we can be walking down the filesystem patch
and enter a directory where we are basically told by the server that
"this volume has been moved" and are given a list of replicated
servername/pathname fields. Those then need to be interpreted in
userland by means of an upcall of some sort, and the new volume needs to
be mounted.

Neither autofs3 nor autofs4 can currently help us do this, because we
don't a priori have a complete list of directories on which to start a
bunch of "automount" daemons (and it wouldn't help anyway since a server
failover event etc. might cause the list to change).

Setting up our own traps, however, and then doing the upcall by means of
an exec & an "intelligent" mount program (as Mike & co. propose) OTOH,
would very much simplify matters, since that allows us to do simple
string parameter passing from the kernel to direct how the mount is to
be set up.
It still leaves the final policy decisions of which server to mount &
where in userland.

Finally, because the upcall is done in the user's own context, you avoid
the whole problem of automounter credentials that are a constant plague
to all those daemon-based implementations when working in an environment
where you have strong authentication.
If anyone wants evidence of how broken the whole daemon thing is, then see
the workarounds that had to be made in RFC-2623 to disable strong
authentication for GETATTR etc. on the NFSv2/v3 mount point.

Cheers,
  Trond




