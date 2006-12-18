Return-Path: <linux-kernel-owner+w=401wt.eu-S1753274AbWLRAgQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753274AbWLRAgQ (ORCPT <rfc822;w@1wt.eu>);
	Sun, 17 Dec 2006 19:36:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753313AbWLRAgQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Dec 2006 19:36:16 -0500
Received: from gate.crashing.org ([63.228.1.57]:35254 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753274AbWLRAgQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Dec 2006 19:36:16 -0500
Subject: Re: [PATCH] more work_struct mess
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20061208091649.GL4587@ftp.linux.org.uk>
References: <20061208091649.GL4587@ftp.linux.org.uk>
Content-Type: text/plain
Date: Mon, 18 Dec 2006 11:35:59 +1100
Message-Id: <1166402159.31351.140.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-12-08 at 09:16 +0000, Al Viro wrote:
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

Please merge, right now, pmac32_defconfig is busted. I'm tempted to
mark dmasound_pmac for removal soon too ...

Ben.

> ---
> diff --git a/sound/oss/dmasound/tas3001c.c b/sound/oss/dmasound/tas3001c.c
> index f227c9f..2f21a3c 100644
> --- a/sound/oss/dmasound/tas3001c.c
> +++ b/sound/oss/dmasound/tas3001c.c
> @@ -50,6 +50,7 @@ struct tas3001c_data_t {
>  	int output_id;
>  	int speaker_id;
>  	struct tas_drce_t drce_state;
> +	struct work_struct change;
>  };
>  
> 
> @@ -667,14 +668,13 @@ tas3001c_update_device_parameters(struct
>  }
>  
>  static void
> -tas3001c_device_change_handler(void *self)
> +tas3001c_device_change_handler(struct work_struct *work)
>  {
> -	if (self)
> -		tas3001c_update_device_parameters(self);
> +	struct tas3001c_data_t *self;
> +	self = container_of(work, struct tas3001c_data_t, change);
> +	tas3001c_update_device_parameters(self);
>  }
>  
> -static struct work_struct device_change;
> -
>  static int
>  tas3001c_output_device_change(	struct tas3001c_data_t *self,
>  				int device_id,
> @@ -685,7 +685,7 @@ tas3001c_output_device_change(	struct ta
>  	self->output_id=output_id;
>  	self->speaker_id=speaker_id;
>  
> -	schedule_work(&device_change);
> +	schedule_work(&self->change);
>  	return 0;
>  }
>  
> @@ -823,7 +823,7 @@ tas3001c_init(struct i2c_client *client)
>  			tas3001c_write_biquad_shadow(self, i, j,
>  				&tas3001c_eq_unity);
>  
> -	INIT_WORK(&device_change, tas3001c_device_change_handler, self);
> +	INIT_WORK(&self->change, tas3001c_device_change_handler);
>  	return 0;
>  }
>  
> diff --git a/sound/oss/dmasound/tas3004.c b/sound/oss/dmasound/tas3004.c
> index 82eaaca..af34fb3 100644
> --- a/sound/oss/dmasound/tas3004.c
> +++ b/sound/oss/dmasound/tas3004.c
> @@ -48,6 +48,7 @@ struct tas3004_data_t {
>  	int output_id;
>  	int speaker_id;
>  	struct tas_drce_t drce_state;
> +	struct work_struct change;
>  };
>  
>  #define MAKE_TIME(sec,usec) (((sec)<<12) + (50000+(usec/10)*(1<<12))/100000)
> @@ -914,15 +915,13 @@ tas3004_update_device_parameters(struct 
>  }
>  
>  static void
> -tas3004_device_change_handler(void *self)
> +tas3004_device_change_handler(struct work_struct *work)
>  {
> -	if (!self) return;
> -
> -	tas3004_update_device_parameters((struct tas3004_data_t *)self);
> +	struct tas3004_data_t *self;
> +	self = container_of(work, struct tas3004_data_t, change);
> +	tas3004_update_device_parameters(self);
>  }
>  
> -static struct work_struct device_change;
> -
>  static int
>  tas3004_output_device_change(	struct tas3004_data_t *self,
>  				int device_id,
> @@ -933,7 +932,7 @@ tas3004_output_device_change(	struct tas
>  	self->output_id=output_id;
>  	self->speaker_id=speaker_id;
>  
> -	schedule_work(&device_change);
> +	schedule_work(&self->change);
>  
>  	return 0;
>  }
> @@ -1112,7 +1111,7 @@ tas3004_init(struct i2c_client *client)
>  	tas3004_write_register(self, TAS3004_REG_MCR2, &mcr2, WRITE_SHADOW);
>  	tas3004_write_register(self, TAS3004_REG_DRC, drce_init, WRITE_SHADOW);
>  
> -	INIT_WORK(&device_change, tas3004_device_change_handler, self);
> +	INIT_WORK(&self->change, tas3004_device_change_handler);
>  	return 0;
>  }
>  
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

