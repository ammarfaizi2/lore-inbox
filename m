Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270746AbRH1LSw>; Tue, 28 Aug 2001 07:18:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270748AbRH1LSm>; Tue, 28 Aug 2001 07:18:42 -0400
Received: from [195.89.159.99] ([195.89.159.99]:12530 "EHLO
	kushida.degree2.com") by vger.kernel.org with ESMTP
	id <S270746AbRH1LSZ>; Tue, 28 Aug 2001 07:18:25 -0400
Date: Tue, 28 Aug 2001 12:18:47 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Clifford Wolf <clifford@clifford.at>
Cc: Remy.Card@linux.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Ext2FS: SUID on Dir
Message-ID: <20010828121847.B9690@thefinal.cern.ch>
In-Reply-To: <Pine.LNX.4.33.0108281227280.1127-100000@nerd.clifford.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0108281227280.1127-100000@nerd.clifford.at>; from clifford@clifford.at on Tue, Aug 28, 2001 at 12:52:46PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Clifford Wolf wrote:
> But that only makes sense if the umask is set to give full permissions to
> the group (e.g. 007 or 002). Noone would do that if there is a system-wide
> 'users' group - so some distributions add an extra group for every user
> which lets the /etc/group file grow very fast and makes the admins life
> harder ...

Concured.  In my experience, "extra group for every user" doesn't work
with you're sharing over NFS with systems that don't use it.  Which
means using a umask of 022 or 077, and that renders the SGID-directory
feature almost useless.

I've seen two problems result from this: user files created group
writable on the NFS server, when they should not be (a security
problem).  And shared directories created non-group-writable, which
other group members cannot fix.  (Only root can fix this).

For example where I work, some of the CVS directories cannot be checked
out because some directories, which should be group writable, are not.

> The following small patch adds a function to the SUID flag on directories.
> If the SUID flag is set for a diectory, all new files in that directory
> will get the same rights in the group-field as they have in their
> user-field.

Your patch does not fix the problem with CVS directories.  In those,
directories need to be writable, but newly created user files should not
necessarily be group writable.

So I would suggest this behaviour:

   sgid directory   -> new subdirectories copy group umask from user umask
   suid directory   -> new non-directories copy group umask from user umask

Both these behaviours would be enabled by a mount option, preferably a
generic one.

cheers,
-- Jamie
