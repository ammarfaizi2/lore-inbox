Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284669AbRLEUNg>; Wed, 5 Dec 2001 15:13:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284651AbRLEUK1>; Wed, 5 Dec 2001 15:10:27 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:44376 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S284645AbRLEUKG>; Wed, 5 Dec 2001 15:10:06 -0500
Message-ID: <3C0E7F1C.4060603@redhat.com>
Date: Wed, 05 Dec 2001 15:10:04 -0500
From: Doug Ledford <dledford@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6+) Gecko/20011129
X-Accept-Language: en-us
MIME-Version: 1.0
To: Nathan Bryant <nbryant@optonline.net>
CC: Mario Mikocevic <mozgy@hinet.hr>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: i810 audio patch
In-Reply-To: <3C0C16E7.70206@optonline.net> <3C0C508C.40407@redhat.com> <3C0C58DE.9020703@optonline.net> <3C0C5CB2.6000602@optonline.net> <3C0C61CC.1060703@redhat.com> <20011204153507.A842@danielle.hinet.hr> <3C0D1DD2.4040609@optonline.net> <3C0D223E.3020904@redhat.com> <3C0D350F.9010408@optonline.net> <3C0D3CF7.6030805@redhat.com> <3C0D4E62.4010904@optonline.net> <3C0D52F1.5020800@optonline.net> <3C0D5796.6080202@redhat.com> <3C0D5CB6.1080600@optonline.net> <3C0D5FC7.3040408@redhat.com> <3C0D77D9.70205@optonline.net> <3C0D8B00.2040603@optonline.net> <3C0D8F02.8010408@redhat.com> <3C0D9456.6090106@optonline.net> <3C0DA1CC.1070408@redhat.com> <3C0DAD26.1020906@optonline.net> <3C0DAF35.50008@redhat.com> <3C0E7DCB.6050600@optonline.net> <3C0E7DFB.2030400@optonline.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nathan Bryant wrote:

> Umm, duh, here's the actual patch. :-)
> 
> Nathan Bryant wrote:
> 
>> Doug Ledford wrote:
>>
>>> The attached patch should get me the debugging output I need to solve 
>>> the problem.  If you'll get me the output, then I can likely have a 
>>> working version in short order.
>>
>>
>>
>> Here is a fix. It is diffed against your original 0.08 version, Doug.
>>
>> It makes GETOPTR set the LVI to the hardware fragment preceding the 
>> one that's currently playing. In the case of Quake, that means Quake 
>> must call GETOPTR at least every 3/4ths of a DMA buffer. Hopefully 
>> that requirement should be relaxed enough. The alternate fix is to 
>> modify the completion handlers.
>>
>> I don't see anything obvious in the databook about how to make the 
>> hardware loop infinitely without taking any additional input from us.
>>
>> Comments, please.


If that fixes it, then the real fix is to find the bug in 
i810_get_free_Wwrite_space() and i810_update_lvi().  By using the first 
function to find the available data in the GETOPTR ioctl, then using 
update_lvi(), we *should* be setting the lvi fragment to exactly 31 sg 
segments away from the current index.  If that's failing, and we are 
instead setting lvi == civ, then things will stop and not work.


> 
> 
> 
> ------------------------------------------------------------------------
> 
> --- i810_audio.c.08	Tue Dec  4 19:43:21 2001
> +++ linux/drivers/sound/i810_audio.c	Wed Dec  5 14:52:28 2001
> @@ -197,7 +197,7 @@
>  #define INT_MASK (INT_SEC|INT_PRI|INT_MC|INT_PO|INT_PI|INT_MO|INT_NI|INT_GPI)
>  
>  
> -#define DRIVER_VERSION "0.07"
> +#define DRIVER_VERSION "0.08n"
>  
>  /* magic numbers to protect our data structures */
>  #define I810_CARD_MAGIC		0x5072696E /* "Prin" */
> @@ -1651,7 +1651,10 @@
>  #endif
>  		if (dmabuf->enable != DAC_RUNNING || file->f_flags & O_NONBLOCK)
>  			return 0;
> -		drain_dac(state, 0);
> +		if (!dmabuf->mapped)
> +			drain_dac(state, 0);
> +		else
> +			stop_dac(state);
>  		dmabuf->ready = 0;
>  		dmabuf->swptr = dmabuf->hwptr = 0;
>  		dmabuf->count = dmabuf->total_bytes = 0;
> @@ -1913,16 +1916,31 @@
>  		if (!dmabuf->ready && (val = prog_dmabuf(state, 0)) != 0)
>  			return val;
>  		spin_lock_irqsave(&state->card->lock, flags);
> -		val = i810_get_free_write_space(state);
> +		i810_update_ptr(state);
>  		cinfo.bytes = dmabuf->total_bytes;
>  		cinfo.ptr = dmabuf->hwptr;
> -		cinfo.blocks = val/dmabuf->userfragsize;
> +		/* blocks is only valid in mmap mode, according to API doc */
> +		cinfo.blocks = 0;
>  		if (dmabuf->mapped && (dmabuf->trigger & PCM_ENABLE_OUTPUT)) {
> -			dmabuf->count += val;
> -			dmabuf->swptr = (dmabuf->swptr + val) % dmabuf->dmasize;
> +			/* blocks is supposed to reset to 0 on every call to GETOPTR */
> +			/* hopefully nobody else destroys count so we can use it for this purpose
> +			   in mmap mode */
> +			cinfo.blocks = (dmabuf->dmasize - dmabuf->count - dmabuf->fragsize) /
> +				dmabuf->userfragsize;
> +			dmabuf->count = dmabuf->dmasize - dmabuf->fragsize;
> +			dmabuf->swptr = (dmabuf->dmasize + dmabuf->hwptr - dmabuf->fragsize) 
> +				% dmabuf->dmasize;
> +#ifdef DEBUG
> +			printk("SNDCTL_DSP_GETOPTR: calling __i810_update_lvi for swptr %d\n",
> +				dmabuf->swptr);
> +#endif
>  			__i810_update_lvi(state, 0);
> -			if (!dmabuf->enable)
> +			if (!dmabuf->enable) {
> +#ifdef DEBUG
> +				printk("SNDCTL_DSP_GETOPTR: calling __start_dac\n");
> +#endif
>  				__start_dac(state);
> +			}
>  		}
>  		spin_unlock_irqrestore(&state->card->lock, flags);
>  #ifdef DEBUG
> @@ -2324,7 +2342,12 @@
>  	/* stop DMA state machine and free DMA buffers/channels */
>  	if(dmabuf->enable & DAC_RUNNING ||
>  	   (dmabuf->count && (dmabuf->trigger & PCM_ENABLE_OUTPUT))) {
> -		drain_dac(state,0);
> +		if (!dmabuf->mapped)
> +			drain_dac(state,0);
> +		else {
> +			stop_dac(state);
> +			synchronize_irq();
> +		}
>  	}
>  	if(dmabuf->enable & ADC_RUNNING) {
>  		stop_adc(state);
> 



-- 

  Doug Ledford <dledford@redhat.com>  http://people.redhat.com/dledford
       Please check my web site for aic7xxx updates/answers before
                       e-mailing me about problems

