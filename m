Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750983AbVIZPEH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750983AbVIZPEH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 11:04:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751640AbVIZPEG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 11:04:06 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:38556 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S1750983AbVIZPEF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 11:04:05 -0400
Message-ID: <43380DD8.8010200@namesys.com>
Date: Mon, 26 Sep 2005 19:03:52 +0400
From: "Vladimir V. Saveliev" <vs@namesys.com>
Organization: Namesys
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050511
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ReiserFS Mailing List <reiserfs-list@namesys.com>,
       Hans Reiser <reiser@namesys.com>
Subject: Re: I request inclusion of reiser4 in the mainline kernel
References: <432AFB44.9060707@namesys.com> <20050916174028.GA32745@infradead.org>
In-Reply-To: <20050916174028.GA32745@infradead.org>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

Christoph Hellwig wrote:
> more trivial review comments ontop of the previous one, after looking
> at things:
> 
>  - please never use list_for_each in new code but list_for_each_entry

done

>  - never use kernel_thread in new code but kthread_*

done

>  - do_sendfile duplicates the common sendfile code.  why aren't you
>    using the generic code?

fixed to use generic code.

>  - there's tons of really useless assertation of the category
>    discussed in the last thread
>  - there's tons of deep pagecache messing in there.  normally this
>    shouldn't be a filesystem, and if this breaks because of VM changes you'll
>    have to fix it, don't complain..

we are also not very happy with it. We will not complain, but try to simplify it.

>  - you still do your plugin mess in ->readpage.  honsetly could you
>    please explain why mpage_readpage{,s} don't work for you?

The reason is performance. Reiser4 uses a search through the filesystem tree to
access metadata of a file.
If reiser4 implemented its read/write via generic functions it would have to
repeat the search for every page being read/written.
It is especially disappointing because reiser4 uses extents with which it is
able in most cases to find all file pointers to data blocks with only one search
through the tree.
Another reason is multithread load.
Tree search includes complex part of providing correct concurrent read/write
access to the tree including deadlock avoidance algorithm. On multithread
filesystem load minimizing of a number of tree searches should have improved
filesystem throughput.

These are on todo list yet.
>  - (issues with the read/write path already addresses in the previous thread)
>  - looking at ->d_count in ->release is wrong
>  - still has security plugin stuff that duplicates LSM
>  - why do underlying attributes change when VFS inode doesn't change?
>    if not please rip out most of getattr_common
>  - link_common S_ISDIR doesn't make sense, VFS takes care of it
>  - please use the generic_readlink infrastructure
> 
> additinoal comment is that the code is very messy, very different
> from normal kernel style, full of indirections and thus hard to read.
> real review will take some time.

We hope to improve that with your help

Thanks
