Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130784AbRCFN6C>; Tue, 6 Mar 2001 08:58:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130824AbRCFN5n>; Tue, 6 Mar 2001 08:57:43 -0500
Received: from eventhorizon.antefacto.net ([193.120.245.3]:2825 "EHLO
	nt1.antefacto.com") by vger.kernel.org with ESMTP
	id <S130821AbRCFN5j>; Tue, 6 Mar 2001 08:57:39 -0500
Message-ID: <3AA4ECBC.8090102@AnteFacto.com>
Date: Tue, 06 Mar 2001 13:57:16 +0000
From: Padraig Brady <Padraig@AnteFacto.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.0-ac4 i686; en-US; 0.8) Gecko/20010215
X-Accept-Language: en
MIME-Version: 1.0
To: Jeremy Jackson <jerj@coplanar.net>
CC: William Stearns <wstearns@pobox.com>,
        ML-linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [OFFTOPIC] Hardlink utility - reclaim drive space
In-Reply-To: <Pine.LNX.4.30.0102191626090.29121-100000@sparrow.websense.net> <3AA3E63E.80101@AnteFacto.com> <3AA3E6D0.806D81B5@coplanar.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeremy Jackson wrote:

> Padraig Brady wrote:
> 
>> Hmm.. useful until you actually want to modify a linked file,
>> but then your modifying the file in all "merged" trees.
>> Wouldn't it be cool to have an extended attribute
>> for files called "Copy on Write", so then you could
>> hardlink all duplicate files together, but when a file is
>> modified a copy is transparently created.
>> Actually should it be called "Copy On Modify"? since if
>> you copied a file there would be no need to make an actual
>> copy until the file was modified.
>> 
>> The only problem I see with this is that you wouldn't have
>> enough space to store a copy of a file, what would you do
>> in this case, just return an error on write?
>> 
>> Is there any way this could be extended across filesystems?
>> I suppose you could add it on top of existing DFS'?
>> 
>> I could see many uses for this, like backup systems, but perhaps
>> a block level system is more appropriate in this case?
>> (like the just announced SnapFS).
>> 
>> Is there any filesystem that supports this @ present?
>> 
>> Padraig.
>> 
>> William Stearns wrote:
>> 
>>> Good day, all,
>>>       Sorry for the offtopic post; I sincerely believe this will be
>>> useful to developers with multiple copies of, say, the linux kernel tree
>>> on their drives.  I'll be brief.  Please followup to private mail -
>>> thanks.
>>>       Freedups scans the directories you give it for identical files and
>>> hardlinks them together to save drive space.  Please see
>>> ftp://ftp.stearns.org/pub/freedups .  V0.2.1 is up there; it has received
>>> some testing, but may yet contain bugs.
>>>       I was able to recover ~676M by running it against 8 different
>>> 2.4.x kernel trees with different patches that originally contained ~948M
>>> of files.  YMMV.
>>>       I do understand there are better ways to handle this problem (cp
>>> -av --link, cvs? Bitkeeper, deleting unneeded trees, tarring up trees,
>>> etc.).  See the readme for a little discussion on this.  This is just one
>>> approach that may be useful in some situations.
>>>       Cheers,
>>>       - Bill
>> 
> snapFS might handle this - versioning, copy-on-write disk file
> clones... even finer grained: only modified blocks of a file are
> duplicated, not the entire file, and it does this in real-time.

Yes I mentioned snapFS above, and a block level system would
be a win for large files, that are quite similar. However
in my experience this is usually not the case, i.e. large files
are usually not similar, so a simple file level system would be 
more appropriate im my opinion. 

Also I don't think user space progs should be relied on to manage
hardlinked files by (effectively) doing:

cp orig temp; mv temp orig

You could use file permissions (chmod -w orig) to remind you to do this,
but that's just a kludge, and also it's messy with every user space
prog doing something different.

Also the cp above breaks the link, which you wouldn't want to do
until the file is actually modified. So if you implemented the
"Copy On modify" extended attribute, you could set cp to cp -l by default.

I'm talking about something more general here than working with a few 
similar trees. This is a general way to never have duplicate files on a 
filesystem. Doing this at the block level would be more fine grained, 
but at the cost of much more complexity and processing time, especially 
if you want to analyse an existing filesystem.
If you do it @ the file level, you can just scan for duplicate files,
merge them using hardlinks, and set the "Copy On Modify" bit. This
can be cleared of course as appropriate, where you want the origonal
hardlink behaviour.

> in the case of kernel, why not get the whole repository?
> CVS stores versions as diffs internally, saving space.

Yep good for kernel where there are no binaries, but
not good in general.

Padraig.

