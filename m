Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263071AbTHZGwb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 02:52:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262918AbTHZGwb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 02:52:31 -0400
Received: from [203.185.132.124] ([203.185.132.124]:48096 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S263071AbTHZGw2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 02:52:28 -0400
Message-ID: <3F4B0343.7050605@nectec.or.th>
Date: Tue, 26 Aug 2003 13:50:43 +0700
From: Samphan Raruenrom <samphan@nectec.or.th>
Organization: NECTEC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en, th
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: Jens Axboe <axboe@image.dk>, linux-kernel@vger.kernel.org,
       Linux TLE Team <rdi1@opentle.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [PATCH] Add MOUNT_STATUS ioctl to cdrom device
References: <3F4A53ED.60801@nectec.or.th> <20030825195026.A10305@infradead.org>
In-Reply-To: <20030825195026.A10305@infradead.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
>>+	case CDROM_MOUNT_STATUS: {
>>+		struct super_block *sb = get_super(dev);
>>+		if (sb == NULL) return -EINVAL;
>>+		down_read(&current->namespace->sem);
>>+		struct vfsmount *mnt = NULL;
>>+		struct list_head *p;
>>+		list_for_each(p, &current->namespace->list) {
>>+			struct vfsmount *m = list_entry(p, struct vfsmount, mnt_list);
>>+			if (sb == m->mnt_sb) {
>>+				mnt = m; break;
>>+			}
>>+		}
>>+		up_read(&current->namespace->sem);		
>>+		drop_super(sb);		
>>+		int mstat = 0; /* 0 not mounted, 1 umount ok, 2 umount EBUSY */
>>+		if (mnt) mstat = 1 + (atomic_read(&mnt->mnt_count) > 1);
>>+		cdinfo(CD_DO_IOCTL, "mount status(%s) = %d\n", mnt->mnt_devname, mstat);
>>+		return mstat;
> WTF?  This is not only a layering violation but also totally racy.

I'm sorry for issueing this layering violation. I read a guideline that
it's easier to submit a patch to add device driver ioctl than inventing
something new. It really doesn't belong here.
Could you guide me where else can I place this functionality?

(my random idea)
- fcntl(open("/dev/cdrom", F_MNTSTAT)
- umount2("/dev/cdrom", MS_TEST) // not actually perform
- new system call! e.g. mntstat(open("/dev/cdrom"))

-- 
Samphan Raruenrom,
The Open Source Project,
National Electronics and Computer Technology Center,
National Science and Technology Development Agency,
Thailand.

