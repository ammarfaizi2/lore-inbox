Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266785AbUGVAus@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266785AbUGVAus (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jul 2004 20:50:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266787AbUGVAus
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jul 2004 20:50:48 -0400
Received: from w130.z209220038.sjc-ca.dsl.cnc.net ([209.220.38.130]:20980 "EHLO
	mail.inostor.com") by vger.kernel.org with ESMTP id S266785AbUGVAud
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jul 2004 20:50:33 -0400
Message-ID: <40FF0ED0.10306@inostor.com>
Date: Wed, 21 Jul 2004 17:48:16 -0700
From: Shesha Sreenivasamurthy <shesha@inostor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rob van Nieuwkerk <robn@verdi.et.tudelft.nl>
Cc: linux-kernel@vger.kernel.org, kernelnewbies@nl.linux.org
Subject: Re: O_DIRECT
References: <40FD561D.1010404@inostor.com>	<20040721020520.4d171db7.robn@verdi.et.tudelft.nl>	<40FEA382.8050700@inostor.com>	<20040721192042.11f9c3f5.robn@verdi.et.tudelft.nl>	<40FEAF70.4070407@inostor.com>	<20040721201532.7e6161ed.robn@verdi.et.tudelft.nl>	<40FEF9CD.9020308@inostor.com>	<20040722015444.6cbeaee0.robn@verdi.et.tudelft.nl>	<40FF0387.5040303@inostor.com> <20040722021810.14e40e2f.robn@verdi.et.tudelft.nl>
In-Reply-To: <20040722021810.14e40e2f.robn@verdi.et.tudelft.nl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, I got to know what exactly is the problem ,,

Basically on my partition total sectors is not a muliple of 8 (Each 
sector = 512, 4096/512=8). That is the end of the disk is not alligned 
with 4096, What I am doing is, reading/writing from/to the last 8192 
bytes by seeking (Negetive  8192) from the end. So this may not be 4096 
byte alligned. Now the start of my read/write point  WILL always be 1024 
byte alligned in case of odd and even # of sectors becasue, Even number 
of sectors is trivial/obvious, but in case of odd # of sectors, when we 
do a SEEK_END it will always seek to the last EVEN sector of the disk. 
Therefore I am always successful with 1024 byte alligned. Actually the 
last sector in my case is 490223474 :)

Thank you all, special thanks to Rob van Nieuwkerk ..
Shesha

Rob van Nieuwkerk wrote:

>On Wed, 21 Jul 2004 17:00:07 -0700
>Shesha Sreenivasamurthy <shesha@inostor.com> wrote:
>
>Hi Shesha,
>
>I've always used the default softblock sizes (eg. did not alter it)
>on the devices I've dealt with (which was 1024).
>
>Did you check what this default softblock size is for your device
>(with BLKBSZGET) ?
>
>Reading my old code I noticed that I use 3 (instead of the 2 I already
>mentioned) alignment requirements:
>
>	1.  read size 1024 byte aligned          (= softblock size)
>	2.  read buffer page aligned (4096)
>	3.  read/write offset 1024 byte aligned  (= softblock size)
>
>Rule 3. is important too for O_DIRECT !  It may be that rule 2. can be
>softblock aligned too, but page alignment certainly won't harm
>
>	greetings,
>	Rob van Nieuwkerk
>
>  
>
>>You are right I am not using any file system. Just did that experiment 
>>by creating FS too. That also did not help. I shared that information. 
>>You are absolutely right I am dealing with straight partitions.
>>
>>(1) With staraight partition even if I explicitly set the block size to 
>>4096 and adher to the rules of O_DIRECT i cannot read/write
>>
>>(2) With staraight partition if I set the block size to 1024 and adher 
>>to the rules of O_DIRECT i can read/write
>>
>>Ruls include : Alligning the buffer & read/write multiple of block size.
>>
>>-Shesha
>>
>>Rob van Nieuwkerk wrote:
>>
>>    
>>
>>>On Wed, 21 Jul 2004 16:18:37 -0700
>>>Shesha Sreenivasamurthy <shesha@inostor.com> wrote:
>>>
>>>Hi Shesha,
>>>
>>>Your original question (and my answer) was about a different situation:
>>>
>>>       - partition with no filesystem
>>>       - access on this raw partition
>>>
>>>Now you start talking about various file-systems and I get the impression
>>>that you access the device through the file-system (although that is
>>>not very clear in your text) on a mounted fs.
>>>
>>>What I told you applied to straight partitions (without mounted a mounted fs).
>>>
>>>I don't know the exact rules for the various file-systems.
>>>They might be different (and some might not support O_DIRECT at all).
>>>I expect the same "soft block size rules" to apply for the filesystems
>>>that *do* support O_DIRECT.  Note that mounting a partition might
>>>change the softblock size of that partition used by the kernel from thereon.
>>>
>>>
>>>	greetings,
>>>	Rob van Nieuwkerk
>>>
>>>PS1: what kernel are you using ?
>>>
>>>PS2: what are you trying to do ?
>>>
>>>PS3: you mention "our driver ..".  What is this driver ?
>>>
>>>
>>>
>>> 
>>>
>>>      
>>>
>>>>I could never get it working with 4096 block size.
>>>>
>>>>I created an EXT3 with blockize=4096 (mkfs.ext3 -b 4096 /dev/sda11). 
>>>>Alligned memory to 4096 boundary. Read 8192 Bytes. -> UNSUCCESSFUL :(
>>>>I created an XFS with blockize=4096 (mkfs.xfs -f  -b size=4096 
>>>>/dev/sda11). Alligned memory to 4096 boundary. Read 8192 Bytes. -> 
>>>>UNSUCCESSFUL :(
>>>>
>>>>SUCCESS HAPPEND ONLY WHEN ....
>>>>
>>>>1. I created an XFS with blockize=4096 (mkfs.xfs -f  -b size=4096 
>>>>/dev/sda11).
>>>>                                                      OR
>>>>   I created an EXT3 with blockize=4096 (mkfs.ext3 -b 4096 /dev/sda11).
>>>>
>>>>2. Changed blocksizeto 1024
>>>>3. Alligned memory to 1024 boundary.
>>>>4  Read 8192 Bytes. -> SUCCESSFUL :)
>>>>
>>>>-Shesha
>>>>
>>>>
>>>>Rob van Nieuwkerk wrote:
>>>>
>>>>   
>>>>
>>>>        
>>>>
>>>>>On Wed, 21 Jul 2004 11:01:20 -0700
>>>>>Shesha Sreenivasamurthy <shesha@inostor.com> wrote:
>>>>>
>>>>>Hi Shesha,
>>>>>
>>>>>
>>>>>
>>>>>     
>>>>>
>>>>>          
>>>>>
>>>>>>ohhh OK, if the block size is 4096, then the read/write size must be 
>>>>>>integer multiple of 4096 ??? is it ???
>>>>>>In general should the read/write length be a multiple of block size?
>>>>>>  
>>>>>>
>>>>>>       
>>>>>>
>>>>>>            
>>>>>>
>>>>>Yes, see my previous emails.
>>>>>
>>>>>	greetings,
>>>>>	Rob van Nieuwkerk
>>>>>
>>>>>
>>>>>
>>>>>     
>>>>>
>>>>>          
>>>>>
>>>>>>Rob van Nieuwkerk wrote:
>>>>>>
>>>>>>  
>>>>>>
>>>>>>       
>>>>>>
>>>>>>            
>>>>>>
>>>>>>>On Wed, 21 Jul 2004 10:10:26 -0700
>>>>>>>Shesha Sreenivasamurthy <shesha@inostor.com> wrote:
>>>>>>>
>>>>>>>Hi Shesha,
>>>>>>>
>>>>>>>You don't mention what the *size* of your read()/write() is.
>>>>>>>Besides a requirement on the alignment of the read/write buffer
>>>>>>>the size of the read()/write() must also be OK.
>>>>>>>
>>>>>>>	greetings,
>>>>>>>	Rob van Nieuwkerk
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>>    
>>>>>>>
>>>>>>>         
>>>>>>>
>>>>>>>              
>>>>>>>
>>>>>>>>This is what I found ....
>>>>>>>>
>>>>>>>>Our driver sets the block size to be 4096. so BLKBSZGET will return 
>>>>>>>>4096. So if I allin the memory at 4096 boundary, I cannot read using 
>>>>>>>>O_DIRECT. But, if I set the block size to 512.  I can read/write 
>>>>>>>>successfully. It also works with 1024, but no with 4096
>>>>>>>>
>>>>>>>>So the recepie what I am following is ...
>>>>>>>>
>>>>>>>>BLKBSZGET -> Get original block size
>>>>>>>>BLKBSZSET ->  Set the block size to 512
>>>>>>>>READ | WRITE Successfully ;)
>>>>>>>>BLKBSZSET ->  Set back to the original block size
>>>>>>>>
>>>>>>>>-Shesha
>>>>>>>>
>>>>>>>>Rob van Nieuwkerk wrote:
>>>>>>>>
>>>>>>>> 
>>>>>>>>
>>>>>>>>      
>>>>>>>>
>>>>>>>>           
>>>>>>>>
>>>>>>>>                
>>>>>>>>
>>>>>>>>>On Tue, 20 Jul 2004 10:27:57 -0700
>>>>>>>>>Shesha Sreenivasamurthy <shesha@inostor.com> wrote:
>>>>>>>>>
>>>>>>>>>Hi Shesha,
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>   
>>>>>>>>>
>>>>>>>>>        
>>>>>>>>>
>>>>>>>>>             
>>>>>>>>>
>>>>>>>>>                  
>>>>>>>>>
>>>>>>>>>>I am having trouble with O_DIRECT. Trying to read or write from a block 
>>>>>>>>>>device partition.
>>>>>>>>>>
>>>>>>>>>>1. Can O_DIRECT be used on a plain block device partition say 
>>>>>>>>>>"/dev/sda11" without having a filesystem on it.
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>     
>>>>>>>>>>
>>>>>>>>>>          
>>>>>>>>>>
>>>>>>>>>>               
>>>>>>>>>>
>>>>>>>>>>                    
>>>>>>>>>>
>>>>>>>>>yes.
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>   
>>>>>>>>>
>>>>>>>>>        
>>>>>>>>>
>>>>>>>>>             
>>>>>>>>>
>>>>>>>>>                  
>>>>>>>>>
>>>>>>>>>>2. If no file system is created then what should be the softblock size. 
>>>>>>>>>>I am using the IOCTL "BLKBSZGET". Is this correct?
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>     
>>>>>>>>>>
>>>>>>>>>>          
>>>>>>>>>>
>>>>>>>>>>               
>>>>>>>>>>
>>>>>>>>>>                    
>>>>>>>>>>
>>>>>>>>>yes.
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>   
>>>>>>>>>
>>>>>>>>>        
>>>>>>>>>
>>>>>>>>>             
>>>>>>>>>
>>>>>>>>>                  
>>>>>>>>>
>>>>>>>>>>3. Can we use SEEK_END with O_DIRECT on a partition without filesystem.
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>     
>>>>>>>>>>
>>>>>>>>>>          
>>>>>>>>>>
>>>>>>>>>>               
>>>>>>>>>>
>>>>>>>>>>                    
>>>>>>>>>>
>>>>>>>>>yes.
>>>>>>>>>
>>>>>>>>>I'm using these exact things in an application.
>>>>>>>>>
>>>>>>>>>Note that with 2.4 kernels the "granularity" you can use for offset
>>>>>>>>>and r/w size is the softblock size (*).  For 2.6 the requirements are
>>>>>>>>>much more relaxed: it's the device blocksize (typically 512 byte).
>>>>>>>>>
>>>>>>>>>(*): actually one of offset or r/w size has a smaller minimum if
>>>>>>>>>I remember correctly.  Don't remember which one.  But if you assume
>>>>>>>>>the softblock size as a minimum for both you're allways safe.
>>>>>>>>>
>>>>>>>>>	greetings,
>>>>>>>>>	Rob van Nieuwkerk
>>>>>>>>>
>>>>>>>>>--
>>>>>>>>>Kernelnewbies: Help each other learn about the Linux kernel.
>>>>>>>>>Archive:       http://mail.nl.linux.org/kernelnewbies/
>>>>>>>>>FAQ:           http://kernelnewbies.org/faq/
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>.
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>   
>>>>>>>>>
>>>>>>>>>        
>>>>>>>>>
>>>>>>>>>             
>>>>>>>>>
>>>>>>>>>                  
>>>>>>>>>
>>>>>>>--
>>>>>>>Kernelnewbies: Help each other learn about the Linux kernel.
>>>>>>>Archive:       http://mail.nl.linux.org/kernelnewbies/
>>>>>>>FAQ:           http://kernelnewbies.org/faq/
>>>>>>>
>>>>>>>
>>>>>>>.
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>>    
>>>>>>>
>>>>>>>         
>>>>>>>
>>>>>>>              
>>>>>>>
>>>>>--
>>>>>Kernelnewbies: Help each other learn about the Linux kernel.
>>>>>Archive:       http://mail.nl.linux.org/kernelnewbies/
>>>>>FAQ:           http://kernelnewbies.org/faq/
>>>>>
>>>>>
>>>>>.
>>>>>
>>>>>
>>>>>
>>>>>     
>>>>>
>>>>>          
>>>>>
>>>.
>>>
>>> 
>>>
>>>      
>>>
>
>.
>
>  
>

