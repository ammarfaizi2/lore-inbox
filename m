Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263290AbTCNJVX>; Fri, 14 Mar 2003 04:21:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263292AbTCNJVX>; Fri, 14 Mar 2003 04:21:23 -0500
Received: from 169.imtp.Ilyichevsk.Odessa.UA ([195.66.192.169]:33033 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S263290AbTCNJVW>; Fri, 14 Mar 2003 04:21:22 -0500
Message-Id: <200303140921.h2E9Lqu08107@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Oleg Drokin <green@linuxhacker.ru>, "Randy.Dunlap" <rddunlap@osdl.org>
Subject: Re: dpt_i2o.c fix for possibly memory corruption on reset timeout
Date: Fri, 14 Mar 2003 11:18:49 +0200
X-Mailer: KMail [version 1.3.2]
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
       deanna_bonds@adaptec.com
References: <20030313182819.GA2213@linuxhacker.ru> <20030313105125.1548d67c.rddunlap@osdl.org> <20030313185628.GA2485@linuxhacker.ru>
In-Reply-To: <20030313185628.GA2485@linuxhacker.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 13 March 2003 20:56, Oleg Drokin wrote:
> Hello!
>
> On Thu, Mar 13, 2003 at 10:51:25AM -0800, Randy.Dunlap wrote:
> > | Ok, so please consider applying this patch instead (appies to
> > | both 2.4 and 2.5)
>
> Ok, here's the one with spelling fix from Randy ;)
>
> Bye,
>     Oleg
>
> ===== drivers/scsi/dpt_i2o.c 1.9 vs edited =====
> --- 1.9/drivers/scsi/dpt_i2o.c	Wed Jan  8 18:26:13 2003
> +++ edited/drivers/scsi/dpt_i2o.c	Thu Mar 13 21:55:08 2003
> @@ -1318,7 +1318,9 @@
>  	while(*status == 0){
>  		if(time_after(jiffies,timeout)){
>  			printk(KERN_WARNING"%s: IOP Reset Timeout\n",pHba->name);
> -			kfree(status);
> +			/* We lose 4 bytes of "status" here, but we cannot
> +			   free these because controller may awake and corrupt
> +			   those bytes at any time */

I'd leave kfree() inside the comment - less effort for those
operating under -ENOCAFFEINE condition

			/* do NOT do kfree(status): we lose ....

I don't like the whole idea that mem leak is tolerable.

Can we just add a 4 byte scratch pad status to
struct _adpt_hba? Let it scribble there...
--
vda
