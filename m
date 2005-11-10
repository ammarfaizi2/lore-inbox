Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751384AbVKJBof@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751384AbVKJBof (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 20:44:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751370AbVKJBof
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 20:44:35 -0500
Received: from hulk.vianw.pt ([195.22.31.43]:57475 "EHLO hulk.vianw.pt")
	by vger.kernel.org with ESMTP id S1751384AbVKJBoe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 20:44:34 -0500
Message-ID: <4372A5F6.7030306@esoterica.pt>
Date: Thu, 10 Nov 2005 01:44:22 +0000
From: Paulo da Silva <psdasilva@esoterica.pt>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Anton Altaparmakov <aia21@cam.ac.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: Accessing file mapped data inside the kernel
References: <437258CD.8060206@esoterica.pt> <Pine.LNX.4.64.0511092143400.19282@hermes-1.csi.cam.ac.uk>
In-Reply-To: <Pine.LNX.4.64.0511092143400.19282@hermes-1.csi.cam.ac.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Altaparmakov wrote:

>Hi,
>
>On Wed, 9 Nov 2005, Paulo da Silva wrote:
>  
>
>>I posted about this a few days ago but got no responses
>>so far! I think this should be a trivial question for those
>>involved in the kernel internals. May be I didn't develop
>>the problem enough to be understood.
>>
>>So, here is the question reformulated.
>>
>>A given file system must supply a procedure for mmap.
>>
>>int <fsname>_file_mmap(struct file * file, struct vm_area_struct * vma)
>>{
>>  int addr;
>>  addr=generic_file_mmap(file,vma);
>>  <Code to access addr pointed bytes or vma->vm_start>
>>  return addr;
>>}
>>
>>I could verify that "addr" is what is returned to the user as
>>a pointer to a string of bytes that maps a file when a user
>>program calls mmap or mmap2.
>>
>>In the user program, I can access those bytes (read/write)
>>as, for ex., a char pointer.
>>
>>I don't know how to access those bytes inside the kernel
>>at the point <Code to access addr pointed bytes or vma->vm_start>
>>
>>First trys led the program that invoked mmap to block.
>>I thought that there's something to do with a previous
>>   down_write(&current->mm->mmap_sem);
>>If I execute
>>   up_write(&current->mm->mmap_sem);
>>before accessing the data the block situation does not
>>occur anymore. I would like to hear something about
>>this.
>>
>>Anyway, I tryed to use "copy_from_user" but I got
>>garbage, not the file contents! Using "strncpy" crashes
>>the kernel (UML)!
>>
>>Can someone please write a fragment of code to safely
>>access those bytes, copying them to and from a
>>kernel char pointed area so that they are read/written
>>to the file?
>>    
>>
>
>Why do you want to do that?  If you explain what you are trying to do it 
>may be possible to help you better.  It is almost 100% certain that your 
>are going about it in completely the wrong way, so please describe what 
>you are trying to do...
>
>Best regards,
>
>	Anton
>  
>
Just try to understand the kernel filesystem.
So far I could understand the 1st layer of
reading and writing. mmap seems to be a
difficult task however. So, I made a 1st try
looking at mmap supplied by the filesystem,
but I couldn't even succeed with a printk
of the mapped area! I would like to understand
what is the meaning of the address (int) returned
by generic_file_mmap that is also into vma->vm_start
and is returned to the user as a char pointer.
I thought that this address, being accessible
by a user program as a char pointer, should also
be accessible by a copy-from-user inside the
kernel. Unfortunately, this didn't happen!
Why? That's my question. Did I make any mistake?
A basic fragment of code showing how to access
that area could enlight me so that I could go
deeply into the code.

Ex.
Suppose a file has a string of text ("foo")
and the user calls mmap.

Why does this code not work?

The supplied filesystem mmap is "generic_file_mmap".
So, I changed it to foo_file_mmap as follows:

int foo_file_mmap(struct file * file, struct vm_area_struct * vma)
{

  int addr;
  char tstr[100];
  addr=generic_file_mmap(file,vma);
  up_write(&current->mm->mmap_sem); /* Without this the user program is dead locked */
  copy_from_user(tstr,(char*)addr,4);
  printk("%s",tstr);

  return addr;
}


