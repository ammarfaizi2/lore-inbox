Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264928AbRFUIIz>; Thu, 21 Jun 2001 04:08:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264929AbRFUIIp>; Thu, 21 Jun 2001 04:08:45 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:36257 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id <S264928AbRFUIIc>; Thu, 21 Jun 2001 04:08:32 -0400
Date: Thu, 21 Jun 2001 17:08:24 +0900
Message-ID: <66dq45mv.wl@nisaaru.open.nm.fujitsu.co.jp>
From: Tachino Nobuhiro <tachino@open.nm.fujitsu.co.jp>
To: Trevor-Hemsley@dial.pipex.com (Trevor Hemsley)
Cc: linux-kernel@vger.kernel.org
Subject: Re: aic7xxx oops with 2.4.5-ac13
In-Reply-To: <20010621072142Z264883-17720+6265@vger.kernel.org>
In-Reply-To: <20010621072142Z264883-17720+6265@vger.kernel.org>
User-Agent: Wanderlust/2.5.8 (Smooth) EMY/1.13.9 (Art is long, life is
 short) SLIM/1.14.7 (=?ISO-2022-JP?B?GyRCPHIwZjpMTD4bKEI=?=) APEL/10.3 MULE
 XEmacs/21.2 (beta46) (Urania) (i386-kondara-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

At Thu, 21 Jun 2001 08:15:10,
Trevor Hemsley wrote:
> 
> On Thu, 21 Jun 2001 03:05:02, "Jeff V. Merkey" 
> <jmerkey@vger.timpanogas.org> wrote:
> 
> > Ditto.  I am also seeing this oops calling the sg driver for a 
> > robotic tape library, and it also seems to happen on 2.4.4.
> 
> In my case it appears that it was the symptom of severe bus problems. 
> About 5 minutes after I posted the initial report I discovered that 
> the cable from the back of the Nikon to the MO drive had fallen off so
> the bus was running unterminated. Replugging it fixed teh bus error 
> and the oops. 
> 
> Looks like error handling is all fscked up...
> 

  I saw this oops too. The following patch is working for me, but I don't
know this is a correct fix.


diff -r -N -u linux.org/drivers/scsi/aic7xxx/aic7xxx_linux.c linux/drivers/scsi/aic7xxx/aic7xxx_linux.c
--- linux.org/drivers/scsi/aic7xxx/aic7xxx_linux.c	Fri Mar 16 13:47:01 2001
+++ linux/drivers/scsi/aic7xxx/aic7xxx_linux.c	Fri Mar 16 13:54:34 2001
@@ -1872,7 +1872,9 @@
 		break;
         case AC_BUS_RESET:
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(2,3,0)
-		scsi_report_bus_reset(ahc->platform_data->host, channel - 'A');
+		if (ahc->platform_data->host) {
+			scsi_report_bus_reset(ahc->platform_data->host, channel - 'A');
+		}
 #endif
                 break;
         default:
