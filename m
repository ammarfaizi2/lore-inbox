Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964902AbVHYJZV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964902AbVHYJZV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 05:25:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964903AbVHYJZV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 05:25:21 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:15879 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S964902AbVHYJZU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 05:25:20 -0400
Message-ID: <430D8E68.7070303@vmware.com>
Date: Thu, 25 Aug 2005 02:24:56 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Kumar Gala <galak@freescale.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 00/15] Remove asm/segment.h from low hanging	architectures
References: <Pine.LNX.4.61.0508241139100.23956@nylon.am.freescale.net> <1124920244.13833.6.camel@localhost.localdomain>
In-Reply-To: <1124920244.13833.6.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 25 Aug 2005 09:25:16.0836 (UTC) FILETIME=[E7A1F640:01C5A956]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>On Mer, 2005-08-24 at 11:43 -0500, Kumar Gala wrote:
>  
>
>>The following set of patches removes the use and existence of 
>>asm/segment.h from the architecture ports 
>>    
>>
>
>You've broken various things by doing this because some driver code
>rightly or wrongly uses segment.h. That is fine because they shouldn't
>do so. However asm/segment.h isn't supoosed to be removed on
>architectures that use segments- like x86, and x86-64. There it is a
>real arch private file and shouldn't be disappearing.
>
>It shouldn't be leaking into drivers any more (eg mxser.c is an offender
>there)
>  
>

Yes, agree totally,  i386 _requires_ asm/segment.h.  It is used in 
low-level trap handling and bootup code from assembly files.  In 
addition, even parts of userspace on i386 depend on asm/segment.h, 
although that is a different beast.

It is a total bug if generic drivers include it, there is simply no 
reason to use segment.h unless you have to use segmentation.  Ideally, 
all includes of segment.h should be confined to architectures that 
require it, and limited to either arch/foo or include/asm-foo.

I'm looking at -rc6-mm1, and I see the following bad guys:

./drivers/char/mxser.c:#include <asm/segment.h>
./drivers/char/speakup/speakup_drvcommon.c:#include <asm/segment.h>     
/* for put_user_byte */
./drivers/isdn/hisax/hisax.h:#include <asm/segment.h>
./drivers/media/video/adv7170.c:#include <asm/segment.h>
./drivers/media/video/adv7175.c:#include <asm/segment.h>
./drivers/media/video/bt819.c:#include <asm/segment.h>
./drivers/media/video/bt856.c:#include <asm/segment.h>
./drivers/media/video/saa7111.c:#include <asm/segment.h>
./drivers/media/video/saa7114.c:#include <asm/segment.h>
./drivers/media/video/saa7185.c:#include <asm/segment.h>
./drivers/serial/68328serial.c:#include <asm/segment.h>
./drivers/serial/crisv10.c:#include <asm/segment.h>
./drivers/serial/icom.c:#include <asm/segment.h>
./drivers/serial/mcfserial.c:#include <asm/segment.h>
./drivers/video/q40fb.c:#include <asm/segment.h>
./include/linux/isdn.h:#include <asm/segment.h>
./sound/oss/os.h:#include <asm/segment.h>

Zach
