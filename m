Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964780AbWGYPWT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964780AbWGYPWT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 11:22:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964779AbWGYPWT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 11:22:19 -0400
Received: from 83-64-96-243.bad-voeslau.xdsl-line.inode.at ([83.64.96.243]:39100
	"EHLO mognix.dark-green.com") by vger.kernel.org with ESMTP
	id S964777AbWGYPWT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 11:22:19 -0400
Message-ID: <44C63727.0@ed-soft.at>
Date: Tue, 25 Jul 2006 17:22:15 +0200
From: Edgar Hucek <hostmaster@ed-soft.at>
User-Agent: Thunderbird 1.5.0.4 (X11/20060615)
MIME-Version: 1.0
To: Michael Krufky <mkrufky@linuxtv.org>
CC: Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       v4l-dvb maintainer list <v4l-dvb-maintainer@linuxtv.org>,
       Andrew de Quincey <adq_dvb@lidskialf.net>,
       Chris Wright <chrisw@sous-sol.org>
Subject: Re: [patch 07/45] v4l/dvb: Fix CI on old KNC1 DVBC cards
References: <20060717160652.408007000@blue.kroah.org> <20060717162617.GH4829@kroah.com> <44C61616.7060203@ed-soft.at> <44C6358D.4040502@linuxtv.org>
In-Reply-To: <44C6358D.4040502@linuxtv.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't own such a dvb card. I only saw it when trying to compile kernel 2.6.17.7.

cu

Edgar (gimli) Hucek

Michael Krufky schrieb:
> Edgar Hucek wrote:
>> Hi.
>>
>> This fix does not compile on 2.6.17.7.
>> philips_cu1216_tuner_set_params is nowhere defined in the kernel tree.
>>
>> cu
>>
>> Edgar (gimli) Hucek
> 
> Yikes!
> 
> The patch description explains the blunder... Sorry about this.
> 
> We've got a fix, but would you mind testing it, Edgar, before I request
> that this gets added to the stable queue?
> 
> Thanks for reporting,
> 
> -Mike
> 
> From: Andrew de Quincey <adq_dvb@lidskialf.net>
> 
> [2.6.17.7 PATCH] Fix budget-av compile failure
> 
> Currently I am doing lots of refactoring work in the dvb tree. This
> bugfix became necessary to fix 2.6.17 whilst I was in the middle of this
> work. Unfortunately after I tested the original code for the patch, I
> generated the diff against the wrong tree (I accidentally used a tree
> with part of the refactoring code in it). This resulted in the reported
> compile errors because that tree (a) was incomplete, and (b) used
> features which are simply not in the mainline kernel yet.
> 
> Many apologies for the error and problems this has caused. :(
> 
> Signed-off-by: Andrew de Quincey <adq_dvb@lidskialf.net>
> Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>
> 
> diff -Naur linux-2.6.17.7.orig/drivers/media/dvb/ttpci/budget-av.c
> linux-2.6.17.7/drivers/media/dvb/ttpci/budget-av.c
> --- linux-2.6.17.7.orig/drivers/media/dvb/ttpci/budget-av.c	2006-07-25
> 14:53:19.000000000 +0100
> +++ linux-2.6.17.7/drivers/media/dvb/ttpci/budget-av.c	2006-07-25
> 15:25:32.000000000 +0100
> @@ -58,6 +58,7 @@
>  	struct tasklet_struct ciintf_irq_tasklet;
>  	int slot_status;
>  	struct dvb_ca_en50221 ca;
> +	u8 reinitialise_demod:1;
>  };
> 
>  /* GPIO Connections:
> @@ -214,8 +215,9 @@
>  	while (--timeout > 0 && ciintf_read_attribute_mem(ca, slot, 0) != 0x1d)
>  		msleep(100);
> 
> -	/* reinitialise the frontend */
> -	dvb_frontend_reinitialise(budget_av->budget.dvb_frontend);
> +	/* reinitialise the frontend if necessary */
> +	if (budget_av->reinitialise_demod)
> +		dvb_frontend_reinitialise(budget_av->budget.dvb_frontend);
> 
>  	if (timeout <= 0)
>  	{
> @@ -1064,12 +1066,10 @@
>  		fe = tda10021_attach(&philips_cu1216_config,
>  				     &budget_av->budget.i2c_adap,
>  				     read_pwm(budget_av));
> -		if (fe) {
> -			fe->ops.tuner_ops.set_params = philips_cu1216_tuner_set_params;
> -		}
>  		break;
> 
>  	case SUBID_DVBC_KNC1_PLUS:
> +		budget_av->reinitialise_demod = 1;
>  		fe = tda10021_attach(&philips_cu1216_config,
>  				     &budget_av->budget.i2c_adap,
>  				     read_pwm(budget_av));
> 
> 

