Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318016AbSGLV7V>; Fri, 12 Jul 2002 17:59:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318019AbSGLV7U>; Fri, 12 Jul 2002 17:59:20 -0400
Received: from grunt.ksu.ksu.edu ([129.130.12.17]:20426 "EHLO
	mailhub.cns.ksu.edu") by vger.kernel.org with ESMTP
	id <S318016AbSGLV7T>; Fri, 12 Jul 2002 17:59:19 -0400
Date: Fri, 12 Jul 2002 17:02:07 -0500 (CDT)
From: Matt Stegman <matts@ksu.edu>
X-X-Sender: <matts@unix2.cc.ksu.edu>
To: Stephen Hemminger <shemminger@osdl.org>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 64 bit netdev stats counter
In-Reply-To: <1026503694.26819.4.camel@dell_ss3.pdx.osdl.net>
Message-ID: <Pine.GSO.4.33L.0207121628100.19313-100000@unix2.cc.ksu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12 Jul 2002, Stephen Hemminger wrote:

> 64 bit values are not atomic so on x86 there will be glitches if this
> ever wraps over on an SMP machine.  One other engineer is already
> adressing this for inode values like size; but this would introduce the
> same problem for network stuff.

One other solution I thought of would be to have an rx_bytes_wrap counter
in the struct.

struct net_device_stats {
...
	unsigned long rx_bytes;
	unsigned long rx_bytes_wrap;
	unsigned long tx_bytes;
	unsigned long tx_bytes_wrap;
...
}

... and then, everywhere we add to rx_bytes (or tx_bytes):

stats->rx_bytes += pkt_length;
if (stats->rx_bytes <= pkt_length) stats->rx_bytes_wrap++;

I suppose this might also be more backwards compatible - if other code I
don't know about expects the rx_bytes to be a long, this would keep it so.
Also, if gcc has real problems with doing 64-bit math on a 32-bit
processor, this keeps everything in 32-bits.  I could then make a local
"unsigned long long" variable in the code that prints /proc/net/dev, and
in ifconfig.

unsigned long long rx_total_bytes = stats->rx_bytes * stats->rx_bytes_wrap;
sprintf(buf, "RX bytes:%llu", stats->rx_total_bytes);

-- 
      -Matt Stegman




