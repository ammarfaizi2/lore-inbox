Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272285AbRHXSFR>; Fri, 24 Aug 2001 14:05:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272286AbRHXSFJ>; Fri, 24 Aug 2001 14:05:09 -0400
Received: from quattro.sventech.com ([205.252.248.110]:2571 "HELO
	quattro.sventech.com") by vger.kernel.org with SMTP
	id <S272285AbRHXSEw>; Fri, 24 Aug 2001 14:04:52 -0400
Date: Fri, 24 Aug 2001 14:05:08 -0400
From: Johannes Erdfelt <johannes@erdfelt.com>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: alan@lxorguk.ukuu.org.uk, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: usb not working with 2.4.8-ac8
Message-ID: <20010824140508.E4961@sventech.com>
In-Reply-To: <mailman.998431141.21252.linux-kernel2news@redhat.com> <200108220004.f7M04Qx01206@devserv.devel.redhat.com> <3B8355D9.7DE64E38@home.com> <20010822165853.A24726@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20010822165853.A24726@devserv.devel.redhat.com>; from zaitcev@redhat.com on Wed, Aug 22, 2001 at 04:58:53PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 22, 2001, Pete Zaitcev <zaitcev@redhat.com> wrote:
> The usb-uhci and ohci worked fine, so I poked uhci a little bit
> and made it all work, at least with my setup. Apparently,
> sometimes uhci returns a success (0) from submit_urb, but
> forgets to deliver a completion callback.
> 
> The fix is a Johannes' territory and I not so sure of my way there,
> so perhaps a better one may be forthcoming.

Forgets may or may not be true. Success (0) from submit_urb only means
the URB was scheduled.

You may not receive a completion callback if the device NAK's the
transfer forever, or if there is a bug in uhci.c where the URB didn't
really get scheduled.

What was you test scenario where you didn't see a completion callback?

> diff -ur -X dontdiff linux-2.4.8-ac9/drivers/usb/uhci.c linux-2.4.8-ac9-niph/drivers/usb/uhci.c
> --- linux-2.4.8-ac9/drivers/usb/uhci.c	Wed Aug 22 11:01:57 2001
> +++ linux-2.4.8-ac9-niph/drivers/usb/uhci.c	Wed Aug 22 13:25:00 2001
> @@ -1471,6 +1471,7 @@
>  
>  static int uhci_submit_urb(struct urb *urb)
>  {
> +	struct usb_device *dev;
>  	int ret = -EINVAL;
>  	struct uhci *uhci;
>  	unsigned long flags;
> @@ -1480,15 +1481,16 @@
>  	if (!urb)
>  		return -EINVAL;
>  
> -	if (!urb->dev || !urb->dev->bus || !urb->dev->bus->hcpriv) {
> +	dev = urb->dev;
> +	if (!dev || !dev->bus || !dev->bus->hcpriv) {
>  		warn("uhci_submit_urb: urb %p belongs to disconnected device or bus?", urb);
>  		return -ENODEV;
>  	}
>  
> -	uhci = (struct uhci *)urb->dev->bus->hcpriv;
> +	uhci = (struct uhci *)dev->bus->hcpriv;
>  
>  	INIT_LIST_HEAD(&urb->urb_list);
> -	usb_inc_dev_use(urb->dev);
> +	usb_inc_dev_use(dev);
>  
>  	spin_lock_irqsave(&urb->lock, flags);
>  
> @@ -1497,7 +1499,7 @@
>  		dbg("uhci_submit_urb: urb not available to submit (status = %d)", urb->status);
>  		/* Since we can have problems on the out path */
>  		spin_unlock_irqrestore(&urb->lock, flags);
> -		usb_dec_dev_use(urb->dev);
> +		usb_dec_dev_use(dev);
>  
>  		return ret;
>  	}
> @@ -1516,7 +1518,7 @@
>  	}
>  
>  	/* Short circuit the virtual root hub */
> -	if (urb->dev == uhci->rh.dev) {
> +	if (dev == uhci->rh.dev) {
>  		ret = rh_submit_urb(urb);
>  
>  		goto out;
> @@ -1528,13 +1530,13 @@
>  		break;
>  	case PIPE_INTERRUPT:
>  		if (urb->bandwidth == 0) {	/* not yet checked/allocated */
> -			bustime = usb_check_bandwidth(urb->dev, urb);
> +			bustime = usb_check_bandwidth(dev, urb);
>  			if (bustime < 0)
>  				ret = bustime;
>  			else {
>  				ret = uhci_submit_interrupt(urb);
>  				if (ret == -EINPROGRESS)
> -					usb_claim_bandwidth(urb->dev, urb, bustime, 0);
> +					usb_claim_bandwidth(dev, urb, bustime, 0);
>  			}
>  		} else		/* bandwidth is already set */
>  			ret = uhci_submit_interrupt(urb);
> @@ -1548,7 +1550,7 @@
>  				ret = -EINVAL;
>  				break;
>  			}
> -			bustime = usb_check_bandwidth(urb->dev, urb);
> +			bustime = usb_check_bandwidth(dev, urb);
>  			if (bustime < 0) {
>  				ret = bustime;
>  				break;
> @@ -1556,7 +1558,7 @@
>  
>  			ret = uhci_submit_isochronous(urb);
>  			if (ret == -EINPROGRESS)
> -				usb_claim_bandwidth(urb->dev, urb, bustime, 1);
> +				usb_claim_bandwidth(dev, urb, bustime, 1);
>  		} else		/* bandwidth is already set */
>  			ret = uhci_submit_isochronous(urb);
>  		break;
> @@ -1578,8 +1580,14 @@
>  
>  	uhci_unlink_generic(uhci, urb);
>  	uhci_destroy_urb_priv(urb);
> +	if (ret == 0) {				/* N.B. Done, must notify */
> +		/* uhci_call_completion(urb); */ /* ->> uhci_destroy_urb_priv */
> +		urb->dev = NULL;
> +		if (urb->complete)
> +			urb->complete(urb);
> +	}
>  
> -	usb_dec_dev_use(urb->dev);
> +	usb_dec_dev_use(dev);
>  
>  	return ret;
>  }

What's all of this for? Protecting against an urb->dev race condition?

JE

