Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264457AbUADIZ1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 03:25:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264464AbUADIZ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 03:25:27 -0500
Received: from maverick.eskuel.net ([81.56.212.215]:34553 "EHLO
	maverick.eskuel.net") by vger.kernel.org with ESMTP id S264457AbUADIZI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 03:25:08 -0500
Message-ID: <3FF7CDE2.9050900@eskuel.net>
Date: Sun, 04 Jan 2004 09:25:06 +0100
From: Mathieu LESNIAK <maverick@eskuel.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031231 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: PCMCIA lockups on HP Pavilion laptop
X-Enigmail-Version: 0.82.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------020301040007000404090506"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020301040007000404090506
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Aubin LaBrosse wrote:
> Hi all,
> 
> I have an HP pavilion ze4145 laptop running fedora core 1 with arjanv's
> 2.6.0-1.109 kernel. I have recently purchased an SMC 2532W-B 802.11b
> wireless card.  I am not sure that this is supported under linux, but
> the problem I am having is rooted deeper than that:
> 
> when the redhat pcmcia script is run, the laptop locks up solid.  sysrq
> is enabled but i have not tried it yet, i'd have to look up the keys and
> what they do.  regardless, i have traced the problem to cardmgr itself,
> cardctl works alright though it can't provide much info on the card.  I
> have pcmcia modularized as is most of the redhat kernel, and the modules
> pcmcia_core, yenta_socket and ds are loaded.  when cardmgr runs, it
> locks the box up when it is inside the adjust_resources function in
> cardmgr.c - at least on this 2.6.0 kernel, though the pcmcia script also
> locks the box up on the 2.4 fedora kernels (2.4.22-1.2135.nptl and
> 2.4.22-1.2115.nptl, both fedora core 1 stock kernels).
>  
> the version of the pcmcia kernel stuff installed with fedora is 3.1.31 -
> i have also installed the 3.2.7 userspace utilities (not kernel side,
> the configuration process from pcmcia-cs-3.2.7 detected that pcmcia was
> already enabled in the kernel and only installed the userspace stuff.)
> 
> the way in which i determined that cardmgr was at fault was by running
> it by hand, simply cardmgr -v.  I then traced it down further by adding
> fprintfs to stderr to cardmgr.c - the specific line from which my box
> never returns is 
> 
>  ret = ioctl(fd, DS_ADJUST_RESOURCE_INFO, &al->adj);
> 
> in adjust_resources() in cardmgr.c
> the resource being adjusted is an io-range resource, and it's the second
> one in the linked list that crashes my box, the first one succeeds just
> fine
> 
> i also tried booting with noapic and acpi=off just to see if that had
> anything to do with it, but no luck.  I have not yet tried a stock
> kernel.org kernel. 
> 
> debugging this inside the ioctl is a bit out of my league, which is why
> i have written this mail - any insight anyone else has (even if it's
> just 'what the hell is wrong with you, you've screwed everything up by
> doing xxx') would be much appreciated.  Not being a kernel-hacker but
> being a compsci major in school probably makes me too dangerous for my
> own good. ;-) so if i've totally made a mess of things just tell me so. 
> I've attached the diff between my modified copy of cardmgr.c and the one
> from pcmcia-cs-3.2.7. First diff I've ever made, so it could be wrong -
> it's just fprintfs to see where it got while it was running.  I'll study
> up on the format of adjust_list_t and see if i can figure out exactly
> which io range the code is trying to adjust and failing at. 
> 
> thanks for any insights, all.  
> 
> -aubin
> 
> 
> ------------------------------------------------------------------------
> 
> --- pcmcia-cs-3.2.7/cardmgr/cardmgr.c	2003-11-27 17:00:14.000000000 -0500
> +++ cardmgr.c	2004-01-03 23:08:27.000000000 -0500
> @@ -1217,8 +1217,21 @@
>      int fd = socket[0].fd;
>      
>      for (al = root_adjust; al; al = al->next) {
> +	    fprintf( stderr, "calling ioctl to adjust resource info for a(n) ");
> +	    switch( al->adj.Resource ) {
> +		    case RES_MEMORY_RANGE:
> +			    fprintf(stderr, "memory range resource\n");
> +			    break;
> +		    case RES_IO_RANGE:
> +			    fprintf( stderr, "io range resource\n");
> +			    break;
> +		    case RES_IRQ:
> +			    fprintf( stderr, "irq resource\n");
> +	    }
>  	ret = ioctl(fd, DS_ADJUST_RESOURCE_INFO, &al->adj);
> +	fprintf( stderr, "made it back from ioctl resource adjust\n");
>  	if (ret != 0) {
> +		fprintf(stderr, "we failed to adjust a resource\n");
>  	    switch (al->adj.Resource) {
>  	    case RES_MEMORY_RANGE:
>  		sprintf(tmp, "memory %#lx-%#lx",
> @@ -1332,7 +1345,9 @@
>  	syslog(LOG_INFO, "watching %d socket%s", sockets,
>  	       (sockets != 1) ? "s" : "");
>  
> +    fprintf(stderr, "cardmgr calling adjust_resources()\n");
>      adjust_resources();
> +    fprintf( stderr, "cardmgr back from adjust_resources() call\n");
>      return 0;
>  }
>  
> @@ -1382,6 +1397,7 @@
>  	    errflg = 1; break;
>  	}
>      }
> +	fprintf(stderr, "cardmgr finished option parsing\n");
>      if (errflg || (optind < argc)) {
>  	fprintf(stderr, "usage: %s [-V] [-q] [-v] [-o] [-f] "
>  		"[-c configpath] [-m modpath]\n               "
> @@ -1414,12 +1430,15 @@
>  	syslog(LOG_NOTICE, "cannot access %s: %m", modpath);
>      /* We default to using modprobe if it is available */
>      do_modprobe |= (access("/sbin/modprobe", X_OK) == 0);
> -    
> +    fprintf(stderr, "cardmgr calling load_config()\n");
>      load_config();
> -    
> +    fprintf(stderr, "cardmgr calling init_sockets()\n");
>      if (init_sockets() != 0)
> -	exit(EXIT_FAILURE);
> -
> +	{
> +		fprintf(stderr, "cardmgr init_sockets failed\n");
> +		exit(EXIT_FAILURE);
> +	}
> +	fprintf( stderr, "cardmgr init_sockets() succeeded\n");
>      closelog();
>      close(0); close(1); close(2);
>      if (!delay_fork && !one_pass)
> @@ -1442,7 +1461,7 @@
>      if (signal(SIGPWR, catch_signal) == SIG_ERR)
>  	syslog(LOG_ERR, "signal(SIGPWR): %m");
>  #endif
> -
> +	fprintf( stderr, "cardmgr finished sighandler setup\n");
>      for (i = max_fd = 0; i < sockets; i++)
>  	max_fd = (socket[i].fd > max_fd) ? socket[i].fd : max_fd;
>  
> @@ -1476,7 +1495,7 @@
>  		syslog(LOG_INFO, "read(%d): %m\n", i);
>  	    if (ret != 4)
>  		continue;
> -	    
> +		fprintf(stderr, "cardmgr about to enter event switch\n");
>  	    switch (event) {
>  	    case CS_EVENT_CARD_REMOVAL:
>  		socket[i].state = 0;

Hi !

I've got a Compaq Presario 2118EA, which is the same kind of laptop if I
remerber correctly. I had this problem in the past until I modified the
the config.opts file in /etc/pcmcia to change the memory range and irq used.
I've attached config.opts with this mail.

Hope this helps

Mathieu LESNIAK


--------------020301040007000404090506
Content-Type: text/plain;
 name="config.opts"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="config.opts"

#
# Local PCMCIA Configuration File
#
#----------------------------------------------------------------------

# System resources available for PCMCIA devices

#include port 0x100-0x4ff, port 0xc00-0xcff
include port 0xfd00-0xfdff, port 0xfc00-0xfcff
#include memory 0xc0000-0xfffff
#include memory 0xa0000000-0xa0ffffff, memory 0x60000000-0x60ffffff
include memory 0x80000000-0x80000fff, memory 0xffeff000-0xffefffff
include memory 0xfbeff000-0xffefefff, memory 0x000d7000-0x000d7fff

# High port numbers do not always work...
# include port 0x1000-0x17ff

# Extra port range for IBM Token Ring
#include port 0xa00-0xaff

# Resources we should not use, even if they appear to be available

# First built-in serial port
exclude irq 3
exclude irq 4
#exclude irq 7
exclude irq 10
exclude irq 12

exclude irq 1
exclude irq 2
exclude irq 3
exclude irq 4
exclude irq 5
exclude irq 6
exclude irq 8
exclude irq 9
exclude irq 10
exclude irq 11
exclude irq 12
exclude irq 13
exclude irq 14
exclude irq 15



# Second built-in serial port
#exclude irq 3
# First built-in parallel port
#exclude irq 7
# PS/2 Mouse controller port, comment this out if you don't have a PS/2
# based mouse
#exclude irq 12
#
#----------------------------------------------------------------------

# Examples of options for loadable modules

# To fix sluggish network with IBM ethernet adapter...
#module "pcnet_cs" opts "mem_speed=600"

# Options for IBM Token Ring adapters
#module "ibmtr_cs" opts "mmiobase=0xd0000 srambase=0xd4000"

# Options for Raylink/WebGear driver: uncomment only one line...
# Generic ad-hoc network
module "ray_cs" opts "essid=ADHOC_ESSID hop_dwell=128 beacon_period=256 translate=1"
# Infrastructure network for older cards
#module "ray_cs" opts "net_type=1 essid=ESSID1"
# Infrastructure network for WebGear
#module "ray_cs" opts "net_type=1 essid=ESSID1 translate=1 hop_dwell=128 beacon_period=256"

# Options for WaveLAN/IEEE driver (AccessPoint mode)...
#module "wvlan_cs" opts "station_name=MY_PC"
# Options for WaveLAN/IEEE driver (ad-hoc mode)...
#module "wvlan_cs" opts "port_type=3 channel=1 station_name=MY_PC"

# Options for Xircom Netwave driver...
#module "netwave_cs" opts "domain=0x100 scramble_key=0x0"



--------------020301040007000404090506--
