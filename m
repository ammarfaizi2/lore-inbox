Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263029AbVD2WVA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263029AbVD2WVA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 18:21:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263030AbVD2WVA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 18:21:00 -0400
Received: from ms-smtp-04.texas.rr.com ([24.93.47.43]:47566 "EHLO
	ms-smtp-04.texas.rr.com") by vger.kernel.org with ESMTP
	id S263029AbVD2WUu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 18:20:50 -0400
Message-ID: <4272B335.5090207@austin.rr.com>
Date: Fri, 29 Apr 2005 17:20:37 -0500
From: Steve French <smfrench@austin.rr.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cifs: handle termination of cifs oplockd kernel thread
References: <4272A275.4030801@austin.rr.com> <20050429213108.GA15262@infradead.org>
In-Reply-To: <20050429213108.GA15262@infradead.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:

>On Fri, Apr 29, 2005 at 04:09:09PM -0500, Steve French wrote:
>  
>
>>>does and who revied that?  Things like that don't have a business in the
>>>kernel, and certainly not as ioctl.
>>>      
>>>
>>Other filesystems such as smbfs had an ioctl that returned the uid of 
>>the mounter which they used (in the smbfs case in smbumount).  This was 
>>required by the unmount helper to determine if the unmount would allow a 
>>user to unmount a particular mount that they mounted.   Unlike in the 
>>case of mount, for unmount  you can not use the owner uid of the mount 
>>target to tell who mounted that mount.   I had not received any better 
>>suggestions as to how to address it.   I had proposed various 
>>alternatives - exporting in in /proc/mounts e.g.   
>>    
>>
>
>exporting the uid using the show_options superblock methods sounds like
>a much better option.
>
>  
>

>No.  /proc/self/mounts is an ASCII format, so there's no problem with
>differemt sizes.
>
>
>  
>

I agree that it would work for most cases [today, in 2.6 Linux] - but I 
really feel uncomfortable introducing a user space / kernel space 
dependency on the size of a field where none is needed - I am especially 
nervous because I can see from the Samba change logs that:
1) historically the size of this field changed
2) other operating systems also have either increased the size of uid 
(as MacOS e.g.) or mapped it (as Windows does) - to accomodate the 
needed concept of UUID (in large networks the current uid is too small)

Ideally I would have liked a general kernel call to be able to answer 
the question "Does the current security context match that of the 
mounter?"  because with SELinux, and the need to increase the size of 
uid or somehow work around it for distributed systems, it is hard for 
user space code to take something opaque (the thing that showmounts 
returns) and map it to what libc returns as the uid for current - 
otherwise it would be impossible for user space code to guarantee that 
it will match the kernel code, but this is so trivial, and has no 
sideeffects so in the interim this seems safer.



   
