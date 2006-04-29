Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751097AbWD2Ilk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751097AbWD2Ilk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Apr 2006 04:41:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751145AbWD2Ilk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Apr 2006 04:41:40 -0400
Received: from smtpout.mac.com ([17.250.248.182]:5842 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1751097AbWD2Ilj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Apr 2006 04:41:39 -0400
In-Reply-To: <20060429075311.GB1886@kroah.com>
References: <20060428112225.418cadd9.holzheu@de.ibm.com> <20060429075311.GB1886@kroah.com>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <8A7D2F4D-5A05-4C93-B514-03268CAA9201@mac.com>
Cc: Michael Holzheu <holzheu@de.ibm.com>, akpm@osdl.org,
       schwidefsky@de.ibm.com, penberg@cs.helsinki.fi, ioe-lkml@rameria.de,
       joern@wohnheim.fh-wedel.de, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [PATCH] s390: Hypervisor File System
Date: Sat, 29 Apr 2006 04:41:05 -0400
To: Greg KH <greg@kroah.com>
X-Mailer: Apple Mail (2.746.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 29, 2006, at 03:53:11, Greg KH wrote:
>> The update process is triggered when writing 'something' into the  
>> 'update' file at the top level hypfs directory. You can do this  
>> e.g. with 'echo 1 > update'. During the update the whole directory  
>> structure is deleted and built up again.
>
> This sounds a lot like configfs.  Why not use that instead?
>
> Is there a reason that sysfs can't be used for a lot of these  
> things too?
>
> We already have the different cpus in sysfs, why put things in a  
> different location than that?

It sounds like a lot of things need some kind of shell-scriptable  
transaction interface for sysfs files.  You don't want to have more  
than one value per file, but reading or writing of some values must  
be done together for consistency reasons.  Is there any way to  
implement something like this?  This would work for the framebuffer  
people and solve the needs of a lot of the people who still want  
ioctls or some other atomic-multivalued transfer that would otherwise  
be a great sysfs candidate.

> # Start a transaction
> exec 3</sys/hypervisor/s390/transaction
>
> # Add another reference to the transaction
> exec 4<&3
>
> # List CPUs and info
> cd /sys/hypervisor/s390/cpus
> for i in *; do
> 	echo "CPU $i: type=`cat type` mgmtime=`cat mgmtime`"
> done
>
> # Transaction does *not* end here
> exec 3<&-
>
> # List CPUs again a different way
> ls /sys/hypervisor/s390/cpus
>
> # Transaction does end here
> exec 4<&-

A process that doesn't care about the transaction (Like a user  
inspecting from a shell), could just cd in and cat random files, and  
it would run a transaction for each file opened, and end the  
transaction when the file is closed.  Obviously that's inefficient,  
but it's obviously correct and works.  Otherwise, from opening the  
transaction filehandle for the first time till closing the last open  
FD to it, the process would get a consistent view of the data, read  
when the "transaction" file is first opened opened.  Perhaps any  
modifications would be synced and written at the close of that  
filehandle.

I don't know if that's something doable given the FD model, but if it  
is, then that's trivial to use for the admin, in shell scripts, perl  
scripts, C programs, etc.  It also works with the one-value-per-file  
sysfs model.

Cheers,
Kyle Moffett

