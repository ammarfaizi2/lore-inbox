Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286411AbSAUNqU>; Mon, 21 Jan 2002 08:46:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286462AbSAUNqK>; Mon, 21 Jan 2002 08:46:10 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:63499 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S286411AbSAUNqE>; Mon, 21 Jan 2002 08:46:04 -0500
Message-ID: <3C4C1AAF.8040303@namesys.com>
Date: Mon, 21 Jan 2002 16:42:07 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011221
X-Accept-Language: en-us
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
CC: Shawn Starr <spstarr@sh0n.net>, linux-kernel@vger.kernel.org
Subject: Re: Possible Idea with filesystem buffering.
In-Reply-To: <Pine.LNX.4.33L.0201211003000.32617-100000@imladris.surriel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:

>On Mon, 21 Jan 2002, Hans Reiser wrote:
>
>>>It seems you're still assuming that different filesystems will
>>>all see the same kind of load.
>>>
>>I don't understand this comment.
>>
>
>[snip]
>
>>The VM should apply pressure to the caches.  It should define an
>>interface that subcache managers act in response to.  The larger a
>>subcache is, the more percentage of total memory pressure it should
>>receive.
>>
>
>Wrong.  If one filesystem is actively being used (eg. kernel
>compile) and the other filesystem's cache isn't being used
>(this one held the tarball of the kernel source) then the
>cache which is being used actively should receive less
>pressure than the cache which doesn't hold any active pages.
>

Pressure received is not equal to pages yielded.  Think of pressure as a 
request to age on average one page.  Not a request to free on average 
one page.  The pressure received should be in proportion to the 
percentage of total memory pages in use by the subcache.  The number of 
pages yielded should depend on the interplay of  pressure received and 
accesses made.

Does this make more sense now?

>
>
>We really want to evict the kernel tarball from memory while
>keeping the kernel source and object files resident.
>
If your example is based on untarring a kernel tarball from one 
filesystem to another, it is doomed, because you probably want to 
drop-behind the tarball contents.

I think I know what you mean though, so let's use an example of one 
filesystem containing the files of a user who logs in once a week mostly 
to check his email that he doesn't get very often, and the other 
contains the files of a programmer who recompiles every 5 minutes.  Is 
this what you intend?  If so, I think the mechanism described above 
handles it.

Perhaps writepage isn't the cleanest way to implement it though, maybe 
the page aging mechanism is where the call to the subcache belongs.

>
>
>This is exactly the reason why each filesystem cannot manage
>its own cache ... it doesn't know anything about what the
>system as a whole is doing.
>
Each filesystem can be told how much aging pressure to exert on itself. 
 The VM tracks what the system as a whole is doing, and the filesystem 
tracks what its subcache is doing, and the filesystem listens to the VM 
and acts accordingly.

Hans


