Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288661AbSAVUgg>; Tue, 22 Jan 2002 15:36:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289234AbSAVUg0>; Tue, 22 Jan 2002 15:36:26 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:11272 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S288661AbSAVUgJ>; Tue, 22 Jan 2002 15:36:09 -0500
Message-ID: <3C4DCC49.1080202@namesys.com>
Date: Tue, 22 Jan 2002 23:32:09 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011221
X-Accept-Language: en-us
MIME-Version: 1.0
To: Chris Mason <mason@suse.com>
CC: Rik van Riel <riel@conectiva.com.br>,
        Andreas Dilger <adilger@turbolabs.com>, Shawn Starr <spstarr@sh0n.net>,
        linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Subject: Re: Possible Idea with filesystem buffering.
In-Reply-To: <Pine.LNX.4.33L.0201221234470.32617-100000@imladris.surriel.com> <3C4DB36F.4090306@namesys.com> <2080500000.1011727185@tiny>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Mason wrote:

>
>On Tuesday, January 22, 2002 09:46:07 PM +0300 Hans Reiser
><reiser@namesys.com> wrote:
>
>>Rik van Riel wrote:
>>
>>>>The FS doesn't know how long a page has been dirty, or how often it
>>>>gets used,
>>>>
>>>In an efficient system, the FS will never get to know this, either.
>>>
>>I don't understand this statement.  If dereferencing a vfs op for every
>>page aging is too expensive, then ask it to age more than one page at a
>>time.  Or do I miss your meaning?
>>
>
>Its not about the cost of a function call, it's what the FS does to make
>that call useful.  Pretend for a second the VM tells the FS everything it
>needs to know to age a page (whatever scheme the FS wants to use).
>
>Then pretend the VM decides there's memory pressure, and tells the FS
>subcache to start freeing ram.  So, the FS goes through its list of pages
>and finds the most suitable one for flushing, but it has no idea how
>suitable that page is in comparison with the pages that don't belong to
>that FS (or even other pages from different mount points of the same FS
>flavor).
>

Why does it need to know how suitable it is compared to the other 
subcaches?  It just ages X pages, and depends on the VM to determine how 
large X is.  The VM pressures subcaches in proportion to their size, it 
doesn't need to know  how suitable one page is compared to another, it 
just has a notion of push on everyone in proportion to their size.

>
>
>Since each subcache has its own aging scheme, you can't look at a page from
>subcache A and compare it with a page from subcache B.
>

Chris, the VM doesn't compare one page to another within a unified 
cache, so why should it compare one page to another within the delegated 
cache management scheme?  The VM ages until it gets what it wants, in 
the current scheme.  In the scheme I propose it requests aging from the 
subcaches until it gets what it wants, instead of doing aging until it 
gets what it wants.

Note that there is some slight inaccuracy in this, in that the current 
scheme has ordered lists, but my point remains valid, especially if we 
move to aging based on usage minus age counts, which I think Rik may be 
supportive of do (it makes it easier to give less staying power to a 
page that is read only once, and I would say it was Rik's idea except 
that I have probably distorted it in repeating it).

>
>
>All the filesystem can do is flush its own pages, which might be the least
>suitable pages on the entire box.  The VM has no way of knowing, and
>neither does the FS, and that's why its inefficient.
>
>Please let me know if I misunderstood the original plan ;-)
>
Thanks for pointing out what needed to be articulated.  Is it more clear 
now?

Hans


