Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266204AbUHXEuV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266204AbUHXEuV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 00:50:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266535AbUHXEuV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 00:50:21 -0400
Received: from jack.feedbackplusinc.com ([64.25.11.70]:59605 "EHLO
	jack.feedbackplusinc.com") by vger.kernel.org with ESMTP
	id S266204AbUHXEuI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 00:50:08 -0400
Subject: setpeuid(pid_t, uid_t) proposal
From: Jerry Haltom <wasabi@larvalstage.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Mon, 23 Aug 2004 23:50:05 -0500
Message-Id: <1093323005.1248.21.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.93 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please CC me on any responses.

Now... this is my first post to the LKML concerning anything useful or
practical, so bear with me. I'm trying my best to explain my idea. :)
Also, I'm new (very new) to kernel hacking, so I may have missed
something extremely important.

I want to propose a new base system function (and cooresponding
syscall). I am tentivly calling this function setpeuid(). The function
will be fairly simple:

Only a process with uid 0 may call it. The first argument is a process
id. The second argument is a uid. The function is effictivly the exact
same as seteuid() except that it operates on another process. Very
simple explanation, now here's why.

One of the problems that I've been presented with regularly when working
with Linux (and Unix in particular) is the lack of what other operating
systems call "impersonation". The ability of one process not running as
root to assume the identity (for a limited time) of another user ID.
Securely.

My most recent experience I've been confronted with involving this is
with Apache hosting a WebDAV server. WebDAV is sort of a remote file
system hosted through HTTP. Apache sends and receives HTTP posts, to
alter remote files. Most of you probably know this.

The problem is when accessing a multiuser WebDAV file system over HTTP,
Apache on the server must either a) run as root, or b) do some really
weird suid stuff. This is because it must have access to all files that
the requesting user would have access to. This causing a number of
problems: Apache has more access than it needs. Files are edited as
root, sometimes this doesn't work such as if those files are available
over NFS or another similar situation. Files are created as root,
probably with the wrong umask. There are a lot of problems. ;)

These problems would be solved if Apache could run as the user that was
requesting access on the server: given shared user accounts. It would
only have access to what it needs to have access to.

So, that's what's broken now. Here's the situation I'd like to be able
to put myself into.

Apache runs as a low privledge user, but can obtain the permissions of
the user that requested the service. Apache can't give itself access, so
it relies on a seperate process to do so. A request is received to
Apache. The request comes with authentication information (in a number
of forms, Basic, Kerberos (GSSAPI), CRAM, NTLM, whatever). The
authentication information is received by the Apache module that handles
the specific authentication type. This module passes the security
information to a seperate stand alone daemon, which is running as root.
This daemon is highly audited and does one purpose, and does it well.
The daemon processes the security crediantials, validates them, uses
whatever policy is neccassary to determine if the user is authorized,
and then setpeuid's the calling process (Apache). The apache module now
returns, the request proceeds. When the request is over, the process
goes back to the user it was previously (either by signaling the daemon
it is done, or calling yet another new function: resetpeuid()).

That's just one use case... there are a number of others. Such as a
secure "Run As" feature for desktop users... FTP servers, SSH could even
use it to totally remove the need for any root presence. There are a
number of possibilities. Too many to list. Use your imagination.

Anyways, the function required is pretty simple. I'd like some of you
wizzes to tell me what's wrong with my thinking.

In the mean time, I'm working on implementing this right now to see how
it goes. But this is my first actual kernel hacking, so we'll see. ;)

Thanks for your time.


Jerry Haltom <wasabi@larvalstage.net>


