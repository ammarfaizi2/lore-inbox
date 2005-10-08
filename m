Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932085AbVJHMSW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932085AbVJHMSW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Oct 2005 08:18:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932087AbVJHMSW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Oct 2005 08:18:22 -0400
Received: from wproxy.gmail.com ([64.233.184.196]:11125 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932085AbVJHMSV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Oct 2005 08:18:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=WBY+Zc51RkE1SRbfW4vXQ5mj2f9mBEs8R2qTzv2HoXZiKp68FziMAmcRpOPqZBYtRcHxlsY1EJ0QuyWzqs0e+fo2lQ5kBElXIg/S3tMgF31goGArBOEOQdu7UBXZrKu4DxckpaC9mpMYQafvq84CTGEmUMP1sGYEnSLOoT5XNyg=
Message-ID: <253000f70510080518m15e2613do@mail.gmail.com>
Date: Sat, 8 Oct 2005 14:18:20 +0200
From: Igor Popik <igor.popik@gmail.com>
To: sasa.ostrouska@volja.net
Subject: Re: oops in 2.6.14-rc3 (pcmcia i82365 patch)
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2005/10/8, Sasa Ostrouska <sasa.ostrouska@volja.net>:
> Hi ppl,
>
>         After some playing with my new slackware 10.2 and
> kernel 2.6.14-rc3 I noted this oops when shutting down the machine.
> Can somebody tell me why ?

This may be caused by bug in i83265 pcmcia module which seems not to
have one release_region() call. It reserves region during init and
does not release it when it fails to probe for the hardware.

That driver is loaded in rc.pcmcia script during boot and usually
fails to load because You do not have such hardware (the script probes
for different pcmcia drivers).

During shutdown one of the shutdown scripts greps through
/proc/ioports file which causes an oops (reserverd region name points
to unloaded driver).

Attached patch is my second attempt to fix this bug :-)

Cheers,
Igor

Signed-off-by: Igor Popik <igor.popik at gmail.com>

--- a/drivers/pcmcia/i82365.c   2005-10-06 20:30:52.000000000 +0200
+++ b/drivers/pcmcia/i82365.c   2005-10-06 20:05:46.000000000 +0200
@@ -1383,6 +1383,7 @@
        printk("not found.\n");
        platform_device_unregister(&i82365_device);
        driver_unregister(&i82365_driver);
+       release_region(i365_base, 2);
        return -ENODEV;
     }
