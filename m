Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261839AbSLDONv>; Wed, 4 Dec 2002 09:13:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266384AbSLDONv>; Wed, 4 Dec 2002 09:13:51 -0500
Received: from 200-206-134-238.async.com.br ([200.206.134.238]:40090 "EHLO
	anthem.async.com.br") by vger.kernel.org with ESMTP
	id <S261839AbSLDONr>; Wed, 4 Dec 2002 09:13:47 -0500
Date: Wed, 4 Dec 2002 12:20:15 -0200
From: Christian Reis <kiko@async.com.br>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel@vger.kernel.org, NFS@lists.sourceforge.net
Subject: Re: 2.4.19+trond and diskless locking problems
Message-ID: <20021204122015.G7742@blackjesus.async.com.br>
References: <20021003184418.K3869@blackjesus.async.com.br> <15845.11182.384531.599421@charged.uio.no> <20021128232911.G18175@blackjesus.async.com.br> <200212021921.24330.trond.myklebust@fys.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200212021921.24330.trond.myklebust@fys.uio.no>; from trond.myklebust@fys.uio.no on Mon, Dec 02, 2002 at 07:21:24PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hey there. Another update on the wierd hangs. After rebooting the server
(and cleaning up /var/lib/nfs/sm consequently) we've had a couple of
days with no hangs. I've been keeping an eye on that directory closely
the past days to see if we have leftover entries there, and today one
showed up:

anthem:~$ date
Wed Dec  4 11:59:31 BRDT 2002
anthem:~$ sudo ls -l /var/lib/nfs/sm
total 0
-rw-------   1 root     root            0 Dec  4 08:47 192.168.99.7

So I have a file there that has been untouched for over 3 hours now.
Having a look at the logfile, I have:

    [... bootup messages culminating in ntpd startup ]

    Dec  4 08:44:16 canario ntpd[317]: kernel time discipline status 0040
    Dec  4 08:44:16 canario ntpd[317]: frequency initialized -97.153
    from /var/lib/ntp/driftfile.canario
    Dec  4 08:47:22 canario rpc.statd[101]: Received erroneous SM_UNMON
    request from canario for 192.168.99.4

    [ same time as file above, see ]

    Dec  4 08:48:47 canario ntpd[317]: kernel time discipline status change 41
    Dec  4 08:50:01 canario /USR/SBIN/CRON[425]: (smmsp) CMD (test -x
    /usr/share/sendmail/sendmail && /usr/share/sendmail/sendmail cron-msp)

    [... more bootup messages]

The reboot log from the night before shows a series of 8 erroneous
SM_UNMON messenges for a period of about an hour before the actual
reboot. The machine was shut down unclean the time before that (well,
as unclean as an NFS-mounted box can be).

And, sure enough, when shutting down this box now, we get the
stalls/pauses again. nlm_debug outputs for both the client and the
server (neat 30s intervals show up :-) - I've selected specific seconds
of activity (i.e. there was a set of entries at 12:06:32 before):

    CLIENT:

    Dec  4 12:07:02 canario kernel: lockd: nlm_bind_host(c0a86304)
    Dec  4 12:07:02 canario kernel: lockd: next rebind in 6000 jiffies
    Dec  4 12:07:02 canario kernel: lockd: get host 192.168.99.4
    Dec  4 12:07:02 canario kernel: lockd: release host 192.168.99.4
    Dec  4 12:07:02 canario kernel: lockd: release host 192.168.99.4
    Dec  4 12:07:02 canario kernel: lockd: nlm_lookup_host(c0a86304, p=17, v=4)
    Dec  4 12:07:02 canario kernel: lockd: host garbage collection
    Dec  4 12:07:02 canario kernel: lockd: nlmsvc_mark_resources
    Dec  4 12:07:02 canario kernel: lockd: get host 192.168.99.4
    Dec  4 12:07:02 canario kernel: lockd: nlm_bind_host(c0a86304)
    Dec  4 12:07:02 canario kernel: lockd: release host 192.168.99.4
    Dec  4 12:07:02 canario kernel: lockd: nlm_lookup_host(c0a86304, p=17, v=4)
    Dec  4 12:07:02 canario kernel: lockd: get host 192.168.99.4
    Dec  4 12:07:02 canario kernel: lockd: nlm_bind_host(c0a86304)
    Dec  4 12:07:32 canario kernel: lockd: nlm_bind_host(c0a86304)
    Dec  4 12:07:32 canario kernel: lockd: get host 192.168.99.4
    Dec  4 12:07:32 canario kernel: lockd: release host 192.168.99.4
    Dec  4 12:07:32 canario kernel: lockd: release host 192.168.99.4
    Dec  4 12:07:32 canario kernel: lockd: nlm_lookup_host(c0a86304, p=17, v=4)
    Dec  4 12:07:32 canario kernel: lockd: get host 192.168.99.4
    Dec  4 12:07:32 canario kernel: lockd: nlm_bind_host(c0a86304)
    Dec  4 12:07:32 canario kernel: lockd: release host 192.168.99.4
    Dec  4 12:07:32 canario kernel: lockd: nlm_lookup_host(c0a86304, p=17, v=4)
    Dec  4 12:07:32 canario kernel: lockd: get host 192.168.99.4
    Dec  4 12:07:32 canario kernel: lockd: nlm_bind_host(c0a86304)

    SERVER:

    Dec  4 12:07:02 anthem kernel: lockd: request from c0a86307
    Dec  4 12:07:02 anthem kernel: lockd: nlm_lookup_host(c0a86307, p=17, v=4)
    Dec  4 12:07:02 anthem kernel: lockd: get host 192.168.99.7
    Dec  4 12:07:02 anthem kernel: lockd: nlm_file_lookup(06000001 0b000900 00000002 0000fd3a 0000fd16 000108a8)
    Dec  4 12:07:02 anthem kernel: lockd: found file c1d1f380 (count 0)
    Dec  4 12:07:02 anthem kernel: lockd: nlmsvc_cancel(090b/64826, pi=1, 0-9223372036854775807)
    Dec  4 12:07:02 anthem kernel: lockd: nlmsvc_lookup_block f=c1d1f380 pd=1 0-9223372036854775807 ty=1
    Dec  4 12:07:02 anthem kernel: lockd: check f=c1d1f380 pd=1 0-9223372036854775807 ty=1 cookie=1393
    Dec  4 12:07:02 anthem kernel: lockd: deleting block d12e9000...
    Dec  4 12:07:02 anthem kernel: lockd: unblocking blocked lock
    Dec  4 12:07:02 anthem kernel: lockd: release host 192.168.99.7
    Dec  4 12:07:02 anthem kernel: lockd: release host 192.168.99.7
    Dec  4 12:07:02 anthem kernel: lockd: nlm_release_file(c1d1f380, ct = 1)
    Dec  4 12:07:02 anthem kernel: nlmsvc_retry_blocked(00000000, when=0)
    Dec  4 12:07:02 anthem kernel: nlmsvc_retry_blocked(00000000, when=0)
    Dec  4 12:07:02 anthem kernel: lockd: request from c0a86307
    Dec  4 12:07:02 anthem kernel: lockd: nlm_lookup_host(c0a86307, p=17, v=4)
    Dec  4 12:07:02 anthem kernel: lockd: get host 192.168.99.7
    Dec  4 12:07:02 anthem kernel: lockd: nlm_file_lookup(06000001 0b000900 00000002 0000fd3a 0000fd16 000108a8)
    Dec  4 12:07:02 anthem kernel: lockd: found file c1d1f380 (count 0)
    Dec  4 12:07:02 anthem kernel: lockd: nlmsvc_unlock(090b/64826, pi=1, 0-9223372036854775807)
    Dec  4 12:07:02 anthem kernel: lockd: nlmsvc_cancel(090b/64826, pi=1, 0-9223372036854775807)
    Dec  4 12:07:02 anthem kernel: lockd: nlmsvc_lookup_block f=c1d1f380 pd=1 0-9223372036854775807 ty=2
    Dec  4 12:07:02 anthem kernel: lockd: release host 192.168.99.7
    Dec  4 12:07:02 anthem kernel: lockd: nlm_release_file(c1d1f380, ct = 1)
    Dec  4 12:07:02 anthem kernel: nlmsvc_retry_blocked(00000000, when=0)
    Dec  4 12:07:02 anthem kernel: nlmsvc_retry_blocked(00000000, when=0)
    Dec  4 12:07:02 anthem kernel: lockd: request from c0a86307
    Dec  4 12:07:02 anthem kernel: lockd: nlm_lookup_host(c0a86307, p=17, v=4)
    Dec  4 12:07:02 anthem kernel: lockd: get host 192.168.99.7
    Dec  4 12:07:02 anthem kernel: lockd: nlm_file_lookup(06000001 0b000900 00000002 0000fd3a 0000fd16 000108a8)
    Dec  4 12:07:02 anthem kernel: lockd: found file c1d1f380 (count 0)
    Dec  4 12:07:02 anthem kernel: lockd: nlmsvc_lock(090b/64826, ty=1, pi=1, 0-9223372036854775807, bl=1)
    Dec  4 12:07:02 anthem kernel: lockd: nlmsvc_lookup_block f=c1d1f380 pd=1 0-9223372036854775807 ty=1
    Dec  4 12:07:02 anthem kernel: lockd: blocking on this lock (allocating).
    Dec  4 12:07:02 anthem kernel: lockd: nlm_lookup_host(c0a86307, p=17, v=4)
    Dec  4 12:07:02 anthem kernel: lockd: get host 192.168.99.7
    Dec  4 12:07:02 anthem kernel: lockd: created block d12e9000...
    Dec  4 12:07:02 anthem kernel: lockd: nlmsvc_insert_block(d12e9000, -1)
    Dec  4 12:07:02 anthem kernel: lockd: blocking on this lock.
    Dec  4 12:07:02 anthem kernel: lockd: release host 192.168.99.7
    Dec  4 12:07:02 anthem kernel: lockd: nlm_release_file(c1d1f380, ct = 1)
    Dec  4 12:07:02 anthem kernel: nlmsvc_retry_blocked(d12e9000, when=-1)
    Dec  4 12:07:02 anthem kernel: nlmsvc_retry_blocked(d12e9000, when=-1)
    Dec  4 12:07:32 anthem kernel: lockd: request from c0a86307
    Dec  4 12:07:32 anthem kernel: lockd: nlm_lookup_host(c0a86307, p=17, v=4)
    Dec  4 12:07:32 anthem kernel: lockd: host garbage collection
    Dec  4 12:07:32 anthem kernel: lockd: nlmsvc_mark_resources
    Dec  4 12:07:32 anthem kernel: lockd: get host 192.168.99.7
    Dec  4 12:07:32 anthem kernel: lockd: nlm_file_lookup(06000001 0b000900 00000002 0000fd3a 0000fd16 000108a8)
    Dec  4 12:07:32 anthem kernel: lockd: found file c1d1f380 (count 0)
    Dec  4 12:07:32 anthem kernel: lockd: nlmsvc_cancel(090b/64826, pi=1, 0-9223372036854775807)
    Dec  4 12:07:32 anthem kernel: lockd: nlmsvc_lookup_block f=c1d1f380 pd=1 0-9223372036854775807 ty=1
    Dec  4 12:07:32 anthem kernel: lockd: check f=c1d1f380 pd=1 0-9223372036854775807 ty=1 cookie=1396
    Dec  4 12:07:32 anthem kernel: lockd: deleting block d12e9000...
    Dec  4 12:07:32 anthem kernel: lockd: unblocking blocked lock
    Dec  4 12:07:32 anthem kernel: lockd: release host 192.168.99.7
    Dec  4 12:07:32 anthem kernel: lockd: release host 192.168.99.7
    Dec  4 12:07:32 anthem kernel: lockd: nlm_release_file(c1d1f380, ct = 1)
    Dec  4 12:07:32 anthem kernel: nlmsvc_retry_blocked(00000000, when=0)
    Dec  4 12:07:32 anthem kernel: nlmsvc_retry_blocked(00000000, when=0)
    Dec  4 12:07:32 anthem kernel: lockd: request from c0a86307
    Dec  4 12:07:32 anthem kernel: lockd: nlm_lookup_host(c0a86307, p=17, v=4)
    Dec  4 12:07:32 anthem kernel: lockd: get host 192.168.99.7
    Dec  4 12:07:32 anthem kernel: lockd: nlm_file_lookup(06000001 0b000900 00000002 0000fd3a 0000fd16 000108a8)
    Dec  4 12:07:32 anthem kernel: lockd: found file c1d1f380 (count 0)
    Dec  4 12:07:32 anthem kernel: lockd: nlmsvc_unlock(090b/64826, pi=1, 0-9223372036854775807)
    Dec  4 12:07:32 anthem kernel: lockd: nlmsvc_cancel(090b/64826, pi=1, 0-9223372036854775807)
    Dec  4 12:07:32 anthem kernel: lockd: nlmsvc_lookup_block f=c1d1f380 pd=1 0-9223372036854775 807 ty=2
    Dec  4 12:07:32 anthem kernel: lockd: release host 192.168.99.7
    Dec  4 12:07:32 anthem kernel: lockd: nlm_release_file(c1d1f380, ct = 1)
    Dec  4 12:07:32 anthem kernel: nlmsvc_retry_blocked(00000000, when=0)
    Dec  4 12:07:32 anthem kernel: nlmsvc_retry_blocked(00000000, when=0)
    Dec  4 12:07:32 anthem kernel: lockd: request from c0a86307
    Dec  4 12:07:32 anthem kernel: lockd: nlm_lookup_host(c0a86307, p=17, v=4)
    Dec  4 12:07:32 anthem kernel: lockd: get host 192.168.99.7
    Dec  4 12:07:32 anthem kernel: lockd: nlm_file_lookup(06000001 0b000900 00000002 0000fd3a 0000fd16 000108a8)
    Dec  4 12:07:32 anthem kernel: lockd: found file c1d1f380 (count 0)
    Dec  4 12:07:32 anthem kernel: lockd: nlmsvc_lock(090b/64826, ty=1, pi=1, 0-9223372036854775 807, bl=1)
    Dec  4 12:07:32 anthem kernel: lockd: nlmsvc_lookup_block f=c1d1f380 pd=1 0-9223372036854775 807 ty=1
    Dec  4 12:07:32 anthem kernel: lockd: blocking on this lock (allocating).
    Dec  4 12:07:32 anthem kernel: lockd: nlm_lookup_host(c0a86307, p=17, v=4)
    Dec  4 12:07:32 anthem kernel: lockd: get host 192.168.99.7
    Dec  4 12:07:32 anthem kernel: lockd: created block d12e9000...
    Dec  4 12:07:32 anthem kernel: lockd: nlmsvc_insert_block(d12e9000, -1)
    Dec  4 12:07:32 anthem kernel: lockd: blocking on this lock.
    Dec  4 12:07:32 anthem kernel: lockd: release host 192.168.99.7
    Dec  4 12:07:32 anthem kernel: lockd: nlm_release_file(c1d1f380, ct = 1)
    Dec  4 12:07:32 anthem kernel: nlmsvc_retry_blocked(d12e9000, when=-1)
    Dec  4 12:07:32 anthem kernel: nlmsvc_retry_blocked(d12e9000, when=-1)

HTH. Yes, we're all sick of this subject :-/

Take care,
--
Christian Reis, Senior Engineer, Async Open Source, Brazil.
http://async.com.br/~kiko/ | [+55 16] 261 2331 | NMFL
