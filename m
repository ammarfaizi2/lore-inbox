Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268339AbUJTPxN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268339AbUJTPxN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 11:53:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268312AbUJTPNg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 11:13:36 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:31248 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S267561AbUJTPLv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 11:11:51 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Lee Revell <rlrevell@joe-job.com>,
       Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH] Make netif_rx_ni preempt-safe
Date: Wed, 20 Oct 2004 18:11:44 +0300
User-Agent: KMail/1.5.4
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>,
       "David S. Miller" <davem@davemloft.net>,
       linux-kernel@gondor.apana.org.au, maxk@qualcomm.com,
       irda-users@lists.sourceforge.net,
       Linux Network Development <netdev@oss.sgi.com>,
       Alain Schroeder <alain@parkautomat.net>
References: <1098230132.23628.28.camel@krustophenia.net> <20041020000009.GA17246@gondor.apana.org.au> <1098231737.23628.42.camel@krustophenia.net>
In-Reply-To: <1098231737.23628.42.camel@krustophenia.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410201811.44419.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> How about this:
> 
> Signed-Off-By: Lee Revell <rlrevell@joe-job.com>
> 
> --- include/linux/netdevice.h~	2004-10-19 20:16:48.000000000 -0400
> +++ include/linux/netdevice.h	2004-10-19 20:21:01.000000000 -0400
> @@ -696,9 +696,12 @@
>   */
>  static inline int netif_rx_ni(struct sk_buff *skb)
>  {
> -       int err = netif_rx(skb);
> +       int err;
> +       preempt_disable();
> +       err = netif_rx(skb);
>         if (softirq_pending(smp_processor_id()))
>                 do_softirq();
> +       preempt_enable();
>         return err;
>  }

#include <linux/netdevice.h>

int netif_rx_ni_(struct sk_buff *skb)
{
    int err;
    preempt_disable();
    err = netif_rx(skb);
    if (softirq_pending(smp_processor_id()))
        do_softirq();
    preempt_enable();
    return err;
}

objdump -d:
00000000 <netif_rx_ni_>:
   0:   55                      push   %ebp
   1:   89 e5                   mov    %esp,%ebp
   3:   56                      push   %esi
   4:   53                      push   %ebx
   5:   bb 00 f0 ff ff          mov    $0xfffff000,%ebx
   a:   21 e3                   and    %esp,%ebx
   c:   ff 43 14                incl   0x14(%ebx)
   f:   8b 4d 08                mov    0x8(%ebp),%ecx
  12:   51                      push   %ecx
  13:   e8 fc ff ff ff          call   14 <netif_rx_ni_+0x14>
  18:   89 c6                   mov    %eax,%esi
  1a:   8b 43 10                mov    0x10(%ebx),%eax
  1d:   c1 e0 07                shl    $0x7,%eax
  20:   8b 80 00 00 00 00       mov    0x0(%eax),%eax
  26:   85 c0                   test   %eax,%eax
  28:   5a                      pop    %edx
  29:   75 25                   jne    50 <netif_rx_ni_+0x50>
  2b:   8b 43 08                mov    0x8(%ebx),%eax
  2e:   ff 4b 14                decl   0x14(%ebx)
  31:   a8 08                   test   $0x8,%al
  33:   75 09                   jne    3e <netif_rx_ni_+0x3e>
  35:   8d 65 f8                lea    0xfffffff8(%ebp),%esp
  38:   5b                      pop    %ebx
  39:   89 f0                   mov    %esi,%eax
  3b:   5e                      pop    %esi
  3c:   5d                      pop    %ebp
  3d:   c3                      ret
  3e:   e8 fc ff ff ff          call   3f <netif_rx_ni_+0x3f>
  43:   eb f0                   jmp    35 <netif_rx_ni_+0x35>
  45:   8d 74 26 00             lea    0x0(%esi,1),%esi
  49:   8d bc 27 00 00 00 00    lea    0x0(%edi,1),%edi
  50:   e8 fc ff ff ff          call   51 <netif_rx_ni_+0x51>
  55:   eb d4                   jmp    2b <netif_rx_ni_+0x2b>

0x57 == 87 bytes is too big for inline.
--
vda

