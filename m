Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267375AbTBPUL0>; Sun, 16 Feb 2003 15:11:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267377AbTBPUL0>; Sun, 16 Feb 2003 15:11:26 -0500
Received: from ms-smtp-02.texas.rr.com ([24.93.36.230]:26864 "EHLO
	ms-smtp-02.texas.rr.com") by vger.kernel.org with ESMTP
	id <S267375AbTBPULZ>; Sun, 16 Feb 2003 15:11:25 -0500
Message-ID: <3E4FF2CE.60208@austin.rr.com>
Date: Sun, 16 Feb 2003 14:21:34 -0600
From: Steve French <smfrench@austin.rr.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:0.9.4) Gecko/20011128 Netscape6/6.2.1
X-Accept-Language: en-us
MIME-Version: 1.0
To: tmolina@cox.net, linux-kernel@vger.kernel.org
Subject: compile problem with 2.5.61-bk
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Those two functions are not exported (see e.g. ksyms.c) so are not 
available for modules to access but work when built as part of the kernel.
For the time being this means the CIFS VFS can not be built as a module.
Looks like I will have to figure out an alternate way to get at those two
functions either directly by exporting them or preferably by calling them 
indirectly - there may be a way to change fs/cifs/file.c to use the similar
function read_cache_pages directly as nfs does (which presumably is an 
exported function) but it wasn't obvious at the time since the cifs vfs 
preferably reads the equivalent of 4 pages at a time (rather than one 
4K page) across the network and the addition of support of readpages 
(with 16K reads in the readahead path) to the cifs vfs demonstrated a 
measurable performance benefit) even in the worst case (to loaded 
servers or on busy network segments the improvement would be more 
dramatic).

I will take a look at this later tonight to see if I can recode 
cifs_readpages to bypass the need for the additional exports.


Thomas Molina wrote: 
>After syncing with bk this morning I get the following errors during make 
>modules

>*** Warning: "add_to_page_cache" [fs/cifs/cifs.ko] undefined!
>*** Warning: "__pagevec_lru_add" [fs/cifs/cifs.ko] undefined!

>which I don't understand since those items are defined in files included 
>by fs/cifs/file.c



