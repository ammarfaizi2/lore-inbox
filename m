Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262581AbTCZWHZ>; Wed, 26 Mar 2003 17:07:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262582AbTCZWHZ>; Wed, 26 Mar 2003 17:07:25 -0500
Received: from sj-core-5.cisco.com ([171.71.177.238]:32485 "EHLO
	sj-core-5.cisco.com") by vger.kernel.org with ESMTP
	id <S262581AbTCZWHV>; Wed, 26 Mar 2003 17:07:21 -0500
Message-Id: <5.1.0.14.2.20030327091610.04aa7128@mira-sjcm-3.cisco.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Thu, 27 Mar 2003 09:16:12 +1100
To: Jeff Garzik <jgarzik@pobox.com>
From: Lincoln Dale <ltd@cisco.com>
Subject: Re: [PATCH] ENBD for 2.5.64
Cc: Matt Mackall <mpm@selenic.com>, ptb@it.uc3m.es,
       Justin Cormack <justin@street-vision.com>,
       linux kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 08:49 AM 26/03/2003 -0500, Jeff Garzik wrote:
>>>Indeed, there are iSCSI implementations that do multipath and
>>>failover.
>>
>>iSCSI is a transport.
>>logically, any "multipathing" and "failover" belongs in a layer above it 
>>-- typically as a block-layer function -- and not as a transport-layer 
>>function.
>>multipathing belongs elsewhere -- whether it be in MD, LVM, EVMS, 
>>DevMapper -- or in a commercial implementation such as Veritas VxDMP, HDS 
>>HDLM, EMC PowerPath, ...
>
>I think you will find that most Linux kernel developers agree w/ you :)
>
>That said, iSCSI error recovery can be considered as supporting some of 
>what multipathing and failover accomplish.  iSCSI can be shoving bits 
>through multiple TCP connections, or fail over from one TCP connection to 
>another.

while the iSCSI spec has the concept of a "network portal" that can have 
multiple TCP streams for i/o, in the real world, i'm yet to see anything 
actually use those multiple streams.
the reason why goes back to how SCSI works.  take a ethereal trace of iSCSI 
and you'll see the way that 2 round-trips are used before any typical i/o 
operation (read or write op) occurs.
multiple TCP streams for a given iSCSI session could potentially be used to 
achieve greater performance when the maximum-window-size of a single TCP 
stream is being hit.
but its quite rare for this to happen.

in reality, if you had multiple TCP streams, its more likely you're doing 
it for high-availability reasons (i.e. multipathing).
if you're multipathing, the chances are you want to multipath down two 
separate paths to two different iSCSI gateways.  (assuming you're talking 
to traditional SAN storage and you're gatewaying into Fibre Channel).

handling multipathing in that manner is well beyond the scope of what an 
iSCSI driver in the kernel should be doing.
determining the policy (read-preferred / write-preferred / round-robin / 
ratio-of-i/o / sync-preferred+async-fallback / ...) on how those paths are 
used is most definitely something that should NEVER be in the kernel.

btw, the performance of iSCSI over a single TCP stream is also a moot one also.
from a single host (IBM x335 Server i think?) communicating with a FC disk 
via an iSCSI gateway:
         mds# sh int gig2/1
         GigabitEthernet2/1 is up
             Hardware is GigabitEthernet, address is xxxx.xxxx.xxxx
             Internet address is xxx.xxx.xxx.xxx/24
             MTU 1500  bytes, BW 1000000 Kbit
             Port mode is IPS
             Speed is 1 Gbps
             Beacon is turned off
             5 minutes input rate 21968640 bits/sec, 2746080 bytes/sec, 
40420 frames/sec
             5 minutes output rate 929091696 bits/sec, 116136462 bytes/sec, 
80679 frames/sec
                                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
             74228360 packets input, 13218256042 bytes
               15409 multicast frames, 0 compressed
               0 input errors, 0 frame, 0 overrun 0 fifo
             169487726 packets output, 241066793565 bytes, 0 underruns
               0 output errors, 0 collisions, 0 fifo
               0 carrier errors

not bad for a single TCP stream and a software iSCSI stack. :-)
(kernel is 2.4.20)

>>>Both iSCSI and ENBD currently have issues with pending writes during
>>>network outages. The current I/O layer fails to report failed writes
>>>to fsync and friends.
>
>...not if your iSCSI implementation is up to spec.  ;-)
>
>>these are not "iSCSI" or "ENBD" issues.  these are issues with VFS.
>
>VFS+VM.  But, agreed.

sure - the devil is in the details - but the issue holds true for 
traditional block devices at this point also.


cheers,

lincoln.

