Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262123AbTHGRkh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 13:40:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267317AbTHGRkh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 13:40:37 -0400
Received: from dm2-82.slc.aros.net ([66.219.220.82]:58250 "EHLO cyprus")
	by vger.kernel.org with ESMTP id S262123AbTHGRke (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 13:40:34 -0400
Message-ID: <3F328F0F.4050902@aros.net>
Date: Thu, 07 Aug 2003 11:40:31 -0600
From: Lou Langholtz <ldl@aros.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paul.Clements@steeleye.com
Cc: Bernd Schubert <bernd.schubert@pci.uni-heidelberg.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.4.21]: nbd ksymoops-report
References: <Pine.LNX.4.10.10308071245130.13289-100000@clements.sc.steeleye.com>
In-Reply-To: <Pine.LNX.4.10.10308071245130.13289-100000@clements.sc.steeleye.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Clements wrote:

>On Thu, 7 Aug 2003, Bernd Schubert wrote:
>
>  
>
>>every time when nbd-client disconnects a nbd-device the decoded oops 
>>from below will happen. 
>>This only happens after we upgraded from 2.4.20 to 2.4.21, 
>>so I guess the backported update from 2.5.50 causes this. 
>>    
>>
>
>Yes, it's definitely related to this...
>
>
>  
>
>>Aug  6 17:24:31 goedel kernel: Process nbd-client (pid: 650, stackpage=d61a5000)
>>    
>>
>
>Are you using the v2.0 nbd-client from nbd.sf.net?
>
>
>  
>
>>Code;  d89e2be7 <[nbd]nbd_ioctl+353/480>
>>00000000 <_EIP>:
>>Code;  d89e2be7 <[nbd]nbd_ioctl+353/480>   <=====
>>   0:   8b 50 08                  mov    0x8(%eax),%edx   <=====
>>Code;  d89e2bea <[nbd]nbd_ioctl+356/480>
>>   3:   6a 03                     push   $0x3
>>Code;  d89e2bec <[nbd]nbd_ioctl+358/480>
>>   5:   50                        push   %eax
>>Code;  d89e2bed <[nbd]nbd_ioctl+359/480>
>>   6:   8b 42 28                  mov    0x28(%edx),%eax
>>Code;  d89e2bf0 <[nbd]nbd_ioctl+35c/480>
>>   9:   ff d0                     call   *%eax
>>    
>>
>
>
>This corresponds to the following source:
>
>lo->sock->ops->shutdown(lo->sock, SEND_SHUTDOWN|RCV_SHUTDOWN);
>
>Somehow, lo->sock is NULL here. The only way I see that this could
>happen is if NBD_CLEAR_SOCK got called out of order (or you're 
>using some non-standard nbd-client).
>
The out-of-order problem is due to "nbd-client -d" (the disconnect 
thread) winning a race with "nbd-client" and setting sock = NULL after 
nbd_do_it returned and before NBD_DO_IT gets into its down'd region and 
calls shutdown. This was the hazardous race that I was having a hard 
time remembering and explaining before that also needed locking for.

