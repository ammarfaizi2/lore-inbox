Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422632AbWA0VSu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422632AbWA0VSu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 16:18:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422633AbWA0VSu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 16:18:50 -0500
Received: from master.soleranetworks.com ([67.137.28.188]:9682 "EHLO
	master.soleranetworks.com") by vger.kernel.org with ESMTP
	id S1422632AbWA0VSt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 16:18:49 -0500
Message-ID: <43DA7447.2010104@wolfmountaingroup.com>
Date: Fri, 27 Jan 2006 12:28:07 -0700
From: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Phillip Susi <psusi@cfl.rr.com>
Cc: jmerkey@ns1.utah-nac.org,
       "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.14 kernels and above copy_to_user stupidity with IRQ disabled
 check
References: <43DA62CC.8090309@wolfmountaingroup.com> <Pine.LNX.4.61.0601271513360.15124@chaos.analogic.com> <20060127201058.GA18805@ns1.utah-nac.org> <43DA851D.6070209@cfl.rr.com>
In-Reply-To: <43DA851D.6070209@cfl.rr.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Phillip Susi wrote:

> jmerkey@ns1.utah-nac.org wrote:
>
>> OK.  Got it.  I guess I need to restructure.  And BTW, This was a 
>> code fragment
>> only, the spinlock gets released when -EFAULT is called -- was just 
>> an example.
>>
>> Jeff
>
>
> Unless you have redefined EFAULT in some strange and hideous way, it 
> is not "called" and doesn't free the spinlock.  EFAULT is defined as a 
> literal integer, so you're just returning a number without freeing the 
> spinlock.
>
> If you have redefined EFAULT to a macro function call or whatever, 
> then don't do that, it's REALLY horrible coding practice.
>
>
No.  I posted a code fragment as an example.  Here's the actual code:

int dump_regen(VIRTUAL_SETUP *s, ULONG count)
{
    register int i = 0;
    VIRTUAL_SETUP *v;
                                                                                

    spin_lock_irqsave(&regen_lock, regen_flags);
    v = regen_head;
    while (v)
    {
       if (i >= count)
       {
          spin_unlock_irqrestore(&regen_lock, regen_flags);
          return -EFAULT;
       }
                                                                                

       err = copy_to_user(&s[i++], v, sizeof(VIRTUAL_SETUP));
       if (err)
       {         
           spin_unlock_irqrestore(&regen_lock, regen_flags);
           return err;
       }

       v = v->next;
    }
    spin_unlock_irqrestore(&regen_lock, regen_flags);
    return 0;
}

Needless to say, this has been restructured to this:

int dump_regen(VIRTUAL_SETUP *s, ULONG count)
{
    register int i = 0;
    VIRTUAL_SETUP *v;
                                                                                

    spin_lock_irqsave(&regen_lock, regen_flags);
    v = regen_head;
    while (v)
    {
       if (i >= count)
       {
          spin_unlock_irqrestore(&regen_lock, regen_flags);
          return 0;
       }
                                                                                

       P_Copy(&s[i++], v, sizeof(VIRTUAL_SETUP));
       v = v->next;
    }
    spin_unlock_irqrestore(&regen_lock, regen_flags);
    return 0;
}
                                                                                

Jeff

