Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131513AbRCSQe7>; Mon, 19 Mar 2001 11:34:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131514AbRCSQeu>; Mon, 19 Mar 2001 11:34:50 -0500
Received: from zeus.kernel.org ([209.10.41.242]:10972 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S131513AbRCSQek>;
	Mon, 19 Mar 2001 11:34:40 -0500
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC-2] Configuring Synchronous Interfaces in Linux
In-Reply-To: <E1441je-0002T3-00@the-village.bc.nu>
Content-Type: text/plain; charset=US-ASCII
From: Krzysztof Halasa <khc@intrepid.pm.waw.pl>
Date: 19 Mar 2001 17:28:56 +0100
In-Reply-To: Alan Cox's message of "Thu, 7 Dec 2000 14:09:19 +0000 (GMT)"
Message-ID: <m3r8ztpvsn.fsf@intrepid.pm.waw.pl>
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> I think we are agreeing
> 
> 
> I'm saying use something like
> 
> 	struct 
> 	{
> 		u16 media_group;
> 		union
> 		{
> 			struct hdlc_physical ...
> 			struct hdlc_bitstream
> 			struct hdlc_protocol
> 			struct fr_protocol
> 			struct eth_physical
> 			struct atm_physical
> 			struct dsl_physical
> 			struct dsl_bitstream
> 			struct tr_physical
> 			struct wireless_physical
> 			struct wireless_80211
> 			struct wireless_auth
> 		} config;
> 	}

I think union like this is fine.


We currently have:
ioctl(sock, COMMAND, ifreq*)

where ifreq is defined in include/linux/if.h and is 16 bytes long:

struct ifreq {
        {
                char    ifrn_name[IFNAMSIZ];    /* if name, e.g. "en0" */
        } ifr_ifrn;

        union {
                struct  sockaddr ifru_addr;
                struct  sockaddr ifru_dstaddr;
                struct  sockaddr ifru_broadaddr;
                struct  sockaddr ifru_netmask;
                struct  sockaddr ifru_hwaddr;
                short   ifru_flags;
                int     ifru_ivalue;
                int     ifru_mtu;
                struct  ifmap ifru_map;
                char    ifru_slave[IFNAMSIZ];   /* Just fits the size */
                char    ifru_newname[IFNAMSIZ];
                char *  ifru_data;
        }

I understand we can put a config structure address in ifru_data - but
do we really need another level?
Wouldn't it be better put config structs there (in the union)?

It would then read:
struct ifreq {
        {
                char    ifrn_name[IFNAMSIZ];    /* if name, e.g. "en0" */
        } ifr_ifrn;

        union {
                struct  sockaddr ifru_addr;
                struct  sockaddr ifru_dstaddr;
                struct  sockaddr ifru_broadaddr;
                struct  sockaddr ifru_netmask;
                struct  sockaddr ifru_hwaddr;
                short   ifru_flags;
                int     ifru_ivalue;
                int     ifru_mtu;
                struct  ifmap ifru_map;
                char    ifru_slave[IFNAMSIZ];   /* Just fits the size */
                char    ifru_newname[IFNAMSIZ];
                char *  ifru_data;
		struct hdlc_physical ...
		struct hdlc_bitstream
		struct hdlc_protocol
		struct fr_protocol
		struct eth_physical
		struct atm_physical
		struct dsl_physical
		struct dsl_bitstream
		struct tr_physical
		struct wireless_physical
		struct wireless_80211
		struct wireless_auth
        }

while I'd put "media_group" in ioctl command code:
#define SIOCSHDLC_PHY ...
#define SIOCGHDLC_PHY ... /* get */
#define SIOCSFR ...
#define SIOCSETH_PHY ...
#define SIOCSATM...

A possible problem is if the struct gets longer - we would have to recompile
all utils using it. Doing that before distributions start using 2.4 as
a kernel for general use would save us (we can use pointers in such cases
as well, as some operations - downloading firmware or crypto keys - may have
very long data areas).

What do you think about it?
-- 
Krzysztof Halasa
Network Administrator
