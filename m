Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262013AbVCaGTJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262013AbVCaGTJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 01:19:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262480AbVCaGTJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 01:19:09 -0500
Received: from redpine-92-161-hyd.redpinesignals.com ([203.196.161.92]:55193
	"EHLO redpinesignals.com") by vger.kernel.org with ESMTP
	id S262013AbVCaGS7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 01:18:59 -0500
Message-ID: <424B991C.5040109@redpinesignals.com>
Date: Thu, 31 Mar 2005 12:00:52 +0530
From: P Lavin <lavin.p@redpinesignals.com>
Reply-To: lavin.p@redpinesignals.com
Organization: www.redpinesignals.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: no need to check for NULL before calling kfree() -fs/ext2/
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Jesper,
I'm sending this mail to mailing list coz in my company we have some
restrictions on o/g mails, Sorry for that...
Lemme ask u smthing, herez the code
     199     sndpkt = (RSI_sndpkt_t *) RSI_MALLOC(sizeof(RSI_sndpkt_t));
     200     sndpkt->buf_list = (RSI_buf_t *) RSI_MALLOC(sizeof(RSI_buf_t));
Here if malloc fails sndpkt->buf_list should be null right ?? & if i
proceed further ..

     201     sndpkt->buf_list->start_addr = buf;
     202     sndpkt->buf_list->length     = length;
Here itself this should crash right ?? But its not crashing here !!! Wt
was happening was

201 sndpkt->buf_list->start_addr = buf; was not getting initailised & wn
we try to access this variable latter
this was crashing.

Actally i'm not checking for return value from kmalloc thatz a mistake,
I'll fix this but why is it not crashing in line # 201 ??

Jesper Juhl wrote:

>On Wed, 30 Mar 2005, P Lavin wrote:
>
>  
>
>>Date: Wed, 30 Mar 2005 12:45:01 +0530
>>From: P Lavin <lavin.p@redpinesignals.com>
>>To: linux-kernel@vger.kernel.org
>>Subject: Re: no need to check for NULL before calling kfree() -fs/ext2/
>>
>>Hi,
>>In my wlan driver module, i allocated some memory using kmalloc in interrupt
>>context, this one failed but its not returning NULL , 
>>    
>>
>
>kmalloc() should always return NULL if the allocation failed.
>
>
>  
>
>>so i was proceeding
>>further everything was going wrong... & finally the kernel crahed. Can any one
>>of you tell me why this is happening ? i cannot use GFP_KERNEL because i'm
>>calling this function from interrupt context & it may block. Any other
>>    
>>
>
>If you need to allocate memory from interrupt context you should be using 
>GFP_ATOMIC (or, if possible, do the allocation earlier in a different 
>context).
>
>
>  
>
I'm using this flag only, this flag does not guarentee mem allocation,
right ??

>>solution for this ?? I'm concerned abt why kmalloc is not returning null if
>>its not a success ??
>>
>>    
>>
>I have no explanation for that, are you sure that's really what's 
>happening?
>
>
>  
>
I'm not checking this , but my explanation is given above.

>>Is it not necessary to check for NULL before calling kfree() ??
>>    
>>
>
>No, it is not nessesary to check for NULL before calling kfree() since 
>kfree() does    
>
>void kfree (const void *objp)
>{
>	... 
>        if (!objp)
>                return;
>	...
>}
>
>So, if you pass kfree() a NULL pointer it deals with it itself, you don't 
>need to check that explicitly before calling kfree() - that's redundant.
>
>
>  
>

Regs,
Lavin
