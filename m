Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264657AbSJ3Koo>; Wed, 30 Oct 2002 05:44:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264663AbSJ3Koo>; Wed, 30 Oct 2002 05:44:44 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:16139 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S264657AbSJ3Kol>;
	Wed, 30 Oct 2002 05:44:41 -0500
Message-ID: <3DBFB97B.3090707@pobox.com>
Date: Wed, 30 Oct 2002 05:50:35 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Miles Bader <miles@gnu.org>
CC: andersen@codepoet.org, Dave Cinege <dcinege@psychosis.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Abbott and Costello meet Crunch Time -- Penultimate 2.5 merge
 candidate list.
References: <200210272017.56147.landley@trommello.org>	<200210300229.44865.dcinege@psychosis.com>	<3DBF8CD5.1030306@pobox.com>	<200210300322.17933.dcinege@psychosis.com>	<20021030085149.GA7919@codepoet.org>	<buofzuogv31.fsf@mcspd15.ucom.lsi.nec.co.jp>	<3DBFA0F8.9000408@pobox.com>	<buobs5cgu7o.fsf@mcspd15.ucom.lsi.nec.co.jp>	<3DBFA5C7.1080603@pobox.com> <buo7kg0gtbj.fsf@mcspd15.ucom.lsi.nec.co.jp>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miles Bader wrote:

>Jeff Garzik <jgarzik@pobox.com> writes:
>  
>
>>I'm not saying that initramfs will do 
>>this out of the box :) but going from initramfs to "initromfs" should 
>>not be a huge leap...
>>    
>>
>
>Do you mean by putting the `internal' format that initramfs normally
>uses in RAM, in ROM, and skip the initial decompression step?
>
>Or do you mean have it somehow avoid copying the data areas of the cpio
>stream (i.e. store pointers from the tree-in-ram to the actual data
>blocks in ROM).
>
>I guess the latter sounds cleaner... it would also have the advantage
>that you could have a tree with the bulk of data in ROM, but which
>allowed new files to be written (which would be stored in RAM).
>  
>

Well, Linux wants file data in pages, so you would need to be able to 
get your kernel to point to page-aligned ROM regions.  Otherwise you are 
stuck with the same issues as fs/romfs or fs/cramfs or most other Linux 
filesystems -- you gotta copy the data into a RAM page before the Linux 
VFS will look at it[1].  For the initramfs cpio image itself, it can 
either piggyback inside the kernel image, or be loaded separately via 
bootloader, from ROM, or some other magic means.  Unpacking [what is 
essentially] pointers into the ROM would probably involve custom 
userland code in an initramfs which mounts and populates a ROM-based 
filesystem.

So one way or another you can have all of _your own_ data in ROM, but I 
don't want to paint too rosy a picture -- if you want to be smarter than 
fs/romfs is now, it will take some additional work.  And of course the 
ramfs-based rootfs will still be needed as the underlying writable fs.

    Jeff

[1] or you can create your own file_operations and eliminate this 
restriction... with a bunch of ROM-specific custom code that totally 
bypasses the pagecache


