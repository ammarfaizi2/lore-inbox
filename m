Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262860AbVA2Exc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262860AbVA2Exc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 23:53:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262856AbVA2Exb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 23:53:31 -0500
Received: from wombat.indigo.net.au ([202.0.185.19]:62471 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S262854AbVA2Ev6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 23:51:58 -0500
Date: Sat, 29 Jan 2005 12:40:32 +0800 (WST)
From: raven@themaw.net
To: Mike Waychison <Michael.Waychison@Sun.COM>
cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] shared subtrees
In-Reply-To: <41FABD4E.6050701@sun.com>
Message-ID: <Pine.LNX.4.61.0501291218290.1607@donald.themaw.net>
References: <20050113221851.GI26051@parcelfarce.linux.theplanet.co.uk>
 <41FABD4E.6050701@sun.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-100.6, required 8,
	EMAIL_ATTRIBUTION, IN_REP_TO, NO_REAL_NAME, QUOTED_EMAIL_TEXT,
	RCVD_IN_ORBS, RCVD_IN_OSIRUSOFT_COM, REFERENCES, REPLY_WITH_QUOTES,
	USER_AGENT_PINE, USER_IN_WHITELIST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Jan 2005, Mike Waychison wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> Al Viro wrote:
>
>> OK, here comes the first draft of proposed semantics for subtree
>> sharing.  What we want is being able to propagate events between
>> the parts of mount trees.  Below is a description of what I think
>> might be a workable semantics; it does *NOT* describe the data
>> structures I would consider final and there are considerable
>> areas where we still need to figure out the right behaviour.
>>
>
> Okay, I'm not convinced that shared subtrees as proposed will work well
> with autofs.

OK. I've read the thread but haven't digested it so you'll have to put up 
with some stupid questions.

>
> The idea discussed off-line was this:
>
> When you install an autofs mountpoint, on say /home, a daemon is started
> to service the requests.  As far as the admin is concerned, an fs is
> mounted in the current namespace, call it namespaceA.  The daemon
> actually runs in it's one private namespace: call it namespaceB.
> namespaceB receives a new autofs filesystem: call it autofsB.  autofsB
> is in it's own p-node.  namespaceA gets an autofsA on /home as well, and
> autofsA is 'owned' by autofsB's p-node.
>
> So:
>
> autofsB -> autofsB
> and
> autofsB -> autofsA
>
> Effectively, namespaceA has a private instance of autofsB in its tree.
>
> The problem is this:
>
> Assume /home/mikew is accessed in namespaceA.  The daemon running in
> namespaceB gets the event, and mounts an nfs vfsmount on autofsB.  This
> event is propagated back to autofsA.

Which condition (or action) in the definition implies

autofsB -> autofsA

>
> (Problem 1: how do you block access to /home/mikew in namespaceA?)
>
> Next, a CLONE_NS is done in namespaceA, creating namespaceA'.  the
> homedir on /home/mikew is also copied.
>
> Now, in namespaceA', what happens when a user umount's /home/mikew?  We
> haven't yet determined how to handle umount event propagation, but it
> appears likely that it will be *a hard thing to do*.

No I haven't spent enough time on the RFC buy into this one.
So I'll just say it looks like something is missing in this argument.

Perhaps the later is namespaceC?

>
> Assuming the nfs umount succeeds, /home/mikew is accessed again in
> namespaceA'.

namespaceC?

>
> (Problem 2: The daemon in namespaceB will see the event, but it already
> has something mounted on it's version of /home/mikew.  How does it
> 'send' a mountpoint to namespaceB.)
>
> - -----------
>
> Shared subtrees may help in some adminstrative situations, but don't
> look like the right solution for autofs.
>
> Autofs will work with namespaces if the following functionality is added
> to the kernel:  The ability to perform mount(2) operations on a
> directory fd.
>
> This has been discussed before and quickly vetoed, citing that it is a
> security risk.  I still fail to understand how allowing a mount to
> happen cross-namespace given a dirfd target is any worse than what is
> already possible given a dirfd.  If you don't want someone to play with
> your namespace, don't give them a dirfd.
>
> Thoughts?
>
> - --
> Mike Waychison
> Sun Microsystems, Inc.
> 1 (650) 352-5299 voice
> 1 (416) 202-8336 voice
>
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> NOTICE:  The opinions expressed in this email are held by me,
> and may not represent the views of Sun Microsystems, Inc.
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.2.5 (GNU/Linux)
> Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org
>
> iD8DBQFB+r1OdQs4kOxk3/MRAmSpAJ96ix25fjze6o7viCq2DCET9J/AlQCfYlC1
> CoLKusJXjL+fYxgwggOCW+w=
> =8bTv
> -----END PGP SIGNATURE-----
> -
> To unsubscribe from this list: send the line "unsubscribe linux-fsdevel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

