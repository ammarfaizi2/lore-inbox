Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265361AbTFMQ6i (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 12:58:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265396AbTFMQ6i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 12:58:38 -0400
Received: from fw-az.mvista.com ([65.200.49.158]:21748 "EHLO
	zipcode.az.mvista.com") by vger.kernel.org with ESMTP
	id S265361AbTFMQ6e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 12:58:34 -0400
Message-ID: <3EEA0577.8050200@mvista.com>
Date: Fri, 13 Jun 2003 10:10:15 -0700
From: Steven Dake <sdake@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Patrick Mochel <mochel@osdl.org>
CC: Oliver Neukum <oliver@neukum.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] udev enhancements to use kernel event queue
References: <Pine.LNX.4.44.0306130942040.908-100000@cherise>
In-Reply-To: <Pine.LNX.4.44.0306130942040.908-100000@cherise>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Patrick Mochel wrote:

>>>+static int sdeq_open (struct inode *inode, struct file *file)
>>>+{
>>>+	MOD_INC_USE_COUNT;
>>>+
>>>+	return 0;
>>>+}
>>>+
>>>+static int sdeq_release (struct inode *inode, struct file *file)
>>>+{
>>>+	MOD_DEC_USE_COUNT;
>>>+
>>>+	return (0);
>>>+}
>>>
>>>Wrong. release does not map to close()
>>>
>>> 
>>>
>>>      
>>>
>>hmm not sure where I got that from i'll fix thanks.
>>    
>>
>
>You don't even need to modify the module refcount, since sdeq cannot even 
>be built as a module. Also, return is a statement, not a function; you 
>could at least be consistent. 
>  
>
Yes this area needs some work. I copied from a previous driver, which 
was obviously also not consistent:)

>  
>
>>For device enumeration, I see a daemon as necessary.  The main goal of 
>>this work is to solve the out-of-order execution of sbin/hotplug and 
>>improve performance of the system during device enumeration with 
>>significant (200 disks, 4 partitions each) amounts of devices.  Boot 
>>time with this scheme appears, in my rudimentary tests, to be faster on 
>>the order of 1-2 seconds for bootup for the case of just 12 disks.  I 
>>would imagine 200 disks (which I don't have a good way to test, as I 
>>don't have 200 disks:) would provide better speed gains during bootup.  
>>This compares greg's original udev to this patched udev binary.
>>    
>>
>
>This part I really don't get about your argument. 
>
>For one, please back up your claim with the method that you used to test
>and post some real numbers, showing real improvement. If you would like
>more hardware to test on, we have an entire lab full of large systems
>specifically for purposes like this. I don't know if we have a 200 disk
>library, but you can see what you can get at:
>
>	http://osdl.org/stp/
>  
>
Brian Jackson (open gfs project) has offered to run a test case. I'll 
work with him to determine a test methodology and test results.

>
>For another, you're preaching about availability, from I presume the 
>carrier-grade camp, since Montavista has a CG distro, and you're involved 
>in our own CGL working group. But, I have never heard of a carrier-grade 
>system that used 12 disks, let alone 200. I fail to see how you're backing 
>up your argument about the 1 second that you saving with a realistic 
>example. 
>  
>
There are two major types of carrier grade applications. Data plane and 
Control plane. Data plane applications generally don't use disks at all 
and this is probably what your most familiar with. Control plane 
applications (such as a home location register) or billing systems etc 
often use multitudes of disks for databases. Currently Linux is well 
suited for control plane applications on x86 with storage, and data 
plane applications on ppc without storage.

>But, I also don't think that the speed hit would increase linearly.
>
>Besides, even if the system had access to 200+ disks, it's probably in a 
>separate library, accessible to an/the entire cluster. It's likely also a 
>commercial storage library, and not a linux system. 
>
>Please, educate me and prove me wrong; I'm not opposed to new ways of 
>thinking. 
>  
>
Future designs (such as ATCA), of which I am mostly concerned with, 
include storage in the chassis itself. A chassis may have 12 slots, of 
which 10 could be disks or cpu slots. The remaining two slots are 
fibrechannel hubs or ethernet switches. The fibrechannel hubs can (and 
often are) tied together through front-panel connectors, to form a rack 
or multiple racks in a cluster. Fibrechannel allows for 126 devices in a 
FCAL. There are two fibrechannel hubs per chassis, which allows for each 
cpu to see a total of 252 devices. now some of these devices could 
certainly be CPUs, but the ratio is atleast 1cpu:2disks since each cpu 
blade should use RAID 1 to protect against disk failure and provide easy 
hotswap. Then there are of course partitions, of which there could be 
many, and of which each one is a seperate device seperately enumerated 
in the system. So a realistic system, currently shipping today for the 
telecom market, could require the enumeration of 
16(partitions)*168(disks) More realistically, each system may have 3 
partitions, which is 3*168 disks, or even more realistically, each 
system may only have 1/4 as many disks, which is 3*42, or 120 disks 
(times two channels, 240 device enumerations).

Brian Jackson has said there are 50 disks in the OSDL cluster, of which 
he could put 3 partitions on, which would test 150 device enumerations.

I propose the following test:
Create 3 partitions on all 50 disks. Create system to boot kernel.org 
2.5.70 with initramdisk. Try greg's original udev without kernel aptch, 
try modified udev with kernel patch, time each system's startup time.

Do you agree with the test methodology? If so, then we can proceed with 
gathering real data.

Thanks
-steve

>  
>
>>devfs is not appropriate as it does not allow for complex policy with 
>>external attributes that the kernel is unaware of.  For an example, lets 
>>take the situation where a policy must access a cluster-wide manager to 
>>determine some information before it can make a policy decision.  For 
>>that to occur, there must be sockets, and hopefully libc, which puts the 
>>entire thing in user space.  Who would want to write policies in the 
>>kernel?  uck.
>>    
>>
>
>Cluster-wide manager of policy? Fine, you can do that with /sbin/hotplug, 
>too. But, I don't think network latency is going to help your boot time..
>
>  
>
yes this can be done with /sbin/hotplug, but not with devfs in the 
kernel. This was just an example, as there may be other policies which 
can only be done in the C language and not accessible from the kernel. 
/sbin/hotplug, of course, could have the same access as any other policy.

>	-pat
>
>
>
>  
>

