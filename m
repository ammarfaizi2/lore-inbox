Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282978AbSAULOh>; Mon, 21 Jan 2002 06:14:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284144AbSAULO1>; Mon, 21 Jan 2002 06:14:27 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:58130 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S282978AbSAULOU>; Mon, 21 Jan 2002 06:14:20 -0500
Message-ID: <3C4BF71D.4010209@namesys.com>
Date: Mon, 21 Jan 2002 14:10:21 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011221
X-Accept-Language: en-us
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
CC: Shawn Starr <spstarr@sh0n.net>, linux-kernel@vger.kernel.org
Subject: Re: Possible Idea with filesystem buffering.
In-Reply-To: <Pine.LNX.4.33L.0201202321350.32617-100000@imladris.surriel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:

>On Mon, 21 Jan 2002, Hans Reiser wrote:
>
>>Rik van Riel wrote:
>>
>
>>>I take it you're volunteering to bring ext3, XFS, JFS,
>>>JFFS2, NFS, the inode & dentry cache and smbfs into
>>>shape so reiserfs won't get unbalanced ?
>>>
>
>>If they use writepage(), then the job of balancing cache cleaning is
>>done, we just use writepage as their pressuring mechanism.
>>Any FS that wants to optimize cleaning can implement a VFS method, and
>>any FS that wants to optimize freeing can implement a VFS method, and
>>all others can use their generic VM current mechanisms.
>>
>
>It seems you're still assuming that different filesystems will
>all see the same kind of load.
>

I don't understand this comment.

>
>
>Freeing cache (or at least, applying pressure) really is a job
>for the VM because none of the filesystems will have any idea
>exactly how busy the other filesystems are.
>

I fully agree, and it is the point I have been making (poorly, since it 
has not
communicated) for as long as I have been discussing it with you.  The VM 
should
apply pressure to the caches.  It should define an interface that 
subcache managers
act in response to.   The larger a subcache is, the more percentage of 
total memory
pressure it should receive.  The amount of memory pressure per unit of 
time should
be determined by the VM.

Note that there are two kinds of pressure, cleaning pressure and freeing 
pressure.
I think that the structure appropriate for delegating them is the same, 
but someone
may correct me.  

Also note that a unit of pressure is a unit of aging, not a unit of
freeing/cleaning.  The application of pressure does not necessarily free 
a page, it
merely ages the subcache, which might or might not free a page depending 
on how much
use is being made of what is in the subcache.

Thus, a subcache receives pressure to grow from somewhere (things like 
write()
in the case of ReiserFS), and pressure to shrink from VM, and VM exerts 
however
much total pressure on all the subcaches is required to not run out of 
memory.

The mechanism of going through pages, seeing what subcache they belong 
to, and
pressuring that subcache, is a decent one (if a bit CPU cache expensive) 
for obtaining
linearly proportional cache pressure.  Since code inertia favors it, 
let's use it for now.

Hans



