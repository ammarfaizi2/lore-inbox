Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261386AbVFCQmj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261386AbVFCQmj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 12:42:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261389AbVFCQmi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 12:42:38 -0400
Received: from smtp107.mail.sc5.yahoo.com ([66.163.169.227]:42365 "HELO
	smtp107.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261386AbVFCQmD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 12:42:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=Z3w3hGw+Il34e6NOa0jimPrzBk3G9O2z+NbLg9xXnnSft8PBNjDRduJoYp84edsGkgi4r/jPa+Z6tr0O+GJc0t9dPBioe7Py7wzdEyGlLOkDpv03l4OY2se5sTHT2EZloDR8v1O6mxYFAu7gPNrfF/itW+8fIzxzn/3GomgX0qc=  ;
Message-ID: <42A08856.7090402@yahoo.com>
Date: Fri, 03 Jun 2005 12:41:58 -0400
From: "J. Scott Kasten" <jscottkasten@yahoo.com>
User-Agent: Mozilla/5.0 (X11; U; IRIX64 IP30; en-US; rv:1.4.1) Gecko/20040105
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Wakko Warner <wakko@animx.eu.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: question why need open /dev/console in init() when starting kernel
References: <42A00065.9060201@avantwave.com> <Pine.LNX.4.61.0506030629170.11487@chaos.analogic.com> <20050603141504.GA14641@animx.eu.org> <42A073BA.5040700@yahoo.com> <20050603152017.GC14641@animx.eu.org>
In-Reply-To: <20050603152017.GC14641@animx.eu.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Wakko Warner wrote:

>J. Scott Kasten wrote:
>  
>
>>Wakko Warner wrote:
>>    
>>
>>>Is it at all possible that if /dev/console does not exist that the kernel
>>>can mknod it?
>>>      
>>>
>>Yes, you could modify the kernel source to create the directory and 
>>device nodes for you if you must.  I have written a few embedded drivers 
>>that created their access nodes that way.
>>    
>>
>
>That's interesting.  All I wanted to do was create /dev and /dev/console if
>they don't exist.  The project I was working on was a 2 stage where stage 1
>loads stage 2 (stage 1 is small enough for floppy use).  Since space is a
>concern, I was wondering if the entries in a cpio archive would be more or
>less bytes compared to the code in the kernel to do it.  At the moment I
>have a vanilla kernel that I'm using (2.6.12-rc5).
>  
>
Have you considered making a root cramfs?  I could almost guarantee that 
it would be smaller, not only that, but you get a gzip like compression 
for free.  Now that I have a little better picture of what you are 
trying to do, I would suggest using a read-only cramfs for your root 
file system.  You can selectively mount writeable file systems over it.

In fact, at the end of your "boot strapping process", you could 
pivot_root/chroot into a live file system on disk then drop the cramfs.  
I use this procedure on the flash of my Zaurus.  It boots a cramfs image 
from the on-board flash which then loads the SD card driver, checks some 
things out, and finally mounts and chroots into a 512MB flash card with 
a nearly stock debian image on ext2.

Actually, even debian uses this type of procedure to fsck the disks and 
look for new devices before turning control over to the disk based system.

>  
>
>>You can also modify the arch/xxx/startup.c file and change the inital 
>>console to /dev/null or just NULL if you need too.  However, I will warn 
>>you of some bad experiences.  I found that tar, and the bash shell 
>>sometimes misbehave with no terminal.  They would inexplicably hang 
>>unless I forced I/O paths 0, 1, 2 to /dev/null.  Tar and the shell would 
>>hang, even though they were not prompting, nor expecting input.  Yet I 
>>could set the initial console to a serial port and it would run fine, 
>>even if the command generated no output!  Very strange and hard to debug 
>>in a restricted environment like that.  Somewhere in that code, it must 
>>have been testing the default I/O paths to see if they were tty like 
>>devices or something and then freaking out with unexpected results.
>>    
>>
>
>The system will be used by console users only (mostly me), thus I can't use
>/dev/null.  The / is populated via a gzipped cpio archive passed via initrd. 
>I don't care if it's right, all that matters is that it works and is small.
>
>  
>
>>My best advice in a situation like this is to actually write your own 
>>pseudo console device driver.  It's not that hard and you might actually 
>>find a way to make it usefull for debugging.  Basicly make it a console 
>>that feeds about a 2K static ring buffer in kernel memory.  That gets 
>>you a few screen fulls of data for debugging.  If you have a PC style 
>>real-time clock, there is a 2K static ram in most of those.  Or "ping" 
>>it out through the network with magic ICMP packets.  Either way, you 
>>have created a usefull debugging tool that will be invaluable for 
>>resolving bootstrapping problems, and you just won't have to deal with 
>>the strangeness I mentioned above.
>>    
>>
>
>I don't believe I can do this.  I've never written a kernel driver before. 
>What I built was a short lived system.  As I stated, it has to be small
>(stage 1 only).  I can now easily reproduce the building of the kernel and
>stage 1 and fit it on a floppy (that was when I upgraded from rc4 to rc5). 
>I had originaly had ext2 compiled in, since 1) the old initrd ramdisk image
>was ext2 2) it was the only filesystem I was using that had unix file
>permissions (and was writable) 3) it was actually the smallest compared to
>the other ones I used.  Now that I pass cpio archive to it, I no longer need
>ext2 compiled in (it's on stage 2 which is either cdrom or usb disk)
>  
>
I don't think you need to do all that I suggested earlier.  I cam in on 
the middle of this discussion and it sounded like a small embedded 
environment you were trying to enhance.  The cramfs image thing I 
described above is probably a much better fit for your needs.

