Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130509AbRCIN5q>; Fri, 9 Mar 2001 08:57:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130510AbRCIN5Z>; Fri, 9 Mar 2001 08:57:25 -0500
Received: from pop3.web.de ([212.227.116.81]:40715 "HELO smtp.web.de")
	by vger.kernel.org with SMTP id <S130509AbRCIN5X>;
	Fri, 9 Mar 2001 08:57:23 -0500
Content-Type: text/plain; charset=US-ASCII
From: Tino Keitel <tino.keitel@web.de>
Organization: German National Research Center for Information Technology
To: linux-kernel@vger.kernel.org
Subject: Re: crashes if accassing FAT MO
Date: Fri, 9 Mar 2001 14:55:53 +0100
X-Mailer: KMail [version 1.2]
In-Reply-To: <3AA7B66D.B32E0FF2@darmstadt.gmd.de>
In-Reply-To: <3AA7B66D.B32E0FF2@darmstadt.gmd.de>
MIME-Version: 1.0
Message-Id: <01030914555300.07686@schinkenbrett.home.de>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday,  8. March 2001 17:42, Tino Keitel wrote:
> Hi folks,
>
> I use kernel 2.4.2. If I try to access files on a 640 MB MO (2048 bytes
> hardware sector size) and the MO is using FAT fs I only got messages
> like these:
>
> Unable to handle kernel NULL pointer dereference at virtual address
> 00000000
>  printing eip:
> 00000000
> *pde = 00000000
> Oops: 0000
> CPU:    0
> EIP:    0010:[<00000000>]
> EFLAGS: 00010286
> eax: 00000000   ebx: c798d740   ecx: 00000003   edx: c798d740
> esi: ffffffea   edi: 00000000   ebp: 00004000   esp: c576bf88
> ds: 0018   es: 0018   ss: 0018
> Process cat (pid: 458, stackpage=c576b000)
> Stack: cc993428 c798d740 0804b220 00004000 c798d760 c012d465 c798d740
> 0804b220
>        00004000 c798d760 c576a000 00004000 0804b220 bffff994 c0108d43
> 00000003
>        0804b220 00004000 00004000 0804b220 bffff994 00000003 0000002b
> 0000002b
> Call Trace: [<cc993428>] [<c012d465>] [<c0108d43>]
>
> Code:  Bad EIP value.
> Segmentation fault
>
> There are no problems if I use ext2fs, exept that I can't use them for
> data exchange with Windows. It also works with 2.2 kernels but the MO
> drive will be much slower.
>
> Tino

Ok, I did some debug work. Here are the results:

Writing to the MO doesn't cause an "Oops", but the file will contain trash.
'cat "test" > file' results in a file that contains 0x1a 0xf7 0xa3 0xdb 0x86

The lines

printk("fat debug: *i_sb: %u\n", inode->i_sb);
printk("fat debug: *cvf_file_read: %u\n", 
MSDOS_SB(inode->i_sb)->cvf_format->cvf_file_read);

in fs/fat/file.c:fat_file_read() shows this:

fat debug: *cvf_format: 3365518688
fat debug: *cvf_file_read: 0

In fs/fat/cvf.c I found this:

struct cvf_format bigblock_cvf = {
        0,      /* version - who cares? */      
        "big_blocks",
        0,      /* flags - who cares? */
        NULL,
        NULL,
        NULL,
        bigblock_fat_bread,
        bigblock_fat_bread,
        bigblock_fat_brelse,
        bigblock_fat_mark_buffer_dirty,
        bigblock_fat_set_uptodate,
        bigblock_fat_is_uptodate,
        bigblock_fat_ll_rw_block,
        default_fat_access,
        NULL,
        default_fat_bmap,
        NULL,
	^^^^^
        default_fat_file_write,
        NULL,
        NULL
};

cvf_file_read is set to zero and will be never changed, but cvf_file_write is 
set to default_fat_file_write.

Tino
