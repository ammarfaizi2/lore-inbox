Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261387AbSJ2C2A>; Mon, 28 Oct 2002 21:28:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261478AbSJ2C2A>; Mon, 28 Oct 2002 21:28:00 -0500
Received: from ns.suse.de ([213.95.15.193]:10003 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S261387AbSJ2C17> convert rfc822-to-8bit;
	Mon, 28 Oct 2002 21:27:59 -0500
Content-Type: text/plain; charset=US-ASCII
From: Andreas Gruenbacher <agruen@suse.de>
Organization: SuSE Linux AG
To: <chris@scary.beasts.org>,
       Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>
Subject: Re: [PATCH][RFC] 2.5.44 (1/2): Filesystem capabilities kernel patch
Date: Tue, 29 Oct 2002 03:23:09 +0100
User-Agent: KMail/1.4.3
Cc: <linux-kernel@vger.kernel.org>, Ulrich Drepper <drepper@redhat.com>
References: <Pine.LNX.4.33.0210282327520.8990-100000@sphinx.mythic-beasts.com>
In-Reply-To: <Pine.LNX.4.33.0210282327520.8990-100000@sphinx.mythic-beasts.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210290323.09565.agruen@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 29 October 2002 00:36, chris@scary.beasts.org wrote:
> On Mon, 28 Oct 2002, Olaf Dietsche wrote:
> > Solving the last issue (checking access to the capabilities database)
> > involves filesystem support, I guess. So, this will be the next step
> > to address.
> >
> > If you're careful with giving away capabilities however, this patch
> > can make your system more secure as it is. But this isn't fully
> > explored, so you might achieve the opposite and open new security
> > holes.
>
> Have you checked how glibc handles an executable with filesystem
> capabilities? e.g. can an LD_PRELOAD hack subvert the privileged
> executable?
> I'm not sure what the current glibc security check is, but it used to be
> simple *uid() vs. *euid() checks. This would not catch an executable with
> filesystem capabilities.
> Have a look at
> http://security-archive.merton.ox.ac.uk/security-audit-199907/0192.html

It seems an additional mechanism is needed to prevent LD_PRELOAD from loading 
non-standard libraries for executables that are not suid/sgid, if those 
executables have any effective or permitted capabilities that the calling 
process doesn't have already.

This shouldn't be too hard; perhaps Ulrich has an opinion on that.

> I think the eventual plan was that we pass the kernel's current->dumpable
> as an ELF note. Not sure if it got done. Alternatively glibc could use
> prctl(PR_GET_DUMPABLE).

Sorry, I don't know exactly what was your plan here. Could you please explain?

A perhaps unrelated note: We once had Pavel Machek's elfcap implementation, in 
which capabilities were stored in ELF. This was a bad idea because being able 
to create executables does not imply the user is capable of CAP_SETFCAP, and 
users shouldn't be able to freely choose their capabilities :-] We still want 
to be able to grant additional capabilities to a binary that are not owned by 
root though. Extended attributes to overcome this limitation.

There also has to be a mechanism to drop capabilities off binaries if they are 
written to (on write or perhaps on open).

The final goal would be the `incapable root user', i.e., we would not give 
suid root binaries any capabilities except those that are explicitly defined.

--Andreas.

