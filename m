Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266221AbUH1UhS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266221AbUH1UhS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 16:37:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266643AbUH1Uf7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 16:35:59 -0400
Received: from the-village.bc.nu ([81.2.110.252]:8320 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268004AbUH1URz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 16:17:55 -0400
Subject: Re: setpeuid(pid_t, uid_t) proposal
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jerry Haltom <wasabi@larvalstage.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1093323005.1248.21.camel@localhost>
References: <1093323005.1248.21.camel@localhost>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1093353063.2810.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 28 Aug 2004 20:15:28 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2004-08-24 at 05:50, Jerry Haltom wrote:
> One of the problems that I've been presented with regularly when working
> with Linux (and Unix in particular) is the lack of what other operating
> systems call "impersonation". The ability of one process not running as
> root to assume the identity (for a limited time) of another user ID.
> Securely.

For the file system case there is setfsuid. You can also make use
of seperate effective/real/saved uids through setreuid() and friends.
setfsuid() also addresses the other problem - if a process switches
fully to my ID then I can play with it - kill it etc.

> These problems would be solved if Apache could run as the user that was
> requesting access on the server: given shared user accounts. It would
> only have access to what it needs to have access to.

This is actually not hard to do if your server is designed to be a
little smarter. The apache model doesn't fit it well although apache
could make some use of setfsuid() as unfsd (user mode nfsd does) and it
does support doing this through suexec.

One little non-obvious trick that might make this work faster would be 
to keep track of running webdav servers for each active user and use 
a redirect from the main server to communicate with it, and when the 
client has idled out to reclaim it and hand the port back to the main
server instance so that users get redirected again

> That's just one use case... there are a number of others. Such as a
> secure "Run As" feature for desktop users... FTP servers, SSH could even
> use it to totally remove the need for any root presence. There are a
> number of possibilities. Too many to list. Use your imagination.

sshd can already do this. The "run as root" desktop feature already
exists using the existing auth functionality (see "usermode")

> Anyways, the function required is pretty simple. I'd like some of you
> wizzes to tell me what's wrong with my thinking.

Actually its easy to implement and horrible to get right - there is no
locking on uid changes. When a task is in a syscall the entire syscall
knows that the security for the process will not be changing.

> In the mean time, I'm working on implementing this right now to see how
> it goes. But this is my first actual kernel hacking, so we'll see. ;)

Have fun - the security stuff is hard but getting something working as
you describe for learning purposes and armwaving that issue should be
nice little project.

Alan

