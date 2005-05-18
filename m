Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262362AbVERUus@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262362AbVERUus (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 16:50:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262369AbVERUus
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 16:50:48 -0400
Received: from mail.wildbrain.com ([209.130.193.228]:27812 "EHLO
	hermes.wildbrain.com") by vger.kernel.org with ESMTP
	id S262362AbVERUtw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 16:49:52 -0400
Message-ID: <428BA8E4.2040108@wildbrain.com>
Date: Wed, 18 May 2005 13:43:16 -0700
From: Gregory Brauer <greg@wildbrain.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
CC: Joshua Baker-LePain <jlb17@duke.edu>,
       Jakob Oestergaard <jakob@unthought.net>, Chris Wedgwood <cw@f00f.org>
Subject: Re: kernel OOPS for XFS in xfs_iget_core (using NFS+SMP+MD)
References: <428511F8.6020303@wildbrain.com> <20050514184711.GA27565@taniwha.stupidest.org> <428B7D7F.9000107@wildbrain.com> <20050518175925.GA22738@taniwha.stupidest.org> <20050518195251.GY422@unthought.net> <Pine.LNX.4.58.0505181556410.6834@chaos.egr.duke.edu>
In-Reply-To: <Pine.LNX.4.58.0505181556410.6834@chaos.egr.duke.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-WB-MailScanner: Found to be clean
X-WB-MailScanner-SpamCheck: not spam (whitelisted),
	SpamAssassin (score=-1.845, required 5, BAYES_00 -2.60,
	J_CHICKENPOX_45 0.60, TW_JB 0.08, TW_UH 0.08)
X-MailScanner-From: greg@wildbrain.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joshua Baker-LePain wrote:
> Do you have a test case that would show this up?  I've been testing a 
> centos-4 based server with the RH-derived 2.6.9-based kernel tweaked to 
> disable 4K stacks and enable XFS and haven't run into any issues yet.  
> This includes running the parallel IOR benchmark from 10 clients (and 
> getting 200MiB/s throughput on reads).
> 

For Jakob,
Note that the last OOPS I posted was for 2.6.11.10.


For Joshua,

We first saw the problem after 5 days in production, but since then
we took the server out of production and used the script
nfs_fsstress.sh located in this package:

http://prdownloads.sourceforge.net/ltp/ltp-full-20050505.tgz?download

We run the script on 5 client machines that are running RedHat 9
with kernel-smp-2.4.20-20.9 and nfs-utils-1.0.1-3.9.1.legacy and
are NFS mounting our 2.6 kernel server.  The longest time to OOPS
has been about 8 hours.  We have not tried the parallel IOR
benchmark.  (Where can we get that?)

You didn't mention if you are using md at all.  We have a
software RAID-0 of 4 x 3ware 8506-4 controllers running the
latest 3ware driver from their site.  The filesystem is XFS.
The network driver is e1000 (two interfaces, not bonded).  The
system is a dual Xeon.  We upped the number of NFS daemons
from 8 to 64.  The nfs_fsstress.sh client mounts the servers
both UDP and TCP, and our in-production oops likely happened
with a combination of both protocols in use simultaneously as
well.  We've seen the OOPS with both the default and with 32K
read and write NFS block sizes.  The machine was stable for
over a year with RedHat 9 and 2.4.20.

I'm grasping for any subtle details that might help...

Here is our list of loaded modules:

Our server configuration is
Module                  Size  Used by
nfsd                  185569  65
exportfs                9921  1 nfsd
lockd                  59625  2 nfsd
md5                     8001  1
ipv6                  236769  16
parport_pc             29701  1
lp                     15405  0
parport                37129  2 parport_pc,lp
sunrpc                135077  28 nfsd,lockd
xfs                   487809  1
dm_mod                 57925  0
video                  19653  0
button                 10577  0
battery                13253  0
ac                      8773  0
uhci_hcd               33497  0
hw_random               9429  0
i2c_i801               11981  0
i2c_core               24513  1 i2c_i801
e1000                  84629  0
bonding                59817  0
floppy                 56913  0
ext3                  117961  2
jbd                    57177  1 ext3
raid0                  11840  1
3w_xxxx                30561  4
sd_mod                 20545  4
scsi_mod              116033  2 3w_xxxx,sd_mod


Let me know if there is anything else I can provide.

Thanks.

Greg
