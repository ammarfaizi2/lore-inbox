Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751922AbWCLXdK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751922AbWCLXdK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 18:33:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751926AbWCLXdK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 18:33:10 -0500
Received: from smtp4-g19.free.fr ([212.27.42.30]:58509 "EHLO smtp4-g19.free.fr")
	by vger.kernel.org with ESMTP id S1751922AbWCLXdJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 18:33:09 -0500
Message-ID: <4414AFBF.9080306@free.fr>
Date: Mon, 13 Mar 2006 00:33:19 +0100
From: Laurent Riffard <laurent.riffard@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.12) Gecko/20050920
X-Accept-Language: fr-fr, fr, en
MIME-Version: 1.0
To: Alexey Dobriyan <adobriyan@gmail.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Maneesh Soni <maneesh@in.ibm.com>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: Re: 2.6.16-rc6-mm1: BUG at fs/sysfs/inode.c:180
References: <20060312031036.3a382581.akpm@osdl.org> <44146C31.3010905@free.fr> <20060312225550.GA7790@mipter.zuzino.mipt.ru>
In-Reply-To: <20060312225550.GA7790@mipter.zuzino.mipt.ru>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Le 12.03.2006 23:55, Alexey Dobriyan a écrit :
> On Sun, Mar 12, 2006 at 07:45:05PM +0100, Laurent Riffard wrote:
> 
>>This kernel hangs on boot while trying to activate logical
>>volumes from initrd:
>>
>>------------[ cut here ]------------
>>kernel BUG at fs/sysfs/inode.c:180!
>>invalid opcode: 0000 [#1]
>>last sysfs file: /block/ram0/dev
>>Modules linked in: dm_mirror dm_mod
>>CPU:    0
>>EIP:    0060:[<c0172e71>]    Not tainted VLI
>>EFLAGS: 00010246   (2.6.16-rc6-mm1 #123)
>>EIP is at sysfs_get_name+0xd/0x46
>>eax: c15a49c8   ebx: dfe2b988   ecx: dff254d8   edx: c15a49cc
>>esi: dfe87b05   edi: dfe2b988   ebp: dfe67d28   esp: dfe67d28
>>ds: 007b   es: 007b   ss: 0068
>>Process vgchange (pid: 242, threadinfo=dfe67000 task=dfe175d0)
>>Stack: <0>dfe67d44 c01738c3 dffdc4b4 c15a49c8 dfe2b988 ffffffef dfe2b98d dfe67d60
>>       c0173dcd dff2a804 dfe2b984 dfe2b984 00000001 fffffffe dfe67d74 c0173f3b
>>       dfe67d6c c15a84d4 dfe2b984 dfe67d90 c01a33fd c03242d0 00000004 dfe2b8f8
>>Call Trace:
>> [<c0103a31>] show_stack_log_lvl+0x8b/0x95
>> [<c0103b69>] show_registers+0x12e/0x194
>> [<c0103e62>] die+0x14e/0x1db
>> [<c01040ba>] do_trap+0x7c/0x96
>> [<c0104319>] do_invalid_op+0x89/0x93
>> [<c01034db>] error_code+0x4f/0x54
>> [<c01738c3>] sysfs_dirent_exist+0x1c/0x65
>> [<c0173dcd>] create_dir+0x55/0x17d
>> [<c0173f3b>] sysfs_create_dir+0x46/0x61
>> [<c01a33fd>] kobject_add+0xa4/0x14c
>> [<c017267e>] register_disk+0x4b/0xe9
>> [<c019c28c>] add_disk+0x2e/0x3d
>> [<e08198a5>] create_aux+0x27e/0x2d7 [dm_mod]
>> [<e081991d>] dm_create+0xe/0x10 [dm_mod]
>> [<e081c317>] dev_create+0x4a/0x239 [dm_mod]
>> [<e081c18c>] ctl_ioctl+0x203/0x238 [dm_mod]
>> [<c0156648>] do_ioctl+0x3c/0x4f
>> [<c0156851>] vfs_ioctl+0x1f6/0x20d
>> [<c0156892>] sys_ioctl+0x2a/0x44
>> [<c01029bb>] sysenter_past_esp+0x54/0x75
>>Code: 0b 30 01 72 85 28 c0 ff 06 31 db eb 07 89 f8 e8 d1 8d fe ff 83 c4 10 89 d8 5b 5e 5f c9 c3 55 85 c0 89 e5 74 06 83 78 14 00 75 08 <0f> 0b b4 00 73 d3 28 c0 8b 50 18 83 fa 08 74 22 7f 0a 83 fa 02
>> BUG: vgchange/242, lock held at task exit time!
>> [dff25548] {inode_init_once}
>>.. held by:          vgchange:  242 [dfe175d0, 102]
>>... acquired at:               create_dir+0x1d/0x17d
>>
>>
>>There was no such problems with 2.6.16-rc5-mm3, I didn't change my
>>kernel config.
> 
> 
> Does reverting this patch make it work?
> 
> BTW, sysfs_dirent_exist() should return 0 or 1.
> ----------------------------------------------------------------
> The following patch checks for existing sysfs_dirent before
> preparing new one while creating sysfs directories and files.
> 
> Signed-off-by: Maneesh Soni <maneesh@in.ibm.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
> ---
>  fs/sysfs/dir.c     |   30 +++++++++++++++++++++++++++++-
>  fs/sysfs/file.c    |    6 ++++--
>  fs/sysfs/symlink.c |    5 +++--
>  fs/sysfs/sysfs.h   |    1 +
>  4 files changed, 37 insertions(+), 5 deletions(-)
> 
[patch trimmed]

Yes, reverting this patch solved the problem, thanks.

If you need more tests, feel free to ask.
-- 
laurent
