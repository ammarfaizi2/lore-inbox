Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263068AbTJELGR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Oct 2003 07:06:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263064AbTJELGR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Oct 2003 07:06:17 -0400
Received: from static213-229-38-018.adsl.inode.at ([213.229.38.18]:57734 "HELO
	home.winischhofer.net") by vger.kernel.org with SMTP
	id S263068AbTJELGP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Oct 2003 07:06:15 -0400
Message-ID: <3F7FFA4C.3020004@winischhofer.net>
Date: Sun, 05 Oct 2003 13:02:36 +0200
From: Thomas Winischhofer <thomas@winischhofer.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030930 Debian/1.4-5
X-Accept-Language: en, de-at, de-de, sv
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Eyal Lebedinsky <eyal@eyal.emu.id.au>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.23pre6aa2 - some problems [with patches]
References: <20031004105731.GA1343@velociraptor.random> <3F7EE96C.4AC99553@eyal.emu.id.au> <20031005104008.GC1561@velociraptor.random>
In-Reply-To: <20031005104008.GC1561@velociraptor.random>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
>>depmod: *** Unresolved symbols in
>>/lib/modules/2.4.23-pre6-aa2/kernel/drivers/vi
>>deo/sis/sisfb.o
>>depmod:         __floatsidf
>>depmod:         __divdf3
>>depmod:         __fixunsdfsi
>>depmod:         __muldf3
>>depmod:         __adddf3
> 
> 
> those drivers are buggy, and had always been buggy, it's just that you
> couldn't notice it before. I added an option in my new tree to catch
> those longstanding bugs. They *must* not compile. Driver
> authors can audit their 2.4 drivers by grabbing my tree or by applying
> this patch alone:
> 
> 	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.23pre6aa2/9999900_soft-float-1
> 
> see drivers/video/sis/init.c:
> 
>       divider = (sr2b & 0x80) ? 2.0 : 1.0;
>       postscalar = (sr2c & 0x80) ?
>               ( (((sr2c >> 5) & 0x03) == 0x02) ? 6.0 : 8.0) : (((sr2c >> 5) & 0x03) + 1.0);
>       num = (sr2b & 0x7f) + 1.0;
>       denum = (sr2c & 0x1f) + 1.0;
> 
> there would be a slight chance to find false positives too, but those
> aren't false positives, there's no fpu save at all there.
> 
> 
> Ironically all the float numbers seems to end with .0, I fixed it a bit
> but I've no idea if I catched all them, so Eyal, you can try to apply
> this patch and follow the code to see if you can spot more of these
> longstanding bugs (those could corrupt the fpu state and segfault
> userspace at the very least):
> 
> --- xx/drivers/video/sis/init.c.~1~	2003-10-02 00:09:44.000000000 +0200
> +++ xx/drivers/video/sis/init.c	2003-10-05 12:36:03.000000000 +0200
> @@ -3940,11 +3940,11 @@ SiSBuildBuiltInModeList(ScrnInfoPtr pScr
>        sr2b = pSiS->SiS_Pr->SiS_VCLKData[vclkindex].SR2B;
>        sr2c = pSiS->SiS_Pr->SiS_VCLKData[vclkindex].SR2C;
>  
> -      divider = (sr2b & 0x80) ? 2.0 : 1.0;
> +      divider = (sr2b & 0x80) ? 2 : 1;
>        postscalar = (sr2c & 0x80) ?
> -              ( (((sr2c >> 5) & 0x03) == 0x02) ? 6.0 : 8.0) : (((sr2c >> 5) & 0x03) + 1.0);
> -      num = (sr2b & 0x7f) + 1.0;
> -      denum = (sr2c & 0x1f) + 1.0;
> +              ( (((sr2c >> 5) & 0x03) == 0x02) ? 6 : 8) : (((sr2c >> 5) & 0x03) + 1);
> +      num = (sr2b & 0x7f) + 1;
> +      denum = (sr2c & 0x1f) + 1;
>  
>  #ifdef TWDEBUG
>        xf86DrvMsg(0, X_INFO, "------------\n");
> 

That part of init.c doesn't get compiled in the linux kernel, it's for 
XFree86. I think the xf86DrvMsg statement should make that clear...

Thomas

-- 
Thomas Winischhofer
Vienna/Austria
thomas AT winischhofer DOT net          http://www.winischhofer.net/
twini AT xfree86 DOT org

