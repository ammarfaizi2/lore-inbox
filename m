Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263752AbTGMPgv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 11:36:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267464AbTGMPgv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 11:36:51 -0400
Received: from hueytecuilhuitl.mtu.ru ([195.34.32.123]:44813 "EHLO
	hueymiccailhuitl.mtu.ru") by vger.kernel.org with ESMTP
	id S263752AbTGMPgt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 11:36:49 -0400
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: Adam Kessel <adam@bostoncoop.net>
Subject: Re: DVD/CD Read Problem: cdrom_decode_status: status=0x51 {DriveReady SeekComplete Error}
Date: Sun, 13 Jul 2003 19:51:07 +0400
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200307131950.44923.arvidjaar@mail.ru>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I get the following errors and an unkillable process when trying to play
> DVDs, using the latest 2.5.75: 
>
> Jul 13 00:15:03 joehill kernel: hdc: cdrom_decode_status: status=0x51 { 
DriveReady SeekComplete Error }
> Jul 13 00:15:03 joehill kernel: hdc: cdrom_decode_status: 
error=0x30LastFailedSense 0x03 

this is ide-cd problem. drivers/ide/ide-cd:cdrom_decode_status():

               } else if ((err & ~ABRT_ERR) != 0) {
                        /* Go to the default handler
                           for other errors. */
                        DRIVER(drive)->error(drive, 
"cdrom_decode_status",stat);
                        return 1;
                } else if (sense_key == MEDIUM_ERROR) {
                        /* No point in re-trying a zillion times on a bad
                         * sector...  If we got here the error is not 
correctabl
e */
                        ide_dump_status (drive, "media error (bad sector)", 
stat
);
                        cdrom_end_request(drive, 0);


The above sense key is exactly MEDIUM_ERROR but driver never has chance to 
stop "retring zillion times" simply because it immediately falls down into 
driver->error again. So "innocent" media error results half an hour retries 
and disabled DMA.

> and sometimes: 
>
> Jul 13 00:15:03 joehill kernel: hdc: ide_intr: huh? expected NULL handler on 
exit 
>
> This problem has been discussed several times before on this list[1], but 
with
> no resolution or fixes that I can find.  
>
> I don't believe this is a userspace issue.  Other OS's are able to deal with
> playing video DVDs by skipping read errors quickly.  There should be some 
one
> way to tell the kernel not to keep retrying for certain (i.e., non-data)
> CD/DVDs.  I can't see any possible way to do this in application space,
> though.  

they are not user-space issues. Try to swap two conditions above and see what 
happens. I cannot test it anymore for reason below ...

[...]

> I'm not sure why it's getting errors at all, incidentally, as this occurs
> with brand new DVDs out of the shrink wrap, and a relatively new DVD
> player (HP F2015B, manufactured by Quanta).

I just had to ditch brand new Toshiba SD-R1312 because I got exactly the same 
errors on multisession CDs. Single sessions were OK but multisessions almost 
never could be reas properly resulting in flood of positioning errors.

While this may be Linux bug in read-ahead handling, this drive usually had the 
same problem under Windows (and even after I let it be replaced) so I guess 
it is firmware problem. Some of them are just beter than other :)

So I do not have drive that readily generates these errors anymore and cannot 
test this patch.

regards

-andrey
