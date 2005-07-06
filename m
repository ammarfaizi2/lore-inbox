Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262052AbVGFT2B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262052AbVGFT2B (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 15:28:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262025AbVGFT2B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 15:28:01 -0400
Received: from 69-18-3-179.lisco.net ([69.18.3.179]:43528 "EHLO
	ninja.slaphack.com") by vger.kernel.org with ESMTP id S262082AbVGFOBD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 10:01:03 -0400
Message-ID: <42CBE426.9080106@slaphack.com>
Date: Wed, 06 Jul 2005 09:01:10 -0500
From: David Masover <ninja@slaphack.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hans Reiser <reiser@namesys.com>
Cc: Hubert Chan <hubert@uhoreg.ca>, Ross Biro <ross.biro@gmail.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Kyle Moffett <mrmacman_g4@mac.com>, Valdis.Kletnieks@vt.edu,
       Lincoln Dale <ltd@cisco.com>, Gregory Maxwell <gmaxwell@gmail.com>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ReiserFS List <reiserfs-list@namesys.com>,
       Alexander Zarochentcev <zam@namesys.com>, vs <vs@thebsh.namesys.com>,
       Nate Diller <ndiller@namesys.com>
Subject: Re: reiser4 plugins
References: <hubert@uhoreg.ca>	<200506290509.j5T595I6010576@laptop11.inf.utfsm.cl>	<87hdfgvqvl.fsf@evinrude.uhoreg.ca>	<8783be6605062914341bcff7cb@mail.gmail.com>	<878y0svj1h.fsf@evinrude.uhoreg.ca> <42C4F97B.1080803@slaphack.com> <87ll4lynky.fsf@evinrude.uhoreg.ca> <42CB0328.3070706@namesys.com> <42CB07EB.4000605@slaphack.com> <42CB0ED7.8070501@namesys.com> <42CB1128.6000000@slaphack.com> <42CB1C20.3030204@namesys.com> <42CB22A6.40306@namesys.com>
In-Reply-To: <42CB22A6.40306@namesys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser wrote:
> If we also add to this the restriction that once you create the file
> part of a file-directory, you can never hardlink to a child of it, it
> should then all work, yes?
> 
> So, /filename/..../owner should be able to avoid colliding with any
> common names by virtue of the '....', and not letting any filedir
> (file-directory) have children with links to them should also work.  The
> one thing that seems inelegant is that when you create the file part of
> a filedir, you must check all its children for hardlinks and fail if
> they exist, and you must flag all its directory children so that the
> plugins for them will disallow hardlinks to their children from that
> point onward.  Still, seems workable....

Ok, still haven't heard much discussion of metafs vs file-as-directory, 
but it seems like it'd be easier in metafs.

Basically, we are entirely POSIX compliant outside of metafs, so that 
/filename is a file and may be hardlinked, and /directory/ is a 
directory and may not.  No problems yet.

Inside /meta/inode, we have no problems yet because any hardlinks 
created outside /meta won't even show up as hardlinks here, so we don't 
get hardlinked directories.

Inside /meta/vfs, where we can find the metadata of '/filename' under 
'/meta/vfs/filename/...', we have what looks like a problem -- we may 
have hardlinks created outside metafs, which will show up as two 
directories inside metafs, so those directories are hardlinks.

I don't think that's such a problem, since we won't allow users to 
change anything in /meta/vfs except when it's inside metadata, such as 
'/meta/vfs/some/where/...'.

Thus, it's impossible to create a hardlink to a directory unless we do 
it *outside* metafs, as a hardlink to a file.

Now, the question I asked is, what if we want hardlinks *inside* metafs, 
*inside* the metadata for a given file, and would we ever want such a 
thing?  Because we can avoid the whole problem if we just disallow any 
sys_link calls inside metafs.

Of course, sometimes we want to have a chunk of metadata that appears 
*exactly* as if it were a normal, POSIX-compliant directory tree, such 
as the contents of a tarball or a zipfile.  In that case, we might want 
to have the "zip" plugin allow hardlinks inside 
"/meta/file.zip/.../contents" -- the only restriction is that any 
hardlink made to a file inside 'contents' must be made to another file 
inside 'contents'.

> Hans Reiser wrote:
> 
> 
>>David Masover wrote:
>>
>> 
>>
>>
>>>Now, can anyone think of a situation where we want user-created
>>>hardlinks inside metadata?  More importantly, what do we do about it?
>>>
>>>
>>>   
>>>
>>
>>I think the equivalent of symlinks would be good enough to get by on for
>>now for most linking of metafiles.  Maybe some years from now somebody
>>can fault me for saying this and write a patch to fix it to be better,
>>at which point I will be happy to concede the point.
>>
>>So the basic principal here is, one can have hardlinks to directories
>>without cycles provided that one does not allow any child of the
>>directory to have a hardlink.  The question is, how cleanly can that
>>relaxed restriction be coded?
>>
>>Hans
>>
>> 
>>
> 
> 

