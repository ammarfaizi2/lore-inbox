Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265588AbSJXSDH>; Thu, 24 Oct 2002 14:03:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265589AbSJXSDG>; Thu, 24 Oct 2002 14:03:06 -0400
Received: from fw-az.mvista.com ([65.200.49.158]:45305 "EHLO
	zipcode.az.mvista.com") by vger.kernel.org with ESMTP
	id <S265588AbSJXSDF>; Thu, 24 Oct 2002 14:03:05 -0400
Message-ID: <3DB837FE.8080100@mvista.com>
Date: Thu, 24 Oct 2002 11:12:14 -0700
From: Steven Dake <sdake@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: andersen@codepoet.org
CC: greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Advanced TCA SCSI/FC disk hotswap driver for kernel 2.5.44
References: <3DB7304A.3030903@mvista.com> <20021024042838.GA30891@codepoet.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik,


Erik Andersen wrote:

>On Wed Oct 23, 2002 at 04:27:06PM -0700, Steven Dake wrote:
>  
>
>>lkml,
>>
>>Attached is an update of the Advanced TCA disk hotswap driver to provide 
>>disk hotswap
>>support for the Linux Kernel 2.5.43.  Hotswap targets include both SCSI 
>>and FibreChannel.
>>    
>>
>
>This looks (in parts) similar to the patch I made to make 1394
>hotswapping work correctly.
>    http://codepoet.org/scsi_add_remove_single.patch
>The patch is vs 2.4, but you get the idea.  Anyway, I think it 
>would make more sense for you to fixup proc_scsi_gen_write() to
>make the old hotswap interface (you know the 
>    echo "scsi add-single-device 0 1 2 3" >/proc/scsi/scsi
>    echo "scsi remove-single-device 0 1 2 3" >/proc/scsi/scsi
>  
>
I wanted to seperate the hotswap functionality from the main scsi code. 
 I also feel
that hotswap shouldn't be a function of proc.  Also, the patch I 
supplied supports
fibrechannel hotswap as well.  Your patch looks pretty good and I plan 
to change
the proc_scsi_gen_write() to use the scsi hotswap commands in hotswap.c. 
 The
advantage of this technique is that the HBA_ptr doesn't have to be known 
(and
this generic code can go in the actual routine instead of the proc 
parsing routine).
The final advantage of having seperate comands is less time is spent 
passing and
parsing text data.  Plus my patch provides usage information for those 
that don't
or can't read the source code to understand the interface :)

As far as I'm concerned, I'd be happy to entirely remove the 
proc_scsi_gen_write
code, but I think that might confuse some people.

As for the interfaces stomping each other, I've added correct locking to 
proc_scsi_gen_write()
to ensure that the host_queue is locked during access so changes to it 
cannot occur
during hotswap operations.  This keeps a scsi_device entry from being 
deleted while
the list is being parsed, resulting in bad magic.

>one) and make it use your new hotswap code.  Otherwise the two
>interfaces could easily stomp on each other and hose up the
>kernel when mucking about with scsi host internals.
>
> -Erik
>
>--
>Erik B. Andersen             http://codepoet-consulting.com/
>--This message was written using 73% post-consumer electrons--
>
>
>
>  
>

