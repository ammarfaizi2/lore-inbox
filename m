Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265272AbSIRH6e>; Wed, 18 Sep 2002 03:58:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265357AbSIRH6e>; Wed, 18 Sep 2002 03:58:34 -0400
Received: from dmz.hesby.net ([81.29.32.2]:60059 "HELO firewall.hesbynett.no")
	by vger.kernel.org with SMTP id <S265272AbSIRH6c> convert rfc822-to-8bit;
	Wed, 18 Sep 2002 03:58:32 -0400
Subject: Re: Virtual to physical address mapping
From: Ole =?ISO-8859-1?Q?Andr=E9?= Vadla =?ISO-8859-1?Q?Ravn=E5s?= 
	<oleavr-lkml@jblinux.net>
To: Steve Mickeler <steve@neptune.ca>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0209180204380.2876-100000@triton.neptune.on.ca>
References: <Pine.LNX.4.44.0209180204380.2876-100000@triton.neptune.on.ca>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
X-Mailer: Ximian Evolution 1.0.8 
Date: 18 Sep 2002 10:07:07 +0200
Message-Id: <1032336427.5812.25.camel@zole.jblinux.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, but the address specified there is certainly not the same as the
base address ifconfig reports. I made a simple program to verify this:

# ./ioctl_test eth0
mem_start: 0x0
mem_end:   0x0
base_addr: 0xa000
irq:       10
dma:       0
port:      0

And /proc/pci tells me, for that device:
  Bus  0, device  15, function  0:
    Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C
(rev 16).
      IRQ 10.
      Master Capable.  Latency=32.  Min Gnt=32.Max Lat=64.
      I/O at 0xd800 [0xd8ff].
      Non-prefetchable 32 bit memory at 0xe4005000 [0xe40050ff].

Is there any way I can map this 0xa000 address, which I assume is
virtual, to its physical address? I guess I'm very limited in userspace,
but are there any options or do I have to go about modifying the kernel?

The source for my test program is here for clarity's sake:
#include <stdio.h>
#include <errno.h>
#include <net/if.h>
#include <sys/ioctl.h>

int main(int argc, char *argv[])
{
	int fd;
	struct ifreq ifr;
	
	if (!argv[1]) {
		fprintf(stderr, "usage: %s [devname]\n", argv[0]);
		return 1;
	}
	
	fd = socket(AF_INET, SOCK_DGRAM, 0);
	
	if (fd < 0) {
		perror("failed to open socket");
		return 1;
	}

	memset(&ifr, 0, sizeof(struct ifreq));
	strcpy(ifr.ifr_name, argv[1]);
	
	if (ioctl(fd, SIOCGIFMAP, &ifr) < 0) {
		perror("ioctl failed");
		close(fd);
		return 1;
	}

	printf("mem_start: 0x%lx\n", ifr.ifr_map.mem_start);
	printf("mem_end:   0x%lx\n", ifr.ifr_map.mem_end);
	printf("base_addr: 0x%hx\n", ifr.ifr_map.base_addr);
	printf("irq:       %d\n", ifr.ifr_map.irq);
	printf("dma:       %d\n", ifr.ifr_map.dma);
	printf("port:      %d\n", ifr.ifr_map.port);
	
	close(fd);
	
	return 0;
}


Ole André

On Wed, 2002-09-18 at 08:05, Steve Mickeler wrote:
> 
> That info will be in /proc/pci
> 
> 
> On 18 Sep 2002, Ole André Vadla Ravnås wrote:
> 
> > Hi
> >
> > I've noticed that ifconfig shows a base address and an interrupt
> > number.. However, I can't get that base address to correspond to
> > anything in /proc/iomem, which means that I can't determine which PCI
> > device (in this case) it corresponds to (guess the base address is
> > virtual). What I want is to find a way to get the PCI bus and device no
> > for the network device, but is this at all possible without altering the
> > kernel?
> >
> > Ole André
> >
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> >
> 
> 
> 
> [-] Steve Mickeler [ steve@neptune.ca ]
> 
> [|] Todays root password is brought to you by /dev/random
> 
> [+] 1024D/9AA80CDF = 4103 9E35 2713 D432 924F  3C2E A7B9 A0FE 9AA8 0CDF
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


