Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264976AbSKSB34>; Mon, 18 Nov 2002 20:29:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265085AbSKSB3z>; Mon, 18 Nov 2002 20:29:55 -0500
Received: from [203.117.131.12] ([203.117.131.12]:48108 "EHLO
	gort.metaparadigm.com") by vger.kernel.org with ESMTP
	id <S264976AbSKSB3y>; Mon, 18 Nov 2002 20:29:54 -0500
Message-ID: <3DD995AF.6090000@metaparadigm.com>
Date: Tue, 19 Nov 2002 09:36:47 +0800
From: Michael Clark <michael@metaparadigm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020913 Debian/1.1-1
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Ragnar_Kj=F8rstad?= <kernel@ragnark.vestdata.no>
Cc: Jesse Pollard <pollard@admin.navo.hpc.mil>,
       Rashmi Agrawal <rashmi.agrawal@wipro.com>, linux-kernel@vger.kernel.org
Subject: Re: Failover in NFS
References: <3DD90197.4DDEEE61@wipro.com> <20021118164408.B30589@vestdata.no> <200211181611.06241.pollard@admin.navo.hpc.mil> <20021118232230.F30589@vestdata.no>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/19/02 06:22, Ragnar Kjørstad wrote:

> But it would not work as described above. There are some important
> limitations here:
> 
> - I assumed that /var/lib/nfs is shared. If you want two servers to
>   be active at once you need a different way to share lock-data.

I'm looking at this problem right now. Basically to support multiple
virtual NFS servers with failover support, lockd could be modified to
communicate with the local statd using the dest IP used in the locking
operation - then statd can modified to look at the peer address
(which is normally 127.0.0.1) to find out which NFS virtual server
the monitor request is for. This would also allow you to run a statd
per virtual NFS server (bound to the specific address instead of
IPADDR_ANY).

> - AFAIK there is no way for statd to service 2 IP's at once.
>   It will (AFAIK) bind to both adresses, but the problem is the
>   message that is sent out at startup and includes the ip of
>   the local host.

The nfs-utils in cvs has an undocumented notify-only mode and the
hostname used in the reboot notify message can also overriden
on the commandline.

So during a take over for a virtual NFS server - the new taking over
node (already has its statd running) can run another copy of statd in
notify-only mode to send out the reboot messages using the name
of the virtual host.

This all assumes /var/lib/nfs/sm can be synchronised between the
hosts either with something like GFS or possibly a modified statd
that communicates monitor requests to its cluster peers.

I have just written some code to sync the /var/lib/nfs/sm directories.
It is a little deamon that uses dnotify to get realtime directory
update notifications, it then sends UDP messages to its cluster peers
to keep the /var/lib/nfs/sm in sync.

The problem is that until statd is virtual IP aware, if a host
is connected to 2 of the virtual NFS servers and sends an unmonitor
for one, both will get unmonitored.

I'm thinking that instead of statd just storing the monitor IP
adress in /var/lib/nfs/sm/1.2.3.4  that instead with the lockd changes,
it could also store the peer address (virtual NFS server) ie.
/var/lib/nfs/sm/5.6.7.8:1.2.3.4 (this would be compatible for a
old lock as the monitor would be stored as /var/lib/nfs/sm/127.0.0.1:1.2.3.4

> Neither limitation is a law of nature. They can be fixed. I think there
> is work going on to change the way locks are stored, and I'm sure the
> second problem can be solved as well.

Yes, i hope so.

~mc

