Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269250AbRHYWTD>; Sat, 25 Aug 2001 18:19:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269515AbRHYWSy>; Sat, 25 Aug 2001 18:18:54 -0400
Received: from adsl-204-0-249-112.corp.se.verio.net ([204.0.249.112]:49648
	"EHLO tabby.cats-chateau.net") by vger.kernel.org with ESMTP
	id <S269250AbRHYWSi>; Sat, 25 Aug 2001 18:18:38 -0400
From: Jesse Pollard <jesse@cats-chateau.net>
Reply-To: jesse@cats-chateau.net
To: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>,
        VDA <VDA@port.imtp.ilyichevsk.odessa.ua>,
        Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Subject: Re: Could NFS daemons be started via inetd?
Date: Sat, 25 Aug 2001 16:56:18 -0500
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200108221341.IAA35277@tomcat.admin.navo.hpc.mil> <1209174562.20010825171357@port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <1209174562.20010825171357@port.imtp.ilyichevsk.odessa.ua>
MIME-Version: 1.0
Message-Id: <01082517182400.12578@tabby>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Aug 2001, VDA wrote:
>Hello Jesse,
>
>Wednesday, August 22, 2001, 4:41:00 PM, you wrote:
>>> I am setting up NFS on my Linux box.
>>> When I start server daemons from init scripts or by hand,
>>> everything is working fine.
>>> 
>>> I tried to arrange these daemons to be run by inetd
>>> but after I issue an NFS mount command inetd starts spawning
>>> tons on rpc.mountd daemons. Log is filled with:
>>> ...
>>> Does anybody tried this? If you do, I am very interested in your
>>> inetd.conf and/or NFS part of startup script. Mine is:
>
>> Simple answer - no.
>> The reason it can't is in two parts:
>> 1. these daemons create their own socket rather than recieving one
>>    from inetd.
>
>Please enlighten me: do daemons need to be writted with some support
>code specific for inetd in order to be compatible with it?

not really:

Daemons started by inetd inherit the socket as inetd actually holds the
open socket.

NFS daemons, on the other hand, open an available socket (some use unreserved
sockets), then connect to portmap/rpcbind to inform portmap of the mapping.

Sendmail is similar - without a special flag to say "don't initialize socket,
use inherited", it won't work either - even though both can specify port
25 for use.

>> 2. The daemons must connect to rpcbind or portmap. Usually this daemon
>>    is not running at the time inetd is started.
>
>I have rpc.portmap started just before inetd in my init script.
>BTW, how portmapper
>
>> These daemons must run all the time or performance will be REALLY bad. Each
>> connection may request ~ 8K bytes of data.
>
>For now, my machine is under very light load (around 0.0) so this is
>not a problem.
>But I experiment a lot with different Linux toys
>(NFS,Samba,TFTP,BOOTP/DHCP,PostgreSQL,MySQL). I'd like to configure it
>so that under light load daemons die out, leaving bare minimum
>(ideally, inetd only)

That is exactly what you want in a file server (even if there are a lot
of NFS daemons present. What you don't want is to have to wait .1 second
for the process to be forked/execed. This ends up happening for every block
read from disk.

>I presume daemons spawned by inetd are supposed to be designed so they
>lurk around for some time in case some more requests are coming for them
>and die after a timeout? Can they be made to spawn additional daemons when
>load increases? This behavior would be nice - no need to guess how
>many nfsd daemons to spawn for NFS, httpd's for HTTP etc.

That depends on the daemon.

Things like telnetd (ftpd, rshd, rlogind ...) don't wait around. Once they are
spawned off by inetd, inetd goes back to waiting for another connection on the
original socket. UDP daemons don't wait around either - these don't have a
permanent connection anyway and can only process one packet, then must either
exit, or provide something else to tell the remote system to use a different
port.

It is possible for daemons to do this, just not often done. Some data server
processes can do that. There just aren't any common ones (too much work in
providing user identification, authentication, and authorization - slows them
down too much).

NFS doesn't use connections established that way:

1. client contacts portmap to locate the service/port desired (mountd is
   part of this)
2. portmap returns target UDP port.
3. client uses that port to send NFS request to (handled by biod on the client).
4. all NFS daemons (depending on implmentations) will wakeup and read the
   NFS request (first one there gets it)... ((( better implementations will
	have the daemons waiting in a queue and only one will wake up at a
	time)))
5. The NFS Daemon replies to the biod on the client, which in turn passes
   the data back to the kernel and on to the user process.

This is also why a delay/timeout can occur if the server crashes. (the port
changes). The servers lockd/rpcstatd resynchronize with the remote hosts forcing
a remount of the NFS file system. This re-identifies the port nfsd is listening
on to the client. It also reestablishes any file locks (NOT guaranteed between
client systems though - it attempts to provide shared locking.. it just
doesn't quite work. Better than nothing, it does work with multiple processes
on ONE client. Each client is consistant with itself, but not with other
clients).

>Want to know why I'm asking all this?
>Go to http://port.imtp.ilyichevsk.odessa.ua/vda/
-- 
-------------------------------------------------------------------------
Jesse I Pollard, II
Email: jesse@cats-chateau.net

Any opinions expressed are solely my own.
