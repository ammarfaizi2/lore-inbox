Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261983AbUCLMNN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 07:13:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262063AbUCLMNN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 07:13:13 -0500
Received: from furon.ujf-grenoble.fr ([152.77.2.202]:37261 "EHLO
	furon.ujf-grenoble.fr") by vger.kernel.org with ESMTP
	id S261983AbUCLMNK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 07:13:10 -0500
From: Mickael Marchand <marchand@kde.org>
To: Joe Thornber <thornber@redhat.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.4-mm1
Date: Fri, 12 Mar 2004 13:11:46 +0100
User-Agent: KMail/1.6.1
Cc: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
References: <1ysXv-wm-11@gated-at.bofh.it> <20040312082214.GO18345@reti> <20040312094951.GP18345@reti>
In-Reply-To: <20040312094951.GP18345@reti>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200403121311.46975.marchand@kde.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

just tested, it works just fine :)
no more errors,
dmsetup version and dmsetup ls work nicely
I will try to make evms work now but I guess that should be okay.
I will report if I have other troubles.

good candidate for next mm ?

thanks Joe,

Mik

Le vendredi 12 Mars 2004 10:49, Joe Thornber a écrit :
> On Fri, Mar 12, 2004 at 08:22:14AM +0000, Joe Thornber wrote:
> > name len == 128, uuid_len == 129, so is the uuid_len being rounded up
> > to the nearest 64bit boundary on x86-64 and only 32bit boundary on
> > x86-32 ?  (Sounds likely)
>
> In which case the following ugly patch should fix things.  Mickael,
> any chance you could test this please ?
>
> - Joe
>
>
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
> +
>  #define DM_IOCTL 0xfd
>
> -#define DM_VERSION       _IOWR(DM_IOCTL, DM_VERSION_CMD, struct dm_ioctl)
> -#define DM_REMOVE_ALL    _IOWR(DM_IOCTL, DM_REMOVE_ALL_CMD, struct
> dm_ioctl) -#define DM_LIST_DEVICES  _IOWR(DM_IOCTL, DM_LIST_DEVICES_CMD,
> struct dm_ioctl) -
> -#define DM_DEV_CREATE    _IOWR(DM_IOCTL, DM_DEV_CREATE_CMD, struct
> dm_ioctl) -#define DM_DEV_REMOVE    _IOWR(DM_IOCTL, DM_DEV_REMOVE_CMD,
> struct dm_ioctl) -#define DM_DEV_RENAME    _IOWR(DM_IOCTL,
> DM_DEV_RENAME_CMD, struct dm_ioctl) -#define DM_DEV_SUSPEND  
> _IOWR(DM_IOCTL, DM_DEV_SUSPEND_CMD, struct dm_ioctl) -#define DM_DEV_STATUS
>    _IOWR(DM_IOCTL, DM_DEV_STATUS_CMD, struct dm_ioctl) -#define DM_DEV_WAIT
>      _IOWR(DM_IOCTL, DM_DEV_WAIT_CMD, struct dm_ioctl) -
> -#define DM_TABLE_LOAD    _IOWR(DM_IOCTL, DM_TABLE_LOAD_CMD, struct
> dm_ioctl) -#define DM_TABLE_CLEAR   _IOWR(DM_IOCTL, DM_TABLE_CLEAR_CMD,
> struct dm_ioctl) -#define DM_TABLE_DEPS    _IOWR(DM_IOCTL,
> DM_TABLE_DEPS_CMD, struct dm_ioctl) -#define DM_TABLE_STATUS 
> _IOWR(DM_IOCTL, DM_TABLE_STATUS_CMD, struct dm_ioctl) +#define DM_VERSION  
>     _IOWR(DM_IOCTL, DM_VERSION_CMD, ioctl_struct) +#define DM_REMOVE_ALL   
> _IOWR(DM_IOCTL, DM_REMOVE_ALL_CMD, ioctl_struct) +#define DM_LIST_DEVICES 
> _IOWR(DM_IOCTL, DM_LIST_DEVICES_CMD, ioctl_struct) +
> +#define DM_DEV_CREATE    _IOWR(DM_IOCTL, DM_DEV_CREATE_CMD, ioctl_struct)
> +#define DM_DEV_REMOVE    _IOWR(DM_IOCTL, DM_DEV_REMOVE_CMD, ioctl_struct)
> +#define DM_DEV_RENAME    _IOWR(DM_IOCTL, DM_DEV_RENAME_CMD, ioctl_struct)
> +#define DM_DEV_SUSPEND   _IOWR(DM_IOCTL, DM_DEV_SUSPEND_CMD, ioctl_struct)
> +#define DM_DEV_STATUS    _IOWR(DM_IOCTL, DM_DEV_STATUS_CMD, ioctl_struct)
> +#define DM_DEV_WAIT      _IOWR(DM_IOCTL, DM_DEV_WAIT_CMD, ioctl_struct)
> +
> +#define DM_TABLE_LOAD    _IOWR(DM_IOCTL, DM_TABLE_LOAD_CMD, ioctl_struct)
> +#define DM_TABLE_CLEAR   _IOWR(DM_IOCTL, DM_TABLE_CLEAR_CMD, ioctl_struct)
> +#define DM_TABLE_DEPS    _IOWR(DM_IOCTL, DM_TABLE_DEPS_CMD, ioctl_struct)
> +#define DM_TABLE_STATUS  _IOWR(DM_IOCTL, DM_TABLE_STATUS_CMD,
> ioctl_struct)
>
>  #define DM_VERSION_MAJOR	4
>  #define DM_VERSION_MINOR	0
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
