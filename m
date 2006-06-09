Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965109AbWFILFx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965109AbWFILFx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 07:05:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965224AbWFILFx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 07:05:53 -0400
Received: from smtp-relay.dca.net ([216.158.48.66]:60129 "EHLO
	smtp-relay.dca.net") by vger.kernel.org with ESMTP id S965109AbWFILFx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 07:05:53 -0400
Date: Fri, 9 Jun 2006 07:05:46 -0400
From: "Mark M. Hoffman" <mhoffman@lightlink.com>
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: Jean Delvare <khali@linux-fr.org>, linux-kernel@vger.kernel.org,
       lm-sensors@lm-sensors.org
Subject: Re: [lm-sensors] [PATCH] I2C: i2c_bit_add_bus should initialize SDA and SCL lines
Message-ID: <20060609110546.GA26073@jupiter.solarsys.private>
References: <m34pyyz0e1.fsf@defiant.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m34pyyz0e1.fsf@defiant.localdomain>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof:

* Krzysztof Halasa <khc@pm.waw.pl> [2006-06-06 18:58:46 +0200]:
> Another thing: I noticed the i2c_bit_add_bus doesn't set SDA and SCL
> lines to a known levels. If the hw driver set them to 1 all is fine
> and the first START condition is detected correctly. But if they're
> set differently (for example, if both are zero), the START will not
> work.
> 
> I'm not sure if the following patch isn't an overkill, though, and
> if the lack of initialization is a real problem which shows in
> practice and not only on my analyzer.
> 
> In case you think it's needed:
> 
> This patch makes i2c_bit_add_bus() initialize SDA and SCL lines
> as required by subsequent START condition.
> 
> Signed-off-by: Krzysztof Halasa <khc@pm.waw.pl>
> 
> --- a/drivers/i2c/algos/i2c-algo-bit.c
> +++ b/drivers/i2c/algos/i2c-algo-bit.c
> @@ -544,6 +544,13 @@ int i2c_bit_add_bus(struct i2c_adapter *
>  	adap->timeout = 100;	/* default values, should	*/
>  	adap->retries = 3;	/* be replaced by defines	*/
>  
> +	setsda(bit_adap, 0);	/* may mean START if SCL = 1 */
> +	udelay(bit_adap->udelay);
> +	setscl(bit_adap, 1);	/* may clock a zero bit in */
> +	udelay(bit_adap->udelay);
> +	setsda(bit_adap, 1);	/* STOP */
> +	udelay(bit_adap->udelay);
> +
>  	i2c_add_adapter(adap);
>  	return 0;
>  }

NACK.  The I2C bus spec says[1]:

	A START condition immediately followed by a STOP condition
	(void message) is an illegal format.

SCL and SDA must be pulled high by hardware.  If a driver inits to
setting them low, that's a bug in the driver.

[1] (page 14, note 5)
http://www.semiconductors.philips.com/acrobat_download/literature/9398/39340011.pdf

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com

