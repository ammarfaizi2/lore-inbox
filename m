Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273946AbRIYBCh>; Mon, 24 Sep 2001 21:02:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274306AbRIYBCW>; Mon, 24 Sep 2001 21:02:22 -0400
Received: from mail.courier-mta.com ([66.92.103.29]:5578 "EHLO
	mail.courier-mta.com") by vger.kernel.org with ESMTP
	id <S273946AbRIYBCJ>; Mon, 24 Sep 2001 21:02:09 -0400
In-Reply-To: <fa.k5o58rv.d7683s@ifi.uio.no>
            <fa.iu7m5ov.i6q3rt@ifi.uio.no>
In-Reply-To: <fa.iu7m5ov.i6q3rt@ifi.uio.no> 
From: "Sam Varshavchik" <mrsam@courier-mta.com>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: two probable security holes
Date: Tue, 25 Sep 2001 01:02:35 GMT
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-ID: <courier.3BAFD7AB.0000609A@ny.email-scan.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller writes: 

>    From: Ken Ashcraft <kash@stanford.edu>
>    Date: Tue, 18 Sep 2001 14:29:57 -0700 (PDT) 
> 
>    Watch ifr.ifr_name.
>    
> Hi Ken, I believe there is some bug in your new checker algorithms for
> this case. 
> 
>                    struct ifreq ifr;
>                    int err;
>    Start--->
>                    if (copy_from_user(&ifr, (void *)arg, sizeof(ifr)))
>                            return -EFAULT;
>                    ifr.ifr_name[IFNAMSIZ-1] = '\0'; 
> 
> ifreq copied safely to kernel space, ifr.ifr_name[] is inside the
> struct and NOT a user pointer. 
> 
>                    err = tun_set_iff(file, &ifr); 
> 
> Pass address of kernel ifreq. 
> 
>                    if (*ifr->ifr_name)
>                            name = ifr->ifr_name;
>    
>                    if ((err = dev_alloc_name(&tun->dev, name)) < 0)
>                            goto failed; 
> 
> Perfectly fine still, name always points to kernel memory.
>    
>    int dev_alloc_name(struct net_device *dev, const char *name)
>    {
>  ... 
> 
>            for (i = 0; i < 100; i++) {
>    Error--->
>    	       sprintf(buf,name,i); 
> 
> Still fine, as stated "name" is pointing to kernel memory.

Ummm...  Is it possible for name to be, oh, something like 

"foo%s%s%s%s%s"? 

In that case, what would that sprintf do? 

> Perhaps your code is being confused by "ifreq->if_name" being
> an array.

-- 
Sam 

