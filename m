Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311928AbSCUN4n>; Thu, 21 Mar 2002 08:56:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312104AbSCUN4Y>; Thu, 21 Mar 2002 08:56:24 -0500
Received: from gear.torque.net ([204.138.244.1]:34309 "EHLO gear.torque.net")
	by vger.kernel.org with ESMTP id <S311928AbSCUN4J>;
	Thu, 21 Mar 2002 08:56:09 -0500
Message-ID: <3C99E6C7.34F05AE7@torque.net>
Date: Thu, 21 Mar 2002 08:57:27 -0500
From: Douglas Gilbert <dougg@torque.net>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Pete Zaitcev <zaitcev@redhat.com>
CC: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: 2 questions about SCSI initialization
In-Reply-To: <20020321000553.A6704@devserv.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pete Zaitcev wrote:
> 
> Hello:
> 
> I've got two questions which I cannot answer just by reading
> the code, so I need to refer to the institutional memory of
> the hackerdom (Doug G. - I need your memory, too :)
> 
> The context is that I got a bug with oops by someone with 68 SCSI
> disks, traceable to a scsi_build_commandblocks failure, with a
> subsequent oops because the error patch calls scsi_unregister_device,
> and scsi_unregister_device aborts with module reference check.
> 
> Now the questions:
> 
> #1: Why does scsi_build_commandblocks() allocate memory with
> GFP_ATOMIC? It's not called from an interrupt or from a swap I/O
> path as far as I can see.

Pete,
There has long been a preference in the scsi subsystem
for using its own memory management ( scsi_malloc() )
or the most conservative mm calls. GFP_ATOMIC may well
be overkill in scsi_build_commandblocks(). However it
might be wise to check that the calling context is indeed
user_space since this can be called from all subsystems 
that have a scsi pseudo device driver (e.g. ide-scsi, 
usb-storage, 1394/sbp2, ...).
 
> #2: What does  if (GET_USE_COUNT(tpnt->module) != 0)  do in
> scsi_unregister_device? The circomstances are truly bizzare:
> a) the error code is NEVER used
> b) it can be called either from module unload.
> I would like to kill that check.

Another badly named function since it is unregistering
in upper level driver (e.g. sd). That "if" is to check
if there are open file descriptors (or some other
reason **) on the driver in question. That seems to be
a sensible check. Whether it can every happen in that
context, I'm not sure.


** The sg driver purposely holds its USE_COUNT > 0 even
when all its file descriptors are closed iff there are
outstanding commands for which the response has not
yet arrived. [If this is not done, then a control-C on
something like cdrecord followed by "rmmod sg" may
cause an oops, especially during "fixating" mode.]

Doug Gilbert
