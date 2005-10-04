Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964977AbVJDVKy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964977AbVJDVKy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 17:10:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964978AbVJDVKx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 17:10:53 -0400
Received: from rwcrmhc11.comcast.net ([216.148.227.117]:28854 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S964977AbVJDVKx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 17:10:53 -0400
Message-ID: <4342EFDB.4040101@namesys.com>
Date: Tue, 04 Oct 2005 14:10:51 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: "Vladimir V. Saveliev" <vs@namesys.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ReiserFS Mailing List <reiserfs-list@namesys.com>
Subject: Re: I request inclusion of reiser4 in the mainline kernel
References: <432AFB44.9060707@namesys.com> <20050916174028.GA32745@infradead.org> <43380DD8.8010200@namesys.com> <20051004190048.GA30832@infradead.org>
In-Reply-To: <20051004190048.GA30832@infradead.org>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:

>On Mon, Sep 26, 2005 at 07:03:52PM +0400, Vladimir V. Saveliev wrote:
>  
>
>>> - you still do your plugin mess in ->readpage.  honsetly could you
>>>   please explain why mpage_readpage{,s} don't work for you?
>>>      
>>>
>>The reason is performance. Reiser4 uses a search through the filesystem tree to
>>access metadata of a file.
>>If reiser4 implemented its read/write via generic functions it would have to
>>repeat the search for every page being read/written.
>>It is especially disappointing because reiser4 uses extents with which it is
>>able in most cases to find all file pointers to data blocks with only one search
>>through the tree.
>>Another reason is multithread load.
>>Tree search includes complex part of providing correct concurrent read/write
>>access to the tree including deadlock avoidance algorithm. On multithread
>>filesystem load minimizing of a number of tree searches should have improved
>>filesystem throughput.
>>
>>These are on todo list yet.
>>    
>>
>
>Let's start with the read side.  You are using the generic sendfile now
>which is the same as the generic read routine as far as the filesystem
>is concerned.
>
I am not sure that is the right thing for us to be doing actually.  We
need to abstract things our own way to create a proper abstraction
underneath sys_reiser4() and the general naming system that we are
headed towards.  That means we need the "flow" abstraction as the basis
of our code.  The flow abstraction is based on the idea that we should
be able to connect to and read or write any stream of bytes, in user or
kernel space.  A flow is a stream of bytes.  That is useful for
constructing sys_reiser4() and other semantic enhancements that we
plan.  If you would like to generalize the vfs interface such that it
reads and writes to and from flows, and user space buffers are just a
special case used by read() and write(), and it is not done page at a
time, that could be good for vfs.

>  What more do you need for read performance than a proper
>mpage_readpage(s) that can use the extent-enabled
>
what does extent enabled mean?  Do you mean that it passes more than one
page to the fs?  Or do you mean that readahead windows are set by the fs
because readahead is affected by file layout?  Or both?

> get_blocks callback?
>I'll post a patch for that ASAP, it benefits the other filesystems aswell.
>
>I know the write path is more complex, and doing your on ->writepage(s)
>is fine because that may need to do a lot of FS-specific things.  I'd
>really like to see you use generic_file_write or at least the major
>routines it's built from.  What's missing for you to do that?
>
Well, to start with, reiser4_write is plugin specific.  Writing to a
file might require modifying a file that it inherits its contents from,
for instance.

I think though that there is another consideration, which is that
reiser4 is not licensed just for Linux.  We need to create a coherent
body of code that can be ported to operating systems that don't have vfs
layers specially modified for us.  The easiest way to do that is to
write our own code for the key things like read and write.

VFS is supposed to allow filesystems to have their own read and write
implementations.  That is its defined interface.  You should allow us to
use it.  Other filesystems that are less ambitious might well want to
use generic code, but reiser4 is not a yellow package with black lettering.

>  Note
>that you read/write path will need a major rewrite anyway due to the
>flaws I pointed out, and I think it would benefit both you (less
>maintaince overhead, feature and bug parity) and the other
>filesystem/vfs/vm hackers (less duplicate functionality to worry about,
>improvement you make shared by every filesystem) if you tried to
>converge to use common code.
>
>
>
>
>  
>

