Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282267AbRK2Be0>; Wed, 28 Nov 2001 20:34:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282269AbRK2BeR>; Wed, 28 Nov 2001 20:34:17 -0500
Received: from zeus.anet-chi.com ([207.7.4.6]:58355 "EHLO zeus.anet-chi.com")
	by vger.kernel.org with ESMTP id <S282267AbRK2Bd6>;
	Wed, 28 Nov 2001 20:33:58 -0500
Message-ID: <02d901c17877$c730f3c0$a300a8c0@ipv16>
From: "Jim Fleming" <jfleming@anet.com>
To: <linux-kernel@vger.kernel.org>
In-Reply-To: <20011128163810.C2512@kroah.com> <E169FUY-0006k8-00@the-village.bc.nu> <20011128170748.A2762@kroah.com>
Subject: CONFIG_IPv8_TOS for 2.4
Date: Wed, 28 Nov 2001 19:47:16 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems that the "kernel" should be open and free of policy, with
respect to the IPv4 TOS field.
http://www.dot-biz.com/IPv4/Tutorial/

These commands illustrate that not all TOS values can be easily set.
ping -Q 34 192.168.0.1
ping -Q 35 192.168.0.1

Below are the changes I made to make the kernel more open.

Jim Fleming
http://www.IPv8.info
IPv16....One Better !!

------------

/*
 * Networking options
 */
#define CONFIG_PACKET 1
#undef  CONFIG_PACKET_MMAP
#undef  CONFIG_NETLINK
#define CONFIG_NETFILTER 1
#undef  CONFIG_NETFILTER_DEBUG
#undef  CONFIG_FILTER
#define CONFIG_UNIX 1
#define CONFIG_INET 1
#undef  CONFIG_TUX
#define CONFIG_IPv8_TOS 1
#define CONFIG_IP_MULTICAST 1
#undef  CONFIG_IP_ADVANCED_ROUTER
#undef  CONFIG_IP_PNP
#undef  CONFIG_NET_IPIP
#undef  CONFIG_NET_IPGRE
#undef  CONFIG_IP_MROUTE
#undef  CONFIG_INET_ECN
#undef  CONFIG_SYN_COOKIES

#ifndef _LINUX_IP_H
#define _LINUX_IP_H
#include <asm/byteorder.h>

/* SOL_IP socket options */

#ifdef CONFIG_IPv8_TOS
#define IPTOS_TOS_MASK  0xFF
#define IPTOS_TOS(tos)  (tos)
#else
#define IPTOS_TOS_MASK  0x1E
#define IPTOS_TOS(tos)  ((tos)&IPTOS_TOS_MASK)
#define IPTOS_LOWDELAY  0x10
#define IPTOS_THROUGHPUT 0x08
#define IPTOS_RELIABILITY 0x04
#define IPTOS_MINCOST  0x02

#define IPTOS_PREC_MASK  0xE0
#define IPTOS_PREC(tos)  ((tos)&IPTOS_PREC_MASK)
#define IPTOS_PREC_NETCONTROL           0xe0
#define IPTOS_PREC_INTERNETCONTROL      0xc0
#define IPTOS_PREC_CRITIC_ECP           0xa0
#define IPTOS_PREC_FLASHOVERRIDE        0x80
#define IPTOS_PREC_FLASH                0x60
#define IPTOS_PREC_IMMEDIATE            0x40
#define IPTOS_PREC_PRIORITY             0x20
#define IPTOS_PREC_ROUTINE              0x00
#endif

Config.in:bool '  IP: IPv8 TOS' CONFIG_IPv8_TOS

---------------------------------------------------------------------
icmp.c:

#ifdef CONFIG_IPv8_TOS
 tos = iph->tos;
#else
 tos = icmp_pointers[type].error ?
  ((iph->tos & IPTOS_TOS_MASK) | IPTOS_PREC_INTERNETCONTROL) :
   iph->tos;
#endif

---------------------------------------------------------------------
ip_sockglue.c:

  case IP_TOS: /* This sets both TOS and Precedence */

#ifndef CONFIG_IPv8_TOS
     /* Reject setting of unused bits */
#ifndef CONFIG_INET_ECN
   if (val & ~(IPTOS_TOS_MASK|IPTOS_PREC_MASK))
    goto e_inval;
#else
   if (sk->type == SOCK_STREAM) {
    val &= ~3;
    val |= sk->protinfo.af_inet.tos & 3;
   }
#endif
   if (IPTOS_PREC(val) >= IPTOS_PREC_CRITIC_ECP && 
       !capable(CAP_NET_ADMIN)) {
    err = -EPERM;
    break;
   }
#endif
   if (sk->protinfo.af_inet.tos != val) {
    sk->protinfo.af_inet.tos=val;
    sk->priority = rt_tos2priority(val);
    sk_dst_reset(sk); 
   }
   break;
  case IP_TTL:
---------------------------------------------------------------------


