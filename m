Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262370AbUDTJGZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262370AbUDTJGZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 05:06:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262388AbUDTJGZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 05:06:25 -0400
Received: from adsl-76-231.38-151.net24.it ([151.38.231.76]:36365 "EHLO
	gateway.milesteg.arr") by vger.kernel.org with ESMTP
	id S262370AbUDTJFJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 05:05:09 -0400
Date: Tue, 20 Apr 2004 11:05:02 +0200
From: Daniele Venzano <webvenza@libero.it>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.26 IRDA BUG - blocker
Message-ID: <20040420090502.GB6363@picchio.gall.it>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20040419175718.GA7959@bougret.hpl.hp.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="3uo+9/B/ebqu+fSQ"
Content-Disposition: inline
In-Reply-To: <20040419175718.GA7959@bougret.hpl.hp.com>
X-Operating-System: Debian GNU/Linux on kernel Linux 2.4.25-grsec
X-Copyright: Forwarding or publishing without permission is prohibited.
X-Truth: La vita e' una questione di culo, o ce l'hai o te lo fanno.
X-GPG-Fingerprint: 642A A345 1CEF B6E3 925C  23CE DAB9 8764 25B3 57ED
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--3uo+9/B/ebqu+fSQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 19, 2004 at 10:57:18AM -0700, Jean Tourrilhes wrote:
> 	Same story, please read my web page on how to report bugs. And
> I bet the problem is the same.

You won the bet.
The echo 115200 > /proc/sys/net/irda/max_baud_rate made the trick.

What about putting some of that useful documentation under Documention/ ?
I took your web page, removed everything that looked unecessary or that
required frequent updates, and made the attached patch.

Before writing I made a grep -r irda linux-2.6.4/Documentation/, but
found nothing interesting. Since I was offline at the time, I could
not check google or irda.sf.net.

Perhaps this patch can reduce the amount of useless and unproper bug
reports against IrDA.

Bye.

-- 
-----------------------------
Daniele Venzano
Web: http://teg.homeunix.org


--3uo+9/B/ebqu+fSQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="irda.diff"

diff -Naur linux-2.6.5/Documentation/networking/irda.txt linux-irda-2.6.5/Documentation/networking/irda.txt
--- linux-2.6.5/Documentation/networking/irda.txt	2003-12-19 10:34:29.000000000 +0100
+++ linux-irda-2.6.5/Documentation/networking/irda.txt	2004-04-20 10:52:22.000000000 +0200
@@ -1,6 +1,9 @@
-To use the IrDA protocols within Linux you will need to get a suitable copy
-of the IrDA Utilities. More detailed information about these and associated
-programs can be found on http://irda.sourceforge.net/
+Linux-IrDA documentation by Jean Tourrilhes
+A page with much more informations, patches, links and current status can
+be found at: http://www.hpl.hp.com/personal/Jean_Tourrilhes/IrDA/IrDA.html
+
+The home page of the Linux-IrDA Project, with latest versions of user space
+utilities is here: http://irda.sourceforge.net/
 
 For more information about how to use the IrDA protocol stack, see the
 Linux Infared HOWTO (http://www.tuxmobil.org/Infrared-HOWTO/Infrared-HOWTO.html)
@@ -9,6 +12,858 @@
 There is an active mailing list for discussing Linux-IrDA matters called
     irda-users@lists.sourceforge.net
 
+                               ------------------
+
+   The instructions presented here should work for Linux Kernel 2.4.X and
+   Kernel 2.6.X. And they may work equally well for later kernels and kernel
+   2.2.15, and maybe others. Some other documentations on the web, like the
+   Linux-IrDA Howto are more generic and complete but not totally up to
+   date, so beware...
+
+                               ------------------
+
+Tutorial : How to use Linux-IrDA
+
+   A lot of IrDA novices mix up the low level and high level of the IrDA
+   stack. A few words...
+
+     * Low level of Linux-IrDA : this is the part of the IrDA stack dealing
+       with the IrDA hardware on your computer and managing it. The key words
+       are IrDA driver, IrDA ports (either SIR or FIR), IrDA dongles and
+       TTY/serial port.
+     * High level of Linux-IrDA : this is the part of the IrDA stack dealing
+       with communicating with the other IrDA device and exchanging the data
+       (the protocol). The key words are protocol, IrCOMM, IrLPT, OBEX, IrLAN
+       and IrNET.
+
+   The low level and high level are totally independant of each other,
+   however each need to be configured properly for what you want to do.
+
+   The procedure to get IrDA working looks usually like this :
+
+     * Configure everything
+     * Set up the low level to recognise your IrDA hardware
+     * Verify that the low level works
+     * Set up your application on top of the proper high level protocol
+
+   I also offer various debugging tips at the end of this document.
+
+                               ------------------
+
+Common configuration
+
+   Most Linux kernels don't come with IrDA enabled, and most distributions
+   come with very approximate config scripts. I don't trust those and I
+   always do things by myself.
+
+     * Get kernel of your choice, unpack the source in /usr/src
+     * Compile yourself a fresh kernel and make it boot properly.
+     * Configure the IrDA stack as a module, enable all options (as module if
+       possible) and the driver/protocols you need (as modules).
+     * Configure serial port as a module. Static is ok as well, except for
+       the NSC or FIR setup.
+     * Recompile the modules and install them :
+
+ > make modules ; make modules_install
+
+     * Install irda-utils-0.9.15 or later
+     * Add the following stuff in /etc/modules.conf :
+
+ # IrDA stuff...
+ alias tty-ldisc-11 irtty
+ alias char-major-161 ircomm-tty         # if you want IrCOMM support
+ # These values are hard-coded in irattach (not instance order)
+ alias irda-dongle-0  tekram             # Tekram IrMate IR-210B
+ alias irda-dongle-1  esi                # ESI JetEye
+ alias irda-dongle-2  actisys            # ACTiSYS IR-220L
+ alias irda-dongle-3  actisys            # ACTiSYS IR-220L+
+ alias irda-dongle-4  girbil             # Greenwich GIrBIL
+ alias irda-dongle-5  litelink           # Parallax LiteLink/ESI JetEye
+ alias irda-dongle-6  airport            # Adaptec Airport 1000 and 2000
+ alias irda-dongle-7  old_belkin         # Belkin (old) SmartBeam dongle
+ alias irda-dongle-8  ep7211_ir          # Cirrus Logic EP7211 Processor (ARM)
+ alias irda-dongle-9  mcp2120            # MCP2120 (Microchip) based
+ alias irda-dongle-10 act200l            # ACTiSYS Ir-200L
+ alias irda-dongle-11 ma600              # Mobile Action ma600
+ # IrNET module...
+ alias char-major-10-187 irnet           # Official allocation of IrNET
+
+     * Create the IrDA devices :
+
+ > mknod /dev/ircomm0 c 161 0
+ > mknod /dev/ircomm1 c 161 1
+ > mknod /dev/irlpt0 c 161 16
+ > mknod /dev/irlpt1 c 161 17
+ > mknod /dev/irnet c 10 187
+ > chmod 666 /dev/ir*
+
+     * Reboot
+
+   Now, it's time to check which hardware you want to make run...
+
+                               ------------------
+
+Kernel 2.6.X differences
+
+   Kernel 2.6.X drivers are slightly different from kernel 2.4.X described
+   above. The main driver differences are listed below. This list is known to
+   not be final.
+
+     * Driver irtty-sir replaces irtty for SIR mode
+     * Dongles drivers for irtty-sir have the -sir prefix added to their name
+       (to distinguish them from old style dongle drivers).
+     * Driver donauboe replaces toshoboe
+     * Driver smsc-ircc2 may replace smc-ircc
+
+   Module configuration is also different, you need to add the following in
+   /etc/modules.conf :
+
+ alias tty-ldisc-11 irtty-sir
+ alias char-major-161 ircomm-tty
+ alias irda-dongle-0 tekram-sir
+ alias irda-dongle-1 esi-sir
+ alias irda-dongle-2 actisys-sir
+ alias irda-dongle-3 actisys-sir
+ alias char-major-10-187 irnet
+
+                               ------------------
+
+Low level drivers
+
+   This really depend on the IrDA hardware that you have. I describe a few of
+   the options below. The two safest options are Laptop in SIR mode and
+   Serial dongle.
+
+                               ------------------
+
+Serial dongle (using irtty driver)
+
+   For all serial dongles, you need an IrDA driver, which is irtty, and a
+   dongle driver. The dongle I use if the Actisys 220L+, and the dongle
+   driver is called actisys (see list above). The setup for other dongles
+   should be very similar. I'm also using the first serial port in this
+   example (ttyS0), you may need to adapt to your case.
+
+     * Attach dongle to the serial port, and check which serial port it is.
+     * Check if the serial config is ok :
+
+ > setserial /dev/ttyS0
+ /dev/ttyS0, UART: 16550A, Port: 0x03f8, IRQ: 4
+
+     * If it say UART: unknown, your serial configuration is invalid.
+     * Start the IrDA stack :
+
+ > irattach /dev/ttyS0 -d actisys -s
+
+     * If you want to unload/stop the IrDA stack just kill all the IrDA
+       applications and do :
+
+ > killall irattach
+ > rmmod irtty actisys
+ > rmmod irda
+
+   Note : all the modern ESI dongles work better with the litelink driver.
+
+                               ------------------
+
+Laptop port in SIR mode (using irtty driver)
+
+   SIR (Serial Infrared) is not fast but almost always work and is easy to
+   set-up, so it's a safe bet. It will work only if the BIOS is set to SIR
+   mode, so don't bother otherwise. Some BIOS don't offer the setting and try
+   to be clever and autodetect the proper setting, but it doesn't always
+   works.
+
+   Note that some laptops (Toshiba) need special magic for their IrDA port to
+   be enabled.
+
+   The irtty driver will use the standard Linux serial driver.
+
+     * Go in the BIOS of the laptop, enable the Infrared port, and set it to
+       SIR mode.
+     * While in the BIOS, note the IO address and IRQ assigned to it.
+     * Using setserial or in the boot log messages, find the ttyS* that
+       correspond to this port. Let's assume /dev/ttyS1 (as in my laptop).
+     * Check if the serial config is ok :
+
+ > setserial /dev/ttyS1
+ /dev/ttyS1, UART: 16550A, Port: 0x02f8, IRQ: 3
+
+     * If it say UART: unknown, your serial configuration is invalid. If the
+       port and IRQ are different, it's usually OK.
+     * Start the IrDA stack :
+
+ > irattach /dev/ttyS1 -s
+
+     * Refer to previous example for more
+
+   Now, you just need to figure out on which side of the laptop if the IrDA
+   port...
+
+                               ------------------
+
+HP Omnibook 6000 in FIR mode
+
+   It seems that each laptop has its quirk when it come to FIR mode. I've
+   managed to get my OB6000 to work (great laptop BTW). Other laptops will be
+   different (different driver, different settings).
+
+     * Go in the BIOS of the laptop, enable the Infrared port, and set it to
+       FIR mode.
+     * Add the following stuff in /etc/modules.conf :
+
+ # NSC FIR chipset in the OB6000
+ alias irda0 nsc-ircc
+ options nsc-ircc dongle_id=0x08
+
+     * Remove the serial driver that gets in the way :
+
+ > setserial /dev/ttyS1 uart none
+ > rmmod serial
+
+     * Start the IrDA stack :
+
+ > irattach irda0 -s
+
+   The NSC driver gives me some pretty good performance.
+
+                               ------------------
+
+Other laptops in FIR mode
+
+   There is different FIR hardwares included in the various laptops.
+   Linux-IrDA support some of them (not all) in various degrees (from good to
+   bad). Moreover, it seems that each laptop has its quirk, so it's difficult
+   to list everything here.
+
+   For this reason, I recommend to make it work first in SIR mode. After
+   that, you can experiment, check the Howto and query the mailing list...
+
+   THe setup for most FIR drivers will follow the same pattern as the
+   Omnibook 6000 example above. You will need to find the proper value of the
+   modules parameters, set the BIOS properly, take care of conflicting
+   hardware (serial, Pcmcia cards and other interrupt conflicts) and start
+   the stack with irattach.
+
+   As a rule of thumb, the NSC driver seems to be the most functional (if you
+   set the proper dongle_id, which most likely 0x9, but sometimes 0x8), and
+   the old SMC driver the most problematic.
+
+                               ------------------
+
+USB FIR dongles
+
+   This driver is included in recent kernel. It's not as efficient as other
+   FIR hardware, but at least is supported and is relatively easy to get
+   working. Also, all the current products are based on the same hardware,
+   and we know most of its bugs.
+
+   The latest version of the driver has been tested with usb-uhci and
+   usb-ohci.
+
+     * Start the USB stack. If you have an UHCI hardware, it looks like :
+
+ > modprobe usb-uhci
+
+     * Load USB driver and start the IrDA stack :
+
+ > modprobe irda-usb
+ > irattach irda0 -s
+
+   If you have already some other IrDA hardware configured on the PC, the
+   driver won't load as irda0, so check the message log with dmesg. Also, the
+   driver can manage up to 4 IrDA-USB dongles per PC (that can be increased
+   in the source).
+
+   Recently a new type of USB dongle from SigmaTel has appeared on the market
+   which is not compliant with the IrDA-USB specification, and therefore
+   doesn't work with this driver. On the other hand, SigmaTel has made
+   available the full technical specification, so writing a driver for
+   it is possible. There is an alpha driver for 2.6.X in my patch list.
+
+   The MA 620 USB dongle is a SIR USB dongle, there is some howto for it
+   written by Martin Diehl.
+
+   Important note : in recent kernels, the USB team has added a driver called
+   ir-usb. Not only this driver is not compatible with the IrDA stack (the
+   IrDA driver is called irda-usb), but this driver will load automatically
+   before irda-usb, therefore preventing you to use it. Solution : get rid of
+   ir-usb. It may also be possible to blacklist ir-usb in
+   /etc/hotplug/blacklist. I would like to thank warmly the USB team for the
+   confusion they created. For complains, please direct to them.
+
+                               ------------------
+
+SIR with irport
+
+   The standard SIR driver is irtty, which uses the standard serial driver
+   and tty layer. This is the easiest and safest way to get IrDA working.
+
+   However, the tty layer adds some overhead and doesn't understand the IrDA
+   protocol, which make it unsuitable in some case (dongle without echo
+   cancelation) and less performant in others (small packets). That is why
+   there is a second driver, irport, which allow the IrDA stack direct access
+   to the serial port.
+
+   Unfortunately, the procedure to use irport is more complicated and less
+   well tested. Actually, I personally never managed to make irport work
+   reliably on any of my systems.
+
+     * Remove the serial driver that gets in the way :
+
+ > setserial /dev/ttyS0 uart none
+ > rmmod serial
+
+     * Load the irport driver and attach the dongle driver.
+
+ > modprobe irport io=0x3f8 irq=4
+ > dongle_attach irda0 -d actisys+
+
+     * Start the IrDA stack :
+
+ > irattach irda0 -s
+
+                               ------------------
+
+Checking that it works
+
+   The first test is to check if the discovery is happening properly. If the
+   IrDA driver is properly configured, the Linux-IrDA will discover other
+   IrDA devices in range. If the discover doesn't work, this indicate that
+   the low level is not configured properly (and you don't need to go any
+   further).
+
+   You can check if there is any device listed in the discovery log with :
+
+ > cat /proc/net/irda/discovery
+ IrLMP: Discovery log:
+
+ nickname: Jean Tourrilhes, hint: 0x8220, saddr: 0x913b1bbc, daddr: 0x5619b45e
+
+
+   You can also check various other files in /proc, or use irdadump, check
+   the debugging section.
+
+   Then, you might want to use a simple aplication, such as e-Squirt to
+   verify that everything works fine. Or you can skip directly to the next
+   section.
+
+   The big advantage of e-Squirt is that it is a really simple protocol,
+   doesn't stress the IrDA stack too much and we have implementation for
+   various platforms, so that you can test your setup with almost
+   anything on the other side (Linux, Win32, WinCE or Palm).
+
+   Compile the Linux e-Squirt library and the test programs on all Linux
+   computers, and go in the tests directory. On other platforms, load and
+   start the relevant the e-Squirt application.
+
+   If you want to use Linux as a receiver, just do :
+
+ ./squirt
+
+   To use Linux as a sender, you can do :
+
+ ./ultra_beacon http://cooltown.hp.com/
+ ./socket_squirt http://cooltown.hp.com/
+
+   With that, you should be able to exchange back and forth URLs and check
+   that your IrDA stack works. If not, continue to read below.
+
+   On caveat : Most implementations have two exclusive receiving modes, IrDA
+   and Ultra, and they switch between these (either as a preference setting,
+   or automatically triggerd by discovery packets). Linux is an exception and
+   can listen to both at the same time. This means that unless you do a
+   Linux-Linux test, only one of the two sender tests listed above will work
+   properly.
+
+                               ------------------
+
+Apps and protocols on top of the IrDA stack
+
+   If you want to run e-Squirt applications, you are done, and you just need
+   to run the application themselves, they should work.
+
+   Other applications and protocols you may want to run :
+
+     * TCP/IP over IrNET
+     * Terminal over IrCOMM
+     * TCP/IP over IrCOMM
+     * TCP/IP over IrLAN
+     * Connect to a mobile phones
+     * Obex to exchange files/objects with PDAs, Phones and other Obex devices
+
+   Note that I don't use IrCOMM and IrLAN, so I can't help much with that...
+
+                               ------------------
+
+Terminal over IrComm
+
+   This is a simple test to check that IrComm is working between two PCs.
+   After that, you can try more complex applications such as PPP. The
+   original instructions were sent on the mailing list.
+
+   Server side :
+   Start the terminal server
+
+ > getty ircomm0 DT19200 vt100           # Red-Hat syntax
+
+   or
+
+ > getty -L ircomm0 19200 vt100          # Debian syntax
+
+   At this point, your text terminal should get reset and you come back to a
+   login prompt. That's normal. I don't know what happen in X.
+
+   Client side with kermit :
+   Start the terminal emulator
+
+ > kermit
+ > > set line /dev/ircomm0
+ > > set speed 19200
+ > > connect
+ > > > stty sane                         # Get backspace to work ok
+
+   The prompt shouls appear after connect. Also, you need to ignore the
+   following message : "Warning: no access to tty (Inappropriate ioctl for
+   device). Thus, no job control enabled", and "Can't open terminal /dev/tty"
+
+   Client side with minicom :
+   Minicom is a bit more problematic, and I'm still fighting with it. I still
+   don't understand how to connect. I managed to make it work like this :
+
+     * start minicom
+     * Configure (^A O)
+     * sub-menu serial
+     * set to /dev/ircomm0
+     * set speed to 19200
+     * exit
+     * sub-menu "save as dft"
+     * exit
+     * Exit (^A X)
+     * restart minicom
+
+                               ------------------
+
+TCP/IP over IrCOMM between two PCs
+
+   This simple example of PPP over IrCOMM is somewhat similar to TCP/IP
+   over IrNET, and is not much use, except to verify the IrCOMM works
+   properly. Real life PPP over IrCOMM to a mobile phone will involve a much
+   more complex configuration (to configure the modem and dial).
+
+   Server side :
+   Start the ppp deamon
+
+ > pppd /dev/ircomm0 9600 local noauth passive
+
+   As you can see, the visible difference with IrNET is that we use
+   /dev/ircomm0 instead of /dev/irnet. Also, IrCOMM doesn't have the advanced
+   features of IrNET to specify IrDA peer.
+
+   Client side :
+   Start the ppp deamon Start the terminal emulator
+
+ > pppd /dev/ircomm0 9600 local noauth
+
+   At this point, the IrDA stack should connect (check with irdadump) and PPP
+   should create a new network device (usually ppp0) and configure IP and
+   route. You should be able to ping and connect to the other side using its
+   IP address.
+
+                               ------------------
+
+TCP/IP over IrLAN
+
+   I don't use IrLAN any longer, because I'm only using IrNET. I just did a
+   refresh on the original instructions that I sent on the mailing list
+   (removing mentions of irmanager which no longer exist).
+
+   IrLAN as an access option, which can be 1 (direct mode), 2 (peer to peer)
+   and 3 (hosted). Basically, you would use 2 if you connect to another PC, 1
+   if you connect to a transparent access point, and 3 if you are the access
+   point (Dag, correct me if I'm wrong). The HP Netbeamer is an access point,
+   but it accept connections only if the PC is in peer mode. Go figure...
+
+   PC -> HP NetBeamer :
+   Here is how to hook to the NetBeamer... After aligning the IrDA port or
+   after starting irattach, the light of the NetBeamer should flash. If it
+   doesn't, you may want to play with the slot_timeout value.
+
+ > insmod irlan access=2
+ > ifconfig irlan0 10.0.0.1 netmask 255.255.255.0 broadcast 10.0.0.255
+
+   At this point, the light goes solid green. Link is on, you can ping and
+   everybody is happy. You may want to add a gateway with "route add default
+   gw ...".
+
+   PC -> PC :
+   Not everybody has a NetBeamer, so here is a step by step on how to create
+   a link between two PCs.
+
+   On the first PC :
+
+ > insmod irlan access=2
+ > ifconfig irlan0 10.0.0.1 netmask 255.255.255.0 broadcast 10.0.0.255
+
+   On the second PC :
+
+ > insmod irlan access=2
+ > ifconfig irlan0 10.0.0.2 netmask 255.255.255.0 broadcast 10.0.0.255
+
+   After that, you should be able to ping and telnet...
+
+   Automated ifconfig :
+   By default, /etc/irda/network.opts is not used. In the previous example,
+   we ifconfig-ure irlan by hand. If you have a Red-Hat/Mandrake
+   distribution, irmanager can do the job automatically at the condition that
+   you create a file /etc/sysconfig/network-scripts/ifcfg-irlan0 and set the
+   right values in there... There might be more needed, but I'm not totally
+   expert on this...
+
+   For other distribution (like Debian), you need to replace the file
+   /etc/irda/network with possibly something from a Pcmcia package, and with
+   some editing you might get it to load network.opts...
+
+   You might also want to add in your /etc/conf.modules a "option irlan
+   access=2". So, if you use modprobe instead of insmod, you won't have to
+   specify access=2 on the command line.
+
+                               ------------------
+
+IrDA and mobile phones or PDAs
+
+   I don't have any mobile phone, and I don't use IrCOMM, so I can't help...
+
+   There is many people using IrDA to connect either to their mobile phone or
+   PDA, and lot's of them have put instructions in their web pages. You may
+   use OBEX to transfer simple objects, or PPP over IrCOMM to establish
+   connections, depending on the application and the device. The people doing
+   Gnokii are also quite knowledgeable in this area, so you may ask
+   advice on their mailing list, but please report IrDA bugs in the IrDA
+   mailing lists.
+
+   One of the most common gotcha is that applications need to be configured
+   to use the proper IrCOMM virtual port (which most often is /dev/ircomm0).
+
+   If I can't reproduce your problem, I can't debug it, so I can't fix it. If
+   I can't see anything obvious in the irdadump log, I won't bother. You may
+   also want to try to reproduce the problem between two Linux boxes (because
+   I may be able to reproduce that).
+
+                               ------------------
+
+Checking Linux-IrDA state and debugging
+
+   Of course, I'm sure that you won't get things smooth the first time.
+   Actually, I'm pretty sure you will struggle a little bit.
+
+   If you get the Obex stuff out of the loop (so, using Ultra or Socket, as
+   described above), the e-Squirt stuff is so simple that if anything doesn't
+   work you can bet that it's the IrDA stack.
+
+   The first trick is to check is the modules are loaded :
+
+ > cat /proc/modules
+ actisys                 1652   1 (autoclean)
+ irtty                   7524   2 (autoclean)
+ irda                  151905  11 (autoclean) [actisys irtty]
+
+   This is what a serial dongle setup would look like. If the modules don't
+   show up, check you modules configuration and check the error messages in
+   the log (with dmesg).
+
+   Then, check the bunch of files in /proc/net/irda :
+
+ > cat /proc/net/irda/discovery
+ IrLMP: Discovery log:
+
+ nickname: Jean Tourrilhes, hint: 0x8220, saddr: 0x913b1bbc, daddr: 0x5619b45e
+
+ > cat /proc/net/irda/irlap
+ irlap0 state: LAP_NDM
+   device name: irda0, hardware name: ttyS0
+   caddr: 0x52, saddr: 0x913b1bbc, daddr: 0x5619b45e
+   win size: 1, win: 1, line capacity: 4800, bytes left: 4800
+   tx queue len: 0 win queue len: 0 rbusy: FALSE mbusy: FALSE
+   retrans: 0 vs: 2 vr: 2 va: 0
+   qos   bps     maxtt   dsize   winsize addbofs mintt   ldisc   comp
+   tx    9600    0       64      1       12      0       0
+   rx    9600    0       64      1       12      0       0
+ > cat /proc/net/irda/irias
+ LM-IAS Objects:
+ name: hp:esquirt, id=76371435
+  - Attribute name: "IrDA:TinyTP:LsapSel", value[IAS_INTEGER]: 96
+
+ name: OBEX:ESquirt, id=76371435
+  - Attribute name: "IrDA:TinyTP:LsapSel", value[IAS_INTEGER]: 95
+
+ name: Device, id=0
+  - Attribute name: "IrLMPSupport", value[IAS_OCT_SEQ]: octet sequence
+
+  - Attribute name: "DeviceName", value[IAS_STRING]: "lagaffe"
+
+ name: hp:beacon, id=76371435
+  - Attribute name: "IrDA:TinyTP:LsapSel", value[IAS_INTEGER]: 97
+
+
+   There, you can see that the IrDA stack has discovered my Palm V, that my
+   IrDA port is ttyS0, that I'm not connected, and you can also see that I
+   have an e-Squirt application running that has opened a bunch of server
+   sockets (of course, if you haven't started e-Squirt, the IAS won't
+   contains all those sockets).
+
+   The ultimate debugging tool is irdadump (and remember that I require you
+   to use version 0.9.15 or later). You should run irdadump while attempting
+   to connect and check what's happening. A normal irdadump log with a IrDA
+   device in front of the port (not connected) should show something like
+   this :
+
+ > irdadump
+ 22:04:48.000713 xid:cmd 6f1e8511 > ffffffff S=6 s=0 (14)
+ 22:04:48.090705 xid:cmd 6f1e8511 > ffffffff S=6 s=1 (14)
+ 22:04:48.180714 xid:cmd 6f1e8511 > ffffffff S=6 s=2 (14)
+ 22:04:48.270734 xid:cmd 6f1e8511 > ffffffff S=6 s=3 (14)
+ 22:04:48.270698 xid:rsp 6f1e8511 < fb48d412 S=6 s=2 Jean Tourrilhes hint=8220 [ PDA/Palmtop IrOBEX ] (32)
+ 22:04:48.360742 xid:cmd 6f1e8511 > ffffffff S=6 s=4 (14)
+ 22:04:48.450733 xid:cmd 6f1e8511 > ffffffff S=6 s=5 (14)
+ 22:04:48.540762 xid:cmd 6f1e8511 > ffffffff S=6 s=* weblab10 hint=0400 [ Computer ] (24)
+
+   You see my Palm V answering the discoveries of Linux. The Palm shows the
+   infamous "Waiting for sender" pop-up.
+
+   On the other hand, if the stack is not properly configured (wrong port,
+   wrong driver), or if the device in front is not active, you will get
+   something like this :
+
+ 22:02:47.988983 xid:cmd 6f1e8511 > ffffffff S=6 s=0 (14)
+ 22:02:48.078981 xid:cmd 6f1e8511 > ffffffff S=6 s=1 (14)
+ 22:02:48.168992 xid:cmd 6f1e8511 > ffffffff S=6 s=2 (14)
+ 22:02:48.258995 xid:cmd 6f1e8511 > ffffffff S=6 s=3 (14)
+ 22:02:48.349018 xid:cmd 6f1e8511 > ffffffff S=6 s=4 (14)
+ 22:02:48.439035 xid:cmd 6f1e8511 > ffffffff S=6 s=5 (14)
+ 22:02:48.529063 xid:cmd 6f1e8511 > ffffffff S=6 s=* weblab10 hint=0400 [ Computer ] (24)
+
+   As you can see, nobody answer us...
+
+   After that, send a good bug report to the Linux-IrDA mailing list.
+
+                               ------------------
+
+The connection just "hang"
+
+   The first type of hang is a very classical problem, where the connection
+   hanging just after beeing negociated (after the packets called SNRM and
+   UA). The irdadump looks like the following :
+
+
+ 18:03:28.766071 xid:cmd ffffffff < af28ca67 S=6 s=0 (14)
+ 18:03:28.856067 xid:cmd ffffffff < af28ca67 S=6 s=1 (14)
+ 18:03:28.947685 xid:cmd ffffffff < af28ca67 S=6 s=2 (14)
+ 18:03:29.037383 xid:cmd ffffffff < af28ca67 S=6 s=3 (14)
+ 18:03:29.037549 xid:rsp 977f612c > af28ca67 S=6 s=3 lagaffe hint=4400 [ Computer LAN Access ] (23)
+ 18:03:29.126099 xid:cmd ffffffff < af28ca67 S=6 s=4 (14)
+ 18:03:29.216071 xid:cmd ffffffff < af28ca67 S=6 s=5 (14)
+ 18:03:29.316257 xid:cmd ffffffff < af28ca67 S=6 s=* tanguy hint=4400 [ Computer LAN Access ] (22)
+ 18:03:29.316433 snrm:cmd ca=fe pf=1 977f612c > af28ca67 new-ca=ba (32)
+ 18:03:29.417508 ua:rsp ca=ba pf=1 977f612c < af28ca67 (31)
+ 18:03:29.417646 rr:cmd > ca=ba pf=1 nr=0 (2)
+ 18:03:29.666173 rr:cmd > ca=ba pf=1 nr=0 (2)
+
+
+   If you are on the primary, you will see a series of rr:cmd until it
+   times-out. On the secondary, you won't see anything after the ua:rsp and
+   it will eventually timeout.
+
+   What most likely happening is that the negociated connection parameters
+   don't match. Usually, one end doesn't implement properly the speed that is
+   beeing negociated, so the two nodes can't hear each other after changing
+   speed. And most likely it happens at FIR speeds.
+
+   Of course, it would be nice to fix the driver, but in the short term the
+   solution is to force the IrDA stack to negociate a lower speed :
+
+ > echo 115200 > /proc/sys/net/irda/max_baud_rate
+
+   You can of course try lower values, and there is also other parameters you
+   can tweak in this directory.
+
+   There is second type of hang, that may look similar but is not. You may
+   see the IrDA stack "hanging" on transmitting a large packet (the last
+   number between parenthesis). This seems due to a bug in the some FIR
+   hardware.
+
+
+ 18:03:30.458569 i:rsp  < ca=ba pf=1 nr=6 ns=5 LM slsap=12 dlsap=10 CONN_CMD TTP credits=0(12)
+ 18:03:30.458740 i:cmd  > ca=ba pf=1 nr=6 ns=6 LM slsap=10 dlsap=12 CONN_RSP TTP credits=0(12)
+ 18:03:30.466399 rr:rsp < ca=ba pf=1 nr=7 (2)
+ 18:03:30.516548 rr:cmd > ca=ba pf=1 nr=6 (2)
+ 18:03:30.537423 i:rsp  < ca=ba pf=1 nr=7 ns=6 LM slsap=12 dlsap=10 TTP credits=0 (29)
+ 18:03:30.537663 rr:cmd > ca=ba pf=1 nr=7 (2)
+ 18:03:30.547328 rr:rsp < ca=ba pf=1 nr=7 (2)
+ 18:03:30.555025 i:cmd  > ca=ba pf=1 nr=7 ns=7 LM slsap=10 dlsap=12 TTP credits=1 (2050)
+ 18:03:30.566804 i:cmd  > ca=ba pf=1 nr=7 ns=7 LM slsap=10 dlsap=12 TTP credits=1 (2050)
+ 18:03:30.596405 i:cmd  > ca=ba pf=1 nr=7 ns=7 LM slsap=10 dlsap=12 TTP credits=1 (2050)
+
+
+   It may look a bit different for you, but you get the idea, the packet
+   doesn't goes through and is retried, and the communication just dies
+   there.
+
+   As we can't fix the hardware, the solution is to force the IrDA stack to
+   transmit smaller packets :
+
+ > echo 2000 > /proc/sys/net/irda/max_tx_data_size
+
+   Now, I've seen is a third type of hang which happen during the connection,
+   and not related to a large packet. This happens with buggy phones, such as
+   Ericsson phones (T39/T68/...).
+
+
+ 14:53:57.741656 snrm:cmd ca=fe pf=1 2cc4b1b4 > 29c42130 new-ca=ae
+         LAP QoS: Baud Rate=4000000bps Max Turn Time=500ms Data Size=2048B
+ Window Size=7 Add BOFS=0 Min Turn Time=1000us Link Disc=12s (33)
+ 14:53:57.877021 ua:rsp ca=ae pf=1 2cc4b1b4 < 29c42130  
+         LAP QoS: Baud Rate=1152000bps Max Turn Time=500ms Data Size=256B Window
+ Size=3 Add BOFS=0 Min Turn Time=0us Link Disc=12s (31)
+ 14:53:57.877622 rr:cmd > ca=ae pf=1 nr=0 (2)
+ 14:53:57.889399 rr:rsp < ca=ae pf=1 nr=0 (2)
+ 14:53:57.889468 i:cmd  > ca=ae pf=1 nr=0 ns=0 LM slsap=11 dlsap=00 CONN_CMD (6)
+ 14:53:57.895119 i:rsp  < ca=ae pf=1 nr=1 ns=0 LM slsap=00 dlsap=11 CONN_RSP (6)
+ 14:53:57.895264 i:cmd  > ca=ae pf=1 nr=1 ns=1 LM slsap=11 dlsap=00
+ GET_VALUE_BY_CLASS: "IrDA:IrCOMM" "Parameters" (28)
+ 14:53:57.899848 i:rsp  < ca=ae pf=1 nr=2 ns=1 LM slsap=00 dlsap=11
+ GET_VALUE_BY_CLASS: Success
+         IrCOMM Parameters Service Type=NINE_WIRE THREE_WIRE Port Type=PARALLEL (19)
+ 14:53:57.900690 i:cmd  > ca=ae pf=0 nr=2 ns=2 LM slsap=11 dlsap=00 DISC (6)
+ 14:53:57.900803 i:cmd  > ca=ae pf=1 nr=2 ns=3 LM slsap=12 dlsap=00 CONN_CMD (6)
+ 14:53:57.914408 rr:rsp < ca=ae pf=1 nr=4 (2)
+ 14:53:57.914453 rr:cmd > ca=ae pf=1 nr=2 (2)
+ 14:53:57.924388 rr:rsp < ca=ae pf=1 nr=4 (2)
+ 14:53:57.965741 rr:cmd > ca=ae pf=1 nr=2 (2)
+
+
+   The first interesting part of the log above is the Min Turn Time=0us. The
+   peer says that it can turn the link around in 0us, but I've never seen any
+   device that fast.
+
+   The problem here is that the Linux-IrDA stack gives the peer exactly what
+   he ask for, and the Linux-IrDA stack can be very fast in turning around.
+   And of course the peer can't keep up and doesn't receive properly the
+   frames, and after that it usually goes downhill.
+
+   In those cases, you may want mandate that Linux uses a large turnaround
+   time :
+
+ > echo 1000 > /proc/sys/net/irda/min_tx_turn_time
+
+   The second interesting part of the log above is that it fails just after
+   the Linux-IrDA sends two consecutive packets. IrLAP is a windowed protocol
+   (up to 7 consecutive frames), but some devices have trouble managing that
+   (such as the Ericsson phones and USB dongles).
+
+   In those cases, you may want limit Linux to send one frame per IrLAP
+   window :
+
+ > echo 1 > /proc/sys/net/irda/max_tx_window
+
+   Note that the patch adding max_tx_window to the IrDA stack is included
+   only in kernel 2.4.22.
+
+                               ------------------
+
+irattach print "tcsetattr" in the log
+
+   People using FIR drivers (nsc-ircc, smc-ircc...) are often confronted to
+   this simple problem. When they start irattach, it doesn't work and the
+   following message (or similar) is printed in the log :
+
+ irattach: tcsetattr: Invalid argument
+
+   This is due to a conflict between the Linux-IrDA FIR driver and the
+   regular Linux serial driver. Both want to manage the same hardware, the
+   serial driver has registered the FIR port as a pseudo serial port and is
+   owning it, and the kernel rightly prevent the FIR driver to get ownership
+   of it (it's first come first serve).
+
+   The solution is simple. You need to tell the serial driver that it should
+   not manage this port.
+
+   The safest way is to remove the serial driver :
+
+ > rmmod serial
+
+   Unfortunately, the trick above doesn't always work (non-modular driver,
+   another serial port in use). Another way is to declare the port invalid :
+
+ > setserial /dev/ttyS1 uart none
+
+   On the other hand, if you do that, you won't be able to use irtty (SIR
+   mode driver), because irtty uses the regular Linux serial driver. If you
+   change your mind and want to use the irtty driver, you can reenable the
+   serial port with :
+
+ > insmod serial
+ > setserial /dev/ttyS1 uart 16550A
+
+                               ------------------
+
+Common pitfalls
+
+   There is many way to get the IrDA stack to not run properly. Not following
+   instructions seems to be one of the most guaranteed way to reach that
+   goal.
+
+   Here are mistakes I've seen user make :
+
+     * IrDA ports not properly aligned
+     * irmanager running (it's obsolete, get rid of it)
+     * Let the init scripts of the distribution do the job
+     * irdaping running (prevent the LAP connection)
+     * Obsolete irda-utils
+     * using the wrong driver (FIR/irtty/irport)
+     * using the wrong port (/dev/ttyS0 vs /dev/ttyS1)
+     * Wrong permissions on the serial port (irattach must run as root)
+     * Some other application (such as pppd) grabbing the serial port
+     * Some other driver (most likely a Pcmcia card) using the IRQ that the
+       IrDA driver needs (for Pcmcia drivers, play with "exclude" directives
+       in /etc/pcmcia/config.opts)
+     * Wrong irattach command (irattach /dev/ttySX for SIR vs irattach irdaX
+       for FIR)
+     * Multiple instances of irattach for the same port (staying in
+       background)
+     * Wrong modules names (should be ircomm-tty, not ircomm_tty)
+     * IrDA modules not loaded
+     * Mixing up /dev/ttySX and /dev/ircommX. The stack runs on top of
+       /dev/ttySX and provides serial emulation through /dev/ircommX, so
+       serial apps should run on top of /dev/ircommX.
+     * Compiling the IrDA stack static (i.e. non module - it may work, but
+       this is not what the developpers work with)
+     * Compiling the IrDA stack without the IRDA_DEBUG option. This option
+       enable extra checks that prevent your kernel to crash.
+     * Mixing modules belonging to different versions of the IrDA stack
+     * Unclean IrDA source (failed patch)
+     * Mixing modules belonging to different kernel versions
+     * Trying to load an IrDA module on a stack wich has this code compiled
+       static (or loading module twice)
+     * Wrong version of modules tools (for kernel 2.4)
+     * Failed to do depmod -a (usually automatic at reboot)
+     * Using a version of the kernel which is not used and recommended by
+       developpers.
+
+                               ------------------
+
+Compilation problems
+
+   Sometimes, when you compile the IrDA stack or some various IrDA package,
+   you may have the compiler complaining the things such as
+   IRLMP_HINT_MASK_SET or IRDAPROTO_ULTRA are not defined.
+
+   This is because of a mess related to kernel headers and the way most
+   distributions deal with it. If you have the 2.4.X kernel source lying
+   around, the fix is simple. Just copy the header irda.h from the kernel to
+   your include directory :
 
+ cp /usr/src/linux/include/linux/irda.h /usr/include/linux
 
+   That should fix it ;-)
 

--3uo+9/B/ebqu+fSQ--
