Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265323AbTIDVcw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 17:32:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265395AbTIDVcw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 17:32:52 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:38884 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S265323AbTIDVcn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 17:32:43 -0400
Message-ID: <3F57AF79.1040702@namesys.com>
Date: Fri, 05 Sep 2003 01:32:41 +0400
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021212
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andreas Dilger <adilger@clusterfs.com>
CC: Mike Fedyk <mfedyk@matchmail.com>, Andrew Morton <akpm@osdl.org>,
       reiserfs-list@namesys.com, linux-kernel@vger.kernel.org
Subject: Re: precise characterization of ext3 atomicity
References: <3F574A49.7040900@namesys.com> <20030904085537.78c251b3.akpm@osdl.org> <3F576176.3010202@namesys.com> <20030904091256.1dca14a5.akpm@osdl.org> <3F57676E.7010804@namesys.com> <20030904181540.GC13676@matchmail.com> <3F578656.60005@namesys.com> <20030904132804.D15623@schatzie.adilger.int>
In-Reply-To: <20030904132804.D15623@schatzie.adilger.int>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger wrote:

>On Sep 04, 2003  22:37 +0400, Hans Reiser wrote:
>  
>
>>Mike Fedyk wrote:
>>    
>>
>>>And how does reiser4 do this [export atomic ops to userspace]
>>>without changing the userspace apps?
>>>      
>>>
>>We don't.  We just make the hovercraft, we don't force you to go over 
>>the water.....
>>    
>>
>
>It is possible to do the same with ext3, namely exporting journal_start()
>and journal_stop() (or some interface to them) to userspace so the application
>can start a transaction for multiple operations.  We had discussed this in
>the past, but decided not to do so because user applications can screw up in
>so many ways, and if an application uses these interfaces it is possible to
>deadlock the entire filesystem if the application isn't well behaved.
>
Yup.  That's why we confine it to a (finite #defined number) set of 
operations within one sys_reiser4 call.  At some point we will allow 
trusted user space processes to span multiple system calls (mail server 
applicances, database appliances, etc., might find this useful).  You 
might consider supporting sys_reiser4 at some point.

>
>If the app doesn't eventually say "end the transaction", the filesystem might
>wait indefinitely.  You could start adding more plumbing like "if the file
>is closed (maybe because the process crashed), cancel the transaction",
>and "if the process doesn't complete the transaction in time, cancel the
>transaction", etc.  How do you guarantee in advance that the application
>will be able to complete all of the operations it needs (i.e. if it runs
>out of space in the filesystem or something)?
>
We will export our space reservation infrastructure code also.  We are 
still thinking about the right API for that.  At first I had some idea 
that we should calculate for the user how much space would be needed, 
but I am getting lazier as we get closer to actually doing it, and I am 
thinking we can add the helpful but complex in some cases 
estimate_sizeof() functions later, and for now just let the user grab 
space, and then if they exceed it return an error, and if they both 
exceed it and run out of disk space return a nastier error that tells 
them to go cope with their mistake.  Now I think it will be something 
that takes a 64 bit int that is the number of blocks to grab, compares 
it to their quota if any, and causes the sys_reiser4 to do nothing and 
error nicely if it can't get it.

When coding sometimes you have to be careful not to let the complex  
needs of the 20% prevent you from getting something that the 80% need 
and would  be happy with to market.  (Learned this one from Dave Hitz of 
NetApp.)

There's a lot of applications that have very simple needs in regards to 
atomicity, like write 3 things to 3 files as one atom.  If we can 
address that, then later people can do their PhDs on the needs of the 
complex 20%.... and hopefully send some nice patches.....

>
>I suppose at worst, the application doesn't get its multi-op atomicity
>guarantee, but I'm guessing that apps which use this interface depend on
>it working properly or they wouldn't be using it.
>
>Cheers, Andreas
>--
>Andreas Dilger
>http://sourceforge.net/projects/ext2resize/
>http://www-mddsp.enel.ucalgary.ca/People/adilger/
>
>
>
>  
>


-- 
Hans


