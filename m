Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284140AbRLRQMG>; Tue, 18 Dec 2001 11:12:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284141AbRLRQL5>; Tue, 18 Dec 2001 11:11:57 -0500
Received: from lacrosse.corp.redhat.com ([12.107.208.154]:54427 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S284140AbRLRQLq>; Tue, 18 Dec 2001 11:11:46 -0500
Message-ID: <3C1F6AC0.40604@redhat.com>
Date: Tue, 18 Dec 2001 11:11:44 -0500
From: Doug Ledford <dledford@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6+) Gecko/20011211
X-Accept-Language: en-us
MIME-Version: 1.0
To: Greg Pomerantz <gmp@alumni.brown.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: i810_audio mono troubles
In-Reply-To: <auto-000001925289@mx1.relaypoint.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Pomerantz wrote:

> +++ drivers/sound/i810_audio.c	Mon Dec 17 23:15:19 2001
> @@ -609,6 +609,9 @@
>  	
>  	new_rate = ac97_set_dac_rate(codec, rate);
>  
> +	if ((dmabuf->fmt & I810_FMT_STEREO) == 0)
> +		new_rate *= 2;
> +
>  	if(new_rate != rate) {
>  		dmabuf->rate = (new_rate * 48000)/clocking;
>  	}
> @@ -1687,6 +1690,12 @@
>  		if (dmabuf->enable & ADC_RUNNING) {
>  			stop_adc(state);
>  		}
> +
> +		if (*(int *)arg == 0)
> +			dmabuf->fmt &= ~I810_FMT_STEREO;
> +		else
> +			dmabuf->fmt |= I810_FMT_STEREO;
> +
>  		return put_user(1, (int *)arg);
>  
>  	case SNDCTL_DSP_GETBLKSIZE:


OK, first off, Alan & Co. will shoot this one down because handling 
stereo/mono conversion belongs in user space (the agreed upon way of 
handling things evidently).  Secondly, aside from that point, this is wrong 
anyway.  You are dividing the play rate in half to compensate for the fact 
that the sound is being sent to two channels instead of one.  So, now each 
channel is playing at half speed and slightly out of phase and with much 
reduced high frequency clarity.  Instead, what you should do, is byte double 
the stream (CPU consuming).  You would need to take any input buffer and 
copy every 16bit sample.  A very simple (and non-optimized) stereo converter 
  might look like this:

short *input=&input_buffer, *output=&output_buffer;
int i,j;

for(i=0, j=0;i < input_size;i++, j+=2)
	output[j] = output[j+1] = input[i];



-- 

  Doug Ledford <dledford@redhat.com>  http://people.redhat.com/dledford
       Please check my web site for aic7xxx updates/answers before
                       e-mailing me about problems

