Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286277AbRLJOv1>; Mon, 10 Dec 2001 09:51:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286278AbRLJOvS>; Mon, 10 Dec 2001 09:51:18 -0500
Received: from thebsh.namesys.com ([212.16.0.238]:30982 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S286277AbRLJOvB>; Mon, 10 Dec 2001 09:51:01 -0500
Message-ID: <3C1422CE.5050207@namesys.com>
Date: Mon, 10 Dec 2001 05:49:50 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us
MIME-Version: 1.0
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
CC: Pavel Machek <pavel@suse.cz>, Quinn Harris <quinn@nmt.edu>,
        linux-kernel@vger.kernel.org
Subject: Re: File copy system call proposal
In-Reply-To: <200112101150.fBABosS271828@saturn.cs.uml.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert D. Cahalan wrote:

>>>I would like to propose implementing a file copy system call.
>>>I expect the initial reaction to such a proposal would be "feature
>>>bloat" but I believe some substantial benefits can be seen possibly
>>>making it worthwhile, primarily the following:
>>>
>>>Copy on write:
>>>
>>You want cowlink() syscall, not copy() syscall. If they are on different
>>partitions, let userspace do the job.
>>
>
>That looks like a knee-jerk reaction to stuff going in the kernel.
>I want maximum survival of non-UNIX metadata and maximum performance
>for this common operation. Let's say you are telecommuting, and...
>
>You have mounted an SMB share from a Windows XP server.
>You need to copy a file that has NTFS security data.
>The file is 99 GB in size, on the far side of a 33.6 kb/s modem link.
>Now copy this file!
>Better yet, maybe you have two mount points or mounted two shares.
>
>????
>
>Filesystem-specific user tools are abominations BTW. We don't
>have reiser-mv, reiser-cp, reiser-gmc, reiser-rm, etc.
>
I think that it is legitimate to first implement a piece of 
functionality in one filesystem, and only after it has that real design 
stability that comes from real code that users have critiqued, 
proselytize to other filesystems.  The disadvantage to the approach 
though is that it advantages one filesystem, and can cause you to lose 
adherents in the other filesystem camps.  For instance, the journaling 
code of ext3, we just weren't willing to wait, and conversely I think 
that ext3/XFS aren't willing to wait for how we do extended attributes. 
 However, I suspect that how we want to do extended attributes (that is, 
not to do them, but instead to do a better file API) is going to be a 
tough sell until it is working code.  I don't think i could have 
convinced the ext2 camp of the advantages of trees and tail combining 
without shipping code that did it (ok, I didn't really try, but somehow 
I think this.....).  Now they seem to think it is good stuff, and are 
responding with a rather interesting htree implementation that, if I 
understand right, does fewer memory copies due to packing less tightly 
(which we may have to contemplate doing as a performance tweak for 
reiser4.1).

So in sum, I think that the right approach is to say: "Hey, I think this 
is a nice feature, any other filesystems interested?", and if there is 
no enthusiasm then go and implement it and let the users convince them 
it belongs in VFS.

So, for the record, I think that sendfile for all file types, and 
cowlink, are both different features and worthwhile.

Reiser4 needs a plugin interconnect, and I think this plugin 
interconnect should translate from one filetype to another, and if you 
say reiser4("fileA<-fileB") it should accomplish copy() functionality. 
 reiser4() will also accomplish subfile copying of ranges, etc., if you 
specify them, but that is going beyond this thread.

I think I don't have the slightest chance of getting the ext2 crowd 
interested in these features before it works in reiserfs based on their 
remarks at the linux kernel summit.  There are some folks like me who 
think filesystems are behind other namespaces such as search engines and 
databases and should catch up, and others who think putting keyword 
search or transactions into the kernel is just nutty.  (Though it is 
actually a lot easier than putting balanced trees into the kernel, but....)

I'd like to thank Albert for persisting here with reminding people of 
his example of where Windows does it better, API design wise (it isn't 
his first email on the topic).

Hans

