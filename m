Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266753AbUIITUM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266753AbUIITUM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 15:20:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266777AbUIITRs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 15:17:48 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:1670 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S266753AbUIITPD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 15:15:03 -0400
Message-ID: <4140ABB6.6050702@namesys.com>
Date: Thu, 09 Sep 2004 12:15:02 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Theodore Ts'o" <tytso@mit.edu>
CC: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
       William Stearns <wstearns@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: silent semantic changes in reiser4 (brief attempt to document
 the idea ofwhat reiser4 wants to do with metafiles and why
References: <41323AD8.7040103@namesys.com> <413E170F.9000204@namesys.com> <Pine.LNX.4.58.0409071658120.2985@sparrow> <200409080009.52683.robin.rosenberg.lists@dewire.com> <20040909090342.GA30303@thunk.org>
In-Reply-To: <20040909090342.GA30303@thunk.org>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Putting \ into filenames makes windows compatibility less trivial. 
Putting | into filenames seems like asking for trouble with shells. 
Asking users to keep track of multiple levels of escapes imposed by 
shells and such is hard on them.

If you think \| is user friendly, oh god, people like you are the reason 
why Unix is hated by many.

Having to explain filename/metas/owner or filename/.../owner or 
filename/..metas/owner (I don't deeply care what string is used in place 
of "metas") is hard enough.

All of that said, if "|" was what people preferred, I could live with it.

Stealing from the namespace has a long history behind it (see WAFL, 
Clearcase, many others), and has never been a real world problem. It is 
not so bad. If you manage to find a historical case where someone made a 
mistake in the past, go ahead and name it, but I think moderate caution 
in such thievery is enough, paranoia is not required. Frankly I think 
the people who get paranoid about stealing a little bit from the 
namespace just aren't experienced enough in such matters.

Making an omelette requires breaking eggs. Making a new semantic layer 
(or adding features to languages generally) requires stealing from the 
namespace. POSIX is a least common denominator of operating systems, not 
something for innovators to follow.

Ted, I encourage you to not innovate and stick with POSIX.;-)

(Oh, and yes, I understand that minimizing the cost of change by being 
artful is desirable.)

Streams are a bad idea. The additional features required to emulate 
streams using files and directories are interesting though. Putting 
metafiles in the fs namespace is an increase in closure for the OS, and 
thus a good thing, because more closure means more connectivity between 
OS components.

Rather few people understand closure though, so I don't expect to do 
well in the politics of this. It is a bit like being for free trade, 
most people will never understand why it is so important because their 
mental gifts are in other matters, and the notion that people need to be 
well connected and free to interact is just way too abstract. That it is 
the single most important determinant of a nation's wealth, oh well.

Namespace connectivity is the single most important determinant of an 
OS's expressive power.

Hans

Theodore Ts'o wrote:

>On Wed, Sep 08, 2004 at 12:09:52AM +0200, Robin Rosenberg wrote:
>  
>
>>Maybe file/./attribute then. /. on a file is currently meaningless. That does 
>>not avoid the unpleasant fact that has been brought up by others (only to be 
>>ignored), that the directory syntax does not allow metadata on directories.
>>    
>>
>
>*Not* that I am endorsing the idea of being able to access metadata
>via a standard pathname --- I continue to believe that named streams
>are a bad idea that will be an attractive nuisance to application
>developers, and if we must do them, then Solaris's openat(2) API is
>the best way to proceed --- HOWEVER, if people are insistent on being
>able to do this via standard pathnames, and not introducing a new
>system call, I would suggest /|/ as the separator as the third least
>worst option.  Why?
>
>Any such scheme will violate POSIX and SUS, since we are stealing from
>the filename namespace, and thus could cause a previously working
>program to stop working --- however, assuming that we don't care about
>this, the virtical bar is the least likely to collide with existing
>file usages, because of its status as a shell meta-character (i.e.,
>pipe).  This means that in order to use it on the shell command line,
>programs will have to quote it:
>
>	cat /home/tytso/word.doc/\|/meta/silly-stupid-metadata-or-named-stream
>
>This may seem to be inconvenient, but one very good thing about this
>is that PHP and existing Perl scripts already already treat pathnames
>that contain pipes with a certain amount of suspicion --- and this is
>a good thing!  Otherwise, programs that take input from untrusted
>sources (say, URL's or http form posts), may convert such input into a
>metadata access, and that may be a very, very, very bad thing.  (For
>example, it may mean that you will have accidentally allowed a web
>user to read or possibly modify an ACL with whatever privileges of the
>CGI-perl or php script.)  By using a pipe character, it avoids this
>problem, since secure CGI scripts must be already checking for the
>pipe character anyway.
>
>  
>
>>I'm not convinced that totally transparent access to meta-data actually 
>>benefits anyone. If metadata is that useful (which I believe) it may well be
>>worth fixing those apps that need, and can use them. The rest should just
>>ignore it, even loose it. 
>>    
>>
>
>Totally agreed.  As I said above, I would prefer openat(2) to trying
>to do this within a standard pathname, and I would prefer not doing it
>all since aside from Samba, which is simply trying to maintain
>backwards compatibility with a Really Bad Idea, the number of
>protocols and data formats (ftp, tar, zip, gzip, cpio, etc., etc.,
>etc.) that would need to be revamped is huge. 
>
>						- Ted
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>
>  
>

