Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315458AbSEBW7J>; Thu, 2 May 2002 18:59:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315463AbSEBW6o>; Thu, 2 May 2002 18:58:44 -0400
Received: from melancholia.rimspace.net ([210.23.138.19]:8976 "EHLO
	melancholia.danann.net") by vger.kernel.org with ESMTP
	id <S315458AbSEBW5V>; Thu, 2 May 2002 18:57:21 -0400
To: Andrew Morton <akpm@zip.com.au>
Cc: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
Subject: Re: 2.5.12 severe ext3 filesystem corruption warning!
In-Reply-To: <UTC200205022140.g42Le8N14139.aeb@smtp.cwi.nl>
	<3CD1B675.BBFBA61B@zip.com.au>
From: Daniel Pittman <daniel@rimspace.net>
Organization: Not today, thank you, Mother.
Date: Fri, 03 May 2002 08:57:13 +1000
Message-ID: <87offy17li.fsf@enki.rimspace.net>
User-Agent: Gnus/5.090006 (Oort Gnus v0.06) XEmacs/21.5 (bamboo,
 i686-pc-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 02 May 2002, Andrew Morton wrote:
> Andries.Brouwer@cwi.nl wrote:
>> 
>> >> 2.5.12, serious ext3 filesystem corrupting behavior
>> 
>> I have had problems with 2.5.10 (first few blocks of the root
>> filesystem overwritten) and then went back to 2.5.8 that I had
>> used for a while already, but then also noticed corruption there.
>> Back at 2.4.17 today..
>> 
>> In my case the problem was almost certainly the IDE code.

For what it's worth, I was aware of the risks with the new IDE code and
have been monitoring this myself. Your notes on it are worth it. :)

> hmm.  Maybe.  As Al says, the fact that it concerned
> mapped files is deeply fishy.
> 
> Daniel, could you please check your logs for IDE
> errors and "buffer layer errors" and 

Sure. I scanned the full set of logs for the time and found no instances
of anything reporting an IDE error or a buffer layer error. Sorry.

> also tell us (as much as you can remember) the names of all the
> affected files, and what application would have written them.

The list of applications is as I mentioned in my other mail on the
topic. I should have read ahead more. The file list, to my knowledge,
is:

~/.gkrellm/user_config                          (gkrellm)
~/.galeon/bookmarks.xbel                        (galeon)
~/.galeon/mozilla/galeon/prefs.js               (mozilla in galeon)
~./newsrc.eld                                   (XEmacs/gnus)

Also, a number of items in ~/Mail/, all written by XEmacs/Gnus. Around
half a dozen groups were effected -- every single one that had mail
added to it during while running under the broken kernel.

The files, specifically, were:

~/Mail/<group>/.overview
~/Mail/<group>/.marks
~/Mail/<group>/[1-9]+

~/News/<group>.SCORE

The last item are the individual email messages, stored in one file per
message, with the INN-style .overview file containing the relevant
cached headers from the messages.

The .marks file contains a Lisp expression defining what has been seen,
flagged, etc, in Gnus for that group. It's updated when you look at
messages in the summary buffer (seen) as well as other things.

Finally, the SCORE files are a killfile on steroids; things add and
subtract from the score and, based on the numeric result, you can act
automatically on the messages.

The only corrupted SCORE files I found were the ones that use
"temporary" scores -- things that are reduced gradually over time.

This is the one case that lets me absolutely confirm that it's only
files that are *written* that were corrupted -- the SCORE files that
were used in a read-only fashion are fine and dandy.


So, the mail group metadata and the mail messages themselves were all
corrupted if written at the time.


Oh, and finally, I forgot to include the dumpe2fs info for the
filesystems before, my bad. They are included, from the mounted
filesystems. :)

        Daniel

] dumpe2fs -h /dev/discs/disc0/part7 # /home/daniel
dumpe2fs 1.27 (8-Mar-2002)
Filesystem volume name:   daniel
Last mounted on:          <not available>
Filesystem UUID:          e93e49be-05d5-4ae5-8ac7-a8883b9b607f
Filesystem magic number:  0xEF53
Filesystem revision #:    1 (dynamic)
Filesystem features:      has_journal filetype needs_recovery sparse_super
Filesystem state:         clean
Errors behavior:          Continue
Filesystem OS type:       Linux
Inode count:              1921024
Block count:              7680944
Reserved block count:     0
Free blocks:              6063023
Free inodes:              1678311
First block:              0
Block size:               2048
Fragment size:            2048
Blocks per group:         16384
Fragments per group:      16384
Inodes per group:         4096
Inode blocks per group:   256
Last mount time:          Thu May  2 18:13:59 2002
Last write time:          Thu May  2 18:13:59 2002
Mount count:              1
Maximum mount count:      37
Last checked:             Thu May  2 18:13:49 2002
Check interval:           15552000 (6 months)
Next check after:         Tue Oct 29 19:13:49 2002
Reserved blocks uid:      0 (user root)
Reserved blocks gid:      0 (group root)
First inode:              11
Inode size:		  128
Journal UUID:             <none>
Journal inode:            8
Journal device:	          0x0000
First orphan inode:       1253429

] dumpe2fs -h /dev/discs/disc0/part6 # /
dumpe2fs 1.27 (8-Mar-2002)
Filesystem volume name:   root
Last mounted on:          <not available>
Filesystem UUID:          8fb25561-51cc-4fd6-b0cd-0cb2e22a7b07
Filesystem magic number:  0xEF53
Filesystem revision #:    1 (dynamic)
Filesystem features:      has_journal filetype needs_recovery sparse_super
Filesystem state:         clean
Errors behavior:          Continue
Filesystem OS type:       Linux
Inode count:              1921024
Block count:              7680944
Reserved block count:     384047
Free blocks:              5540410
Free inodes:              1676136
First block:              0
Block size:               2048
Fragment size:            2048
Blocks per group:         16384
Fragments per group:      16384
Inodes per group:         4096
Inode blocks per group:   256
Last mount time:          Fri May  3 04:12:09 2002
Last write time:          Fri May  3 04:12:09 2002
Mount count:              1
Maximum mount count:      30
Last checked:             Fri May  3 04:12:03 2002
Check interval:           15552000 (6 months)
Next check after:         Wed Oct 30 05:12:03 2002
Reserved blocks uid:      0 (user root)
Reserved blocks gid:      0 (group root)
First inode:              11
Inode size:		  128
Journal UUID:             <none>
Journal inode:            8
Journal device:	          0x0000
First orphan inode:       381271

-- 
I am, as I said, inspired by the biological phenomena in which chemical
forces are used in repetitious fashion to produce all kinds of weird
effects (one of which is the author).
        -- Richard Feynman, _There's Plenty of Room at the Bottom_
