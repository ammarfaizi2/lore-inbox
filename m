Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131501AbQKAVHq>; Wed, 1 Nov 2000 16:07:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131409AbQKAVHg>; Wed, 1 Nov 2000 16:07:36 -0500
Received: from chaos.analogic.com ([204.178.40.224]:15620 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S131202AbQKAVH0>; Wed, 1 Nov 2000 16:07:26 -0500
Date: Wed, 1 Nov 2000 16:06:33 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Dennis Bjorklund <dennisb@cs.chalmers.se>
cc: linux-kernel@vger.kernel.org
Subject: Re: Broadcast
In-Reply-To: <Pine.SOL.4.21.0011012143200.20182-100000@muppet17.cs.chalmers.se>
Message-ID: <Pine.LNX.3.95.1001101155922.5045A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Nov 2000, Dennis Bjorklund wrote:

> On Wed, 1 Nov 2000, Richard B. Johnson wrote:
> 
> > > I'm trying to turn of the broadcast flag for a network card. But I
> > > can't, why??
> > 
> > Your version of `ifconfig` is probably broken (just like mine).
> > `strace` it and see:
> > ioctl(5, SIOCGIFFLAGS, 0xbffff620)      = 0
> > ioctl(5, SIOCSIFFLAGS, 0xbffff620)      = 0
> > 
> > In this case the flags were gotten with SIOCGIFFLAGS, then the
> > exact same stuff was written back with SIOCSIFFLAGS.
> 
> IFF_BROADCAST is bit number 1 (that is 0x2). So in this case it indicates
> that the broadcast bit is not set before and not set after. But why do I
> see BROADCAST listed when i do "ifconfig eth1" then. This bit should be
> set.
> 
> Right now I'm a bit confused. There is something strange going on here
> that I don't understand. 
> 

Well I screwed up the explaination. That number is a pointer, so it
won't change. However, I made some software for an imbedded system
that sets up ethernet. It was during this time that I noted that
`ifconfig` doesn't always do what it's told, but the kernel does:


/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-*/
/*
 *  File ifconfig.c              Created 12-DEC-1999       Richard B. Johnson
 * 
 *  This replaces the usual Unix `ifconfig` program to configure the
 *  network interface devices. It gets its network parameters from
 *  shared memory.
 */
#include <stdio.h>
#include <unistd.h>
#include <errno.h>
#include <sys/socket.h>
#include <sys/ioctl.h>
#include <string.h>
#include <linux/if.h>
#include <plib.h>

#define IF_NOTSET(a) \
        if(!!ioctl(s, (a), &ifr))

#define EXTRACT_ADDR(m) \
    *((unsigned long *) &ifr.m.sa_data[2])

/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-*/
/*
 *  See if an ethernet device exists within the kernel. This should fail
 *  if one does not exist. It attempts to get the current flags from
 *  the interface.
 */
int chk_eth0()
{
    struct ifreq ifr;
    int s, status;
    if((s = socket(AF_INET, SOCK_DGRAM, 0)) < 0)
        ERRORS(Socket);
    memset(&ifr, 0x00, sizeof(ifr));
    ifr.ifr_netmask.sa_family = AF_INET;
    strcpy(ifr.ifr_name, Eth0);
    status = ioctl(s, SIOCGIFFLAGS, &ifr);
    (void)close(s);
    return status;
}
/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-*/
/*
 *  This does all the stuff that the SYS-V 'ifconfig' does to start both
 *  the loopback and the Ethernet network.
 */
void ifconfig()
{
    struct ifreq ifr;
    struct ifreq tem;
    int s;
    if((s = socket(AF_INET, SOCK_DGRAM, 0)) < 0)
        ERRORS(Socket);
/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-*/
/*
 *  First set up the loop-back device. This gets the standard hard-coded
 *  parameters.
 */   
    if(!pars->lo_up)
    {
        memset(&tem, 0x00, sizeof(tem));
        tem.ifr_netmask.sa_family = AF_INET;
        strcpy(tem.ifr_name, Lo);

        ifr = tem;
        EXTRACT_ADDR(ifr_addr) = 0x0100007F;
        IF_NOTSET(SIOCSIFADDR)
            logerror(__LINE__,__FILE__,Ioctl, errno);
        ifr = tem;
        EXTRACT_ADDR(ifr_netmask) = 0x000000FF;
        IF_NOTSET(SIOCSIFNETMASK)
            logerror(__LINE__,__FILE__,Ioctl, errno);
        ifr = tem;
        EXTRACT_ADDR(ifr_broadaddr) = 0xFFFFFF7F;
        IF_NOTSET(SIOCSIFBRDADDR)
            logerror(__LINE__,__FILE__,Ioctl, errno);
        ifr = tem;
        ifr.ifr_mtu = LO_MTU;
        IF_NOTSET(SIOCSIFMTU)
            logerror(__LINE__,__FILE__,Ioctl, errno);
        ifr = tem;
        ifr.ifr_flags = (IFF_UP|IFF_LOOPBACK|IFF_BROADCAST|IFF_RUNNING);
        IF_NOTSET(SIOCSIFFLAGS)
            logerror(__LINE__,__FILE__,Ioctl, errno);
    }
/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-*/
/*
 *  Now set up the possibly new parameters for the single Ethernet device.
 */
    memset(&tem, 0x00, sizeof(tem));
    tem.ifr_netmask.sa_family = AF_INET;
    strcpy(tem.ifr_name, Eth0);
/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-*/
/*
 *  Shut down old interface by resetting all the flags.
 */
    ifr = tem;
    ifr.ifr_flags = 0;
    IF_NOTSET(SIOCSIFFLAGS)
        logerror(__LINE__,__FILE__,Ioctl, errno);
/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-*/
/*
 *  Now set it up. It gets an address, a netmask, a broadcast address,
 *  and some flags. Routes are added later.
 */
    ifr = tem;
    EXTRACT_ADDR(ifr_addr) = pars->ipaddr;
    IF_NOTSET(SIOCSIFADDR)
        logerror(__LINE__,__FILE__,Ioctl, errno);
    ifr = tem;
    EXTRACT_ADDR(ifr_netmask) = pars->netmask;
    IF_NOTSET(SIOCSIFNETMASK)
        logerror(__LINE__,__FILE__,Ioctl, errno);
    ifr = tem;
    EXTRACT_ADDR(ifr_broadaddr) = pars->broadcast;
    IF_NOTSET(SIOCSIFBRDADDR)
        logerror(__LINE__,__FILE__,Ioctl, errno);
    ifr = tem;
    ifr.ifr_mtu = MTU;
    IF_NOTSET(SIOCSIFMTU)
        logerror(__LINE__,__FILE__,Ioctl, errno);
    ifr = tem;
    ifr.ifr_flags = (IFF_UP|IFF_BROADCAST|IFF_RUNNING|IFF_MULTICAST);
    IF_NOTSET(SIOCSIFFLAGS)
        logerror(__LINE__,__FILE__,Ioctl, errno);
    if(!!close(s))
        ERRORS(Close);
    return;
}

Note that these are just bits in the flag variable:
    ifr.ifr_flags = (IFF_UP|IFF_BROADCAST|IFF_RUNNING|IFF_MULTICAST);

You can turn these on/off at will. However, you have to understand
that TCP/IP won't work without broadcast. It's needed to do the
ARP (Address Resolution Protocol), so that peer-to-peer hardware
addresses become known.

Cheers,
Dick Johnson

Penguin : Linux version 2.2.17 on an i686 machine (801.18 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
