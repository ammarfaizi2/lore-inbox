Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262696AbVFWTHp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262696AbVFWTHp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 15:07:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262694AbVFWTG1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 15:06:27 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:13461 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S263050AbVFWTAI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 15:00:08 -0400
Message-ID: <42BB06B6.1090203@namesys.com>
Date: Thu, 23 Jun 2005 12:00:06 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christophe Saout <christophe@saout.de>
CC: Andrew Morton <akpm@osdl.org>, hch@infradead.org, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: reiser4 plugins
References: <20050620235458.5b437274.akpm@osdl.org>	 <42B831B4.9020603@pobox.com> <42B87318.80607@namesys.com>	 <20050621202448.GB30182@infradead.org> <42B8B9EE.7020002@namesys.com>	 <20050621181802.11a792cc.akpm@osdl.org> <1119452212.15527.33.camel@server.cs.pocnet.net>
In-Reply-To: <1119452212.15527.33.camel@server.cs.pocnet.net>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a very nice description, thank you Christophe.  My comments are
below.

Christophe Saout wrote:

>Am Dienstag, den 21.06.2005, 18:18 -0700 schrieb Andrew Morton:
>
>  
>
>>>What is wrong with having an encryption plugin implemented in this
>>> manner?  What is wrong with being able to have some files implemented
>>> using a compression plugin, and others in the same filesystem not.
>>>
>>> What is wrong with having one file in the FS use a write only plugin, in
>>> which the encrypion key is changed with every append in a forward but
>>> not backward computable manner, and in order to read a file you must
>>> either have a key that is stored on another computer or be reading what
>>> was written after the moment of cracking root?
>>>
>>> What is wrong with having a set of critical data files use a CRC
>>> checking file plugin?
>>>      
>>>
>>I think the concern here is that this is implemented at the wrong level.
>>
>>In Linux, a filesystem is some dumb thing which implements
>>address_space_operations, filesystem_operations, etc.
>>
>>Advanced features such as those which you describe are implemented on top
>>of the filesystem, not within it.  reiser4 turns it all upside down.
>>
>>Now, some of the features which you envision are not amenable to
>>above-the-fs implementations.  But some will be, and that's where we should
>>implement those.
>>    
>>
>
>Yes, but that would be difficult, probably worse. The name "plugins" is
>perhaps a bit misleading. These plugins are most of the time some sort
>client to the reiser4 on-disk database structure. The core code is does
>on-disk tree handling, journalling and these things. The plugins in turn
>glue this core database system to the rest of the system in order to
>make a filesystem of it. The "file plugin" tells the database how to
>store files.
>
>A compression plugins is more tricky. Files should be randomly
>accessible and if you write in the middle of the file the compressed
>block might change in size. For reiser4 this is not a problem since it
>just tells the underlying database "give me some room for 1234 bytes and
>insert it in the tree instead of the other block". The reiser4 core has
>totally different semantics than the VFS layer and I don't see how these
>things could be handled elsewhere in this simple way.
>
>The reiser4 core is more some sort of library that abstracts a block
>device and provides some sort of database API (which is highly optimized
>for filesystem purposes). The actual filesystem is then another layer on
>top of this. You could actually implement lots of different filesystems
>on top of that database core.
>
>The actual layer is a bit different though. The database core itself
>registers with the Linux VFS and then passes the calls down to one of
>the plugins which then calls back into the reiser4 core to do the actual
>database modification. I think this was the point that Christoph was
>criticizing the most.
>
>Currently it looks like this:
>
>             ,--------------.       ,--------------.
>VFS -------> |              | ----> |              |
>             | /fs/reiser4/ |       | .../plugins/ |
>blockdev <-- |              | <---> |              |
>             `--------------'       `--------------'
>
>So the reiser4 code is introducing another abstraction of the Linux VFS
>layer instead of letting the plugins define the Linux VFS ops directly.
>Which would look like this:
>
>                                    ,--------------.
>VFS ------------------------------> |              |
>             ,--------------,       | .../plugins/ |
>blockdev <-- | /fs/reiser4/ | <---> |              |
>             `--------------'       `--------------'
>  
>
Note that the proposed change (as I understand it) creates a need to
load plugin definitions (classes) into VFS vectors (instances), which
requires additional code and operations. 

Plugins need to be FS specific by their nature (unless someone wants the
nightmare of allocating pluginids to each of the different filesystems
and dealing with the inevitable collisions and violations).

Note that with the proposed change there are now two places the contents
of the plugin definition must reside:  once in each VFS instance of that
plugin, and once in the plugin definition.  As Codd taught us, putting
data in two places that must be kept synchronous is strongly
undesirable, and it always causes more bugs over time than people think
it will.

By loading the instance from the plugin layer into VFS, we are creating
a need to instantiate something that could instead be shared among all
the instances.  It seems an additional step that is unneeded.

The advantage though is that it avoids a function dereference.

Perhaps I miss something here?

>Which probably would be okay for most of the time except for some
>details (which could probably be solved otherwise).
>
>Actually the flow is not always this simple, usually the path goes back
>and forth multiple time between the core and the plugins.
>
>One of the features Hans is using is that there can be different kinds
>of files. The on-disk structure tells the core which of the plugins is
>responsible for the "database object" found on the disk. It could be a
>directory or a "stat data" (inode) or a file. The file itself could be
>handled by different plugins like one that stores the data directly or
>one that compresses it.
>
>reiser4 is different than other filesystems in that it uses a lot more
>abstraction levels. The database aspect and the semantic aspect of a
>traditional filesystems are strongly separated.
>
>To understand the code probably means a lot of work because it is a bit
>different. Some of the layering concerns may be right, other probably
>not.
>
>The plugins that add additional VFS semantics (that are currently
>disable) should most definitely not be implemented only inside the
>filesystem. I think Hans did this because it would have been a lot more
>work doing this at the proper layer (which means talking to people and a
>lot of politics...).
>
>The last time I looked at the code is a while ago, so if I'm wrong on
>something, please don't shoot me. The only thing I can say is that
>reiser4 has very stable for me (though I've gone back to reiser3 for
>most of my filesystems because I wanted acl/xattr).
>
>So here's my advice: Instead of insulting each other or doing pure
>marketing talk, please try to address each detail and explain why
>something has been done and if it's good or bad and if it should be
>changed and how.
>
>  
>

