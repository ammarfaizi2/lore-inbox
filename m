Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261383AbVFNC4v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261383AbVFNC4v (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 22:56:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261298AbVFNC4v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 22:56:51 -0400
Received: from ns.intellilink.co.jp ([61.115.5.249]:16026 "HELO
	ns.intellilink.co.jp") by vger.kernel.org with SMTP id S261383AbVFNC4S
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 22:56:18 -0400
Message-ID: <42AE450C.5020908@dd.iij4u.or.jp>
Date: Tue, 14 Jun 2005 11:46:36 +0900
From: Kenichi Okuyama <okuyamak@dd.iij4u.or.jp>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hans Reiser <reiser@namesys.com>
Cc: Andreas Dilger <adilger@clusterfs.com>, fs <fs@ercist.iscas.ac.cn>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, zhiming@admin.iscas.ac.cn,
       qufuping@ercist.iscas.ac.cn, madsys@ercist.iscas.ac.cn,
       xuh@nttdata.com.cn, koichi@intellilink.co.jp,
       kuroiwaj@intellilink.co.jp, okuyama@intellilink.co.jp,
       matsui_v@valinux.co.jp, kikuchi_v@valinux.co.jp,
       fernando@intellilink.co.jp, kskmori@intellilink.co.jp,
       takenakak@intellilink.co.jp, yamaguchi@intellilink.co.jp,
       ext2-devel@lists.sourceforge.net, shaggy@austin.ibm.com,
       xfs-masters@oss.sgi.com,
       Reiserfs developers mail-list <Reiserfs-Dev@namesys.com>
Subject: Re: [Ext2-devel] Re: [RFD] FS behavior (I/O failure) in kernel summit
References: <1118692436.2512.157.camel@CoolQ> <42ADC99D.5000801@namesys.com> <20050613201315.GC19319@moraine.clusterfs.com> <42AE1D4A.3030504@namesys.com>
In-Reply-To: <42AE1D4A.3030504@namesys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Dr. Reiser, and Mr. Dilger,

Hans Reiser wrote:

>Andreas Dilger wrote:
>
>  
>
>>On Jun 13, 2005  10:59 -0700, Hans Reiser wrote:
>> 
>>
>>    
>>
>>>If you write a patch to implement 1a and 3a for reiserfs and reiser4 I
>>>will accept them.  2a is too vague for me to support --- I can only
>>>answer the question of whether error conditions are fs independent when
>>>it is regarding specified error conditions.  I suspect there are times
>>>when it needs to be fs dependent, but only a comprehensive review could
>>>answer to that.
>>>   
>>>
>>>      
>>>
>>Hans, it would probably be preferrable to get ext2-like behaviour where
>>action is configurable (see below),
>>
>>    
>>
>
>  
>
>>I personally would be annoyed if my
>>workstation rebooted if there is a read error from the disk.
>> 
>>
>>    
>>
>My concern is that real users don't read their logs and won't notice
>that a disk is going bad, and there is no effective method for the
>kernel notifying userspace of an error requiring user attention.
>
>However given the existence of USB drives and CDROMs with scratches I
>concede the point.
>  
>
I agree that kernel can not directly influence user.
But, application may have better chance.

Think about case of editor (vi, emacs, almost any text editors are ok ).

If you try to save file, and recieve no error, user will believe they 
have been written on disk they believe to be existing.
Even log yells for error, user will not notice.

If editor recieve error, then user can know something is wrong. Though 
he is still wondering, if he recieve the message
like "Input Output Error: may be HW error?", he definitely will start 
from looking at cable.

>  
>
>>Better to mark filesystem read-only on error and continue to allow
>>users to read from rest of filesystem than to just reboot the node.
>>That is my experience in any case.  For those systems where there is
>>e.g. an HA server with dual-channel disk it might be better to reboot
>>and failover to another server, but even that isn't clear as a real
>>media error will just cause both nodes to reboot endlessly instead of
>>providing the best service they can.
>>
>> 
>>
>>    
>>
>>>fs wrote:
>>>   
>>>
>>>      
>>>
>>>>Dear Linus, Andrew Morton, and all FS maintainers,
>>>>1) When I/O failure occurs(e.g.: unrecoverable media failure - USB
>>>>unplug), FS should
>>>> a. shutdown the FS right now(XFS does this)
>>>> b. try to make the media serve as long as possible(EXT3 remounts 
>>>>    read-only, cache is still valid for read)
>>>> c. do not care, just print some kernel debugging info(EXT2 JFS 
>>>>    ReiserFS)
>>>>     
>>>>
>>>>        
>>>>
>>Actually, 1b is just the default behaviour for ext3 (because of journal
>>errors).  It is also possible to mount the filesystem with error=panic,
>>which will implement 1a, and it is also possible to mount ext2 with
>>error=remount-ro (which is default on Debian for ext2) which implements
>>1b.  I don't think it is possible to get 1c behaviour for journal
>>errors on ext3.
>>
>> 
>>
>>    
>>
>>>>2) When I/O failure occurs, FS should
>>>> a. give a unified error
>>>> b. give errors according to the FS type
>>>>     
>>>>
>>>>        
>>>>
>>What is "unified error"?  Does this mean "-EIO" for all cases?  I also
>>don't understand why this is so important to your application...  If
>>you get an error back from the filesystem that isn't expected, that is
>>generally a problem regardless of what the error is...
>>
>> 
>>
>>    
>>
>>>>3) the returned errno should be
>>>> a. real cause of failure, e.g. USB unplug returns EIO
>>>> b. cause from FS, e.g. USB unplug made FS remount read-only,
>>>>    so open(O_RDONLY) returns ENOENT while open(O_RDWR) returns
>>>>    EROFS
>>>> c. errno means nothing, you already get -1, that's enough
>>>>     
>>>>
>>>>        
>>>>
>>This doesn't make sense.  If the "real cause of failure" is that the
>>journal code detected an inconsistency (it might not be an IO error at
>>the time, just some structure that is not what it should be, maybe the
>>user tried to format their partition while in use ;-) then the real
>>error is that the journal turned the filesystem read-only.  In any case,
>>you can't expect to get more information that "EIO", regardless of the
>>root cause (e.g. ENOMEM causes async buffer read to not complete, caller
>>checks buffer_uptodate() and it isn't uptodate, returns EIO).
>> 
>>
>>    
>>
>Well, maybe we should fix this. Or at least be open to his writing a
>patch to fix it.
>
>EIO is simply not enough information, don't you agree? i mean, if the
>USB drive got unplugged, for us to say IO error rather than "hey you,
>where'd the USB drive go? Plug it back in, or I can't do nothing!" and
>to distinguish it from some other complex error due to software bugs in
>the filesystem is to fail to understand the information needs of the
>seven year old using the laptop. The seven year old probably can't cope
>with debugging the filesystem's software error, but plugging the USB
>drive back in he can do....
>  
>

I do agree that EIO is not enough information. But is far better than 
nothing, or error like EROFS.
# Read Only? that means you still can READ entire area file system is 
serving, not only cached area.

At least , EIO tells application that it is due to some hardware 
problem, not software.

Also, I strongly disagree with "wait till someone re-plug the cable" action.

- How can you tell that re-plugged device is the same HDD you've unplugged?
- How can you tell user WILL re-plug?

At least, when we think about what word "cache" means, we should not 
assume for existing
"cache image" to be correct. cache is copy of information, which it's 
consistency is UNDER CONTROL.
When cable are unplugged, it means WE LOST OUR CONTROL, and therefore we 
should immediately
remove every cache related.

And at this moment, I don't see any reason why file system can continue 
it's service, nor why it should.

So, I do think we need at least EIO. EIO may be more classifiable into 
detail, and we do wish to have those
information somehow, but just like error handling starts from -1, EIO 
should start from ( errno == EIO ).


It might be good idea to make this as user's mount option for choice. 
But once given, I definitely choose
"immediate service stop". Knowing something went wrong is more important 
than continuing something
we can't trust.


best regards,
----
Kenichi Okuyama@Project DOUBT

