Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286373AbRL0RUq>; Thu, 27 Dec 2001 12:20:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286374AbRL0RU1>; Thu, 27 Dec 2001 12:20:27 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:55544 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S286373AbRL0RUP>;
	Thu, 27 Dec 2001 12:20:15 -0500
Date: Thu, 27 Dec 2001 10:18:46 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: andersg@0x63.nu
Cc: Jens Axboe <axboe@suse.de>, Andrew Morton <akpm@zip.com.au>,
        linux-kernel@vger.kernel.org, lvm-devel@sistina.com
Subject: Re: [lvm-devel] Re: lvm in 2.5.1
Message-ID: <20011227101846.B12868@lynx.no>
Mail-Followup-To: andersg@0x63.nu, Jens Axboe <axboe@suse.de>,
	Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org,
	lvm-devel@sistina.com
In-Reply-To: <20011227084304.GA26255@h55p111.delphi.afb.lu.se> <3C2AEADB.24BEFE94@zip.com.au> <20011227122520.GA2194@h55p111.delphi.afb.lu.se> <20011227135453.GA5803@h55p111.delphi.afb.lu.se> <20011227162019.C1730@suse.de> <20011227160232.GA11106@h55p111.delphi.afb.lu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <20011227160232.GA11106@h55p111.delphi.afb.lu.se>; from andersg@0x63.nu on Thu, Dec 27, 2001 at 05:02:32PM +0100
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec 27, 2001  17:02 +0100, andersg@0x63.nu wrote:
> you mean like this?
> 
> -- 
> 
> //anders/g
> 
> diff -ru linux-2.5.2-pre2/drivers/md/lvm.c linux-2.5.2-pre2-lvmfix/drivers/md/lvm.c
> --- linux-2.5.2-pre2/drivers/md/lvm.c	Thu Dec 27 08:28:39 2001
> +++ linux-2.5.2-pre2-lvmfix/drivers/md/lvm.c	Thu Dec 27 16:43:52 2001
> @@ -1533,8 +1549,10 @@
>  			}
>  			vg_ptr->lv[l] = NULL;
>  			/* only create original logical volumes for now */
> -			if (lvm_do_lv_create(minor, lv.lv_name, &lv) != 0) {
> +			if (lvm_do_lv_create(minor, tmplv->lv_name, tmplv) != 0) {
>  				lvm_do_vg_remove(minor);
> +				vfree(snap_lv_ptr);
> +				kfree(tmplv);
>  				return -EFAULT;
>  			}
>  		}

How about re-doing this to look more like:

				lvm_do_vg_remove(minor);
				ret = -EFAULT;
				goto exit_lv;
			}
		}
.
.
.
	vg_count++;

	MOD_INC_USE_COUNT;

	/* let's go active */
	vg_ptr->vg_status |= VG_ACTIVE;

exit_lv:
	kfree(tmplv);
exit_snap:
	vfree(snap_lv_ptr);

	return ret;
}

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

