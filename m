Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262587AbTCZWIi>; Wed, 26 Mar 2003 17:08:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262595AbTCZWIh>; Wed, 26 Mar 2003 17:08:37 -0500
Received: from sj-core-2.cisco.com ([171.71.177.254]:52904 "EHLO
	sj-core-2.cisco.com") by vger.kernel.org with ESMTP
	id <S262587AbTCZWIA>; Wed, 26 Mar 2003 17:08:00 -0500
Message-Id: <5.1.0.14.2.20030327091616.03a2ce60@mira-sjcm-3.cisco.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Thu, 27 Mar 2003 09:16:18 +1100
To: Matt Mackall <mpm@selenic.com>
From: Lincoln Dale <ltd@cisco.com>
Subject: Re: [PATCH] ENBD for 2.5.64
Cc: Jeff Garzik <jgarzik@pobox.com>, ptb@it.uc3m.es,
       Justin Cormack <justin@street-vision.com>,
       linux kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 10:09 AM 26/03/2003 -0600, Matt Mackall wrote:
> > >Indeed, there are iSCSI implementations that do multipath and
> > >failover.
> >
> > iSCSI is a transport.
> > logically, any "multipathing" and "failover" belongs in a layer above 
> it --
> > typically as a block-layer function -- and not as a transport-layer
> > function.
> >
> > multipathing belongs elsewhere -- whether it be in MD, LVM, EVMS, 
> DevMapper
> > PowerPath, ...
>
>Funny then that I should be talking about Cisco's driver. :P

:-)

see my previous email to Jeff.  iSCSI as a transport protocol does have a 
muxing capability -- but its usefulness is somewhat limited (imho).

>iSCSI inherently has more interesting reconnect logic than other block
>devices, so it's fairly trivial to throw in recognition of identical
>devices discovered on two or more iSCSI targets..

what logic do you use to identify "identical devices"?
same data reported from SCSI Report_LUNs?  or perhaps the same data 
reported from a SCSI_Inquiry?

in reality, all multipathing software tends to use some blocks at the end 
of the disk (just in the same way that most LVMs do also).

for example, consider the following output from a set of two SCSI_Inquiry 
and Report_LUNs on two paths to storage:
         Lun Description Table
         WWPN             Lun   Capacity Vendor       Product      Serial
         ---------------- ----- -------- ------------ ------------ ------
         Path A:
         21000004cf8c21fb 0     16GB     HP 18.2G     ST318452FC   3EV0BD8E
         21000004cf8c21c5 0     16GB     HP 18.2G     ST318452FC   3EV0KHHP
         50060e8000009591 0     50GB     HITACHI      DF500F       DF500-00B
         50060e8000009591 1     50GB     HITACHI      DF500F       DF500-00B
         50060e8000009591 2     50GB     HITACHI      DF500F       DF500-00B
         50060e8000009591 3     50GB     HITACHI      DF500F       DF500-00B

         Path B:
         31000004cf8c21fb 0     16GB     HP 18.2G     ST318452FC   3EV0BD8E
         31000004cf8c21c5 0     16GB     HP 18.2G     ST318452FC   3EV0KHHP
         50060e8000009591 0     50GB     HITACHI      DF500F       DF500-00A
         50060e8000009591 1     50GB     HITACHI      DF500F       DF500-00A
         50060e8000009591 2     50GB     HITACHI      DF500F       DF500-00A
         50060e8000009591 3     50GB     HITACHI      DF500F       DF500-00A


the "HP 18.2G" devices are 18G FC disks in a FC JBOD.  each disk will 
report an identical Serial # regardless of the interface/path used to get 
to that device.  no issues there right -- you can identify the disk as 
being unique via its "Serial #" and can see the interface used to get to it 
via its WWPN.

now, take a look at some disk from an intelligent disk array (in this case, 
a HDS 9200).
it reports a _different_ serial number for the same disk, dependent on the 
interface used.  (DF500 is the model # of a HDS 9200, interfaces are 
numbered 00A/00B/01A/01B).

does one now need to add logic into the kernel to provide some multipathing 
for HDS disks?
does using linux mean that one had to change some settings on the HDS disk 
array to get it to report different information via a SCSI_Inquiry?  (it 
can - but thats not the point - the point is that any multipathing software 
out there just 'works' right now).

this is just one example.  i could probably find another 50 of 
slightly-different-behavior if you wanted me to!

> > >Both iSCSI and ENBD currently have issues with pending writes during
> > >network outages. The current I/O layer fails to report failed writes
> > >to fsync and friends.
> >
> > these are not "iSCSI" or "ENBD" issues.  these are issues with VFS.
>
>Except that the issue simply doesn't show up for anyone else, which is
>why it hasn't been fixed yet. Patches are in the works, but they need
>more testing:
>
>http://www.selenic.com/linux/write-error-propagation/

oh, but it does show up for other people.  it may be that the issue doesn't 
show up at fsync() time, but rather at close() time, or perhaps neither of 
those!

code looks interesting.  i'll take a look.
hmm, must find out a way to intentionally introduce errors now and see what 
happens!


cheers,

lincoln.

