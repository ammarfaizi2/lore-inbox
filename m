Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262090AbUCLNcO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 08:32:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262099AbUCLNcO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 08:32:14 -0500
Received: from zero.aec.at ([193.170.194.10]:43526 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S262090AbUCLNcM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 08:32:12 -0500
To: Joe Thornber <thornber@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.4-mm1
References: <1yygN-7Ut-65@gated-at.bofh.it> <1yyqt-83X-23@gated-at.bofh.it>
	<1yyqs-83X-17@gated-at.bofh.it> <1yyJK-8mD-41@gated-at.bofh.it>
	<1yzPs-1bI-21@gated-at.bofh.it> <1yGe9-7Rk-23@gated-at.bofh.it>
	<1yI6f-1Bj-3@gated-at.bofh.it> <1yQdz-1Uf-7@gated-at.bofh.it>
	<1yRCI-3lE-19@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Fri, 19 Mar 2004 06:58:26 +0100
In-Reply-To: <1yRCI-3lE-19@gated-at.bofh.it> (Joe Thornber's message of
 "Fri, 12 Mar 2004 11:00:20 +0100")
Message-ID: <m3k71htm2l.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joe Thornber <thornber@redhat.com> writes:

> Fix ioctl breakage on x86-64.
> --- diff/include/linux/dm-ioctl.h	2004-03-11 10:20:28.000000000 +0000
> +++ source/include/linux/dm-ioctl.h	2004-03-12 09:44:58.000000000 +0000
> @@ -187,23 +187,37 @@ enum {
>  	DM_TABLE_STATUS_CMD,
>  };
>  
> +/*
> + * The dm_ioctl struct passed into the ioctl is just the header
> + * on a larger chunk of memory.  On x86-64 the dm-ioctl struct
> + * will be padded to an 8 byte boundary so the size will be
> + * different, which would change the ioctl code - yes I really
> + * messed up.  This hack forces x86-64 to have the correct ioctl
> + * code.
> + */
> +#ifdef CONFIG_X86_64
> +typedef char ioctl_struct[308];
> +#else
> +typedef struct dm_ioctl ioctl_struct;
> +#endif

That's bad because it will break binary compatibility for existing
x86-64 systems.  Don't add that please. Either emulate it properly
or I will just declare the 32bit DM emulation broken and users will
have to live with that.

-Andi

