Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161260AbWF0SSk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161260AbWF0SSk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 14:18:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161264AbWF0SSj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 14:18:39 -0400
Received: from relay2.netbox.cz ([83.240.0.204]:59623 "EHLO relay.netbox.cz")
	by vger.kernel.org with ESMTP id S1161260AbWF0SSh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 14:18:37 -0400
Subject: Re: NFS and partitioned md
From: Martin Filip <bugtraq@smoula.net>
To: Neil Brown <neilb@suse.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <17568.31894.207153.563590@cse.unsw.edu.au>
References: <1151355145.4460.16.camel@archon.smoula-in.net>
	 <17568.31894.207153.563590@cse.unsw.edu.au>
Content-Type: text/plain; charset=ISO-8859-2
Date: Tue, 27 Jun 2006 20:18:32 +0200
Message-Id: <1151432312.11996.32.camel@reaver.netbox-in.cz>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

thx for your interrest,

Neil Brown pí¹e v Út 27. 06. 2006 v 10:32 +1000:
> Odd.  It works fine for me (I've had this sort of configuration on
> some machines for ages, and I just tested a bleeding edge kernel and
> it still works).
> 
> So I suspect there is something else going on that has nothing to do
> with the usage of partitioned md.... then again, maybe there is some
> weird sign extension happening to '254' somewhere, though that would
> be terribly strange.
> 
> So: details please.
>  What md device exactly (major and minor)
# mount | grep /mnt/data
/dev/md_d64p9 on /mnt/data type ext3 (rw)
/dev/loop/0 on /mnt/data-loop type ext3 (rw)

# ls -al /dev/md_d64p9
brw-rw---- 1 root disk 254, 4105 2006-06-27 10:17 /dev/md_d64p9
# ls -al /dev/loop0
lrwxrwxrwx 1 root root 6 2006-06-27 19:44 /dev/loop0 -> loop/0
# ls -al /dev/loop/0
brw-rw---- 1 root disk 7, 0 2006-06-27 19:45 /dev/loop/0

(as I look on that it comes on my mind, that problem could be minor
longer than 1 byte)


>  What filesystem.
as you can see above - ext3

>  'tcpdump -s0' trace capturing all nfs/mountd/rpc packets from before
>  you issue the mount command. e.g.  use 'rpcinfo -p' to find out what
>  port mountd is listening on then,
# cat /etc/exports 
/mnt/data/public            *(ro,all_squash,async)
/mnt/data-loop/public       *(ro,all_squash,async)

# rpcinfo -p  | grep mountd
    100005    1   udp    879  mountd
    100005    1   tcp    882  mountd
    100005    2   udp    879  mountd
    100005    2   tcp    882  mountd
    100005    3   udp    879  mountd
    100005    3   tcp    882  mountd

>    tcpdump -s0 -w /tmp/trace host CLIENT and host SERVER and \( \
>     port 2049 or port 111 or port MOUNTDPORT \)  &
on 192.168.0.2 (server)
# tcpdump -s0 -w /tmp/trace-data host 172.16.0.14 and host 192.168.0.2
and \( port 2049 or port 111 or port 879 or port 882 \) &

on 172.16.0.14 (client) - no fw between them
mount -t nfs 192.168.0.2:/mnt/data/public /mnt/tmp
 - fails with errors like
  * nfs: server 192.168.0.2 not responding, timed out in dmesg
 - can't read superblock from mount


> 
>  Then try the mount.
> 
>  After the experiment, on the server
>     grep . /proc/net/rpc/*/content
>     cat /proc/fs/nfsd/exports
# grep . /proc/net/rpc/*/content
/proc/net/rpc/auth.unix.ip/content:#class IP domain
/proc/net/rpc/auth.unix.ip/content:nfsd 172.16.0.14 *
/proc/net/rpc/nfsd.export/content:#path domain(flags)
/proc/net/rpc/nfsd.export/content:/mnt/data/public
*(ro,root_squash,all_squash,async,wdelay)
/proc/net/rpc/nfsd.fh/content:#domain fsidtype fsid [path]
/proc/net/rpc/nfsd.fh/content:# * 3 0x0100fe09000d4001
/proc/net/rpc/nfs4.idtoname/content:#domain type id [name]
/proc/net/rpc/nfs4.nametoid/content:#domain type name [id]

file /proc/fs/nfsd/exports does not exists


on 192.168.0.2 (server)
# tcpdump -s0 -w /tmp/trace-data-loop host 172.16.0.14 and host
192.168.0.2 and \( port 2049 or port 111 or port 879 or port 882 \) &

on 172.16.0.14 (client) - no fw between them
mount -t nfs 192.168.0.2:/mnt/data-loop/public /mnt/tmp

works OK
# grep . /proc/net/rpc/*/content
/proc/net/rpc/auth.unix.ip/content:#class IP domain
/proc/net/rpc/auth.unix.ip/content:nfsd 172.16.0.14 *
/proc/net/rpc/nfsd.export/content:#path domain(flags)
/proc/net/rpc/nfsd.export/content:/mnt/data-loop/public
*(ro,root_squash,all_squash,async,wdelay)
/proc/net/rpc/nfsd.export/content:/mnt/data/public
*(ro,root_squash,all_squash,async,wdelay)
/proc/net/rpc/nfsd.fh/content:#domain fsidtype fsid [path]
/proc/net/rpc/nfsd.fh/content:* 0
0x0000070000013881 /mnt/data-loop/public
/proc/net/rpc/nfsd.fh/content:# * 3 0x0100fe09000d4001
/proc/net/rpc/nfs4.idtoname/content:#domain type id [name]
/proc/net/rpc/nfs4.nametoid/content:#domain type name [id]

file /proc/fs/nfsd/exports does not exists

both dump files could be downloaded from:
http://www.smoula.net/lkml-nfs/

> 
> That should be enough detail to start with.
> 

I hope :)))

again - thanks for your interrest

-- 
Martin Filip
e-mail: nexus@smoula.net
ICQ#: 31531391
jabber: nexus@smoula.net
www: http://www.smoula.net

 _______________________________ 
< BOFH Excuse #86: Runt packets >
 ------------------------------- 
       \   ,__,
        \  (oo)____
           (__)    )\
              ||--|| *

