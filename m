Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271109AbUJVKzR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271109AbUJVKzR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 06:55:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271111AbUJVKzR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 06:55:17 -0400
Received: from mail45.messagelabs.com ([140.174.2.179]:36751 "HELO
	mail45.messagelabs.com") by vger.kernel.org with SMTP
	id S271109AbUJVKzL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 06:55:11 -0400
X-VirusChecked: Checked
X-Env-Sender: justin.piszcz@mitretek.org
X-Msg-Ref: server-6.tower-45.messagelabs.com!1098442509!6653668
X-StarScan-Version: 5.2.10; banners=-,-,-
X-Originating-IP: [66.10.26.57]
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: 2.6.9 - e1000 - page allocation failed
Date: Fri, 22 Oct 2004 06:55:08 -0400
Message-ID: <2E314DE03538984BA5634F12115B3A4E01BC3FA5@email1.mitretek.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.9 - e1000 - page allocation failed
thread-index: AcS4HfNZjlA7GiuVRvuDl0CQlyoMPwABza1g
From: "Piszcz, Justin Michael" <justin.piszcz@mitretek.org>
To: "Andrew Morton" <akpm@osdl.org>, "Francois Romieu" <romieu@fr.zoreil.com>
Cc: <xhejtman@mail.muni.cz>, <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Question regarding TSO:

I found this in regards to TSO:
http://www.kerneltrap.org/node.php?id=397

Which option enables TSO?

$ grep -i tso .config
$ grep -i tcp .config
CONFIG_NFSD_TCP=y

I get them almost 1-10 minutes after rebooting into 2.6.9.
Machine = Dell Optiplex GX1
RAM = 768MB (ECC)
SWAP = 2048MB

So try the patch and increasing /proc/sys/vm/min_free_kbytes? I will
give this a shot and report back.

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
