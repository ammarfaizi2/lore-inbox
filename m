Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261411AbUAAMn7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 07:43:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261492AbUAAMn7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 07:43:59 -0500
Received: from gamemakers.de ([217.160.141.117]:51850 "EHLO www.gamemakers.de")
	by vger.kernel.org with ESMTP id S261411AbUAAMn6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 07:43:58 -0500
Message-ID: <3FF41611.90109@lambda-computing.de>
Date: Thu, 01 Jan 2004 13:44:01 +0100
From: =?ISO-8859-1?Q?R=FCdiger_Klaehn?= <rudi@lambda-computing.de>
Reply-To: rudi@lambda-computing.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: en
MIME-Version: 1.0
To: jw schultz <jw@pegasys.ws>
Cc: linux-kernel@vger.kernel.org
Subject: Re: File change notification
References: <3FF2FC85.5070906@lambda-computing.de> <20040101104717.GA1373@pegasys.ws>
In-Reply-To: <20040101104717.GA1373@pegasys.ws>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jw schultz wrote:

[snip]

>hmm...
>
>
>#ln tree1/sub/dir/file tree2/sub/dir/file
>#watch_tree tree1 &
>#do_something_to tree2/sub/dir/file
>
>A dnotify can potentially know about open, chown, chmod,
>utimes and possibly link of the files by watching the paths
>and cwd; meaning it won't know about alternate paths.  How
>is it to know about read, write, fchown, fchmod and
>truncate?
>
>  
>
Take a look at fs/read_write.c. There are calls to dnotify_parent in all 
file operation functions. There is a comment in fs/dnotify.c which says 
that dnotify_parent is "hopelessly wrong, but unfixable without API 
changes". Another good reason for a new file change notification api...

The only thing I am not so sure about is mmap. I think a mmapped file 
will not create change notifications.

>Perhaps someone else has a more fertile imagination but
>short of looking up all the file inode numbers of the tree
>in question and watching that whole list this sounds futile.
>  
>
Whats wrong with that? You would just have to know the inode numbers of 
all directories in the subtree you are interested in. Then you can do a 
really fast inode->name translation using a hashtable or something. At 
least it is much more lightweight than having to open all directories :-)

I think that it is much cleaner and faster to report the inode numbers 
of the changed files since inode numbers are unique per filesystem and 
they are immediately available. The complicated mapping of inodes to 
path names should happen in user space only for the files the userspace 
process is interested in.

