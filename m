Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161492AbWJUURa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161492AbWJUURa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 16:17:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161490AbWJUURa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 16:17:30 -0400
Received: from mail.parknet.jp ([210.171.160.80]:31236 "EHLO parknet.jp")
	by vger.kernel.org with ESMTP id S1161025AbWJUUR3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 16:17:29 -0400
X-AuthUser: hirofumi@parknet.jp
To: Damien Wyart <damien.wyart@free.fr>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Nick Piggin <npiggin@suse.de>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.19-rc2-mm2 : empty files on vfat file system
References: <20061021104454.GA1996@localhost.localdomain>
	<87lkn9x0ly.fsf@duaron.myhome.or.jp>
	<20061021173849.GA1999@localhost.localdomain>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sun, 22 Oct 2006 05:17:22 +0900
In-Reply-To: <20061021173849.GA1999@localhost.localdomain> (Damien Wyart's message of "Sat\, 21 Oct 2006 19\:38\:49 +0200")
Message-ID: <87ac3ptodp.fsf@duaron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Damien Wyart <damien.wyart@free.fr> writes:

>> > I have noticed something strange (and bad :) since using
>> > 2.6.19-rc2-mm2 (the problem is NOT present on 2.6.19-rc2-mm1 ; do
>> > not know for mainline, I have not been able to test yet, but I think
>> > there have not been recent changes in this area) : writing a file to
>> > a vfat fs (fat 32) writes it, but with size 0 and no content.
>
> * OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> [2006-10-21 22:24]:
>> diff -puN fs/fat/inode.c~fs-prepare_write-fixes fs/fat/inode.c
>> --- a/fs/fat/inode.c~fs-prepare_write-fixes
>> +++ a/fs/fat/inode.c
>> @@ -150,7 +150,11 @@ static int fat_commit_write(struct file 
>>  			    unsigned from, unsigned to)
>>  {
>>  	struct inode *inode = page->mapping->host;
>> -	int err = generic_commit_write(file, page, from, to);
>> +	int err;
>> +	if (to - from > 0)
>> +		return 0;
>> +
>> +	err = generic_commit_write(file, page, from, to);
>>  	if (!err && !(MSDOS_I(inode)->i_attrs & ATTR_ARCH)) {
>>  		inode->i_mtime = inode->i_ctime = CURRENT_TIME_SEC;
>>  		MSDOS_I(inode)->i_attrs |= ATTR_ARCH;
>
>> This change does't update ->i_size. Could you just delete, and test
>> it? Anyway, this seems wrong even if it's "if ((to - from) == 0)".
>
> Reverting the change makes the problem go away. But I do not know if
> this is safe wrt the fs-prepare_write-fixes patch.

Yes, maybe another patch will be needed. However, I don't know the
background of this change. I'll make time and see what happened.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
