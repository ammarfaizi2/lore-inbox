Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268886AbUIHGxV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268886AbUIHGxV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 02:53:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268883AbUIHGxV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 02:53:21 -0400
Received: from [209.195.52.120] ([209.195.52.120]:30106 "HELO
	warden2.diginsite.com") by vger.kernel.org with SMTP
	id S266223AbUIHGxK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 02:53:10 -0400
Date: Tue, 7 Sep 2004 23:51:43 -0700 (PDT)
From: David Lang <dlang@digitalinsight.com>
X-X-Sender: dlang@dlang.diginsite.com
To: Horst von Brand <vonbrand@inf.utfsm.cl>
cc: Christer Weinigel <christer@weinigel.se>, Hans Reiser <reiser@namesys.com>,
       David Masover <ninja@slaphack.com>, Spam <spam@tnonline.net>,
       Tonnerre <tonnerre@thundrix.ch>, Linus Torvalds <torvalds@osdl.org>,
       Pavel Machek <pavel@ucw.cz>, Jamie Lokier <jamie@shareable.org>,
       Chris Wedgwood <cw@f00f.org>, viro@parcelfarce.linux.theplanet.co.uk,
       Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4 
In-Reply-To: <200409080007.i880745c002997@localhost.localdomain>
Message-ID: <Pine.LNX.4.60.0409072336330.11722@dlang.diginsite.com>
References: <200409080007.i880745c002997@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Sep 2004, Horst von Brand wrote:

> David Lang <david.lang@digitalinsight.com> said:
>> so far the best answer that I've seen is a slight varient of what Hans is
>> proposing for the 'file-as-a-directory'
>
>> make the base file itself be a serialized version of all the streams and
>> if you want the 'main' stream open file/. (or some similar varient)
>
> Serialized how? cpio(1), tar(1), cat(1)ed together, ...? Ship it via FTP or
> something, how do you unpack on a traditional filesystem? On a wacky
> filesystem?
>

as I said elsewhere in the origional post the owner of the file sets the 
tool to use to serialize it. if you want tar set it to use tar, if you 
want cpio set that. in both cases it would be a call out to userspace

> Note that this has the same performance implications as the targzfilesystem
> concept, just the other way around: Instead of unpacking on the fly it is
> packing on the fly. And paying a (possibly huge) cost for "simple, everyday
> operations" in some cases that can't be distinguished from ones where there
> is no such cost is very wrong to me.

this is a (huge) oppurtunity for the filesystem to provide for an 
optimization. if it is able to maintain a serialized version then this 
could turn into a simple read. no it's not always the simple obvious 
thing, but very few things are.

the problem of things having unexpected side effects in an uncontrolled 
server already are out there.

>> this doesn't address the hard-link issue,
>
> It has to be solved!

I never disputed that, in fact I pointed out that that issue remained, 
with the idea (since disproved) that this suggestion would settle the 
other issues sufficiantly to let everyone concentrate on the link issue.

>
>>                                           but it should handle the backup
>> problems (your backup software just goes through the files and what it
>> gets is suitable for backups).
>
> But how do you recreate the original "files" later? You only get the
> serialized version back. Even worse, if you unpack on top of the original
> wacky file, you'd get a wacky file, where the main stream is the serialized
> version of the original... Rinse and repeat. [Shudder]

how smart if the filesystem plugin? can the filesystem recognise compound 
filetypes? if so then it can tell what's happening and do the right thing 
when recreating the file

>> you will ask what serializer to user, and my answer is to let one of the
>> streams tell you, and have the kernel make a call out to userspace to
>> execute the appropriate program (note that this means that tar is not put
>> into the kernel)
>
> If I want to see it serialized via tar(1), and you via cpio(1), and
> somebody else via "take the icon stream, discard everything else", how do
> you handle that?

the owner of the file decides (or whoever that owner grants the 
permissions to to change it to a different system)

>> in fact it may make sense to just open file/file to get at the 'main'
>> stream of the file (there may be cases where the concept of a single main
>> stream may not make sense)
>
> What do you do then?

the backup doesn't really care. if you refrence files by file/file then 
you can't really say that file/foo is any more the 'main' stream then 
file/bar. but if you call it file/. then you do have to define what 
themain version is.

>> so if this solves the tool/backup problem
>
> It makes it much worse, AFAICS.



>>                                            then we can look and figure out
>> if there's a reasonable way to solve the hard-link problem
>
> Right. And if none is found, can we drop this madness?

solutions are known , it's just not known if any solution can be 
implemented with suitable performance (lock the entire filesystem when you 
go to do a dangerous action goes a _long_ way towards solving the 
problems, but it's not acceptable due to performance issues)

the fundamental problem with hard links and directories (maintaining a 
sane path) is the exact same problem that the *notify tools need solved so 
that a program can setup notification on a directory tree that it's 
interested in without tieing up a large number of file handles. it's a odd 
problem, but if it can be solved there are several doors that open up.

David Lang



-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
