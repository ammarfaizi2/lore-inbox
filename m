Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265285AbUHCKdK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265285AbUHCKdK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 06:33:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265354AbUHCKdK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 06:33:10 -0400
Received: from acheron.informatik.uni-muenchen.de ([129.187.214.135]:54749
	"EHLO acheron.informatik.uni-muenchen.de") by vger.kernel.org
	with ESMTP id S265285AbUHCKdF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 06:33:05 -0400
Message-ID: <410F69DF.7050602@bio.ifi.lmu.de>
Date: Tue, 03 Aug 2004 12:33:03 +0200
From: Frank Steiner <fsteiner-mail@bio.ifi.lmu.de>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040503)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Problem: nfsd producing stales when restarting too fast
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

there seems to be a problem with the kernel nfsd on 2.6.7
when restarting the server too fast. I'm running 2.6.7
on both NFS server and client.

I've mounted two test volumes, both with
-orw,nfsvers=3,rsize=8192,wsize=8192,hard,intr,nolock
Using soft or hard and udp or tcp does not make any difference.

On the client that mounts the volumes (subdirs udp and tcp)
I run loops like "while true; do date >> udp/bla; done"

Restarting the nfsserver with "/etc/init.d/nfsserver restart"
(sometimes a few times, somtimes on the first try) ends up with
both loops echoing "bash: udp/bla: Stale NFS file handle"
forever.
But when I shutdown the nfsserver, wait 5 seconds and
bring it up again, this never happens. And it does even
bring back the loops to normal behaviour when they
were stuck on stale fs before.

Ok, it seems that you just need to insert a sleep statement
in the init script, but I guess this is not the desired
behaviour of the nfs daemon.

Btw, it's not a problem with the init script, I can also
produce this behaviour manually by
/usr/sbin/exportfs -au
killall -9 nfsd
killall -9 /usr/sbin/rpc.mountd
[sleep 5]
/usr/sbin/exportfs -r
/usr/sbin/rpc.nfsd
/usr/sbin/rpc.mountd

Without the sleep, everything stales. With the sleep, it works
fine.

cu,
Frank

-- 
Dipl.-Inform. Frank Steiner   Web:  http://www.bio.ifi.lmu.de/~steiner/
Lehrstuhl f. Bioinformatik    Mail: http://www.bio.ifi.lmu.de/~steiner/m/
LMU, Amalienstr. 17           Phone: +49 89 2180-4049
80333 Muenchen, Germany       Fax:   +49 89 2180-99-4049
* Rekursion kann man erst verstehen, wenn man Rekursion verstanden hat. *
