Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278480AbRJPAcS>; Mon, 15 Oct 2001 20:32:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278482AbRJPAcI>; Mon, 15 Oct 2001 20:32:08 -0400
Received: from [62.58.73.254] ([62.58.73.254]:64761 "EHLO
	ats-core-0.atos-group.nl") by vger.kernel.org with ESMTP
	id <S278480AbRJPAcA>; Mon, 15 Oct 2001 20:32:00 -0400
Date: Tue, 16 Oct 2001 02:28:46 +0200 (CEST)
From: Ryan Sweet <rsweet@atos-group.nl>
To: <linux-kernel@vger.kernel.org>
Subject: random reboots of diskless nodes - 2.4.7 (fwd)
Message-ID: <Pine.LNX.4.30.0110160228000.18043-100000@core-0>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've posted about this problem before, but in the meantime I've managed to
test under several different configurations to help rule out some possible
causes.

Short version: 2.4.7 on nfsroot diskless nodes randomly re-boots and I
don't think it is a hardware problem or a problem with the server (which
is stable).  Rather than "try this, try that..." I (and more importantly
my boss) would really like to find (and then hopefully fix) the root cause
of the problem.

See below for the long version and more details.

Questions:
- what the heck can I do to isolate the problem?
- why would the system re-boot instead of hanging on whatever caused it to
crash (ie, why don't I see an oops message?)
- how can I tell the system not to re-boot when it crashes (or is it
crashing at all???)
- is it worth trying all the newer kernel versions (this does not sound
very appealing, especially given the troubles reported with 2.4.10 and
also the split over which vm to use, etc..., also the changelogs don't
really point to anything that appears to precisely describe my problem)?
- if I patch with kgdb and use a null modem connection from the gateway to
run gdb can I expect to gain any useful info from a backtrace?

thanks for your help,
-Ryan Sweet,

 - Long Version -

The problem:

At seemingly random intervals, one or more nodes of a diskless nfsroot
cluster will re-boot without being told to....  No information is available
on the console or in the logs.  Sometimes the systems are up for a weeks,
sometimes it is only a few hours.  Out of 23 nodes, we can pretty
reliably get at least one failure every couple of days or less.  As the
number of nodes decreases, our average time to failure increases.

Notably, the problem happens far less frequently (but still occurs
eventually) when running kernels without SMP support.  Also, 2.4.7 seems
to offer increased stability over previous versions, but still fails.

There seems to be no degradation of performance or measurable increase in
resource consumption or other activity before the re-boot occurs.  Memory
pressure ddoes not seem to be a problem (of 768MB, we are never using more
than 256). lmsensors using the on-board hardware sensors does not record
any anomalies.  In fact, performance on the system when it is not
re-booting is very good.  A tcpdump shows that the last network activity
before the re-boot was an nfs file open, but since the systems are
nfsroot, that pretty much is the majority of the network activity.

--
The configuration:

Cluster Gateway:  Single PIII-1Ghz 133Mhz FSB, 1GB RAM, dual 20GB IDE HD,
Mylex RAID Array, linux 2.4.6+sgi-xfs1.01, nfsutils-0.3.1, Intel eepro1000
Gigabit adapter connected to Farallon FastStarlet 10/100/1000 switch,
3com3c90x connected to the rest of the network.  /tftpboot/<cluster ips>
and /data (examples) are exported in /etc/exports to all the cluster
nodes. iptables is setup to masquerade all traffic (mainly DNS and YP
lookups) from the cluster to the rest of the network.  The kernel is
configured with the following support built-in, except as indicated):
	sgi xfs 1.0.1
	iptables+NAT
	ext2
	knfsdv3
	DAC96x
	3c90x
	e1000 (module)
	aic7xxx (module, used for tape device)

The root file system is on an ide disk using ext2, as is the tftpboot
area.  The raid array is formatted with xfs and is mounted by each node
for use as data storage by the application.

The gateway node has been operating rock-solid stable since day one (about
90 days ago).

The compute nodes: Dual PIII-1Ghz 133Mhz FSB, Server works chipset, 768MB
RAM (some with 1GB RAM).  Some nodes are using the Asus CUR_DLS
motherboard, others are using a SuperMicro motherboard, both boards have
the ServerWorks chipset.  All on board features (apm, scsi, usb, ide...)
except video and the on-board eepro100 have been disabled.  The systems
boot with nfsroot, mount several other partitions via nfs (for user dirs,
data area, etc...).  They create a 64Mb ram disk partition and format it
with ext2 to use for /tmp (otherwise LAM MPI and some other things break).
The kernel is linux 2.4.7+lmsensors with support for the following (all
built-in):
	smp (also tried UP, UP appears to be more stable, but still fails)
	noapic
	eepro100
	knfsv3 client
	nfsroot
	ip auto-configuration
	"  "	dhcp
	ramdisk, size 65536
	initrd
	ext2
	lmsensors

The nodes mount the root as nfsv2 because if I mount as v3 they
inevitably fall over and _don't re-boot_.  All other mounts are as v3.

-- The troubleshooting (abridged version - believe me, you don't want the
full story):
	- profiled network, cpu, memory utilisation, hardware sensors,
with no anomalies visible
	- tested all minor versions on the nodes from 2.2.19-2.4.7,
including the redhat and suse supplied kernels for 2.4.3-xx
	- upgraded bios on all nodes to the latest recommended by the
manufacturer
	- upgraded (replaced) the power supply in all nodes
	- tested power source to computer room, moved to another computer
room with better available power, etc...
	- tested with a different switch
	- tested with all combinations of nfsv2/3 for each mount point
	- replaced all cables, verified all connections (re-seated all CPUS,
RAM)
	- swapped the gigabit adapter
	- the problem originally occurred with a brand new batch of
CUR_DLS servers that were all identical, however we ordered a second batch
of supermicro servers that have a different motherboard, case, cooling,
etc... (but still use the same ServerWorks chipset) and the problem also
occurs with them
	- tried playing with the nfs rsize and wsize.  While this affected
performance, it didn't seem to make a difference in the failures.
	- upgraded util-linux, mount, and nfs-utils to current versions
(as of August 2001)




-- 
Ryan Sweet <ryan.sweet@atosorigin.com>
Atos Origin Engineering Services
http://www.aoes.nl


