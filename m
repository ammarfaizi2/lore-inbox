Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262672AbVCaAfB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262672AbVCaAfB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 19:35:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262691AbVCaAem
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 19:34:42 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:11478 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262498AbVCaAbN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 19:31:13 -0500
Message-ID: <424B44C3.4040804@pobox.com>
Date: Wed, 30 Mar 2005 19:30:59 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       dbrownell@users.sourceforge.net, Greg KH <greg@kroah.com>
Subject: Re: [PATCH] USB: usbnet uses netif_msg_*() ethtool filtering
References: <200503302319.j2UNJEBP019719@hera.kernel.org>
In-Reply-To: <200503302319.j2UNJEBP019719@hera.kernel.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux Kernel Mailing List wrote:
> ChangeSet 1.2181.4.72, 2005/03/24 15:31:29-08:00, david-b@pacbell.net
> 
> 	[PATCH] USB: usbnet uses netif_msg_*() ethtool filtering
> 	
> 	This converts most of the usbnet code to actually use the ethtool
> 	message flags.  The ASIX code is left untouched, since there are
> 	a bunch of patches pending there ... that's where the remaining
> 	handful of "sparse -Wbitwise" warnings come from.
> 	
> 	Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
> 	Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

It would be nice if people at least CC'd me on net driver patches.


> @@ -2886,18 +2885,21 @@
>  			defer_kevent (dev, EVENT_RX_MEMORY);
>  			break;
>  		case -ENODEV:
> -			devdbg (dev, "device gone");
> +			if (netif_msg_ifdown (dev))
> +				devdbg (dev, "device gone");
>  			netif_device_detach (dev->net);
>  			break;
>  		default:
> -			devdbg (dev, "rx submit, %d", retval);
> +			if (netif_msg_rx_err (dev))
> +				devdbg (dev, "rx submit, %d", retval);
>  			tasklet_schedule (&dev->bh);
>  			break;
>  		case 0:
>  			__skb_queue_tail (&dev->rxq, skb);
>  		}
>  	} else {
> -		devdbg (dev, "rx: stopped");
> +		if (netif_msg_ifdown (dev))
> +			devdbg (dev, "rx: stopped");
>  		retval = -ENOLINK;
>  	}
>  	spin_unlock_irqrestore (&dev->rxq.lock, lockflags);

netfi_msg_ifdown() is only for __interface__ up/down events; as such, 
there should be only one message of this type in dev->open(), and one 
message of this type in dev->stop().


> @@ -2963,9 +2967,8 @@
>  	    // software-driven interface shutdown
>  	    case -ECONNRESET:		// async unlink
>  	    case -ESHUTDOWN:		// hardware gone
> -#ifdef	VERBOSE
> -		devdbg (dev, "rx shutdown, code %d", urb_status);
> -#endif
> +		if (netif_msg_ifdown (dev))
> +			devdbg (dev, "rx shutdown, code %d", urb_status);
>  		goto block;
>  
>  	    // we get controller i/o faults during khubd disconnect() delays.

ditto


> @@ -3026,9 +3030,8 @@
>  	    /* software-driven interface shutdown */
>  	    case -ENOENT:		// urb killed
>  	    case -ESHUTDOWN:		// hardware gone
> -#ifdef	VERBOSE
> -		devdbg (dev, "intr shutdown, code %d", status);
> -#endif
> +		if (netif_msg_ifdown (dev))
> +			devdbg (dev, "intr shutdown, code %d", status);
>  		return;
>  
>  	    /* NOTE:  not throttling like RX/TX, since this endpoint

ditto


> @@ -3044,7 +3047,7 @@
>  
>  	memset(urb->transfer_buffer, 0, urb->transfer_buffer_length);
>  	status = usb_submit_urb (urb, GFP_ATOMIC);
> -	if (status != 0)
> +	if (status != 0 && netif_msg_timer (dev))
>  		deverr(dev, "intr resubmit --> %d", status);
>  }
>  

this looks more like a debugging message?


> @@ -3094,7 +3097,7 @@
>  
>  	netif_stop_queue (net);
>  
> -	if (dev->msg_level >= 2)
> +	if (netif_msg_ifdown (dev))
>  		devinfo (dev, "stop stats: rx/tx %ld/%ld, errs %ld/%ld",
>  			dev->stats.rx_packets, dev->stats.tx_packets, 
>  			dev->stats.rx_errors, dev->stats.tx_errors

see -- this one is actually OK


> @@ -3110,7 +3113,8 @@
>  			&& skb_queue_len (&dev->txq)
>  			&& skb_queue_len (&dev->done)) {
>  		msleep(UNLINK_TIMEOUT_MS);
> -		devdbg (dev, "waited for %d urb completions", temp);
> +		if (netif_msg_ifdown (dev))
> +			devdbg (dev, "waited for %d urb completions", temp);
>  	}
>  	dev->wait = NULL;
>  	remove_wait_queue (&unlink_wakeup, &wait); 

not OK


> @@ -3142,16 +3146,19 @@
>  
>  	// put into "known safe" state
>  	if (info->reset && (retval = info->reset (dev)) < 0) {
> -		devinfo (dev, "open reset fail (%d) usbnet usb-%s-%s, %s",
> -			retval,
> -			dev->udev->bus->bus_name, dev->udev->devpath,
> +		if (netif_msg_ifup (dev))
> +			devinfo (dev,
> +				"open reset fail (%d) usbnet usb-%s-%s, %s",
> +				retval,
> +				dev->udev->bus->bus_name, dev->udev->devpath,
>  			info->description);
>  		goto done;
>  	}
>  
>  	// insist peer be connected
>  	if (info->check_connect && (retval = info->check_connect (dev)) < 0) {
> -		devdbg (dev, "can't open; %d", retval);
> +		if (netif_msg_ifup (dev))
> +			devdbg (dev, "can't open; %d", retval);
>  		goto done;
>  	}
>  

not OK


> @@ -3159,13 +3166,14 @@
>  	if (dev->interrupt) {
>  		retval = usb_submit_urb (dev->interrupt, GFP_KERNEL);
>  		if (retval < 0) {
> -			deverr (dev, "intr submit %d", retval);
> +			if (netif_msg_ifup (dev))
> +				deverr (dev, "intr submit %d", retval);
>  			goto done;
>  		}
>  	}
>  
>  	netif_start_queue (net);
> -	if (dev->msg_level >= 2) {
> +	if (netif_msg_ifup (dev)) {
>  		char	*framing;
>  
>  		if (dev->driver_info->flags & FLAG_FRAMING_NC)

not OK


> @@ -3526,7 +3541,7 @@
>  				if (urb != NULL)
>  					rx_submit (dev, urb, GFP_ATOMIC);
>  			}
> -			if (temp != dev->rxq.qlen)
> +			if (temp != dev->rxq.qlen && netif_msg_link (dev))
>  				devdbg (dev, "rxqlen %d --> %d",
>  						temp, dev->rxq.qlen);
>  			if (dev->rxq.qlen < qlen)

highly questionable.

