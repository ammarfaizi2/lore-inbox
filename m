Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751321AbWIRDev@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751321AbWIRDev (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Sep 2006 23:34:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751354AbWIRDev
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Sep 2006 23:34:51 -0400
Received: from wx-out-0506.google.com ([66.249.82.231]:53680 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751321AbWIRDeu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Sep 2006 23:34:50 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=ZANZX1puCw6wROhPEZLbiU3TlyqCxuTy3XpGRSX28oI0AHMpddiQzm8aVkAjcLA1ELB3q/Qgxtx0eFRZFMoRrznaTHu3Kfpx67P0b9XJDzSE4SK5pjE279t8RDyCwmVgVgQPCYylLC0FpGOtJmFBk85CQrs8ZwE/2nlDY8zHKpo=
Message-ID: <450E13D4.10200@gmail.com>
Date: Mon, 18 Sep 2006 12:34:44 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060915)
MIME-Version: 1.0
To: "Robin H. Johnson" <robbat2@gentoo.org>
CC: Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc7-git1: AHCI not seeing devices on ICH8 mobo (DG965RY)
References: <20060914200500.GD27531@curie-int.orbis-terrarum.net> <4509AB2E.1030800@garzik.org> <20060914205050.GE27531@curie-int.orbis-terrarum.net> <20060916203812.GC30391@curie-int.orbis-terrarum.net> <20060916210857.GD30391@curie-int.orbis-terrarum.net> <20060917074929.GD25800@htj.dyndns.org> <20060918034826.GA10116@curie-int.orbis-terrarum.net>
In-Reply-To: <20060918034826.GA10116@curie-int.orbis-terrarum.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robin H. Johnson wrote:
> Yes your patch fixes it perfectly - it's a better version of an almost
> working fix I hacked up after my previous email.
> 
> Some patch review comments below as well.
> 
> Signed-off-by: Robin H. Johnson <robbat2@gentoo.org>
> 
>> @@ -186,9 +187,11 @@ struct ahci_host_priv {
>>  	unsigned long		flags;
>>  	u32			cap;	/* cache of HOST_CAP register */
>>  	u32			port_map; /* cache of HOST_PORTS_IMPL reg */
>> +	int			port_tbl[AHCI_MAX_PORTS];
>>  };
> maybe u8 instead of int?

Yeah, I like that.

> also a comment - /* mapping of port_idx to the implemented port */

Okay.

>> +	if (n_ports == 0) {
>> +		dev_printk(KERN_ERR, &pdev->dev, "0 port implemented\n");
>> +		return -EINVAL;
>> +	}
> Use plural form (0 ports), or negative (No ports) instead.

And, okay.

Jeff, we've been ignoring PI in ahci_host_init()...

	for (i = 0; i < probe_ent->n_ports; i++) {
#if 0 /* BIOSen initialize this incorrectly */
		if (!(hpriv->port_map & (1 << i)))
			continue;
#endif

The comment suggests that some BIOSen initialize PI incorrectly which 
will probably result in undetected ports.  Is this true?  Would it be 
dangerous to honor PI on some controllers?  If so, PI should be used 
only for controllers which does non-linear port mapping.

Thanks.

-- 
tejun
