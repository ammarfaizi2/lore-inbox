Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261322AbTESSFO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 14:05:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261624AbTESSFO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 14:05:14 -0400
Received: from chaos.analogic.com ([204.178.40.224]:1664 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261322AbTESSFN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 14:05:13 -0400
Date: Mon, 19 May 2003 14:18:04 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Denis Zaitsev <zzz@cd-club.ru>
cc: linux-kernel@vger.kernel.org
Subject: Re: Impossible to turn BROADCAST mode off on ethernet device?
In-Reply-To: <20030519225656.A6998@natasha.zzz.zzz>
Message-ID: <Pine.LNX.4.53.0305191401200.148@chaos>
References: <20030519225656.A6998@natasha.zzz.zzz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 May 2003, Denis Zaitsev wrote:

> Kernel 2.4.20.  I do:
>
>         ifconfig eth0 -broadcast
>
> And BROADCAST isn't turned off...  The ethernet modules are: eepro100,
> tulip, 3c59x.  So, what does it mean?
>
> Thanks in advance.


Your `ifconfig` might not allow broadcast to be turned off as
long a eth0 is `up`. So I just made a little program to get the flags,
and reset the flags. This shows that your observation is, indeed,
correct.

If you mess around with this, I think you will find that you can't
set broadcast OFF as long at the IFF_UP flag is set. This may be
the required behavior because an interface without broadcast
capability will not work on ethernet because ARP requires it.

#include <stdio.h>
#include <unistd.h>
#include <errno.h>
#include <netinet/in.h>
#include <sys/socket.h>
#include <sys/ioctl.h>
#include <string.h>
#include <net/if.h>

int main()
{
    struct ifreq ifr;
    int s, status;
    if((s = socket(PF_INET, SOCK_DGRAM, IPPROTO_IP)) == -1)
    {
        fprintf(stderr, "socket() failed (%s)\n", strerror(errno));
        return s;
    }
    memset(&ifr,  0x00, sizeof(ifr));
    ifr.ifr_netmask.sa_family = AF_INET;
    strcpy(ifr.ifr_name, "eth0");
    status = ioctl(s, SIOCGIFFLAGS, &ifr);
    ifr.ifr_flags &= ~IFF_BROADCAST;
    status = ioctl(s, SIOCGIFFLAGS, &ifr);

    (void)close(s);
    return status;
}



Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

