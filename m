Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289887AbSBOQBK>; Fri, 15 Feb 2002 11:01:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289880AbSBOQA7>; Fri, 15 Feb 2002 11:00:59 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:27662 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S289887AbSBOQAx>;
	Fri, 15 Feb 2002 11:00:53 -0500
Date: Fri, 15 Feb 2002 07:56:36 -0800
From: Greg KH <greg@kroah.com>
To: Pierre Rousselet <pierre.rousselet@wanadoo.fr>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-usb-devel@lists.sourceforge.net
Subject: Re: 2.5.5-pre1 rmmod usb-uhci hangs
Message-ID: <20020215155636.GB1695@kroah.com>
In-Reply-To: <3C6D2130.1020103@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C6D2130.1020103@wanadoo.fr>
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Fri, 18 Jan 2002 13:35:02 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2002 at 03:54:40PM +0100, Pierre Rousselet wrote:
> with 2.5.5-pre1 usb-uhci module can't unload. rmmod hangs, leaving the 
> system unstable. in one circumstance the box freezed with an oops 
> involving swapper pid0 . this doesn't happen with 2.5.4

Try this (untested, I haven't rebooted yet) patch:

thanks,

greg k-h


diff -Nru a/drivers/usb/usb.c b/drivers/usb/usb.c
--- a/drivers/usb/usb.c	Thu Feb 14 22:47:21 2002
+++ b/drivers/usb/usb.c	Thu Feb 14 22:47:21 2002
@@ -1979,11 +1979,11 @@
 				if (driver->owner)
 					__MOD_DEC_USE_COUNT(driver->owner);
 				/* if driver->disconnect didn't release the interface */
-				if (interface->driver) {
-					put_device (&interface->dev);
+				if (interface->driver)
 					usb_driver_release_interface(driver, interface);
-				}
 			}
+			/* remove our device node for this interface */
+			put_device(&interface->dev);
 		}
 	}
 
