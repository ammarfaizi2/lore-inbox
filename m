Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265024AbTFCOVY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 10:21:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265026AbTFCOVX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 10:21:23 -0400
Received: from [211.167.76.68] ([211.167.76.68]:6814 "HELO soulinfo")
	by vger.kernel.org with SMTP id S265024AbTFCOVV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 10:21:21 -0400
Date: Tue, 3 Jun 2003 22:35:11 +0800
From: hugang <hugang@soulinfo.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: software suspend in 2.5.70-mm3.
Message-Id: <20030603223511.155ea2cc.hugang@soulinfo.com>
In-Reply-To: <1054646566.9234.20.camel@dhcp22.swansea.linux.org.uk>
References: <20030603211156.726366e7.hugang@soulinfo.com>
	<1054646566.9234.20.camel@dhcp22.swansea.linux.org.uk>
X-Mailer: Sylpheed version 0.8.10claws13 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
 =?ISO-8859-1?Q?=CA=D5=BC=FE=C8=CB=A3=BA:?= Alan Cox <alan@lxorguk.ukuu.org.uk>
 =?ISO-8859-1?Q?=CA=D5=BC=FE=C8=CB=A3=BA:?= linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 03 Jun 2003 14:22:48 +0100
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> On Maw, 2003-06-03 at 14:11, hugang wrote:
> > Hi Pavel Machek:
> > 
> > I try the 2.5.70-mm3 with software suspend function. When suspend it will oops at ide-disk.c 1526 line
> >    BUG_ON (HWGROUP(drive)->handler);
> > 
> > I'm disable this check, The software suspend can work, and also can resumed. But this fix is not best way. I found in ide-io.c 1196
> >    hwgroup->handler = NULL;
> > is the problem.
> 
> The only way to make the suspend work properly is to queue the suspend
> sequence wit the other requests. Ben was doing some playing with this
> but I'm not sure what happened to it.
> 
Yes the above patch is not safe, When i'm run updatedb and suspsned, After resume will oops at kjournal. 

Here is another test on it, it can works with updatedb.
-
I found a best way to fix it. here is it. With the patch, I'm run updatedb and suspend for 5 counts, every things is ok.

 --- ide-disk.c.old	Tue Jun  3 22:22:13 2003
 +++ ide-disk.c	Tue Jun  3 22:16:22 2003
 @@ -1523,7 +1523,10 @@
  	do_idedisk_standby(drive);
  	drive->blocked = 1;
  
 -	BUG_ON (HWGROUP(drive)->handler);
 +	/*BUG_ON (HWGROUP(drive)->handler);*/
 +	while(HWGROUP(drive)->handler) {
 +		schedule();
 +	}
  	return 0;
  }
  

-- 
Hu Gang / Steve
Email        : huagng@soulinfo.com, steve@soulinfo.com
GPG FinePrint: 4099 3F1D AE01 1817 68F7  D499 A6C2 C418 86C8 610E
http://soulinfo.com/~hugang/HuGang.asc
ICQ#         : 205800361
Registered Linux User : 204016
