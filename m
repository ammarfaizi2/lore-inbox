Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262792AbTCUVxa>; Fri, 21 Mar 2003 16:53:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262769AbTCUVwv>; Fri, 21 Mar 2003 16:52:51 -0500
Received: from elaine24.Stanford.EDU ([171.64.15.99]:59779 "EHLO
	elaine24.Stanford.EDU") by vger.kernel.org with ESMTP
	id <S261759AbTCUVrp>; Fri, 21 Mar 2003 16:47:45 -0500
Date: Fri, 21 Mar 2003 13:58:19 -0800 (PST)
From: Junfeng Yang <yjf@stanford.edu>
To: Chris Wright <chris@wirex.com>
cc: linux-kernel@vger.kernel.org, <mc@cs.stanford.edu>, <perex@suse.cx>
Subject: Re: [CHECKER] potential dereference of user pointer errors
In-Reply-To: <20030321134449.A646@figure1.int.wirex.com>
Message-ID: <Pine.GSO.4.44.0303211355080.12835-100000@elaine24.Stanford.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks a lot for your confirmation! So actually the first copy_from_user
is meant to copy in what "*data" points to, not "data".

-Junfeng

On Fri, 21 Mar 2003, Chris Wright wrote:

> * Junfeng Yang (yjf@stanford.edu) wrote:
> >
> > [BUG] not sure. the dereference occurs at a tainted place. call
> > copy_from_user (, data, ), then copy_from_user (, *data, )
> >
> > /home/junfeng/linux-2.5.63/sound/core/seq/instr/ainstr_iw.c:92:snd_seq_iwffff_copy_env_from_stream:
> > ERROR:TAINTED deferencing "data" tainted by [dist=0][copy_from_user:parm1]
>
> seems like a bug, although i think it's the first copy_from_user that
> would be broken.
>
> Looks like call flow could be something like:
> Store user buf ptr in event.data.ext.ptr.
> Call snd_seq_iwffff_put with the event.data.ext.ptr (offset by header bits)
> Call snd_seq_iwffff_copy_env_from_stream with &event.data.ext.ptr (offset a
> little further).
>
> Finally, call copy_from_user on &event.data.ext.ptr, which is copying
> into an stype.  This looks like it's the bug.   I don't think the 32 bit
> addr should be copied into the stype, rather the 1st 32bits of the data
> (IOW copy_from_user(stype, *data,...)).  The second copy_from_user (with
> *data) copies in the whole iwffff_env_record_t struct which begins with
> an stype, so it really looks as if the first copy is broken. Patch
> below.   Jaroslav?
>
> thanks,
> -chris
> --
> Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
>
> ===== instr/ainstr_iw.c 1.3 vs edited =====
> --- 1.3/sound/core/seq/instr/ainstr_iw.c	Mon Feb 10 02:39:27 2003
> +++ edited/instr/ainstr_iw.c	Fri Mar 21 13:01:32 2003
> @@ -78,7 +78,7 @@
>  	while (1) {
>  		if (*len < (long)sizeof(__u32))
>  			return -EINVAL;
> -		if (copy_from_user(&stype, data, sizeof(stype)))
> +		if (copy_from_user(&stype, *data, sizeof(stype)))
>  			return -EFAULT;
>  		if (stype == IWFFFF_STRU_WAVE)
>  			return 0;
>

