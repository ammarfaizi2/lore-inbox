Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282074AbRK1HQb>; Wed, 28 Nov 2001 02:16:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282025AbRK1HQW>; Wed, 28 Nov 2001 02:16:22 -0500
Received: from kiruna.synopsys.com ([204.176.20.18]:56264 "HELO
	kiruna.synopsys.com") by vger.kernel.org with SMTP
	id <S282029AbRK1HQM>; Wed, 28 Nov 2001 02:16:12 -0500
From: "Alex Riesen" <riesen@synopsys.COM>
To: "Jochen Eisinger" <jochen.eisinger@gmx.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: 2.4.16 alsa 0.5.12 mixer ioctl problem
Date: Wed, 28 Nov 2001 08:16:01 +0100
Message-ID: <HKEMJNBMMEMMAEHPEBGNGECECBAA.riesen@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <3C034944.1090501@gmx.de>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, your patch fixed the problem.
BTW, 2.5.[0,1-pre1] contain this 'broken' code:
Maybe it is silently fixed at some other play,
but just for everyones information.

2.5.1-pre1:
struct inode * proc_get_inode(struct super_block * sb, int ino,
				struct proc_dir_entry * de)
{
	struct inode * inode;

	/*
	 * Increment the use count so the dir entry can't disappear.
	 */
	de_get(de);
#if 1
/* shouldn't ever happen */
if (de && de->deleted)
printk("proc_iget: using deleted entry %s, count=%d\n", de->name,
atomic_read(&de->count));
#endif

	inode = iget(sb, ino);
	if (!inode)
		goto out_fail;

	inode->u.generic_ip = (void *) de;
	if (de) {
		if (de->mode) {
			inode->i_mode = de->mode;
			inode->i_uid = de->uid;
			inode->i_gid = de->gid;
		}
		if (de->size)
			inode->i_size = de->size;
		if (de->nlink)
			inode->i_nlink = de->nlink;
		if (de->owner)
			__MOD_INC_USE_COUNT(de->owner);
		if (de->proc_iops) <<<<<<<<
			inode->i_op = de->proc_iops; <<<<<<<<
		if (de->proc_fops) <<<<<<<<
			inode->i_fop = de->proc_fops; <<<<<<<<
-- this line looks like error, what has init_special_inode to do with
de->proc_fops?
		else if (S_ISBLK(de->mode)||S_ISCHR(de->mode)||S_ISFIFO(de->mode))
			init_special_inode(inode,de->mode,kdev_t_to_nr(de->rdev));
	}

out:
	return inode;

out_fail:
	de_put(de);
	goto out;
}

> -----Original Message-----
> From: Jochen Eisinger [mailto:jochen.eisinger@gmx.de]
> Sent: Tuesday, November 27, 2001 09:05
> To: Alex Riesen
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: 2.4.16 alsa 0.5.12 mixer ioctl problem
>
>
> Hi!
>
> This appears to be a problem with fs/proc/inode.c. Reverting to the
> version up to 2.4.15-pre6 will solve your problem.
>
> regards
> -- jochen
>
> Alex Riesen wrote:
>
> > Hi, all
> >
> > just tried to compile the mentioned alsa drivers under 2.4.16.
> > Mixer doesnt work, yes. It compiles, installs, loads. And
> > any program trying to open mixer (through libasound) get EINVAL.
> >
>

