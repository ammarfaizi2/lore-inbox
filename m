Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964871AbVHaQlq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964871AbVHaQlq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 12:41:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964869AbVHaQlq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 12:41:46 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:65036 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S964871AbVHaQlp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 12:41:45 -0400
To: "Machida, Hiroyuki" <machida@sm.sony.co.jp>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][FAT] FAT dirent scan with hin take #3
References: <4313CBEF.9020505@sm.sony.co.jp> <4313E578.8070100@sm.sony.co.jp>
	<874q979qdj.fsf@devron.myhome.or.jp> <43156963.8020203@sm.sony.co.jp>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Thu, 01 Sep 2005 01:41:33 +0900
In-Reply-To: <43156963.8020203@sm.sony.co.jp> (Hiroyuki Machida's message of "Wed, 31 Aug 2005 17:25:07 +0900")
Message-ID: <87irxm83eq.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Machida, Hiroyuki" <machida@sm.sony.co.jp> writes:

> Right, it looks like TLB, which holds cache "Physical addres"
> correponding to "Logical address". In this case, PID and file name
> to be looked up, perform role of "Logical address".

But, there is the big difference between hint table and TLB. TLB is
just the cache, and TLB hit is perfectly good, because kernel is
flushing the wrong values.

But this hint table is just collecting the recent access, it's not
cache, and it's not tracking the process's access at all.  So, since
the hint value is really random, the hint value may be bad.

I worry bad cases of this.


Umm... How about tracking the access pattern of process?  If that
seems randomly access, just give up tracking and return no hint.  And,
probably, I think it would be easy to improve the behavior later.

What do you think?

e.g.

#define FAT_LOOKUP_HINT_MAX	16

/* this data per task */
struct fat_lookup_hint {
	struct list_head lru;
	pid_t pid;
	struct super_block *sb;
	struct inode *dir;
	loff_t last_pos;
/*	int state;*/
};

static void fat_lkup_hint_inval(struct super_block *, struct inode *);
static loff_t fat_lkup_hint_get(struct super_block *, struct inode *);
static void fat_lkup_hint_add(struct super_block *, struct inode *, loff_t);
static int fat_lkup_hint_init(void);
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
