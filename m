Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264912AbSJ3VCc>; Wed, 30 Oct 2002 16:02:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264910AbSJ3VCc>; Wed, 30 Oct 2002 16:02:32 -0500
Received: from fw-az.mvista.com ([65.200.49.158]:52464 "EHLO
	zipcode.az.mvista.com") by vger.kernel.org with ESMTP
	id <S264907AbSJ3VC2>; Wed, 30 Oct 2002 16:02:28 -0500
Message-ID: <3DC04A74.9020701@mvista.com>
Date: Wed, 30 Oct 2002 14:09:08 -0700
From: Steven Dake <sdake@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: [PATCH] SCSI and FibreChannel Hotswap for linux 2.5.44-bk2
References: <3DC02AF7.6020209@mvista.com> <20021030201834.A4815@infradead.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph,

I'll seperate the patches and fix the things you mention.  I'm still not 
entirely pleased with the locking and Patrick Mansfield has suggested a 
better method for traversing the host_queue structure that I may consider.

Regarding WWN translation in userspace, there are several reasons why 
this apporach is inferior:

1.  When a device is "inserted" into the system and isn't present, there 
is no way to map WWNs to target ids.  Processing in userspace would work 
for removals, but what about insertions?  Sure the driver could export 
its list of known WWNs (the firmware maintains a list of active WWNs on 
the bus and their associated scsi target, even if the SCSI subsystem 
doesn't know the device is there), but read #2 below:

2.  There is no simple way to know what WWN maps to which SCSI ID from 
user space.

Typical FibreChannel drivers maintain this information, but it isn't 
exported to user space in any useable way.  I suppose a list of 
device->WWN maps could be present in /proc or driverfs but that adds 
alot of string processing from user space and requires a standard format 
between drivers to be generically usable.  Further, what if two drivers 
want to keep track of their device to WWN map?  They must each register 
with some function that exports the list to userspace.  Why go through 
all the trouble when the driver can just do the work?

3.  Hotswap operations should be fast (10 msec or so) and userspace 
processing is slow.
Compare two operations one using the defined hotswap mapping interface 
and one processing a file in proc
processing in userspace:
while (not_eol) {
read syscall
convert string WWNS to 64 bit number
compare WWNS
if matched, convert string scsi target information (host, channel, 
target, lun) into 32 bit numbers
    issue hotswap command using host channel target lun information
}

processing in kernel:
call wwn to scsi target converter in driver
in driver, each WWN is compared against wwn in WWN list
if match found, scsi target information returned

Now, assume the above with 32 or more devices.  That is alot of syscalls 
using userspace methodology (and slow).  Let the kernel do the 
conversion directly.  It has direct access to the data.  Another choice 
would be to put a 64 bit field for wwn's into the scsi device structure. 
 Then the scsi device list could be traveresed to find the correct 
target to hotswap.  Would this be preferrrable to the interface 
currently implemented?

4. Having to map WWNs to scsi IDs in userspace is harder to use
its alot easier to remove a device to echo "wwn" > 
/sys/bus/scsi/hotswap_comamnds/remove_by_fc_wwn_wildcard

compare that with writing an application to process /proc entries (or 
something similiar).

other comments below:

Christoph Hellwig wrote:

>Umm, stop.
>
>Scsi midlayer patches don't go directly to Linus, but through the linux-scsi
>list and James into the linux-scsi bk repository first.
>
>The patch still has a bunch of problem not solved, and contains two things
>that should be independant patches.
>
>The first patch should be the host_queue locking you added, this one currently
>has the following issues:
>
>* you call spin_lock on a semaphore once!
>  
>
sloppy I'll fix.

>* you take semaphores inside spinlocks and with interrupts disabled
>
good point I think I need to look at this patch more.

>* the coding style needs some imnprovements (you adds lots of empty lines,
>  and there's a space before the opening brakes of function calls).
>
>the actual driver still has other issues:
>
>* you still duplicated lots of code from scsi.c
>
I'll remove the code from scsi.c and have it call the hotswap interfaces 
directly.

>* your header is still in include/linux instead of include/scsi,
>  but imho it should be merged into scsi.h anyway
>
I'll merge into scsi.h.

>* you still havent explain why wwn -> host id translation can't
>  be done in userspace
>
see above

>* you still have useage information in the driverfs files.
>
>  
>
i'll remove.

Thanks for the great comments.  
-steve

