Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261813AbTIPI4n (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 04:56:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261816AbTIPI4n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 04:56:43 -0400
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:60633 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S261813AbTIPI4k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 04:56:40 -0400
Date: Tue, 16 Sep 2003 10:56:30 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Wade <neroz@ii.net>
Cc: David Yu Chen <dychen@stanford.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [CHECKER] 32 Memory Leaks on Error Paths
Message-ID: <20030916085630.GD27703@wohnheim.fh-wedel.de>
References: <200309160435.h8G4ZkQM009953@elaine4.Stanford.EDU> <3F66CDB6.7000601@ii.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3F66CDB6.7000601@ii.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 September 2003 16:45:42 +0800, Wade wrote:
> David Yu Chen wrote:
> >
> >[FILE:  2.6.0-test5/drivers/char/vt_ioctl.c]
> >[FUNC:  do_kdsk_ioctl]
> >[LINES: 133-150]
> >[VAR:   key_map]
> > 128:
> > 129:			if (keymap_count >= MAX_NR_OF_USER_KEYMAPS &&
> > 130:			    !capable(CAP_SYS_RESOURCE))
> > 131:				return -EPERM;
> > 132:
> >START -->
> > 133:			key_map = (ushort *) kmalloc(sizeof(plain_map),
> > 134:						     GFP_KERNEL);
> > 135:			if (!key_map)
> > 136:				return -ENOMEM;
> > 137:			key_maps[s] = key_map;
                                ^^^^^^^^^^^^^^^^^^^^^^
> > 138:			key_map[0] = U(K_ALLOCATED);
> >        ... DELETED 6 lines ...
> > 145:			break;	/* nothing to do */
> > 146:		/*
> > 147:		 * Attention Key.
> > 148:		 */
> > 149:		if (((ov == K_SAK) || (v == K_SAK)) && 
> > !capable(CAP_SYS_ADMIN))
> >END -->
> > 150:			return -EPERM;
> > 151:		key_map[i] = U(v);
> > 152:		if (!s && (KTYP(ov) == KT_SHIFT || KTYP(v) == KT_SHIFT))
> > 153:			compute_shiftstate();
> > 154:		break;
> > 155:	}
> >---------------------------------------------------------
> 
> Is the attached correct?

Looks like there is no leak after all, as long as key_maps is dealt
with properly sometime.  But I'm not familiar enough with the code to
judge that.

> --- linux-2.6.0-test5.old/drivers/char/vt_ioctl.c	2003-08-23 07:57:57.000000000 +0800
> +++ linux-2.6.0-test5.new/drivers/char/vt_ioctl.c	2003-09-16 16:17:00.000000000 +0800
> @@ -146,8 +146,10 @@
>  		/*
>  		 * Attention Key.
>  		 */
> -		if (((ov == K_SAK) || (v == K_SAK)) && !capable(CAP_SYS_ADMIN))
> +		if (((ov == K_SAK) || (v == K_SAK)) && !capable(CAP_SYS_ADMIN)) {
> +			kfree(key_map);
>  			return -EPERM;
> +		}
>  		key_map[i] = U(v);
>  		if (!s && (KTYP(ov) == KT_SHIFT || KTYP(v) == KT_SHIFT))
>  			compute_shiftstate();


Jörn

-- 
Data dominates. If you've chosen the right data structures and organized
things well, the algorithms will almost always be self-evident. Data
structures, not algorithms, are central to programming.
-- Rob Pike
