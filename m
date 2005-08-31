Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964787AbVHaNEY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964787AbVHaNEY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 09:04:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964789AbVHaNEY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 09:04:24 -0400
Received: from NS5.Sony.CO.JP ([137.153.0.45]:42233 "EHLO ns5.sony.co.jp")
	by vger.kernel.org with ESMTP id S964787AbVHaNEX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 09:04:23 -0400
Message-ID: <4315AACF.2050409@sm.sony.co.jp>
Date: Wed, 31 Aug 2005 22:04:15 +0900
From: "Machida, Hiroyuki" <machida@sm.sony.co.jp>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: Pekka Enberg <penberg@cs.helsinki.fi>
CC: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][FAT] FAT dirent scan with hin take #3
References: <4313CBEF.9020505@sm.sony.co.jp> <4313E578.8070100@sm.sony.co.jp>	 <874q979qdj.fsf@devron.myhome.or.jp> <43156963.8020203@sm.sony.co.jp> <84144f0205083103142faaf076@mail.gmail.com>
In-Reply-To: <84144f0205083103142faaf076@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thank you checking code...

Pekka Enberg wrote:
> Hi,
> 
	:
	snip

>>
>>This patch enables using hint information on scanning dir.
>>It achieves excellent performance with "ls -l" for over 1000 entries.
>>
>>* fat-dirscan-with-hint_3.patch for linux 2.6.13
>>
>> fs/fat/dir.c             |  130 ++++++++++++++++++++++++++++++++++++++++++++---
>> fs/fat/inode.c           |   13 ++++
>> include/linux/msdos_fs.h |    2
>> 3 files changed, 137 insertions(+), 8 deletions(-)
>>
>>Signed-off-by: Hiroyuki Machida <machida@sm.sony.co.jp> for CELF
>>
>>* modified files
>>
>>
>>--- linux-2.6.13/fs/fat/dir.c   2005-08-29 08:41:01.000000000 +0900
>>+++ linux-2.6.13-work/fs/fat/dir.c      2005-08-31 13:48:01.001119437 +0900
>>@@ -201,6 +201,88 @@ fat_shortname2uni(struct nls_table *nls,
>>  * Return values: negative -> error, 0 -> not found, positive -> found,
>>  * value is the total amount of slots, including the shortname entry.
>>  */
>>+
>>+#define FAT_SCAN_SHIFT 4                       /* 2x8 way scan hints  */
>>+#define FAT_SCAN_NWAY  (1<<FAT_SCAN_SHIFT)
>>+
>>+inline
>>+static int hint_allocate(struct inode *dir)
>>+{
>>+       loff_t *hints;
>>+       int err = 0;
>>+
>>+       if (!MSDOS_I(dir)->scan_hints) {
> 
> 
> Please consider moving this check to callers. Conditional allocation
> makes this bit strange API-wise. Or alternatively, give
> hint_allocate() a better name.

How about hint_allocate_conditional() ?

> 
>>--- linux-2.6.13/fs/fat/inode.c 2005-08-29 08:41:01.000000000 +0900
>>+++ linux-2.6.13-work/fs/fat/inode.c    2005-08-31 12:59:54.292274060 +0900
>>@@ -242,6 +242,8 @@ static int fat_fill_inode(struct inode *
>>        inode->i_version++;
>>        inode->i_generation = get_seconds();
>>
>>+       init_MUTEX(&MSDOS_I(inode)->scan_lock);
>>+       MSDOS_I(inode)->scan_hints = 0;
> 
> 
> Please use NULL.

Ok,

> 
>>        if ((de->attr & ATTR_DIR) && !IS_FREE(de->name)) {
>>                inode->i_generation &= ~1;
>>                inode->i_mode = MSDOS_MKMODE(de->attr,
>>@@ -345,6 +347,15 @@ static void fat_delete_inode(struct inod
>> static void fat_clear_inode(struct inode *inode)
>> {
>>        struct msdos_sb_info *sbi = MSDOS_SB(inode->i_sb);
>>+       loff_t *hints;
>>+
>>+       down(&MSDOS_I(inode)->scan_lock);
>>+       hints = (MSDOS_I(inode)->scan_hints);
> 
> 
> Pleas drop redundant parenthesis.

Ok,

> 
>>+       if (hints) {
>>+               MSDOS_I(inode)->scan_hints = NULL;
>>+       }
>>+       up(&MSDOS_I(inode)->scan_lock);
>>+       kfree(hints);
> 
> 
> Why can't you do kfree() under scan_lock?
> 
Just try to minimize blocked period.


> 
>>@@ -1011,6 +1022,8 @@ static int fat_read_root(struct inode *i
>>        struct msdos_sb_info *sbi = MSDOS_SB(sb);
>>        int error;
>>
>>+       init_MUTEX(&MSDOS_I(inode)->scan_lock);
>>+       MSDOS_I(inode)->scan_hints = 0;
> 
> 
> Please use NULL here.

Ok.

>                              Pekka
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


-- 
Hiroyuki Machida		machida@sm.sony.co.jp		
SSW Dept. HENC, Sony Corp.
