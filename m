Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290356AbSBORxG>; Fri, 15 Feb 2002 12:53:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290361AbSBORxA>; Fri, 15 Feb 2002 12:53:00 -0500
Received: from smtp-out-1.wanadoo.fr ([193.252.19.188]:52118 "EHLO
	mel-rto1.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S290356AbSBORwo>; Fri, 15 Feb 2002 12:52:44 -0500
Message-ID: <3C6D4A58.6070401@wanadoo.fr>
Date: Fri, 15 Feb 2002 18:50:16 +0100
From: Pierre Rousselet <pierre.rousselet@wanadoo.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: lkml <linux-kernel@vger.kernel.org>, linux-usb-devel@lists.sourceforge.net
Subject: Re: 2.5.5-pre1 rmmod usb-uhci hangs
In-Reply-To: <3C6D2130.1020103@wanadoo.fr> <20020215155636.GB1695@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Fri, Feb 15, 2002 at 03:54:40PM +0100, Pierre Rousselet wrote:
> 
>>with 2.5.5-pre1 usb-uhci module can't unload. rmmod hangs, leaving the 
>>system unstable. in one circumstance the box freezed with an oops 
>>involving swapper pid0 . this doesn't happen with 2.5.4
>>
> 
> Try this (untested, I haven't rebooted yet) patch:
> 
> thanks,
> 
> greg k-h
> 
> 
> diff -Nru a/drivers/usb/usb.c b/drivers/usb/usb.c
> --- a/drivers/usb/usb.c	Thu Feb 14 22:47:21 2002
> +++ b/drivers/usb/usb.c	Thu Feb 14 22:47:21 2002
> @@ -1979,11 +1979,11 @@
>  				if (driver->owner)
>  					__MOD_DEC_USE_COUNT(driver->owner);
>  				/* if driver->disconnect didn't release the interface */
> -				if (interface->driver) {
> -					put_device (&interface->dev);
> +				if (interface->driver)
>  					usb_driver_release_interface(driver, interface);
> -				}
>  			}
> +			/* remove our device node for this interface */
> +			put_device(&interface->dev);
>  		}
>  	}
>  
> 
> 
no, it doesn't solve the problem. i would like to test it whith 
preemtible kernel not set but it doesn't boot.

with both 2.5.4 and 2.5.5-pre1 when loading usb-uhci usb.c reports 2 
devices :
device 1 : USB UHCI Root Hub
device 2 : Alcatel Speed Touch USB (the driver module and firmware are 
not loaded at this stage)

when rmmoding usb-uhci with 2.5.4 usb.c reports:
usb.c: USB disconnect on device 1
usb.c: USB disconnect on device 2

with 2.5.5-pre1
usb.c: USB disconnect on device 1
  and nothing else.
Pierre
-- 
------------------------------------------------
  Pierre Rousselet <pierre.rousselet@wanadoo.fr>
------------------------------------------------

