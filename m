Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261530AbSKSHdY>; Tue, 19 Nov 2002 02:33:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261908AbSKSHdY>; Tue, 19 Nov 2002 02:33:24 -0500
Received: from [203.117.131.12] ([203.117.131.12]:41105 "EHLO
	gort.metaparadigm.com") by vger.kernel.org with ESMTP
	id <S261530AbSKSHdX>; Tue, 19 Nov 2002 02:33:23 -0500
Message-ID: <3DD9EAE0.6000205@metaparadigm.com>
Date: Tue, 19 Nov 2002 15:40:16 +0800
From: Michael Clark <michael@metaparadigm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020913 Debian/1.1-1
MIME-Version: 1.0
To: rashmi.agrawal@wipro.com
Cc: =?ISO-8859-1?Q?Ragnar_Kj=F8rstad?= <kernel@ragnark.vestdata.no>,
       Jesse Pollard <pollard@admin.navo.hpc.mil>,
       linux-kernel@vger.kernel.org
Subject: Re: Failover in NFS
References: <3DD90197.4DDEEE61@wipro.com> <20021118164408.B30589@vestdata.no> <200211181611.06241.pollard@admin.navo.hpc.mil> <20021118232230.F30589@vestdata.no> <3DD995AF.6090000@metaparadigm.com> <3DD9C725.D7A9186A@wipro.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/19/02 13:07, Rashmi Agrawal wrote:
> Michael Clark wrote:
> 
> 
>>On 11/19/02 06:22, Ragnar Kjørstad wrote:
>>
>>
>>>But it would not work as described above. There are some important
>>>limitations here:
>>>
>>>- I assumed that /var/lib/nfs is shared. If you want two servers to
>>>  be active at once you need a different way to share lock-data.
>>
>>I'm looking at this problem right now. Basically to support multiple
>>virtual NFS servers with failover support, lockd could be modified to
>>communicate with the local statd using the dest IP used in the locking
>>operation - then statd can modified to look at the peer address
>>(which is normally 127.0.0.1) to find out which NFS virtual server
>>the monitor request is for. This would also allow you to run a statd
>>per virtual NFS server (bound to the specific address instead of
>>IPADDR_ANY).
> 
> 
> What is the plan for this implementation? Is it going to be part of main line
> kernel.
> If yes then when will it be available and if no, when will it be available in
> the form of
> patches.

I still don't know how hard the lockd changes would be.
More just thinking how it could be done now.

> Should we expect NFs failover support in linux kernel soon??

Simple failover with a single NFS service is already supported.

As ppl have said - you just failover the /var/lib/nfs directory
along with the exported partition and modify the rpc.statd script
to use the virtual node name, and add a notify call to the cluster
service start script plus a few other little things.

One little trick is blocking the NFS port for the NFS ip alias
during failover. Assuming you are using exportfs and exportfs -u
in your cluster service script to raise and lower the export
(to allow for unmounting of the failover partition, etc).
Doing this is req'd to stop the takeover node from returning
stale nfs handle errors when the IP alias has been raised (and
gratutiously arped for) but before the newly mounted fs has been exported.

ie. in your boot scripts, disable access to NFS and create
a chain to add accept rules later.

iptables -N nfs_allow
iptables -A INPUT -p udp -m udp --dport 2049 -j nfs_allow
iptables -A INPUT -p udp -m udp --dport 2049 -j DROP

and in the cluster service scripts I then do:

case "$1" in
'start')
     exportfs -o rw,sync someclient.somedomain:/foo/bar
     iptables -A nfs_allow --dest $nfs_ip_alias -j ACCEPT
     rstatd -N -n $nfs_virtual_hostname
     ;;
'stop')
     iptables -D nfs_allow --dest $nfs_ip_alias -j ACCEPT
     exportfs -u someclient.somedomain:/foo/bar
     ;;

Multiple virtual NFS servers failover support is what doesn't
currently work right due to the way statd works. This is what i'm
looking at the moment - no timeline - no promises of patches -
just ideas.

I do have one patch to make the kernel RPC code reply using
the ipalias address instead of the base host IP (although it
is a bit of a hack as it directly changes the address of the
nfsd server socket before replies - maybe introducing problems
during concurrency). I'm looking at a better solution for this.

This is needed for UDP NFS clients like MacOS X that do a connect
and thusly refuse to see the packets coming from the linux NFS server
originating from a different address. It also solves problem with
accessing an ip alias NFS server through NAT or a firewall.

~mc

