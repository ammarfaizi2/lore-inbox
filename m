Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271198AbUJVLQ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271198AbUJVLQ7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 07:16:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271212AbUJVLQ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 07:16:59 -0400
Received: from mail45.messagelabs.com ([140.174.2.179]:62914 "HELO
	mail45.messagelabs.com") by vger.kernel.org with SMTP
	id S271198AbUJVLQq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 07:16:46 -0400
X-VirusChecked: Checked
X-Env-Sender: justin.piszcz@mitretek.org
X-Msg-Ref: server-16.tower-45.messagelabs.com!1098443804!6651726
X-StarScan-Version: 5.2.10; banners=-,-,-
X-Originating-IP: [66.10.26.57]
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: 2.6.9 - e1000 - page allocation failed
Date: Fri, 22 Oct 2004 07:16:43 -0400
Message-ID: <2E314DE03538984BA5634F12115B3A4E01BC3FA7@email1.mitretek.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.9 - e1000 - page allocation failed
thread-index: AcS4HfNZjlA7GiuVRvuDl0CQlyoMPwACAcYw
From: "Piszcz, Justin Michael" <justin.piszcz@mitretek.org>
To: "Andrew Morton" <akpm@osdl.org>, "Francois Romieu" <romieu@fr.zoreil.com>
Cc: <xhejtman@mail.muni.cz>, <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# patch -p1 < ../e1000.patch
patching file net/ipv4/tcp_output.c
# lilo
Added 2.6.9-2 *
# 

I am copying files on the NIC @ 24-28MB/s (normal) over NFS (16GB), no
problems yet.

I will let you know if I get any more page allocation failures.

Also, on the topic of page allocation failures, if I increase the MTU to
9000 I always get page allocation failures on the Optiplex GX1 box, on a
P4 box I do not get the page allocation failures (I wanted to see what
kind of speeds could be achieved using a 9000 byte MTU vs 1500).

So far, no problems, I will Re: if there if the errors re-occur.


-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Andrew Morton
Sent: Friday, October 22, 2004 5:52 AM
To: Francois Romieu
Cc: xhejtman@mail.muni.cz; linux-kernel@vger.kernel.org
Subject: Re: 2.6.9 - e1000 - page allocation failed

Francois Romieu <romieu@fr.zoreil.com> wrote:
>
> Lukas Hejtmanek <xhejtman@mail.muni.cz> :
> [page allocation failure with e1000]
> 
> If you are using TSO, try patch below by Herbert Xu (available
> from
http://marc.theaimsgroup.com/?l=linux-netdev&m=109799935603132&w=3)
> 
> --- 1.67/net/ipv4/tcp_output.c	2004-10-01 13:56:45 +10:00
> +++ edited/net/ipv4/tcp_output.c	2004-10-17 18:58:47 +10:00
> @@ -455,8 +455,12 @@
>  {
>  	struct tcp_opt *tp = tcp_sk(sk);
>  	struct sk_buff *buff;
> -	int nsize = skb->len - len;
> +	int nsize;
>  	u16 flags;
> +
> +	nsize = skb_headlen(skb) - len;
> +	if (nsize < 0)
> +		nsize = 0;
>  
>  	if (skb_cloned(skb) &&
>  	    skb_is_nonlinear(skb) &&

I'd be interested in knowing if this fixes it - I don't expect it will,
because that's a zero-order allocation failure.  He's really out of
memory.

The e1000 driver has a default rx ring size of 256 which seems a bit
nutty:
a back-to-back GFP_ATOMIC allocation of 256 skbs could easily exhaust
the
page allocator pools.

Probably this machine needs to increase /proc/sys/vm/min_free_kbytes.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
