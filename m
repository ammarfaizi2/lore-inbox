Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267081AbSKSSTl>; Tue, 19 Nov 2002 13:19:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267086AbSKSSTk>; Tue, 19 Nov 2002 13:19:40 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:39907 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S267081AbSKSSTF> convert rfc822-to-8bit; Tue, 19 Nov 2002 13:19:05 -0500
Subject: Re: Failover in NFS
To: Michael Clark <michael@metaparadigm.com>
Cc: kernel@ragnark.vestdata.no, linux-kernel@vger.kernel.org,
       linux-kernel-owner@vger.kernel.org, pollard@admin.navo.hpc.mil,
       rashmi.agrawal@wipro.com
X-Mailer: Lotus Notes Release 5.0.2a (Intl) 23 November 1999
Message-ID: <OFA0B84CE0.D5872EFD-ON87256C76.0064CE7C@us.ibm.com>
From: Juan Gomez <juang@us.ibm.com>
Date: Tue, 19 Nov 2002 10:24:20 -0800
X-MIMETrack: Serialize by Router on D03NM694/03/M/IBM(Release 6.0 [IBM]|November 8, 2002) at
 11/19/2002 11:25:25
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

                                                                                                               
                                                                                                               
                                                                                                               


I do not think we need changes to lockd. Earlier this year I sent a patch
to Alan Cox that would enable you to control server's lockd grace period
from user land which helps you do the takeover from server to server. Also
I have sent in patches included in tha latest version of NFS utils that
would let you do takeover along with the lockd patch of the kernel and
using shared /var/lib/nfs/sm directory.  This is a good time to check if
Alan has had some time to include that patch.

Juan



|---------+---------------------------------->
|         |           Michael Clark          |
|         |           <michael@metaparadigm.c|
|         |           om>                    |
|         |           Sent by:               |
|         |           linux-kernel-owner@vger|
|         |           .kernel.org            |
|         |                                  |
|         |                                  |
|         |           11/18/02 11:40 PM      |
|         |                                  |
|---------+---------------------------------->
  >-------------------------------------------------------------------------------------------------------------------------|
  |                                                                                                                         |
  |       To:       rashmi.agrawal@wipro.com                                                                                |
  |       cc:       Ragnar Kjørstad <kernel@ragnark.vestdata.no>, Jesse Pollard <pollard@admin.navo.hpc.mil>,               |
  |        linux-kernel@vger.kernel.org                                                                                     |
  |       Subject:  Re: Failover in NFS                                                                                     |
  |                                                                                                                         |
  |                                                                                                                         |
  >-------------------------------------------------------------------------------------------------------------------------|



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
> What is the plan for this implementation? Is it going to be part of main
line
> kernel.
> If yes then when will it be available and if no, when will it be
available in
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

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/



