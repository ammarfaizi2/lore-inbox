Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263151AbTDBR5a>; Wed, 2 Apr 2003 12:57:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263155AbTDBR5a>; Wed, 2 Apr 2003 12:57:30 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:1551 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S263151AbTDBR51>; Wed, 2 Apr 2003 12:57:27 -0500
Date: Wed, 2 Apr 2003 19:08:52 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Gerd Knorr <kraxel@bytesex.org>
Cc: Kernel List <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>,
       Frank Davis <fdavis@si.rr.com>
Subject: Re: [patch] add i2c_clients_command()
Message-ID: <20030402190852.B1091@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Gerd Knorr <kraxel@bytesex.org>,
	Kernel List <linux-kernel@vger.kernel.org>,
	Greg KH <greg@kroah.com>, Frank Davis <fdavis@si.rr.com>
References: <20030402170652.GA24954@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030402170652.GA24954@bytesex.org>; from kraxel@bytesex.org on Wed, Apr 02, 2003 at 07:06:52PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 02, 2003 at 07:06:52PM +0200, Gerd Knorr wrote:
>   Hi,
> 
> This patch adds a function which loops over all i2c clients attached
> to some i2c adapter and calls the ->command function of the driver.
> 
> Currently the bttv and saa7134 drivers have simliar functions, but
> (currently) without sane locking and module handling.  Newer versions
> will switch to this function.  Updates for the two drivers which are
> actually using this new function are available from
> http://bytesex.org/patches/wip/
> 
>   Gerd
> 
> diff -u linux-2.5.66/drivers/i2c/i2c-core.c linux/drivers/i2c/i2c-core.c
> --- linux-2.5.66/drivers/i2c/i2c-core.c	2003-04-02 11:42:18.357220889 +0200
> +++ linux/drivers/i2c/i2c-core.c	2003-04-02 16:17:47.127702160 +0200
> @@ -494,6 +494,27 @@
>  	return 0;
>  }
>  
> +void i2c_clients_command(struct i2c_adapter *adap, unsigned int cmd, void *arg)
> +{
> +	int i;
> +
> +	down(&adap->list);
> +	for (i = 0; i < I2C_CLIENT_MAX; i++) {
> +		if (NULL == adap->clients[i])
> +			continue;
> +		if (!try_module_get(adap->clients[i]->driver->owner))
> +			continue;
> +		if (NULL == adap->clients[i]->driver->command)
> +			continue;
> +		
> +		up(&adap->list);
> +		adap->clients[i]->driver->command(adap->clients[i],cmd,arg);
> +		module_put(adap->clients[i]->driver->owner);
> +		down(&adap->list);
> +	}
> +	up(&adap->list);

This is a horrible algorithm!  Please introduce a per-adapter client
lists.

