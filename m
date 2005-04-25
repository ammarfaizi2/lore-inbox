Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261197AbVDYVIx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261197AbVDYVIx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 17:08:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261201AbVDYVIx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 17:08:53 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:18327 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261197AbVDYVIE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 17:08:04 -0400
In-Reply-To: <20050424211942.GN13052@parcelfarce.linux.theplanet.co.uk>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: akpm@osdl.org, hch@infradead.org, linux-fsdevel@vger.kernel.org,
       linux-fsdevel-owner@vger.kernel.org, linux-kernel@vger.kernel.org,
       Miklos Szeredi <miklos@szeredi.hu>
MIME-Version: 1.0
Subject: Re: [PATCH] private mounts
X-Mailer: Lotus Notes Release 6.0.2CF1 June 9, 2003
Message-ID: <OF32F95BBA.F38B2D1F-ON88256FEE.006FE841-88256FEE.00742E46@us.ibm.com>
From: Bryan Henderson <hbryan@us.ibm.com>
Date: Mon, 25 Apr 2005 14:09:43 -0700
X-MIMETrack: Serialize by Router on D01ML604/01/M/IBM(Build V70_M4_01112005 Beta 3|January
 11, 2005) at 04/25/2005 17:08:00,
	Serialize complete at 04/25/2005 17:08:00
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> No.  You can't set "mount environment" in scp.
>
>Of course you can.  It does execute the obvious set of rc files.

Incidentally, there is no obvious set of files.  The only relevant one 
that gets executed does so by accident because of a side effect of an ugly 
hack.

Jamie pointed out that such files wouldn't really help anyway, because 
there isn't a shell command that can affect the mounts seen by the copy 
server process it forks.  And others have noted that some such remote 
processes don't run shells at all.  But in case anyone is thinking of 
shell rc files as an architectural solution to the scp problem, let me 
explain shell rc files, in particular Bash's:

.profile runs when a login shell starts, which is supposed to be when you 
start a work session with the computer.  You put stuff in there like an 
announcement of mail, displaying reminders, reading news, etc.

/etc/profile is the same, but for everyone.

.bashrc runs when an interactive shell starts that isn't a login shell, 
which is supposed to be as in opening  a new shell window.  You put stuff 
in there to customize your interactive experience -- key binding, screen 
colors, aliases, and the like.

Some builds of Bash have a system level version of this as 
/etc/bash.bashrc.

All of these are for shells that are being used by a human.  They can 
really mess up a "user" that is a machine.  The most important case of a 
non-human user is a shell script.

The rc file named by the BASH_ENV environment variable runs for every 
shell, interactive or not.  But this is hard to use for personalization 
because you need a place to personalize BASH_ENV.  It's also hard to use 
for anything else, because so many programs (including some Ssh daemons) 
cut off environment variable inheritance.

Now for the ugly hack:  An interactive shell is normally one whose 
Standard Input is a terminal.  But when rsh came about, Standard Input was 
a socket, even though the shell session was quite interactive.  So Bash 
contains code that looks at several conditions consistent with an rsh 
session and if it determines that it is probably being run as the backend 
of an rsh session, it treats the shell as interactive.  Openssh 'ssh' 
doesn't need this hack, because Sshd uses a pseudo-terminal instead of a 
socket as the shell's Standard Input.  But Openssh's 'scp' falls into the 
trap and gets taken as an interactive human user of the shell.  So .bashrc 
runs.  Many are the scp sessions I've tortured with my .bashrc, and spent 
hours debugging.  (I finally removed the hack from Bash and regained 
sanity).

A design for user-specific namespaces that relies on this particular hack 
would not be clean.

On the other hand, it is possible to customize any scp backend session 
just by making a personal wrapper for the scp backend program.  The 
wrapper can do the setup -- either directly or by running an "scprc" file. 
 With Openssh, you can choose the backend program in various places.

--
Bryan Henderson                          IBM Almaden Research Center
San Jose CA                              Filesystems
