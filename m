Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261833AbVBTOBt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261833AbVBTOBt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Feb 2005 09:01:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261834AbVBTOBt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Feb 2005 09:01:49 -0500
Received: from lucidpixels.com ([66.45.37.187]:6784 "HELO lucidpixels.com")
	by vger.kernel.org with SMTP id S261833AbVBTOBh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Feb 2005 09:01:37 -0500
Date: Sun, 20 Feb 2005 09:01:33 -0500 (EST)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p500
To: linux-kernel@vger.kernel.org
cc: linux.nics@intel.com, jun.nakajima@intel.com, len.brown@intel.com,
       ganesh.venkatesan@intel.com, apiszcz@solarrain.com
Subject: Intel Gigabit NIC (2.6.5 -> 2.6.10) Bug(?) Found
Message-ID: <Pine.LNX.4.62.0502200814510.6305@p500>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What is this e-mail about?

Something in the kernel changed regarding the Intel e1000 driver from 
2.6.5 to 2.6.10. The change resulted in thousands of errors when the NIC 
is receiving data. For the past two weeks I have thought about this and 
tried everything I could think of, it had really been pestering me. 
Normally, I never really looked at my ifconfig eth0, eth1 etc because I 
looked at it a long time ago and noticed it was just fine, this was with 
earlier kernels.  I guess I should check my NIC statistics more often. I 
have tried the following to figure out why I get so many dropped packets 
and errors on an interface:

1] New Intel [same model] NIC.
2] Different ports in the switch.
3] New cable.
4] Switched PCI slots for the Intel Gigabit Card.
5] Switched BIOS settings/parameters to exact settings as other, identical
    machine.

None of these fixed the problem. There are two machines (same model) here 
with GigE nics, on one there are  very few (1-3) if any errors on the nic 
ever.  The test that I used that reproduces the problem the quickest is dd 
if=/dev/zero of=/nfsv3/udp/file.img where the dd is on another box sending 
to the box that gets the RX errors on the NIC.  Generally, there would be 
about 100 errors every 10 seconds.  There are two identical machines on 
the network here, both with this same Intel Gigabit NIC (82541GI/PI).  So 
one machine is running 2.6.5, the other 2.6.10, I figured it had to 
something in the kernel that was causing this.  Therefore I grabbed 
ethtool and installed it and did a basic query for network setting 
parameters, immediately I noticed a difference, which is shown below:

* Box with no problems.
# ethtool -a eth0
Pause parameters for eth0:
Autonegotiate:  on
RX:             on
TX:             on

* Box with NIC that generates errors, dropped packets and overrun errors.
# ethtool -a eth0
Pause parameters for eth0:
Autonegotiate:  on
RX:             off
TX:             off

According to the manpage:

        -A     change the pause parameters of the specified ethernet 
device.

        rx on|off
               Specify if RX pause is enabled.

        tx on|off
               Specify if TX pause is enabled.


# ethtool -A eth0 rx on
# ethtool -A eth0 tx on

My machine now:

# ethtool -a eth0
Pause parameters for eth0:
Autonegotiate:  on
RX:             on
TX:             on

Then, I re-run the dd command mentioned earlier and let it run for about 
ten minutes, long and behold not a single dropped packet, overrun or frame
error reported!

           RX packets:6157606 errors:0 dropped:0 overruns:0 frame:0

Previously, this is what I would get after only a minute of running that 
dd command (I also get the errors copying files etc, dd command just 
speeds things up):

           RX packets:6374096 errors:1419 dropped:1419 overruns:1419 frame:0

Afterwards, I no longer have any errors:

To the Intel/Kernel guys:

Question, these are identical machines for the most part, even the same 
nics are used in each box, why in 2.6.5 are the settings set differently 
than that in 2.6.10?  I do not believe that it is a distribution specific 
error as I did not even have ethtool installed before I checked this nor 
do I see it any boot scripts?  For now, I will just have it set the 
proper settings -A tx on and -A rx on but is there another way to do this 
or did it change in the kernel at some point?

Further investigation reveals on my main machine with an onboard Intel/PRO 
1000 built-in NIC which runs on the CSA bus (A-Bit IC7-G) the pause 
feature is also off; HOWEVER, (2.6GHZ w/HT) this machine does not exhibit 
any errors!

           RX packets:2471666 errors:0 dropped:0 overruns:0 frame:0
           TX packets:56413066 errors:0 dropped:0 overruns:0 carrier:0

Is it a bug that it defaults to off in the newer kernel versions, as it 
causes MASSIVE errors on the RX side of the fence?  Or should people who 
run gigabit interfaces on slower machines just add the ethool commands to 
their startup scripts to avoid the errors/etc?

There may be some parallel between speed_OF_CPU and whether it can 
handle it with the pause option on or off.  If anyone has any idea of what 
the pause option is about and why it changed from 2.6.5 to 2.6.10, I'd 
like to know!

Thanks!


