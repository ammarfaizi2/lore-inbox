Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131771AbRCOSrX>; Thu, 15 Mar 2001 13:47:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131779AbRCOSrN>; Thu, 15 Mar 2001 13:47:13 -0500
Received: from robur.slu.se ([130.238.98.12]:29457 "EHLO robur.slu.se")
	by vger.kernel.org with ESMTP id <S131771AbRCOSrC>;
	Thu, 15 Mar 2001 13:47:02 -0500
From: Robert Olsson <Robert.Olsson@data.slu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15025.3553.176799.382488@robur.slu.se>
Date: Thu, 15 Mar 2001 19:45:53 +0100 (CET)
To: Rik van Riel <riel@conectiva.com.br>
Cc: Robert Olsson <Robert.Olsson@data.slu.se>,
        Mårten_Wikström <Marten.Wikstrom@framfab.se>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        <netdev@oss.sgi.com>
Subject: Re: How to optimize routing performance
In-Reply-To: <Pine.LNX.4.33.0103152137240.1320-100000@duckman.distro.conectiva>
In-Reply-To: <15024.53099.41814.716733@robur.slu.se>
	<Pine.LNX.4.33.0103152137240.1320-100000@duckman.distro.conectiva>
X-Mailer: VM 6.75 under Emacs 19.34.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Sorry for the length]

Rik van Riel writes:
 > On Thu, 15 Mar 2001, Robert Olsson wrote:
 > 
 > >  CONFIG_NET_HW_FLOWCONTROL enables kernel code for it. But device
 > >  drivers has to have support for it. But unfortunely very few drivers
 > >  has support for it.
 > 
 > Isn't it possible to put something like this in the layer just
 > above the driver ?

 There is a dropping point in netif_rx. The problem is that knowledge
 of congestion has to be pushed back to the devices that is causing this.

 Alexey added netdev_dropping for drivers to check. And via netdev_wakeup()
 the drivers xon_metod can be called when the backlog below a certain 
 threshold. 

 So from here the driver has do the work. Not investing any resources and
 interrupts in packets we still have to drop. This what happens at very
 high load a kind of livelock. For routers routing protocols will time
 out and we loose conetivity. But I would say its important for all apps.
 
 In 2.4.0-test10 Jamal added sampling of the backlog queue so device
 drivers get the current congestion level. This opens new possiblities.
 

 > It probably won't work as well as putting it directly in the
 > driver, but it'll at least keep Linux from collapsing under
 > really heavy loads ...

 
 And we have done experiments with controlling interrupts and running
 the RX at "lower" priority. The idea is take RX-interrupt and immediately
 postponing the RX process to tasklet. The tasklet opens for new RX-ints.
 when its done.  This way dropping now occurs outside the box since and
 dropping becomes very undramatically.


 As little example of this. I monitored a DoS attack on Linux router
 equipped with this RX-tasklet driver.


Admin up    6 day(s) 13 hour(s) 37 min 54 sec 
Last input  NOW
Last output NOW
5min RX bit/s   22.4 M  
5min TX bit/s   1.3 M
5min RX pkts/s  44079    <====     
5min TX pkts/s  877          
5min TX errors  0            
5min RX errors  0            
5min RX dropped 49913    <====     
      
Fb: no 3127894088 low 154133938 mod 6 high 0 drp 0 <==== Congestion levels

Polling:  ON starts/pkts/tasklet_count 96545881/2768574948/1850259980
HW_flowcontrol xon's     0           



 A bit of explanation. Above is output from tulip driver. We are forwarding
 44079 and we are dropping  49913 packets per second!  This box has 
 full BGP. The DoS attack was going on for about 30 minutes BGP survived 
 and the box was manageable. Under a heavy attack it still performs well.


 Cheers.

						--ro

