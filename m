Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286215AbRL0FgG>; Thu, 27 Dec 2001 00:36:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286216AbRL0Ff5>; Thu, 27 Dec 2001 00:35:57 -0500
Received: from lacrosse.corp.redhat.com ([12.107.208.154]:20477 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S286215AbRL0Ffp>; Thu, 27 Dec 2001 00:35:45 -0500
Message-ID: <3C2AB32F.2010905@redhat.com>
Date: Thu, 27 Dec 2001 00:35:43 -0500
From: Doug Ledford <dledford@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6+) Gecko/20011217
X-Accept-Language: en-us
MIME-Version: 1.0
To: Nathan Bryant <nbryant@allegientsystems.com>
CC: saidani@info.unicaen.fr, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] TEST of patch proposed for i810 audio
In-Reply-To: <3C2A56C7.5050801@allegientsystems.com> <3C2A5F24.6090501@allegientsystems.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nathan Bryant wrote:

> Nathan Bryant wrote:
> 
>>
>> maybe this patch will solve your problem, samir, maybe it won't; 
>> regardless, it should fix at least one corner case and is either 
>> obviously correct or start_*c is not ;-)
>>
>> patch is against doug's 0.12.
> 
> 
> [snip]
> 
> attached is a slightly more anal retentive version of my previous patch. 
> as in the previous patch, the goal is to make update_lvi completely 
> self-contained, ie resistant to changes in higher-level code, ie not 
> deadlock even if somebody really sets it up with bad state, also 
> eliminates one if/then/else thinko in 0.12 that could theoretically 
> cause dac to be started when you're trying to record, which would cause 
> a deadlock.
> 
> 
> ------------------------------------------------------------------------
> 
> --- i810_audio.c.12	Wed Dec 19 02:04:06 2001
> +++ linux/drivers/sound/i810_audio.c	Wed Dec 26 18:22:37 2001
> @@ -952,12 +952,16 @@
>  	 * the CIV value to the next sg segment to be played so that when
>  	 * we call start_{dac,adc}, things will operate properly
>  	 */
> -	if (!dmabuf->enable && dmabuf->trigger) {
> -		if(rec && dmabuf->count != dmabuf->dmasize) {
> +	if (!dmabuf->enable && dmabuf->ready) {
> +		if(rec && dmabuf->count < dmabuf->dmasize &&
> +		   (dmabuf->trigger & PCM_ENABLE_INPUT))
> +		{
>  			outb((inb(port+OFF_CIV)+1)&31, port+OFF_LVI);
>  			__start_adc(state);
>  			while( !(inb(port + OFF_CR) & ((1<<4) | (1<<2))) ) ;
> -		} else if(dmabuf->count) {
> +		} else if (!rec && dmabuf->count &&
> +			   (dmabuf->trigger & PCM_ENABLE_OUTPUT))
> +		{
>  			outb((inb(port+OFF_CIV)+1)&31, port+OFF_LVI);
>  			__start_dac(state);
>  			while( !(inb(port + OFF_CR) & ((1<<4) | (1<<2))) ) ;
> 

This looks fine to me.  I've added it to my 0.12 driver, bumped the number 
to 0.13, put it up on my web site 
(http://people.redhat.com/dledford/i810_audio.c.gz) and if that solves 
people's problems then that's what I'll send to Marcello in a day or so.

Thanks Nathan, I've been to busy to look into it the last little bit :-(

-- 

  Doug Ledford <dledford@redhat.com>  http://people.redhat.com/dledford
       Please check my web site for aic7xxx updates/answers before
                       e-mailing me about problems

