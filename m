Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287337AbSAGXNO>; Mon, 7 Jan 2002 18:13:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287353AbSAGXM4>; Mon, 7 Jan 2002 18:12:56 -0500
Received: from odin.allegientsystems.com ([208.251.178.227]:50560 "EHLO
	lasn-001.allegientsystems.com") by vger.kernel.org with ESMTP
	id <S287342AbSAGXMe>; Mon, 7 Jan 2002 18:12:34 -0500
Message-ID: <3C3A2B5D.8070707@allegientsystems.com>
Date: Mon, 07 Jan 2002 18:12:29 -0500
From: Nathan Bryant <nbryant@allegientsystems.com>
Organization: Allegient Systems
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011226
X-Accept-Language: en-us
MIME-Version: 1.0
To: Thomas Gschwind <tom@infosys.tuwien.ac.at>,
        Doug Ledford <dledford@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: i810_audio
In-Reply-To: <20020105031329.B6158@infosys.tuwien.ac.at>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gschwind wrote:

>I have integrated the SiS patches into Doug's code.  Chances are that
>it works now also in combination with artsd.  Can anybody test this
>please?  And report your success (or failure)?  In case it does not
>work you might want to change the fragsize to dmabuf->userfragsize
>inside the i810_poll function (line 1596).  If I use
>dmabuf->userfragsize, however, I get loads of DMA buffer
>over/underruns in combination with xmms.  According to the sepc, I
>think dmabuf->fragsize should be as correct as dmabuf->userfragsize.
>I have not found and minimum available space requirement in the poll
>man page or the OSS documentation I have?
>
Can you elaborate a little more? What do the buffer underflow sound 
like, does it stop playing (silence) for a very short period and then 
start again, or does it write ahead too far and overrite data that's 
currently playing, causing garbled or repeated sound? Your email to me 
describing this scenario left me a little confused.

The former would indicate simple scheduling latency--nothing that can be 
done about that--and the latter might be a problem with i810_update_ptr 
or get_free_write_space in your implementation. I haven't looked at your 
code too much yet...

I assume you're using xmms with artsd. What is your artsd fragment size? 
(Click on kde control center, go to sound/sound server/sound i/o)

I assume you're using the artsd default of 4096, which is larger than 
the actual hardware chunk size of 2048. If your problem is nothing more 
than latency-induced underruns, perhaps it would make more sense to use 
MIN(userfragsize, fragsize) to determine the return status for 
i810_poll. Doug, do you have any thoughts?

A buffer overrun is not the same as an underflow, even when we're 
talking about a ring buffer ;)

>Fixes I applied except for the SiS integration:
>* drain_dac
>  Use interruptible_sleep_on_timeout instead of schedule_timeout.
>  I think this is cleaner.  Set the timeout to 
>  (dmabuf->count * HZ * 2) / (dmabuf->rate * 4)
>  since we play dmabuf->rate*4 bytes per second (16bit samples stereo).
>  Added stop_dac at the end.  Otherwise the system gets locked up sometimes. 
>
Some sort of fix in the drain_dac area is probably needed for the real 
Intel chips too; with 0.13 I was seeing a drain_dac: dma_timeout printk 
occasionally on my setup which I hadn't bothered to debug yet. Didn't 
hurt the machine and I figured it was maybe just dropped or latent 
interrupts, so I got lazy. ;)

>* i810_read, i810_write
>  Set the timeout to (dmabuf->size * HZ * 2) / (dmabuf->rate * 4)
>  since we record / play dmabuf->rate*4 bytes per second (16bit samples 
>  stereo).
>
Does this solve a problem for your SiS chip? i810_write seemed to be 
working fine on my setup. (Intel hardware.)

