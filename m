Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266926AbSK2B2t>; Thu, 28 Nov 2002 20:28:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266927AbSK2B2D>; Thu, 28 Nov 2002 20:28:03 -0500
Received: from 200-206-134-238.async.com.br ([200.206.134.238]:10882 "EHLO
	anthem.async.com.br") by vger.kernel.org with ESMTP
	id <S266926AbSK2B04>; Thu, 28 Nov 2002 20:26:56 -0500
Date: Thu, 28 Nov 2002 23:34:12 -0200
From: Christian Reis <kiko@async.com.br>
To: NFS@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: 2.4.19+trond and diskless locking problems
Message-ID: <20021128233412.A18448@blackjesus.async.com.br>
References: <20021003184418.K3869@blackjesus.async.com.br> <shsy99f16np.fsf@charged.uio.no> <20021003202602.M3869@blackjesus.async.com.br> <15772.60202.510717.850059@charged.uio.no> <20021120120223.A15034@blackjesus.async.com.br> <15835.49194.109931.227732@charged.uio.no> <20021126224123.A9660@blackjesus.async.com.br> <15844.7306.735524.133781@charged.uio.no> <20021127150828.A12120@blackjesus.async.com.br> <15845.11182.384531.599421@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <15845.11182.384531.599421@charged.uio.no>; from trond.myklebust@fys.uio.no on Wed, Nov 27, 2002 at 09:31:42PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 27, 2002 at 09:31:42PM +0100, Trond Myklebust wrote:
> >>>>> " " == Christian Reis <kiko@async.com.br> writes:
> 
>      > What can I do to help further debug the issue? Try another
>      > kernel version on clients? Server? This is giving me a
>      > headache.. :-/
> 
> Try to give us a dump of the server lock manager activity when this
> problem occurs. Try to do
> 
> echo "217" >/proc/sys/sunrpc/nlm_debug

Okay, I've just done that. Just completing information, this server uses
ReiserFS filesystems, and I know we've had issues with knfsd and reiser
before, so I guess it's at least relevant to say. 

* The tcpdump output first for the first set of hangs (hangs start 15:37:15)

  [ Following a million nfs packets in the same second (:15): ]

15:37:15.606342 banzai.async.com.br.2337883237 > anthem.async.com.br.nfs: 112 lookup [|nfs] (DF)
15:37:15.606365 anthem.async.com.br.nfs > banzai.async.com.br.2337883237: reply ok 120 lookup [|nfs] (DF)
15:37:15.607877 banzai.async.com.br.792 > anthem.async.com.br.sunrpc: udp 56 (DF)
15:37:15.608384 anthem.async.com.br.sunrpc > banzai.async.com.br.792: udp 28 (DF)
15:37:15.608583 banzai.async.com.br.793 > anthem.async.com.br.sometimes-rpc4: udp 176 (DF)
15:37:15.609593 anthem.async.com.br.sometimes-rpc4 > banzai.async.com.br.793: udp 36 (DF)

  [ 3s here ]

15:37:18.032896 banzai.async.com.br.2421769317 > anthem.async.com.br.nfs: 116 lookup [|nfs] (DF)
15:37:18.032975 anthem.async.com.br.nfs > banzai.async.com.br.2421769317: reply ok 128 lookup [|nfs] (DF)
15:37:18.033392 banzai.async.com.br.2438546533 > anthem.async.com.br.nfs: 112 read [|nfs] (DF)
15:37:18.033449 anthem.async.com.br.nfs > banzai.async.com.br.2438546533: reply ok 720 read [|nfs] (DF)
15:37:18.034177 banzai.async.com.br.2455323749 > anthem.async.com.br.nfs: 116 lookup [|nfs] (DF)
15:37:18.034211 anthem.async.com.br.nfs > banzai.async.com.br.2455323749: reply ok 128 lookup [|nfs] (DF)
15:37:18.034490 banzai.async.com.br.2472100965 > anthem.async.com.br.nfs: 112 read [|nfs] (DF)
15:37:18.034534 anthem.async.com.br.nfs > banzai.async.com.br.2472100965: reply ok 816 read [|nfs] (DF)

  [ 10s here ]

15:37:28.041862 banzai.async.com.br.2488878181 > anthem.async.com.br.nfs: 100 getattr [|nfs] (DF)
15:37:28.042385 anthem.async.com.br.nfs > banzai.async.com.br.2488878181: reply ok 96 getattr [|nfs] (DF)
15:37:28.042820 banzai.async.com.br.2505655397 > anthem.async.com.br.nfs: 100 getattr [|nfs] (DF)
15:37:28.042892 anthem.async.com.br.nfs > banzai.async.com.br.2505655397: reply ok 96 getattr [|nfs] (DF)

  At this point, a pattern forms. Second 28 has nfs activity, then hangs
  till second 40. Second 40 has has nfs activity, then hangs till second
  45. Then second 04. Then second 15. Then 20... 

* The kernel log output when 217 is echoed to nlm_debug:

Nov 28 15:36:37 anthem kernel: eth0: Setting promiscuous mode.
Nov 28 15:37:15 anthem kernel: lockd: request from c0a86309
Nov 28 15:37:15 anthem kernel: lockd: nlm_lookup_host(c0a86309, p=17, v=4)
Nov 28 15:37:15 anthem kernel: lockd: host garbage collection
Nov 28 15:37:15 anthem kernel: lockd: nlmsvc_mark_resources
Nov 28 15:37:15 anthem kernel: lockd: get host 192.168.99.9
Nov 28 15:37:15 anthem kernel: lockd: nlm_file_lookup(06000001 0b000900 00000002 00006693 000071c9 0001dcc7)
Nov 28 15:37:15 anthem kernel: lockd: found file cbacccc0 (count 10)
Nov 28 15:37:15 anthem kernel: lockd: nlmsvc_lock(090b/26259, ty=1, pi=1, 0-9223372036854775807, bl=1)
Nov 28 15:37:15 anthem kernel: lockd: nlmsvc_lookup_block f=cbacccc0 pd=1 0-9223372036854775807 ty=1
Nov 28 15:37:15 anthem kernel: lockd: check f=cbacc4c0 pd=401 0-9223372036854775807 ty=1 cookie=1269
Nov 28 15:37:15 anthem kernel: lockd: check f=cbacccc0 pd=389 0-9223372036854775807 ty=1 cookie=1274
Nov 28 15:37:15 anthem kernel: lockd: check f=cbacccc0 pd=383 0-9223372036854775807 ty=1 cookie=1262
Nov 28 15:37:15 anthem kernel: lockd: check f=cbacccc0 pd=391 0-9223372036854775807 ty=1 cookie=1272
Nov 28 15:37:15 anthem kernel: lockd: check f=cbacccc0 pd=407 0-9223372036854775807 ty=1 cookie=1262
Nov 28 15:37:15 anthem kernel: lockd: check f=cbacccc0 pd=430 0-9223372036854775807 ty=1 cookie=1272
Nov 28 15:37:15 anthem kernel: lockd: check f=cbacccc0 pd=1 0-9223372036854775807 ty=1 cookie=124f
Nov 28 15:37:15 anthem kernel: lockd: nlmsvc_insert_block(c33be400, -1)
Nov 28 15:37:15 anthem kernel: lockd: release host 192.168.99.9
Nov 28 15:37:15 anthem kernel: lockd: nlm_release_file(cbacccc0, ct = 11)
Nov 28 15:37:15 anthem kernel: nlmsvc_retry_blocked(cbd6fc00, when=-1)
Nov 28 15:37:15 anthem kernel: nlmsvc_retry_blocked(cbd6fc00, when=-1)
Nov 28 15:37:45 anthem kernel: lockd: request from c0a86309
Nov 28 15:37:45 anthem kernel: lockd: nlm_lookup_host(c0a86309, p=17, v=4)
Nov 28 15:37:45 anthem kernel: lockd: get host 192.168.99.9
Nov 28 15:37:45 anthem kernel: lockd: nlm_file_lookup(06000001 0b000900 00000002 00006693 000071c9 0001dcc7)
Nov 28 15:37:45 anthem kernel: lockd: found file cbacccc0 (count 10)
Nov 28 15:37:45 anthem kernel: lockd: nlmsvc_cancel(090b/26259, pi=1, 0-9223372036854775807)
Nov 28 15:37:45 anthem kernel: lockd: nlmsvc_lookup_block f=cbacccc0 pd=1 0-9223372036854775807 ty=1
Nov 28 15:37:45 anthem kernel: lockd: check f=cbacc4c0 pd=401 0-9223372036854775807 ty=1 cookie=1269
Nov 28 15:37:45 anthem kernel: lockd: check f=cbacccc0 pd=389 0-9223372036854775807 ty=1 cookie=1274
Nov 28 15:37:45 anthem kernel: lockd: check f=cbacccc0 pd=383 0-9223372036854775807 ty=1 cookie=1262
Nov 28 15:37:45 anthem kernel: lockd: check f=cbacccc0 pd=391 0-9223372036854775807 ty=1 cookie=1272
Nov 28 15:37:45 anthem kernel: lockd: check f=cbacccc0 pd=407 0-9223372036854775807 ty=1 cookie=1262
Nov 28 15:37:45 anthem kernel: lockd: check f=cbacccc0 pd=430 0-9223372036854775807 ty=1 cookie=1272
Nov 28 15:37:45 anthem kernel: lockd: check f=cbacccc0 pd=326 0-9223372036854775807 ty=1 cookie=1250
Nov 28 15:37:45 anthem kernel: lockd: check f=cbacccc0 pd=1 0-9223372036854775807 ty=1 cookie=124f
Nov 28 15:37:45 anthem kernel: lockd: deleting block c33be400...
Nov 28 15:37:45 anthem kernel: lockd: unblocking blocked lock
Nov 28 15:37:45 anthem kernel: lockd: release host 192.168.99.9
Nov 28 15:37:45 anthem kernel: lockd: release host 192.168.99.9
Nov 28 15:37:45 anthem kernel: lockd: nlm_release_file(cbacccc0, ct = 11)
Nov 28 15:37:45 anthem kernel: nlmsvc_retry_blocked(cbd6fc00, when=-1)
Nov 28 15:37:45 anthem kernel: nlmsvc_retry_blocked(cbd6fc00, when=-1)
Nov 28 15:37:45 anthem kernel: lockd: request from c0a86309
Nov 28 15:37:45 anthem kernel: lockd: nlm_lookup_host(c0a86309, p=17, v=4)
Nov 28 15:37:45 anthem kernel: lockd: get host 192.168.99.9
Nov 28 15:37:45 anthem kernel: lockd: nlm_file_lookup(06000001 0b000900 00000002 00006693 000071c9 0001dcc7)
Nov 28 15:37:45 anthem kernel: lockd: found file cbacccc0 (count 10)
Nov 28 15:37:45 anthem kernel: lockd: nlmsvc_unlock(090b/26259, pi=1, 0-9223372036854775807)
Nov 28 15:37:45 anthem kernel: lockd: nlmsvc_cancel(090b/26259, pi=1, 0-9223372036854775807)
Nov 28 15:37:45 anthem kernel: lockd: nlmsvc_lookup_block f=cbacccc0 pd=1 0-9223372036854775807 ty=2
Nov 28 15:37:45 anthem kernel: lockd: check f=cbacc4c0 pd=401 0-9223372036854775807 ty=1 cookie=1269
Nov 28 15:37:45 anthem kernel: lockd: check f=cbacccc0 pd=389 0-9223372036854775807 ty=1 cookie=1274
Nov 28 15:37:45 anthem kernel: lockd: check f=cbacccc0 pd=383 0-9223372036854775807 ty=1 cookie=1262
Nov 28 15:37:45 anthem kernel: lockd: check f=cbacccc0 pd=391 0-9223372036854775807 ty=1 cookie=1272
Nov 28 15:37:45 anthem kernel: lockd: check f=cbacccc0 pd=407 0-9223372036854775807 ty=1 cookie=1262
Nov 28 15:37:45 anthem kernel: lockd: check f=cbacccc0 pd=430 0-9223372036854775807 ty=1 cookie=1272
Nov 28 15:37:45 anthem kernel: lockd: check f=cbacccc0 pd=326 0-9223372036854775807 ty=1 cookie=1250
Nov 28 15:37:45 anthem kernel: lockd: release host 192.168.99.9
Nov 28 15:37:45 anthem kernel: lockd: nlm_release_file(cbacccc0, ct = 11)
Nov 28 15:37:45 anthem kernel: nlmsvc_retry_blocked(cbd6fc00, when=-1)
Nov 28 15:37:45 anthem kernel: nlmsvc_retry_blocked(cbd6fc00, when=-1)
Nov 28 15:37:45 anthem kernel: lockd: request from c0a86309
Nov 28 15:37:45 anthem kernel: lockd: nlm_lookup_host(c0a86309, p=17, v=4)
Nov 28 15:37:45 anthem kernel: lockd: get host 192.168.99.9
Nov 28 15:37:45 anthem kernel: lockd: nlm_file_lookup(06000001 0b000900 00000002 00006693 000071c9 0001dcc7)
Nov 28 15:37:45 anthem kernel: lockd: found file cbacccc0 (count 10)
Nov 28 15:37:45 anthem kernel: lockd: nlmsvc_lock(090b/26259, ty=1, pi=1, 0-9223372036854775807, bl=1)
Nov 28 15:37:45 anthem kernel: lockd: nlmsvc_lookup_block f=cbacccc0 pd=1 0-9223372036854775807 ty=1
Nov 28 15:37:45 anthem kernel: lockd: check f=cbacc4c0 pd=401 0-9223372036854775807 ty=1 cookie=1269
Nov 28 15:37:45 anthem kernel: lockd: check f=cbacccc0 pd=389 0-9223372036854775807 ty=1 cookie=1274
Nov 28 15:37:45 anthem kernel: lockd: check f=cbacccc0 pd=383 0-9223372036854775807 ty=1 cookie=1262
Nov 28 15:37:45 anthem kernel: lockd: check f=cbacccc0 pd=391 0-9223372036854775807 ty=1 cookie=1272
Nov 28 15:37:45 anthem kernel: lockd: check f=cbacccc0 pd=407 0-9223372036854775807 ty=1 cookie=1262
Nov 28 15:37:45 anthem kernel: lockd: check f=cbacccc0 pd=430 0-9223372036854775807 ty=1 cookie=1272
Nov 28 15:37:45 anthem kernel: lockd: check f=cbacccc0 pd=326 0-9223372036854775807 ty=1 cookie=1250
Nov 28 15:37:45 anthem kernel: lockd: blocking on this lock (allocating).
Nov 28 15:37:45 anthem kernel: lockd: nlm_lookup_host(c0a86309, p=17, v=4)
Nov 28 15:37:45 anthem kernel: lockd: get host 192.168.99.9
Nov 28 15:37:45 anthem kernel: lockd: created block c33be400...
Nov 28 15:37:45 anthem kernel: lockd: nlmsvc_insert_block(c33be400, -1)
Nov 28 15:37:45 anthem kernel: lockd: blocking on this lock.
Nov 28 15:37:45 anthem kernel: lockd: release host 192.168.99.9
Nov 28 15:37:45 anthem kernel: lockd: nlm_release_file(cbacccc0, ct = 11)
Nov 28 15:37:45 anthem kernel: nlmsvc_retry_blocked(cbd6fc00, when=-1)
Nov 28 15:37:45 anthem kernel: nlmsvc_retry_blocked(cbd6fc00, when=-1)
Nov 28 15:38:15 anthem kernel: lockd: request from c0a86309
Nov 28 15:38:15 anthem kernel: lockd: nlm_lookup_host(c0a86309, p=17, v=4)

[ Then we have a lot of entries for second 15, then a number for 
  second 45, then more for 15... ]

I also noticed an interesting thing. Certain boxes on the network are
hanging; others are not. And if I `ls -l /var/lib/nfs/sm', I get:

/var/lib/nfs/sm:
total 0
-rw-------   1 root     root            0 Nov 26 16:41 192.168.99.2
-rw-------   1 root     root            0 Nov 28 15:48 192.168.99.5
-rw-------   1 root     root            0 Nov 23 17:06 192.168.99.7
-rw-------   1 root     root            0 Nov 25 22:10 192.168.99.9

The boxes .2, .5 and .7 are hanging. The box .9 is not. See the dates
on their files? Could this be related to the problem?

Take care,
--
Christian Reis, Senior Engineer, Async Open Source, Brazil.
http://async.com.br/~kiko/ | [+55 16] 261 2331 | NMFL
