Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268084AbUH3Nxe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268084AbUH3Nxe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 09:53:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268094AbUH3Nx1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 09:53:27 -0400
Received: from hermine.aitel.hist.no ([158.38.50.15]:61701 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S268084AbUH3Nwj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 09:52:39 -0400
Message-ID: <41333225.7070801@hist.no>
Date: Mon, 30 Aug 2004 15:56:53 +0200
From: Helge Hafting <helge.hafting@hist.no>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Helge Hafting <helgehaf@aitel.hist.no>, Rik van Riel <riel@redhat.com>,
       Spam <spam@tnonline.net>, Jamie Lokier <jamie@shareable.org>,
       Hans Reiser <reiser@namesys.com>, David Masover <ninja@slaphack.com>,
       Diego Calleja <diegocg@teleline.es>, christophe@saout.de,
       vda@port.imtp.ilyichevsk.odessa.ua, christer@weinigel.se,
       Andrew Morton <akpm@osdl.org>, wichert@wiggy.net, jra@samba.org,
       hch@lst.de, linux-fsdevel@vger.kernel.org,
       Kernel Mailing List <linux-kernel@vger.kernel.org>, flx@namesys.com,
       reiserfs-list@namesys.com,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: Re: silent semantic changes with reiser4
References: <Pine.LNX.4.44.0408272158560.10272-100000@chimarrao.boston.redhat.com> <Pine.LNX.4.58.0408271902410.14196@ppc970.osdl.org> <20040828170515.GB24868@hh.idb.hist.no> <Pine.LNX.4.58.0408281038510.2295@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0408281038510.2295@ppc970.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

>On Sat, 28 Aug 2004, Helge Hafting wrote:
>  
>
>>>I think that lack of distinguishing power is more serious for 
>>>directories. The more I think I think about it, the more I wonder whether 
>>>Solaris did things right - having a special operation to "cross the 
>>>boundary".
>>>
>>>I suspect Solaris did it that way because it's a hell of a lot easier to 
>>>do it like that, but regardless, it would solve the issue of real 
>>>directories having both real children _and_ the "extra streams".
>>>      
>>>
>>There are many ways of doing this. Several extra streams to a directory
>>that aren't ordinary files in the directory?
>>    
>>
>
>Well.. Yes. We already have "." and "..", which are "special extra
>streams" in a sense. However, people expect them, and know to ignore them. 
>The same wouldn't be true of new naming.
>
>  
>
>>It seems to me that we can get a lot of nice functionality in a simpler way:
>>Instead of thinking about a number of streams attached to something
>>that is either an ordinary file or directory, just say that the only
>>change will be that a directory may have a _single_ file stream in
>>addition to being a plain directory.
>>    
>>
>
>That doesn't really help us. What would the name be, and how could you 
>avoid clashes? 
>  
>
The name for the file stream and the directory would be the same,
distinguished by how they're used.  I.e. fopen("filedirname", "rw")
gets the stream, while chdir("filedirname") changes into the directory.
fopen("filedirname/substream", "rw"); opens some stream inside
the directory - as usual.

My idea is that the "extra streams" aren't special at all, they
are simply files in a directory and will therefore work with
any normal tool.  cd'ing into such a directory won't be special
either - because it is a plain directory. A collection of named streams
is usually a bunch of files in a directory - nothing new there.

Someone serving files for clients using
other os'es may attach special meaning to them, but I don't see the need
for a special meaning under linux.

So the only new thing is that the directory have a stream of
its own.  Then there must be a way to turn a ordinary
file into such a directory - people may then implement
thumbnails, summaries and so on as substreams.  Where
the substreams really are plain files in this slightly
special directory.

Perhaps mkdir with an existing filename could succeed,
creating a mixed file/directory, if the underlying fs support it.

>  
>
>>If the VFS is to be extended in order to support file-as-directory (or
>>vice versa) then hopefully it can be done in a simple way.
>>    
>>
>
>I'm pretty confident that we can extend the VFS layer to support named
>streams (see the technical discussion with Al, rather than the flames in
>this thread). I also clearly believe that it is worth it, but I'm starting
>to wonder if we should have a special open flag to make people select the
>stream.
>
>If you look at the Solaris interface, the _nice_ part about "openat()" is 
>that you can do something like
>
>	file = open(filename, O_RDONLY);
>	if (file < 0)
>		return -ENOENT;
>	icon = openat(file, "icon", O_RDONLY | O_XATTR);
>	if (icon < 0)
>		icon = default_icon_file;
>	..
>
>and it will work regardless of whether "filename" is a directory or a 
>regular file, if I've understood correctly.
>  
>
An alternative: support open("filename/icon", O_CREAT);
and have this turn "filename" into file-as-directory if it wasn't so
already.  Then it works both with files and directories.
A new flag might be needed if old programs somehow depend on the stuff
above failing for plain files.

>Now, I think that makes sense for several reasons:
> - single case
> - race-free (think "stat()" vs "fstat()" races).
> - I think we want to do "openat()" regardless of whether we ever 
>   support extended attributes or not ("openat()" is nice for doing 
>   "namei()" in user space even in the absense of any attributes or 
>   named streams).
>
>So what we can do is
> - implement openat() regardless, and expect to do the Solaris thing for 
>   it if we ever do streams.
> - _also_ support the "implied named attributes" for regular files, so 
>   that you don't have to use "openat()" to access them.
>
>Comments? Does anybody hate "openat()" for any reason (regardless of 
>attributes)? We can easily support it, we'd just need to pass in the file 
>to use as part of the "nameidata" thing or add an argument (it would also 
>possibly be cleaner if we made "fs->pwd" be a "struct file").
>
>  
>
No problem with openat()

Helge Hafting

