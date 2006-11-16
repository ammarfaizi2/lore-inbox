Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162296AbWKPWeR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162296AbWKPWeR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 17:34:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162295AbWKPWeR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 17:34:17 -0500
Received: from nz-out-0102.google.com ([64.233.162.193]:14927 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1162159AbWKPWeP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 17:34:15 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=PpSCqnAWLHkSduCtq/GYExvd3Rvp8M/1UdhXkVKJmXJ3imYC6NOuiRy2fLVXR/vwrvwTGgTsOdhE/db9Zd8rNwNetW1Thlnqkttt2d13olXyGOZJX3AwZTn6T0gHI69V2PGUCOBtT/Hp1mUKiU7iAZEd7pZPuotmdFFfpUpL/lA=
Message-ID: <9a8748490611161434oc393db0o1e1c23ba99b1c796@mail.gmail.com>
Date: Thu, 16 Nov 2006 23:34:14 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: netdev@vger.kernel.org
Subject: IPv4: ip_options_compile() how can we avoid blowing up on a NULL skb???
Cc: "David Miller" <davem@davemloft.net>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

In net/ipv4/ip_options.c::ip_options_compile() we have the following
code at the start of the function :


int ip_options_compile(struct ip_options * opt, struct sk_buff * skb)
{
        int l;
        unsigned char * iph;
        unsigned char * optptr;
        int optlen;
        unsigned char * pp_ptr = NULL;
        struct rtable *rt = skb ? (struct rtable*)skb->dst : NULL;

        if (!opt) {
                opt = &(IPCB(skb)->opt);
                iph = skb->nh.raw;
                opt->optlen = ((struct iphdr *)iph)->ihl*4 -
sizeof(struct iphdr);
                optptr = iph + sizeof(struct iphdr);
                opt->is_data = 0;
        } else {
                optptr = opt->is_data ? opt->__data : (unsigned
char*)&(skb->nh.iph[1]);
                iph = optptr - sizeof(struct iphdr);
        }

...

I don't see how that avoids blowing up if we get passed a NULL skb.

>From the line
    struct rtable *rt = skb ? (struct rtable*)skb->dst : NULL;
it is clear that we /may/ get passed a null skb.

Then a bit further down in the  if (!opt)  bit we dereference 'skb' :
    opt = &(IPCB(skb)->opt);
and we also may dereference it in the  else  part :
    optptr = opt->is_data ? opt->__data : (unsigned char*)&(skb->nh.iph[1]);

So if 'skb' is NULL, the only route I see that doesn't cause a NULL
pointer deref is if  (opt != NULL)  and at the same time
(opt->is_data != NULL)  .   Is that guaranteed in any way?  If now,
how come we don't blow up regularly?


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
