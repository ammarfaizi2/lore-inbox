Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271007AbRH3Azu>; Wed, 29 Aug 2001 20:55:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271063AbRH3Azk>; Wed, 29 Aug 2001 20:55:40 -0400
Received: from [208.48.139.185] ([208.48.139.185]:9093 "HELO
	forty.greenhydrant.com") by vger.kernel.org with SMTP
	id <S269975AbRH3Az3>; Wed, 29 Aug 2001 20:55:29 -0400
Date: Wed, 29 Aug 2001 17:55:41 -0700
From: David Rees <dbr@greenhydrant.com>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: Andrew Morton <akpm@zip.com.au>, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org, ext3-users@redhat.com
Subject: Re: kupdated, bdflush and kjournald stuck in D state on RAID1 device (deadlock?)
Message-ID: <20010829175541.E21590@greenhydrant.com>
Mail-Followup-To: David Rees <dbr@greenhydrant.com>,
	Neil Brown <neilb@cse.unsw.edu.au>, Andrew Morton <akpm@zip.com.au>,
	linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
	ext3-users@redhat.com
In-Reply-To: <3B8D54F3.46DC2ABB@zip.com.au> <20010829141451.A20968@greenhydrant.com> <3B8D60CF.A1400171@zip.com.au> <20010829144016.C20968@greenhydrant.com> <3B8D6BF9.BFFC4505@zip.com.au> <20010829153818.B21590@greenhydrant.com> <3B8D712C.1441BC5A@zip.com.au> <20010829155633.D21590@greenhydrant.com> <15245.35636.82680.966567@notabene.cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <15245.35636.82680.966567@notabene.cse.unsw.edu.au>; from neilb@cse.unsw.edu.au on Thu, Aug 30, 2001 at 10:39:16AM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2001 at 10:39:16AM +1000, Neil Brown wrote:
> 
> Thanks David and Andrew for providing all the helpful details.
> I know what happened.  As Andrew said, the raid1 buffers have simply
> disappeared into thin air.
> The line that makes them invisible is
> 			r1_bh->state = 0;
> at line 165 in drivers/md/raid1.c.  This should be more like
> 			r1_bh->state = (1 << R1BH_PreAlloc);
> We need to clear the Uptodate bit and the Phase bit, but not
> the prealloc bit.  
> 
> Linus:  Please consider applying this patch.
> 
> NeilBrown
> 
> --- drivers/md/raid1.c	2001/08/30 00:36:54	1.1
> +++ drivers/md/raid1.c	2001/08/30 00:37:03
> @@ -162,7 +162,7 @@
>  			conf->freer1 = r1_bh->next_r1;
>  			conf->freer1_cnt--;
>  			r1_bh->next_r1 = NULL;
> -			r1_bh->state = 0;
> +			r1_bh->state = (1 << R1BH_PreAlloc);
>  			r1_bh->bh_req.b_state = 0;
>  		}
>  		md_spin_unlock_irq(&conf->device_lock);

Since rebooting, I haven't encountered any problems (but I did lose a lot of
data on that partition!).  I'll apply this patch and let you know if
anything strange happens.  Otherwise assume that it works for me.

I'm curious, why hasn't this bug shown up before?  Did I just get unlucky? 
Or is everyone else using software raid1 without problems lucky?  8)

-Dave
