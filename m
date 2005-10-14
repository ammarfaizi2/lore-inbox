Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750733AbVJNNDn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750733AbVJNNDn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Oct 2005 09:03:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750736AbVJNNDn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Oct 2005 09:03:43 -0400
Received: from NS8.Sony.CO.JP ([137.153.0.33]:40082 "EHLO ns8.sony.co.jp")
	by vger.kernel.org with ESMTP id S1750733AbVJNNDn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Oct 2005 09:03:43 -0400
Message-ID: <434FAC28.20000@sm.sony.co.jp>
Date: Fri, 14 Oct 2005 22:01:28 +0900
From: "Machida, Hiroyuki" <machida@sm.sony.co.jp>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: "Machida, Hiroyuki" <machida@sm.sony.co.jp>,
       OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       Andrew Morton <akpm@osdl.org>, David Howells <dhowells@redhat.com>
Subject: [PATCH] generic_osync_inode() with OSYNC_INODE only passed (Re: [PATCH
 1/2] miss-sync changes on attributes)
References: <43288A84.2090107@sm.sony.co.jp>	<87oe6uwjy7.fsf@devron.myhome.or.jp> <433C25D9.9090602@sm.sony.co.jp>	<20051011142608.6ff3ca58.akpm@osdl.org>	<87r7armlgz.fsf@ibmpc.myhome.or.jp>	<20051011211601.72a0f91c.akpm@osdl.org>	<87psqbxreb.fsf@ibmpc.myhome.or.jp> <434CA527.90604@sm.sony.co.jp> <87r7arqmqv.fsf@ibmpc.myhome.or.jp> <434CD445.2040704@sm.sony.co.jp>
In-Reply-To: <434CD445.2040704@sm.sony.co.jp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


generic_osync_inode() seems to do over-writing, if OSYNC_INODE only passed.
According comments of generic_osync_inode(), it is expected to write inode
itself only. Current implementation trys to write data page, even if
OSYNC_INODE only passed. This patch fixes it.

This patch is preparetion of other patch to fix "miss-sync changes on
attributes".


Machida, Hiroyuki wrote:
> 
> 
> OGAWA Hirofumi wrote:
> 
>> "Machida, Hiroyuki" <machida@sm.sony.co.jp> writes:
>>
>>
>>> OGAWA Hirofumi wrote:
>>>
>>>> Andrew Morton <akpm@osdl.org> writes:
>>>>
>>>>
>>>>> However there's not much point in writing a brand-new function when
>>>>> write_inode_now() almost does the right thing.  We can share the
>>>>> implementation within fs-writeback.c.
>>>>
>>>>
>>>> Indeed. We use the generic_osync_inode() for it?
>>>
>>>
>>> Please let me confirm.
>>> Using generic_osync_inode(inode, NULL, OSYNC_INODE) instaed of
>>> sync_inode_wodata(inode) is peferable for changes on fs/open.c,
>>> even it would write data. Is it correct?
>>
>>
>>
>> No, I only thought the interface is good. I don't know why it writes
>> data pages even if OSYNC_INODE only.
> 
> 
> 
> I checked 2.6.13 tree, following functions call generic_osync_inode().
> However noone calls it with OSYNC_INODE. SO I can't find intention of
> it's usage.
> 
> Does anyone know why generic_osync_inode() trys to write data page,
> even if OSYNC_INODE only passed ?
> 
>   - fs/reiserfs/file.c
>     reiserfs_file_write()        OSYNC_METADATA | OSYNC_DATA
>   - mm/filemap.c
>     sync_page_range()        OSYNC_METADATA
>     sync_page_range_nolock()    OSYNC_METADATA
>     generic_file_direct_write    OSYNC_METADATA
> 

-- 
Hiroyuki Machida		machida@sm.sony.co.jp		

