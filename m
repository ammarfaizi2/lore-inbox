Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315482AbSECAEb>; Thu, 2 May 2002 20:04:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315483AbSECADC>; Thu, 2 May 2002 20:03:02 -0400
Received: from melancholia.rimspace.net ([210.23.138.19]:13328 "EHLO
	melancholia.danann.net") by vger.kernel.org with ESMTP
	id <S315480AbSECACw>; Thu, 2 May 2002 20:02:52 -0400
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.12 severe ext3 filesystem corruption warning!
In-Reply-To: <87u1pqln4h.fsf@enki.rimspace.net> <3CD191C5.AC09B1F4@zip.com.au>
	<87znzi18hn.fsf@enki.rimspace.net> <3CD1C50B.1DB3DBA2@zip.com.au>
From: Daniel Pittman <daniel@rimspace.net>
Organization: Not today, thank you, Mother.
Date: Fri, 03 May 2002 10:02:46 +1000
Message-ID: <874rhq14k9.fsf@enki.rimspace.net>
User-Agent: Gnus/5.090006 (Oort Gnus v0.06) XEmacs/21.5 (bamboo,
 i686-pc-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 02 May 2002, Andrew Morton wrote:
> Daniel, this is good stuff.  Thanks.
> Daniel Pittman wrote:
>> 
>> ...
>> 
>> Not quite. I found the corruption in three places:
>> 
>> * my XEmacs and Gnus mail spool.
>> * gkrellm configuration files.
>> * galeon/mozilla bookmarks and preferences.
> 
> So all of those files were written to by their application
> during the failed session.

Yes. Files that they accessed in a read-only fashion, and untouched
files, seem entirely unharmed.

> Question on the table is: did the kernel write the wrong
> stuff into those files, or did it forget to write the
> right stuff?

Wrong stuff.

> Is the incorrect content within those files recognisable
> at all?  If so, what is it?

Yes. There are three things that I noted as incorrect in the files.

Many of them, but not all, featured large blocks of NULL (0) bytes, on
the order of 2K worth of them. No exacting counts available but they did
fill a page in an 80x30 terminal, generally.

Several of the files featured the "right" content, just in the wrong
location. For example, the galeon 'bookmarks.xbel' file started about a
third of the way into it's correct content.

Only one of the files seemed to be gratuitously truncated, the mozilla
prefs.js file.


The remaining file content seemed to be randomly swizzled. I found part
of a .overview file in .newsrc.eld, for example, and part of the
.newsrc.eld elsewhere. Also, 'active' got written to a mail folder...


There were *no* cases where the file content was unrecognizable with the
exception of the NULL bytes. In *every* case the content was from a
*completely* different file.

This included files in different directories getting content swapped, so
a file in ~ got content from ~/Mail/<group>/, so it's not just within
the same directory.


I can't think of a single verifiable case where a file got the wrong
data from another process, though. That's not a "didn't", just a "can't
remember seeing", though, so don't take that as gospel.

[...]

>> I also found corruption in the mozilla prefs.js file from the same
>> application[1]. That was simply a truncated file -- no NULL bytes or
>> anything, just a file that cut off half way through a single
>> expression like:
>> 
>> user_pref("wallet.capture
>> 
>> This /may/ be the logical break between two write(2) calls or a
>> partly completed write, though.
> 
> That sounds like metadata corruption. Are you sure that the file
> doesn't have a chunk of invisible nulls in it, after the text? 

Yes. I used an editor that displays the NULL byte correctly in files to
view it when looking for damage and there was *no* NULL content in this
file.

None of the NULL bytes were at the end of the file, always in the
middle of the data. 

> Because if it got chopped off in this manner, e2fsck should have
> detected something.

Yup. I carefully watched the forced fsck and no errors. This is:
] fsck.ext3 -V
e2fsck 1.27 (8-Mar-2002)
	Using EXT2FS Library version 1.27, 8-Mar-2002

>> > And no, it doesn't promise anything good - last time we had crap in
>> > truncate/mmap interaction it was a hell to fix.
>> >
>> > I suspect that you had screwed the truncate exclusion warranties
>> > up. If _any_ IO happens in the area currently manipulated by
>> > ->truncate() - you are screwed and results would look pretty much
>> > like the things mentioned in bug report.
>> 
>> Ick. Er, good luck. I am quite happy to provide more information and
>> even to install a scratch disk and try to get it to fail the same way
>> if you wish.
> 
> It would be good if you had the time to do that.

Sure. I will have a run at reproducing it in an hour or two, then post
the results to the list under this thread, with a direct CC. :)

        Daniel

-- 
Nobody objects to a woman being a good writer or sculptor or geneticist if at
the same time she manages to be a good wife, good mother, good-looking,
well-groomed and unaggressive.
        -- Leslie M. McIntyre
