Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276720AbRJQNt7>; Wed, 17 Oct 2001 09:49:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276840AbRJQNtt>; Wed, 17 Oct 2001 09:49:49 -0400
Received: from mail.loewe-komp.de ([62.156.155.230]:33296 "EHLO
	mail.loewe-komp.de") by vger.kernel.org with ESMTP
	id <S276720AbRJQNti>; Wed, 17 Oct 2001 09:49:38 -0400
Message-ID: <3BCD8D4F.B26684B@loewe-komp.de>
Date: Wed, 17 Oct 2001 15:53:19 +0200
From: Peter =?iso-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>
Organization: LOEWE. Hannover
X-Mailer: Mozilla 4.76 [de] (X11; U; Linux 2.4.9-ac3 i686)
X-Accept-Language: de, en
MIME-Version: 1.0
To: Steve Lord <lord@sgi.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: NFS related Oops in 2.4.[39]-xfs
In-Reply-To: <200110170928.f9H9SsP07618@jen.americas.sgi.com> <3BCD8AC5.8FD733BC@loewe-komp.de>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Wächtler wrote:
> 
> Steve Lord wrote:
> >
> > Where did you get your kernel (the 2.4.9 version that is) this problem
> > sounds familiar, but I am pretty sure we fixed this case in XFS somewhere
> > between 2.4.3 and 2.4.9.
> >
> 
> The following diff was made in 2.4.4.
> 
> diff -u --recursive --new-file v2.4.4/linux/fs/nfsd/nfsfh.c linux/fs/nfsd/nfsfh.c
> --- v2.4.4/linux/fs/nfsd/nfsfh.c        Fri Feb  9 11:29:44 2001
> +++ linux/fs/nfsd/nfsfh.c       Sat May 19 17:47:55 2001
> @@ -244,6 +245,11 @@
>          */
>         pdentry = child->d_inode->i_op->lookup(child->d_inode, tdentry);
>         d_drop(tdentry); /* we never want ".." hashed */
> +       if (!pdentry && tdentry->d_inode == NULL) {
> +               /* File system cannot find ".." ... sad but possible */
> +               dput(tdentry);
> +               pdentry = ERR_PTR(-EINVAL);
> +       }
> 
> But it would not prevent the code path 2.4.3-xfs hit.
> pdentry is !=NULL and tdentry->d_inode is always NULL after d_alloc():611
> 

Damn. pdentry IS NULL.
Sorry, the patch would prevent the crash.
