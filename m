Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264178AbTKKBVV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 20:21:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264188AbTKKBVV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 20:21:21 -0500
Received: from sccrmhc12.comcast.net ([204.127.202.56]:7051 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S264178AbTKKBVK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 20:21:10 -0500
Subject: Re: OT: why no file copy() libc/syscall ??
From: Albert Cahalan <albert@users.sf.net>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Cc: davide.rossetti@roma1.infn.it, filia@softhome.net, jesse@cats-chateau.net,
       dwmw2@infradead.org, moje@vabo.cz, kakadu_croc@yahoo.com
Content-Type: text/plain
Organization: 
Message-Id: <1068512710.722.161.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 10 Nov 2003 20:05:11 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It is too simple to implement in user mode.

That works for a plain byte-stream on a
local UNIX-style filesystem. (though it
likely isn't the fastest)

It doesn't work for Macintosh files.
It's too slow for CIFS over a modem.
It doesn't work for Windows security data.
It doesn't allow copy-on-write files.
It eats CPU time on compressed filesystems.

> The security context of the output depends
> on the user process. If it is a privileged
> process (ie, may change the context of the
> result) then the user process has to setup
> that context before the file is copied.

So open the file, change context, and then:

long copy_fd_to_file(int fd, const char *name, ...)

(if you can no longer read from the OPEN fd,
either we override that or we just don't care
about such mostly-fictional cases)

> There are also some issues with mandatory
> security controls. If it is copied in kernel
> mode, then the previous labels could be
> automatically carried over to the resulting
> file... But that may not be what you want
> (and frequently, it isn't).

If it matters:

// security as if a new file were created
#define CF_REPLACE_SECURITY 0x00000001
// if unable to replicate, up or down?
#define CF_ROUND_SECURITY_UP 0x00000002
#define CF_ROUND_SECURITY_DOWN 0x00000004
// fail if security can't be replicated
#define CF_SECURITY_EXACT 0x00000008

> Now back to the copy.. You don't have to
> use a read/write loop- mmap is faster.

It's slower. (this is Linux, not SunOS)
Use a 4 kB or 8 kB read/write loop.

> And this is the other reason for not doing
> it in Kernel mode. Buffer management of
> this type is much easier in user space
> since the copy procedure doesn't have to
> deal with memory limitations, cache flushes
> page faulting of processes unrelated to the
> copy, but is related to cache pressure.

Buffer management is very much a kernel thing.

>> Is it? Please explain the simple steps which
>> cp(1) should take in order to observe that it
>> is being asked to duplicate a file on a file
>> system such as CIFS (or NFSv4?) which allows
>> the client to issue a 'copy file' command
>> over the network without actually transferring
>> the data twice, and to invoke such a command.
>
> Ah. That is an optimization question, not a
> question of kernel/user mode.

Note that /bin/cp isn't always going to have
the necessary passwords and such. You're headed
down a path toward setuid /bin/cp.

> Since the error checking for source and
> destination both include doing a stat and
> statfs, the device information (and FS info)
> can both be retrieved.
>
> And mmap doesn't require data transfer "twice"
> (local copy).

Huh? Over the network from server to client
counts as once. Then /bin/cp gets the data.
Then it goes back over the network from the
client to the server. That's "twice". That's
horribly painful for a multi-gigabyte file
and a DSL or cable-modem connection, never
mind a dial-up connection.

> Since that copy only pagefaults (though
> read/write may be faster for some files
> - I thought that was true for small files
> that fit in cache, and large files faster
> via mmap and depends on the page size;
> and the tradeoff would be system dependant).

Keep the read/write loop small for speed.

> And since both source and destination may
> be remote you do get to decide based on
> source and destination devices: if they
> are the same, and one on a remote node,
> then BOTH will be on the remote, then you
> get to use the CIFS/NFS file copy. (check
> the doc on "stat/statfs" for additional info).
>
> I don't believe it works when source and
> destination are on DIFFERENT remote nodes,
> though.
>
> Strictly up to the implementation of cp/mv.
>
> Though you will loose portability of cp/mv.
> (Of course, you also loose it with a syscall
> for file copy too; as well as the MUCH more
> complicated implementation/security checks).

Doing that in cp/mv is just insane. For one,
it bypasses any local security control over
access to the filesystem. There's not even a
way to be sure you're dealing with the server
you think you're dealing with.


