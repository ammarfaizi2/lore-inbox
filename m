Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261622AbTCKVPL>; Tue, 11 Mar 2003 16:15:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261634AbTCKVPL>; Tue, 11 Mar 2003 16:15:11 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:39133 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S261622AbTCKVPJ>; Tue, 11 Mar 2003 16:15:09 -0500
Message-ID: <3E6E545F.5060608@namesys.com>
Date: Wed, 12 Mar 2003 00:25:51 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021212
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Daniel Phillips <phillips@arcor.de>
CC: Helge Hafting <helgehaf@aitel.hist.no>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: atomic kernel operations are very tricky to export to user space
 (was  [RFC] Improved inode number allocation for HTree )
References: <11490000.1046367063@[10.10.2.4]> <3E6DBE3B.8030007@namesys.com> <3E6DDDD2.3050709@aitel.hist.no> <20030311133705.2157A102100@mx12.arcor-online.net>
In-Reply-To: <20030311133705.2157A102100@mx12.arcor-online.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:

>On Tue 11 Mar 03 14:00, Helge Hafting wrote:
>  
>
>>Hans Reiser wrote:
>>    
>>
>>>Let's make noatime the default for VFS.
>>>
>>>Daniel Phillips wrote:
>>>      
>>>
>>[...]
>>
>>    
>>
>>>>If I were able to design Unix over again, I'd state that if you don't
>>>>lock a directory before traversing it then it's your own fault if
>>>>somebody changes it under you, and I would have provided an interface
>>>>to inform you about your bad luck.  Strictly wishful thinking.
>>>>(There, it feels better now.)
>>>>        
>>>>
>>I'm happy nobody _can_ lock a directory like that.  Think of it - unable
>>to create or delete files while some slow-moving program is traversing
>>the directory?  Ouch.  Plenty of options for DOS attacks too.
>>And how to do "rm *.bak" if rm locks the dir for traversal?
>>    
>>
>
><wishful thinking>
>Now that you mention it, just locking out create and rename during directory 
>traversal would eliminate the pain.  Delete is easy enough to handle during 
>traversal.  For a B-Tree, coalescing could simply be deferred until the 
>traversal is finished, so reading the directory in physical storage order 
>would be fine.  Way, way cleaner than what we have to do now.
></wishful thinking>
>
>Regards,
>
>Daniel
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>
>  
>
You would want a  directory listing command that is a single system 
call, and then that could be made isolated, without risk of userspace 
failing to unlock.   Then you have to worry about very large directories 
straining things in user space, but you can probably have the user 
specify the maximimum size directory his process has space for, etc.

In general, DOS issues are what makes it difficult to introduce 
transactions into the kernel.  We are grappling with that now in 
reiser4.  It seems that the formula is to create atomic plugins, and 
then it is the system administrator's responsibility to verify that he 
can live with whatever DOS vulnerabilities it has before he installs it 
in his kernel (or our responsibility if it is sent to us for inclusion 
in the main kernel).  Allowing arbitrary filesystem operations to be 
combined into one atomic transaction seems problematic for either user 
space or the kernel, depending on what you do.

In general, allowing user space to lock things means that you trust user 
space  to unlock.  This creates all sorts of trust troubles, and if you 
force the unlock after some timeout, then the user space application 
becomes vulnerable to DOS from other processes causing it to exceed the 
timeout.

Ideas on this are welcome.

-- 
Hans


