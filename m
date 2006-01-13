Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422804AbWAMS1c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422804AbWAMS1c (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 13:27:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422805AbWAMS1c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 13:27:32 -0500
Received: from uproxy.gmail.com ([66.249.92.200]:33417 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1422804AbWAMS1b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 13:27:31 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=dSwmrKES3azGrjGHgV2jomwEx5jfVDteWhEShlnmQBi3XJ4dNJqMCIvX/kuX+ChiTiZQdCyZGxlo1+jZ11pB18RDwRQ5/OlXYYRGP0V+0Ct+zPMLLZI3TEGRb7DaKOiYHYXR8iqw+Sa+XDo2+FGKo0aaRks2S9zxgDZe80Wj/d0=
Date: Fri, 13 Jan 2006 21:44:41 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: matthieu castet <castet.matthieu@free.fr>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org, usbatm@lists.infradead.org,
       linux-usb-devel@lists.sourceforge.net, ueagle <ueagleatm-dev@gna.org>
Subject: Re: [PATCH] UEAGLE : add iso support and commestic stuff
Message-ID: <20060113184441.GA7951@mipter.zuzino.mipt.ru>
References: <43C7E8A2.1000605@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43C7E8A2.1000605@free.fr>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2006 at 06:51:30PM +0100, matthieu castet wrote:
> this patch mainly adds the support for isochronous pipe.
> There are also some cosmetic stuff (please tell me if you want them in a
> extra patch).

This patch should be shrinked by >50% by dropping unrelated changes.
It'd make it much easier to read.

> --- Linux.orig/drivers/usb/atm/ueagle-atm.c
> +++ Linux/drivers/usb/atm/ueagle-atm.c
> @@ -628,8 +631,7 @@
>  			dsp_name = FW_DIR "DSPep.bin";
>  	}
>  
> -	ret = request_firmware(&sc->dsp_firm,
> -				dsp_name, &sc->usb_dev->dev);
> +	ret = request_firmware(&sc->dsp_firm, dsp_name, &sc->usb_dev->dev);
>  	if (ret < 0) {
>  		uea_err(INS_TO_USBDEV(sc),
>  		       "requesting firmware %s failed with error %d\n",
> @@ -744,7 +746,6 @@
>  		return ret;
>  
>  	return (ret == 0) ? -ETIMEDOUT : 0;
> -
>  }
>  
>  #define UCDC_SEND_ENCAPSULATED_COMMAND 0x00
> @@ -1184,8 +1186,7 @@
>  		}
>  	}
>  
> -	/* finish to send the fpga
> -	 */
> +	/* finish to send the fpga */
>  	ret = uea_request(sc, 0xe, 1, 0, NULL);
>  	if (ret < 0) {
>  		uea_err(INS_TO_USBDEV(sc),
> @@ -1193,9 +1194,7 @@
>  		goto err1;
>  	}
>  
> -	/*
> -	 * Tell the modem we finish : de-assert reset
> -	 */
> +	/* Tell the modem we finish : de-assert reset */
>  	value = 0;
>  	ret = uea_send_modem_cmd(sc->usb_dev, 0xe, 1, &value);
>  	if (ret < 0)
> @@ -1268,23 +1268,19 @@
>   */
>  static void uea_intr(struct urb *urb, struct pt_regs *regs)
>  {
> -	struct uea_softc *sc = (struct uea_softc *)urb->context;
> -	struct intr_pkt *intr;
> +	struct uea_softc *sc = urb->context;
> +	struct intr_pkt *intr = urb->transfer_buffer;
>  	uea_enters(INS_TO_USBDEV(sc));
>  
> -	if (urb->status < 0) {
> +	if (unlikely(urb->status < 0)) {
>  		uea_err(INS_TO_USBDEV(sc), "uea_intr() failed with %d\n",
>  		       urb->status);
>  		return;
>  	}
>  
> -	intr = (struct intr_pkt *) urb->transfer_buffer;
> -
>  	/* device-to-host interrupt */
>  	if (intr->bType != 0x08 || sc->booting) {
> -		uea_err(INS_TO_USBDEV(sc), "wrong intr\n");
> -		// rebooting ?
> -		// sc->reset = 1;
> +		uea_err(INS_TO_USBDEV(sc), "wrong interrupt\n");
>  		goto resubmit;
>  	}
>  
> @@ -1300,7 +1296,7 @@
>  		break;
>  
>  	default:
> -		uea_err(INS_TO_USBDEV(sc), "unknown intr %u\n",
> +		uea_err(INS_TO_USBDEV(sc), "unknown interrupt %u\n",
>  		       le16_to_cpu(intr->wInterrupt));
>  	}
>  
> @@ -1379,7 +1375,7 @@
>  	int ret;
>  	uea_enters(INS_TO_USBDEV(sc));
>  	ret = kthread_stop(sc->kthread);
> -	uea_info(INS_TO_USBDEV(sc), "kthread finish with status %d\n", ret);
> +	uea_dbg(INS_TO_USBDEV(sc), "kthread finish with status %d\n", ret);
>  
>  	/* stop any pending boot process */
>  	flush_scheduled_work();
> @@ -1636,9 +1632,7 @@
>  	if (ret < 0)
>  		return ret;
>  
> -	/* ADI930 has only 2 interfaces and inbound traffic
> -	 * is on interface 1
> -	 */
> +	/* ADI930 has only 2 interfaces and inbound traffic is on interface 1 */
>  	if (UEA_CHIP_VERSION(id) != ADI930) {
>  		/* interface 2 is for inbound traffic */
>  		ret = claim_interface(usb, usbatm, UEA_DS_IFACE_NO);

