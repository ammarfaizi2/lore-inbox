Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267974AbUJOOsI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267974AbUJOOsI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 10:48:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267973AbUJOOsI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 10:48:08 -0400
Received: from anor.ics.muni.cz ([147.251.4.35]:54709 "EHLO anor.ics.muni.cz")
	by vger.kernel.org with ESMTP id S267953AbUJOOrj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 10:47:39 -0400
Date: Fri, 15 Oct 2004 16:47:02 +0200
From: Jan Kasprzak <kas@fi.muni.cz>
To: linux-kernel@vger.kernel.org
Cc: unix@fi.muni.cz
Subject: NFS mount hang (no response to getattr)
Message-ID: <20041015144701.GD4473@fi.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2i
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, world!\n

	I have ran into the following problem with Linux NFS code. Following
examples are the simplest test (meaningless) cases, the real /etc/exports
is more complicated, of course.

	The problem is, that in some cases (depending on the contents of
/etc/exports) mounting the NFS volume hangs. The NFS client gets filehandle
from mount-daemon, but then it keeps retransmitting the NFS getattr call
for the root directory of the to-be-mounted volume, while NFS server
(nfsd on port 2049) does not respond. The tcpdump looks like this (first
packets omitted, they look the same for both cases).

The non working case:
[...]
15:38:09.512977 IP erinys2.fi.muni.cz.xxx > scylla.fi.muni.cz.nfs: 104 getattr fh 0,1/16777984
15:38:10.622833 IP erinys2.fi.muni.cz.xxx > scylla.fi.muni.cz.nfs: 104 getattr fh 0,1/16777984
[ and the getattr call gets retransmitted ad infinitum ]

The working case:
[...]
15:41:13.010098 IP erinys2.fi.muni.cz.xxx > scylla.fi.muni.cz.nfs: 104 getattr fh 0,1/16777984
15:41:13.010481 IP scylla.fi.muni.cz.nfs > erinys2.fi.muni.cz.xxx: reply ok 112 getattr DIR 40755 ids 0/0 sz 0x1000
15:41:13.010829 IP erinys2.fi.muni.cz.xxx > scylla.fi.muni.cz.nfs: 104 fsinfo fh 0,1/16777984
[ the rest of traffic snipped ]

Note that in both cases, the getattr refers to the same fh.
As I said, the difference is in /etc/exports. I have a single
non-working case:

/tmp/1                          erinys2.fi.muni.cz(ro)
/tmp/2                          erinys*.fi.muni.cz(ro)
/tmp/3                          *.fi.muni.cz(ro)

(in tcpdump above, I am trying to mount scylla:/tmp/2 to erinys2:/mnt1).
I can get mount of /tmp/2 working by any of the three modifications to
/etc/exports on scylla (the last one is most strange one):

# Modification 1 - comment out the first line:
#/tmp/1                         erinys2.fi.muni.cz(ro)
/tmp/2                          erinys*.fi.muni.cz(ro)
/tmp/3                          *.fi.muni.cz(ro)
                                                                                
# Modification 2 - comment out the last line:
/tmp/1                          erinys2.fi.muni.cz(ro)
/tmp/2                          erinys*.fi.muni.cz(ro)
#/tmp/3                         *.fi.muni.cz(ro)
                                                                                
# Modification 3 - change "erinys*" to "eriny*" in the middle line:
/tmp/1                          erinys2.fi.muni.cz(ro)
/tmp/2                          eriny*.fi.muni.cz(ro)
/tmp/3                          *.fi.muni.cz(ro)

Any of the above versions of /etc/exports makes mount of /tmp/2 on erinys2
working. The problem may be that all exported directories are on the
same physical volume on scylla. I have the following contents of
/proc/fs/nfs/exports:

# Version 1.1
# Path Client(Flags) # IPs
/tmp/2  *.fi.muni.cz,erinys*.fi.muni.cz,erinys2.fi.muni.cz(ro,root_squash,sync,wdelay)

So maybe mount-daemon tells kernel something different than is written
in /etc/exports.

The NFS server is 2.6.8.1-mm2 running on Fedora core 3 test3 on single-cpu
x86-64 box, but I have tried i386 box running FC2 an x86_64 SMP box running
RHEL3 too, with different kernels around 2.6.8.1 (vanilla 2.6.8.1, 2.6.7,
2.6.9-rc4). So the problem is probably not dependent on the distribution,
compiler, SMPness or architecture. I have not tried 2.4 kernel.

I have tried two NFS clients - one is IRIX 6.5.22, the other is Linux i386
box with FC2 and 2.6.7 kernel. IRIX box uses NFS v2 and v3 over UDP (I have
tried -o vers=2 and -o vers=3), Linux box uses NFS v3, but I have tried v2
as well.

I can provide more detailed information on demand. There is definitely
a problem either with parsing wild-card export lists in rpc.mountd,
or with kernel NFS-damon not responding to legitimate requests.

	Does anybody see the problem here? Thanks,

-Yenya

P.S.: I have come with another strange case of /etc/exports: I am exporting
	only one directory for multiple wild-carded clients:

/tmp/2  erinys2.fi.muni.cz(ro) *.fi.muni.cz(ro) *.muni.cz(ro) eriny*.fi.muni.cz(ro)

	This does not work (retransmits of getattr call), but by deleting
_any_ of the four client descriptions in the above line it is possible
to make it working.

-- 
| Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - private}> |
| GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18A5E |
| http://www.fi.muni.cz/~kas/   Czech Linux Homepage: http://www.linux.cz/ |
btw, David, I'm wondering about this loop: [...]  Is this
a busy-wait-until-someone-plugs-in-more-ram-chips thing? ;)  --Andrew Morton
