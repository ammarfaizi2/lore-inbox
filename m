Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750789AbWCADyU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750789AbWCADyU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 22:54:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751100AbWCADyT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 22:54:19 -0500
Received: from moutng.kundenserver.de ([212.227.126.177]:35801 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1750789AbWCADyT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 22:54:19 -0500
From: Hauke Laging <mailinglisten@hauke-laging.de>
To: linux-kernel@vger.kernel.org
Subject: Re: VFS: Dynamic umask for the access rights of linked objects
Date: Wed, 1 Mar 2006 04:54:15 +0100
User-Agent: KMail/1.8.2
References: <200603010328.42008.mailinglisten@hauke-laging.de> <44050AB7.7020202@vilain.net>
In-Reply-To: <44050AB7.7020202@vilain.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200603010454.15223.mailinglisten@hauke-laging.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:02bdc4d6ea016d90f9ef4145f50516b2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch 01 März 2006 03:45 schrieb Sam Vilain:

> Of course this doesn't work if, like /tmp and /var/tmp are shipped as on
> every distribution, the directory has permissions 1777.

I had this idea after the announcement of such a security problem in an 
antivirus software. The rpm package was buggy and set wrong rights for the 
installation directory /usr/whatever. So this is a real-world problem.

In the German Usenet group for shell scripts this problem is mentioned from 
time to time, too. It may arise if not so clever software works with "user 
files" (e.g. in the home directories) and does not notice the symlinks.


> What problem you are trying to solve?

I want to prevent the case that superuser processes accidentally read or 
write (system) files because they have been redirected there by a symlink 
which has been created by a user who cannot access (or at least write) 
these files hinself.


> Why does it matter what the ownership of the symlink is?

If the symlink has been created by root or the application itself then 
there is no risk of abuse because both would have been able to cause the 
intended damage themselves. The attacking user can create the symlink but 
he cannot prevent his uid being stored with the link.

After all symlinks are not "bad by design" but can be dangerous under very 
certain circumstances. These can be identified by the owner of the symlink 
being less privileged than the accessing process.


> Reading the page, the considerations about hard links seem quite off the
> mark.  If somebody creates a hard link to one of your files, it *is* the
> same file, just with a different name.  So it becomes the same problem
> as the first one.

Your right with the fact but not with the conclusion: Because it is not 
(reliably) possible to understand the situation after the hard link has 
been created my approach for soft links does not work. Thus I had the idea 
to solve this problem earlier, on link creation. At that moment you can 
check what's up and disallow the operation if it looks strange.


> You should at least describe your envisioned scenario in a step
> by step basis, highlighting your concerns.

OK:
1) There is a process which superuser rights which will write to /foo/bar.

That may be a daemon writing its own file or some superuser/sudo process 
which works on user files (and relies on the users to be nice - if aware 
of the problem at all). The process may need superuser rights to collect 
data for the user and stores it in the users home directory.

2) The attacking user need be able to write the target directory. This may 
be due to a bug in the daemon software (or its installer) or even be 
intended.

3) The user replaces the target file by a symlink to a file he cannot write 
himself: ln -s /etc/passwd /foo/bar

4) The VFS determines that /foo/bar is a symlink and checks whether the 
process may write to it. It may.

5) Under current circumstances the process would kill /etc/passwd now and 
the system would be dead. In more complicated situations it may be 
possible to make the process store certain data there or to read 
unreadable files.

6) In my scenario the VFS would add a step after 4): It would check if the 
symlink has been created by someone different from the process's uid and 
from root. If so there is the risk of abuse and the access check would be 
repeated for the symlink owner.

7) The VFS would find out that the symlink owner is not allowed to write 
to /etc/passwd. Thus the write access is prohibited, even for a process 
with superuser rights.


A part of this problem has to do with the "rm effect" but deleting 
application files if the app's installer is to stupid to protect it is one 
thing allowing to overwrite every system file by such a bug is something 
different. The problem may be not very frequent but on the other hand the 
implementation should be simple (steps 6 and 7).


Best regards,

Hauke
