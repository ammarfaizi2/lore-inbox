Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267743AbUHZINe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267743AbUHZINe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 04:13:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267818AbUHZIN0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 04:13:26 -0400
Received: from hermine.aitel.hist.no ([158.38.50.15]:43015 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S267806AbUHZIM0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 04:12:26 -0400
Message-ID: <412D9C5C.3070302@hist.no>
Date: Thu, 26 Aug 2004 10:16:28 +0200
From: Helge Hafting <helge.hafting@hist.no>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matt Mackall <mpm@selenic.com>
CC: Nicholas Miell <nmiell@gmail.com>, Wichert Akkerman <wichert@wiggy.net>,
       Jeremy Allison <jra@samba.org>, Andrew Morton <akpm@osdl.org>,
       Spam <spam@tnonline.net>, torvalds@osdl.org, reiser@namesys.com,
       hch@lst.de, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
References: <20040824202521.GA26705@lst.de> <412CEE38.1080707@namesys.com> <20040825152805.45a1ce64.akpm@osdl.org> <112698263.20040826005146@tnonline.net> <Pine.LNX.4.58.0408251555070.17766@ppc970.osdl.org> <1453698131.20040826011935@tnonline.net> <20040825163225.4441cfdd.akpm@osdl.org> <20040825233739.GP10907@legion.cup.hp.com> <20040825234629.GF2612@wiggy.net> <1093480940.2748.35.camel@entropy> <20040826044425.GL5414@waste.org>
In-Reply-To: <20040826044425.GL5414@waste.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall wrote:

>On Wed, Aug 25, 2004 at 05:42:21PM -0700, Nicholas Miell wrote:
>  
>
>>On Wed, 2004-08-25 at 16:46, Wichert Akkerman wrote:
>>    
>>
>>>Previously Jeremy Allison wrote:
>>>      
>>>
>>>>Multiple-data-stream files are something we should offer, definately (IMHO).
>>>>I don't care how we do it, but I know it's something we need as application
>>>>developers.
>>>>        
>>>>
>>>Aside from samba, is there any other application that has a use for
>>>them? 
>>>
>>>      
>>>
>>Anything that currently stores a file's metadata in another file really
>>wants this right now. Things like image thumbnails, document summaries,
>>digital signatures, etc.
>>    
>>
>
>That is _highly_ debatable. I would much rather have my cp and grep
>and cat and tar and such continue to work than have to rewrite every
>tool because we've thrown the file-is-a-stream-of-bytes concept out
>the window. Never mind that I've got thumbnails, document summaries,
>and digital signatures already.
>  
>
Utilities that works on files only, such as cat, should keep
working.  No problem there.  If you cat a file that also is
a directory, then the file contents is all you get - by design.

Utilities that _only_ traverse the directory tree, such as find,
should keep working too.  Perhaps with a very minor update
so they don't mistake a file-directory for a file only.  I.e.
find must recurse into anything that support directory semantics.

Something that both recurse and operate on files (cp -a, tar, grep, ...
will need minor updating.  They already knows how to handle
files and directories, now they will need an update so
they're open for objects that are both.  I.e. let grep scan the file
as usual, then recurse into its directory part in the usual way too.
Performance problems should be avoided by not supporting
directory operations on files with no directory content, which I
believe will be many of them.

The "file-as-directory" thing will not be that useful before the tools
gets these relatively simple updates.  Till then it'll be a toy, which 
shouldn't
stop it from getting into the VFS.  Updating the tools will be a task
for the file-as-dir fans.

(I don't know wether reiser4 does things this way - it is certainly
they way I would want file-as-directory though.)

>While the number of annoying properties of files with forks is
>practically endless, the biggest has got to be utter lack of
>portability. How do you stick the thing in an attachment or on an ftp
>site? Well you can't because it's NOT A FILE. 
>  
>
Stick the file in an attachment and you get the file only. 
No problem, it is designed that way.  An app that really
wants everything in a single file should use a file structured
for that, not file-as-dir.  File-as-dir attach stuff to a file in a
more loose way.

If you want to attach the directory contents too, do what you usually do
when you want to mail someone a directory tree.  You can't stick a 
directory
in an attachment because it is not a file.  So you either attach every 
file in
the tree, or use tar.  In this case, an updated tar.

The ftp server shouldn't be a problem.  It supports both files and
directories already.  It may need a minor update in order to
not mistake directory for file or vice-versa when someone
request an operation.

ftp> get filename  #Will get you the contents of the file part only - by 
design.
ftp> cd filename    #Will change into the directory (if the file indeed 
provides one.)

>A file is a stream of bytes.
>  
>
Sure.  And a file with a directory support both directory and file 
operations.
You can get the stream of bytes as usual - that's the file part.  Or you
can cd into the directory as usual. There isn't much overlap between
file operations and directory operations, so there is little conflict 
the way
I see it.  Merely letting the tools know that being a file no longer rule
out the possibilities of directory operations.  Getting the VFS right
is another matter of course, but I don't worry about userland tools.

Helge Hafting
