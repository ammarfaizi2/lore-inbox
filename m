Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263593AbSIQEnN>; Tue, 17 Sep 2002 00:43:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263594AbSIQEnN>; Tue, 17 Sep 2002 00:43:13 -0400
Received: from mx1.sac.fedex.com ([199.81.208.10]:33799 "EHLO
	mx1.sac.fedex.com") by vger.kernel.org with ESMTP
	id <S263593AbSIQEnL>; Tue, 17 Sep 2002 00:43:11 -0400
Date: Tue, 17 Sep 2002 12:47:14 +0800 (SGT)
From: Jeff Chua <jchua@fedex.com>
X-X-Sender: root@boston.corp.fedex.com
To: Oleg Drokin <green@namesys.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: remount reiserfs hangs under heavy load 2.4.20pre5
In-Reply-To: <20020909184657.A6250@namesys.com>
Message-ID: <Pine.LNX.4.44.0209171246110.29232-100000@boston.corp.fedex.com>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 09/17/2002
 12:48:04 PM,
	Serialize by Router on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 09/17/2002
 12:48:06 PM,
	Serialize complete at 09/17/2002 12:48:06 PM
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I upgraded to 2.4.20-pre7 and the problem seems to have gone away.


Thanks,
Jeff
[ jchua@fedex.com ]

On Mon, 9 Sep 2002, Oleg Drokin wrote:

> Hello!
>
> On Fri, Sep 06, 2002 at 11:35:16PM +0800, Jeff Chua wrote:
> > > > Whenever "mount -o remount -n -w /dev/hdax" is issued under disk
> > > > activities, the system would freezed, and had to be hard booted.
> > > What kind of disk activies?
> > Activities such as compiling the kernel or rcp large files on /dev/hda3
> > > What was mount status of filesystems before that command was it readonly
> > > mounted ?
> > Yes, read-only on /dev/hda2, trying to change to read-write.
>
> Hm. Well, I have not found this same bug as you describe but a very similar
> problem.
> Can you please try patch below and see it it helps in your situation too?
> It should apply to almost anything including 2.4.19 and 2.4.20-pre5.
>
> Thank you.
>
> Bye,
>     Oleg
>
>
> ===== super.c 1.23 vs edited =====
> --- 1.23/fs/reiserfs/super.c	Mon Sep  9 14:41:12 2002
> +++ edited/super.c	Mon Sep  9 17:48:55 2002
> @@ -664,7 +664,7 @@
>    }
>
>    if (*mount_flags & MS_RDONLY) {
> -    /* remount rean-only */
> +    /* remount read-only */
>      if (s->s_flags & MS_RDONLY)
>        /* it is read-only already */
>        return 0;
> @@ -680,6 +680,10 @@
>      journal_mark_dirty(&th, s, SB_BUFFER_WITH_SB (s));
>      s->s_dirt = 0;
>    } else {
> +    /* remount read-write */
> +    if (!(s->s_flags & MS_RDONLY))
> +	return 0; /* We are read-write already */
> +
>      s->u.reiserfs_sb.s_mount_state = sb_state(rs) ;
>      s->s_flags &= ~MS_RDONLY ; /* now it is safe to call journal_begin */
>      journal_begin(&th, s, 10) ;
>

