Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262068AbUCVQAb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 11:00:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262070AbUCVQAb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 11:00:31 -0500
Received: from gamemakers.de ([217.160.141.117]:42197 "EHLO www.gamemakers.de")
	by vger.kernel.org with ESMTP id S262068AbUCVQA2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 11:00:28 -0500
Message-ID: <405F0DFD.2070801@gamemakers.de>
Date: Mon, 22 Mar 2004 17:02:05 +0100
From: =?ISO-8859-1?Q?R=FCdiger_Klaehn?= <rudi@gamemakers.de>
Reply-To: rudi@lambda-computing.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: File change notification (enhanced dnotify)
References: <200403221500.i2MF0EI7003024@eeyore.valparaiso.cl>
In-Reply-To: <200403221500.i2MF0EI7003024@eeyore.valparaiso.cl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Horst von Brand wrote:
> =?ISO-8859-1?Q?R=FCdiger_Klaehn?= <rudi@gamemakers.de> said:
> 
>>Horst von Brand wrote:
>>
>>>=?ISO-8859-1?Q?R=FCdiger_Klaehn?= <rudi@gamemakers.de> said:
>>>
>>>>I am working on a mechanism to let programs watch for file system 
>>>>changes in large directory trees or on the whole system. Since my last 
>>>>post in january I have been trying various approaches.
> 
> 
>>>How do you propose to handle the fact that there are changes to _files_,
>>>which happen to be pointed to by entries in directories? There is no
>>>"change in the directory tree" in Unix...
> 
> 
>>Of course it is files that change. But as you say each file is pointed 
>>to by one or more dentry, so I use the dentry hierarchy to propagate the 
>>information about the change. Just like the old dnotify.
> 
> 
> dentries just keep the path travelled by hard links to get to the file in
> memory for fast future access. So if you have, say:
> 
>    dir1  dir2
>     |     |
>     .     .
>     .     .
>     .     .
>      \   /
>     somefile
> 
> and you referenced somefile by the path through dir1, if you monitor dir2
> you won't notice the change. There is no on-disk data to trace back through
> all the directories that reference the file, and reading all of the
> filesystem's metadata to find this out is ludicrous (ever seen fsck(8)
> taking an hour or so to make much the same?).

I am aware of that. As I mentioned, this approach does not work with 
hard links, just like the original dnotify.

 From the current "Documentation/dnotify.txt":
"In order to make the impact on the file system code as small as 
possible, the problem of hard links to files has been ignored."

There would be some ways to solve this for hard links. But I don't think 
that it would be worth it since it would involve a big performance 
overhead for little gain.

Note that if you watch for changes in the root of a file system, you 
will get notified exactly once for each file change in the file system 
regardless of hard links.

In your example if you have one file which can be accessed via two 
different paths "/dir1/somefile" and "/dir2/somefile" and you watch "/" 
you would get notified for "/dir1/somefile" or "/dir2/somefile" 
depending on how the changing program accesses the file.

Figuring out that "/dir1/somefile" and "/dir2/somefile" refer to the 
same file should IMHO be done in userspace. If inode numbers were unique 
and persistent on all file systems it might be possible to do this 
efficiently in kernel space, but unfortunately this is not the case.

My original approach assumed that inode numbers were unique, and it 
would have worked with hard links. But I think it is much more important 
to have a mechanism that works for all file systems than to solve the 
problem of hard links.

best regards,

Rüdiger

By the way: I just made a small website for my enhanced dnotify 
mechanism. I will post my latest code there. It can be found at
<http://www.lambda-computing.com/~rudi/dnotify/>
