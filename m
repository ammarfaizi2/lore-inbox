Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290494AbSAQWVE>; Thu, 17 Jan 2002 17:21:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290495AbSAQWU4>; Thu, 17 Jan 2002 17:20:56 -0500
Received: from lenin.nu ([192.31.21.154]:37099 "HELO lenin.nu")
	by vger.kernel.org with SMTP id <S290494AbSAQWUj>;
	Thu, 17 Jan 2002 17:20:39 -0500
Date: Thu, 17 Jan 2002 14:20:36 -0800
From: "Peter C. Norton" <spacey@lenin.nu>
To: linux-kernel@vger.kernel.org
Cc: bonding-devel@lists.sourceforge.net
Subject: Re: Weird bonding driver and tulip quad-card interaction on 2.4.17
Message-ID: <20020117222036.GT31418@lenin.nu>
In-Reply-To: <20020117191528.GJ31418@lenin.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020117191528.GJ31418@lenin.nu>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As a follow-up, Chad T. on the bonding list pointed out to me that there is
no Media flag normally output by ifconfig.  This would lead me to believe
that somehow the bonding driver is perhaps overwriting the MAC address in my
case.  How can this have happened?  Why is it only on this system?  

-Peter

On Thu, Jan 17, 2002 at 11:15:28AM -0800, Peter C. Norton wrote:
> I've installed 2.4.17 on a 2-cpu p2 333 system and am getting some kind of
> corruption in the ifconfig output.
> 
> I'm running debian, mostly testing, some unstable (most of the unstable is
> gnome-related, though).  The net-tools package version is 1.60-4, and
> netbase package is version 4.07.
> 
> I see the following when I test:
> 
> [spacey@obelisk mp3]$ sudo /sbin/modprobe bonding iimon=100
> Warning: /lib/modules/2.4.17/kernel/drivers/net/bonding.o parameter max_bonds has max < min!
> [spacey@obelisk mp3]$ sudo /sbin/modprobe tulip
> [spacey@obelisk mp3]$ /sbin/lsmod
> Module                  Size  Used by    Not tainted
> bonding                11180   0 (unused)
> [...]
> tulip                  37568   0 (unused)
> [...]
> [spacey@obelisk bonding]$ sudo ifconfig bond0 10.0.3.20 netmask 255.255.255.0 broadcast 10.0.3.255
> [spacey@obelisk bonding]$ sudo route add -net 10.0.3.0 netmask 255.255.255.0 gw 10.0.3.20
> [spacey@obelisk bonding]$ /sbin/ifconfig bond0
> bond0     Link encap:Ethernet  HWaddr 00:00:00:00:00:00  
>           inet addr:10.0.3.20  Bcast:10.0.3.255  Mask:255.255.255.0
> 	  UP BROADCAST RUNNING MASTER MULTICAST  MTU:1500  Metric:1
> 	  RX packets:0 errors:0 dropped:0 overruns:0 frame:0
> 	  TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
>           collisions:0 txqueuelen:0 
> 	  RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)
> 
> [spacey@obelisk bonding]$ /sbin/ifconfig eth1
> eth1      Link encap:Ethernet  HWaddr 00:80:C8:B9:43:89  
>           BROADCAST MULTICAST  MTU:1500  Metric:1
> 	  RX packets:0 errors:0 dropped:0 overruns:0 frame:0
> 	  TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
> 	  collisions:0 txqueuelen:100
> 	  RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)
>           Interrupt:18 Base address:0x2000 
> 
> and the same for eth[2-4] with their MAC address incrementing by 1.
> 
> Now, when bonding the interfaces using the ifenslave included with the
> kernel in linux/Documentation/networking/ifenslave.c:
> 
> [spacey@obelisk bonding]$ gcc -I /usr/src/linux-2.4.17/include -o /tmp/ifenslave  /usr/src/linux-2.4.17/Documentation/networking/ifenslave.c 
> [spacey@obelisk bonding]$ sudo /tmp/ifenslave bond0 eth1 eth2 eth3 eth4
> 
> OK, now watch this:
> eth1      Link encap:Ethernet  HWaddr 00:80:C8:B9:43:89
> Media:U<89><E5><83><EC
> <8B>f<83>8^Du^N<83><C4><F4><83><C0>^BP<E8><E1><FE><FF><FF><EB> <83><C4><FC>j@
> <83><C4><F4>h>>^<E8><DD><8C><FF><FF><83><C4>^PPh i^<E8>7
>           inet addr:10.0.3.20  Bcast:10.0.3.255  Mask:255.255.255.0
> 	  UP BROADCAST NOTRAILERS RUNNING SLAVE  MTU:1500  Metric:1
> 	  RX packets:1 errors:1 dropped:0 overruns:0 frame:0
> 	  TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
>           collisions:0 txqueuelen:100 
> 	  RX bytes:60 (60.0 b)  TX bytes:0 (0.0 b)
> 	  Interrupt:18 Base address:0x2000 
> 
> eth[1-4] are all the same - something in the media field is being clobbered
> or otherwise messed up.  The same thing, with the same model/make of quad
> nic, the same driver and the same kernel, though slightly different build
> options does work on an alpha.
> 
> I've mentioned this on the bonding list, but nothing has turned up.  Can
> anyone suggest what might be doing this, and what I should be looking at to
> figure out a fix?
> 
> If relevant .configs would help, let me know and I'll send them along.
> 
> TIA,
> -Peter
> 
> -- 
> The 5 year plan:
> In five years we'll make up another plan.
> Or just re-use this one.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
The 5 year plan:
In five years we'll make up another plan.
Or just re-use this one.
