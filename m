Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275605AbRIZU7m>; Wed, 26 Sep 2001 16:59:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275603AbRIZU7d>; Wed, 26 Sep 2001 16:59:33 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:5385 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S275600AbRIZU7W>; Wed, 26 Sep 2001 16:59:22 -0400
Date: Wed, 26 Sep 2001 16:36:20 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
        netdev@oss.sgi.com
Subject: Re: [patch] netconsole - log kernel messages over the network.
 2.4.10.
In-Reply-To: <Pine.LNX.4.33.0109262128320.8277-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.21.0109261635190.957-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ingo, 

Don't you think it would be useful to have some reserved memory for the
netconsole use ?

It would be nice to have a guarantee that messages are sent over network
even if the system is under real OOM. 

On Wed, 26 Sep 2001, Ingo Molnar wrote:

> 
> this is the first public release of the 'netconsole patch', a debugging
> patch that implements kernel-level network logging via UDP packets.
> 
> the special thing about this approach is the ability to send 'emergency'
> network packets even from IRQ handlers. This enables the netconsole to
> send enough info even if we crash in init or in an interrupt handler.
> 
> another property of netconsole is that it's able to share the networking
> device with other kernel subsystems, like the TCP/IP stack. So the
> networking device is not dedicated for netconsole use, it's transparently
> shared.
> 
> netconsole is also designed to be robust, it goes straight to the network
> driver, so it does not depend on the networking stack to log messages.
> 
> kernel-level netlogging is useful in a number of scenarios:
> 
>  - if remotely managed systems with no serial cable logging keep crashing
>    without any trace of an oops message in the userspace log. (the patch
>    was written to debug such a crash. Original idea of sending an
>    emergency packet from IRQ handlers comes from Daniel Veillard who's
>    system produced the crash - thanks Daniel!)
> 
>  - if for whatever reason the amount of logging is so high that a serial
>    console cannot hold it and disks can not keep up - or in cases where
>    logged messages disturb the debugged subsystem. I'm sure fellow VM
>    hackers will find this useful :-)
> 
>  - the netconsole can be used to emit crashdumps over the network, without
>    any delay between the point of crash and start of netlogging.
> 
> the kernel patch (against 2.4.10 or 2.4.9-ac), and a simple user-space
> tool to display netconsole messages can be found at:
> 
> 	http://redhat.com/~mingo/netconsole-patches/
> 
> sample startup of the netconsole on the server:
> 
>      insmod netconsole dev=eth1 target_ip=0x0a000701 \
>                   source_port=6666 \
>                   target_port=6666 \
>                   target_eth_byte0=0x00 \
>                   target_eth_byte1=0x90\
>                   target_eth_byte2=0x27 \
>                   target_eth_byte3=0x8C \
>                   target_eth_byte4=0xA0 \
>                   target_eth_byte5=0xA8
> 
> and on the client:
> 
> 	# ./netconsole-client -server 10.0.7.5 -client 10.0.7.1 -port 6666
>         [...network console startup...]
>         netconsole: network logging started up successfully!
>         SysRq : Loglevel set to 9
> 
> more about features and limitations can be found under:
> 
> 	Documentation/networking/netlogging.txt
> 
> reports, comments, suggestions welcome.
> 
> 	Ingo
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

