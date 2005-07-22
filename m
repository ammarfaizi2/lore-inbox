Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262097AbVGVObb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262097AbVGVObb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 10:31:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262092AbVGVO3P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 10:29:15 -0400
Received: from zproxy.gmail.com ([64.233.162.201]:59879 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262104AbVGVO1W convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 10:27:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=q2kUKpu7bToqXjbIsMDO8aCRVDH/P3cMIcclXN7EVKD3nR8tgtT5NbuYoVTixIm39jr3WgswtUkyawBo9CqIBQmT/3mL+FD3W4A7L3zPdAHASnAlvGxNxYFUWu0ZGEYoZ5HA1p0r62gndQ2BGriA4FRQ5klFT9pNVLlABI8gV64=
Message-ID: <7d15175e050722072727a7f539@mail.gmail.com>
Date: Fri, 22 Jul 2005 19:57:14 +0530
From: Bhanu Kalyan Chetlapalli <chbhanukalyan@gmail.com>
Reply-To: Bhanu Kalyan Chetlapalli <chbhanukalyan@gmail.com>
To: vamsi krishna <vamsi.krishnak@gmail.com>
Subject: Re: Whats in this vaddr segment 0xffffe000-0xfffff000 ---p ?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3faf0568050721232547aa2482@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <3faf0568050721232547aa2482@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

To the best of my knowledge, It is the vsyscall page. The manner in
which system calls were implemented has changed from using the 80h
interrupt directly to using the vsyscall page (on the x86 arch). This
makes for better throughput while running frequently used system calls
which do not affect the kernel, but merely retrieve the information. A
very good example is the system call to retrieve the current time,
which is used extensively esp during logging. Google for vsyscall page
and you will get more information.

> on a 64-bit(uname --all == 'Linux host 2.6.5-7.97.smp #1 <time stamp>
> x86_64 x86_64 x86_64 GNU/Linux) machine which is running the same
> kernel, I try to write the contents of the virtual address on to file
> with (r = write(fd,0xffffe000,4096) ). The write on this machine is
> successful. But if I try to write the same segment on 32-bit machine
> (uname --all == Linux host 2.6.5-7.97-smp #1 <timestamp> i686 i686
> i386 GNU/Linux).

The location of the vsyscall page is different on 32 and 64 bit
machines. So 0xffffe000 is NOT the address you are looking for while
dealing with the 64 bit machine.  Rather 0xffffffffff600000 is the
correct location (on x86-64).

Regards,
Bhanu.


On 7/22/05, vamsi krishna <vamsi.krishnak@gmail.com> wrote:
> Hello All,
> 
> Sorry to interrupt you.
> 
> I have been facing a wierd problem on same kernel version
> (2.6.5-7.97.smp) but running on different machines 32-bit and 64-bit
> (which can run 32-bit also).
> 
> I found that every process running in this kernel version has a
> virtual address mapping in /proc/<pid>/maps file as follows
> <-------------------------------------------------------------------------------------------------->
> ffffe000-ffff000 ---p 00000000 00:00 0
> <-------------------------------------------------------------------------------------------------->
> 
> You can find this vaddr mapping at end of maps file.
> 
> on a 64-bit(uname --all == 'Linux host 2.6.5-7.97.smp #1 <time stamp>
> x86_64 x86_64 x86_64 GNU/Linux) machine which is running the same
> kernel, I try to write the contents of the virtual address on to file
> with
> (r = write(fd,0xffffe000,4096) ). The write on this machine is
> successful. But if I try to write the same segment on 32-bit machine
> (uname --all == Linux host 2.6.5-7.97-smp #1 <timestamp> i686 i686
> i386 GNU/Linux).
> 
> The write on this 32-bit machine fails with EFAULT(14), but if memcpy
> to a buffer from this virtual address seems to work fine i.e if I do
> 'memcpy(buf1,0xffffe000,4096)' it write perfectly the contents of this
> virtual address segment into the buf1.
> 
> I had a hard time googling about this I could'nt find any information
> on why this happens. May be some mm hackers may share some of their
> thoughts.
> 
> Really appreciate your inputs on this.
> 
> Sincerely,
> Vamsi kundeti
> 
> PS: BTW I'am running suse distribution and will glibc will have any
> effect on write behaviour ? (I though that since write is a syscall
> the issue might be with the kernel the thus skipping the glibc
> details)
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


-- 
The difference between Theory and Practice is more so in Practice than
in Theory.
