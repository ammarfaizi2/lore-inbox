Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261754AbVDDDcO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261754AbVDDDcO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 23:32:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261983AbVDDDcO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 23:32:14 -0400
Received: from fire.osdl.org ([65.172.181.4]:13520 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261754AbVDDDbV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 23:31:21 -0400
Message-ID: <4250B4C5.2000200@osdl.org>
Date: Sun, 03 Apr 2005 20:30:13 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
CC: ioe-lkml@axxeo.de, matthew@wil.cx, lkml <linux-kernel@vger.kernel.org>,
       netdev@oss.sgi.com, hadi@cyberus.ca, cfriesen@nortel.com, tgraf@suug.ch
Subject: [PATCH] network configs: disconnect network options from drivers
References: <20050330234709.1868eee5.randy.dunlap@verizon.net> <20050331185226.GA8146@mars.ravnborg.org> <424C5745.7020501@osdl.org> <20050331203010.GA8034@mars.ravnborg.org>
In-Reply-To: <20050331203010.GA8034@mars.ravnborg.org>
Content-Type: multipart/mixed;
 boundary="------------000906010009010506010105"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000906010009010506010105
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Sam Ravnborg wrote:
> On Thu, Mar 31, 2005 at 12:02:13PM -0800, Randy.Dunlap wrote:
> 
>>Other than "sounds good," are there some comments on:
>>
>>a.  leaving IrDA and Bluetooth subsystem (with drivers) where they
>>    are, which is under "Network options and protocols"
>>	(I really don't want to split their drivers away from their
>>	subsystem, just to put them under Network driver support.)
> 
> 
> Agreed. All IrDA / Bluetooth stuff belongs together.
> Leave them where they are for now.
> 
> 
>>b.  leaving SLIP, PPP, and PLIP where they are under Network driver
>>    support, even though they say that they are "protocols" ?
> 
> SLIP and PLIP is no that common. PPP is more common for cable-modem/ADSL
> I suppose. But still it would make sense to create an Misc protocols
> menu, like we have a misc filesystems menu.

While looking into this suggestion, I see that SLIP, PLIP,
and PPP depend on NETDEVICES, and they use some netdev
interfaces, so they appear to be more like net devices
than protocols even though they are called
protocols in Kconfig text, so I am leaving them alone
for now.  Don't hesitate to correct me....

Any comments on this new version?

Thanks,
-- 
~Randy


--------------000906010009010506010105
Content-Type: text/x-patch;
 name="netconfigs_v4.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="netconfigs_v4.diff"


A few people dislike that the Networking Options menu is inside
the Device Drivers/Networking menu.  This patch moves the
Networking Options menu to immediately before the Device Drivers
menu, renames it to "Networking options and protocols", & moves
most protocols to more logical places.

Notes:
- IrDA & Bluetooth subsystems include protocols & drivers, yet
  they are displayed under Networking protocols.  I don't see
  much good reason to split them up.  (See, this is an example
  of why the Networking Options and Network Drivers were close
  together....)
- SLIP, PLIP, and PPP option names say that they are protocols,
  but they are sort of a hybrid device and protocol, and they
  use network device interfaces, so they remain listed under
  Network devices.

 drivers/Kconfig              |    4
 drivers/net/Kconfig          |    5
 net/Kconfig                  |  450 ++++++++++++++++++++++---------------------
 net/bridge/netfilter/Kconfig |    1
 4 files changed, 241 insertions(+), 219 deletions(-)

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>

diff -Naurp -X /home/rddunlap/doc/dontdiff-osdl linux-2612-rc1-bk5-pv/drivers/Kconfig linux-2612-rc1-bk5-netconfigs/drivers/Kconfig
--- linux-2612-rc1-bk5-pv/drivers/Kconfig	2005-03-01 23:38:26.000000000 -0800
+++ linux-2612-rc1-bk5-netconfigs/drivers/Kconfig	2005-04-03 19:45:18.330102257 -0700
@@ -1,5 +1,7 @@
 # drivers/Kconfig
 
+source "net/Kconfig"
+
 menu "Device Drivers"
 
 source "drivers/base/Kconfig"
@@ -28,7 +30,7 @@ source "drivers/message/i2o/Kconfig"
 
 source "drivers/macintosh/Kconfig"
 
-source "net/Kconfig"
+source "drivers/net/Kconfig"
 
 source "drivers/isdn/Kconfig"
 
diff -Naurp -X /home/rddunlap/doc/dontdiff-osdl linux-2612-rc1-bk5-pv/drivers/net/Kconfig linux-2612-rc1-bk5-netconfigs/drivers/net/Kconfig
--- linux-2612-rc1-bk5-pv/drivers/net/Kconfig	2005-04-03 19:42:32.000000000 -0700
+++ linux-2612-rc1-bk5-netconfigs/drivers/net/Kconfig	2005-04-03 19:45:18.335101815 -0700
@@ -1,8 +1,9 @@
-
 #
 # Network device configuration
 #
 
+menu "Network device support"
+
 config NETDEVICES
 	depends on NET
 	bool "Network device support"
@@ -2536,3 +2537,5 @@ config NETCONSOLE
 	If you want to log kernel messages over the network, enable this.
 	See <file:Documentation/networking/netconsole.txt> for details.
 
+endmenu
+
diff -Naurp -X /home/rddunlap/doc/dontdiff-osdl linux-2612-rc1-bk5-pv/net/bridge/netfilter/Kconfig linux-2612-rc1-bk5-netconfigs/net/bridge/netfilter/Kconfig
--- linux-2612-rc1-bk5-pv/net/bridge/netfilter/Kconfig	2005-03-01 23:37:50.000000000 -0800
+++ linux-2612-rc1-bk5-netconfigs/net/bridge/netfilter/Kconfig	2005-04-03 19:45:18.000000000 -0700
@@ -139,6 +139,7 @@ config BRIDGE_EBT_VLAN
 config BRIDGE_EBT_ARPREPLY
 	tristate "ebt: arp reply target support"
 	depends on BRIDGE_NF_EBTABLES
+	depends on INET
 	help
 	  This option adds the arp reply target, which allows
 	  automatically sending arp replies to arp requests.
diff -Naurp -X /home/rddunlap/doc/dontdiff-osdl linux-2612-rc1-bk5-pv/net/Kconfig linux-2612-rc1-bk5-netconfigs/net/Kconfig
--- linux-2612-rc1-bk5-pv/net/Kconfig	2005-04-03 19:42:35.000000000 -0700
+++ linux-2612-rc1-bk5-netconfigs/net/Kconfig	2005-04-03 19:45:18.000000000 -0700
@@ -2,7 +2,7 @@
 # Network configuration
 #
 
-menu "Networking support"
+menu "Networking options and protocols"
 
 config NET
 	bool "Networking support"
@@ -10,7 +10,9 @@ config NET
 	  Unless you really know what you are doing, you should say Y here.
 	  The reason is that some programs need kernel networking support even
 	  when running on a stand-alone machine that isn't connected to any
-	  other computer. If you are upgrading from an older kernel, you
+	  other computer.
+
+	  If you are upgrading from an older kernel, you
 	  should consider updating your networking tools too because changes
 	  in the kernel and the tools often go hand in hand. The tools are
 	  contained in the package net-tools, the location and version number
@@ -20,11 +22,9 @@ config NET
 	  recommended to read the NET-HOWTO, available from
 	  <http://www.tldp.org/docs.html#howto>.
 
-menu "Networking options"
-	depends on NET
-
 config PACKET
 	tristate "Packet socket"
+	depends on NET
 	---help---
 	  The Packet protocol is used by applications which communicate
 	  directly with network devices without an intermediate network
@@ -47,6 +47,7 @@ config PACKET_MMAP
 
 config UNIX
 	tristate "Unix domain sockets"
+	depends on NET
 	---help---
 	  If you say Y here, you will include support for Unix domain sockets;
 	  sockets are the standard Unix mechanism for establishing and
@@ -64,6 +65,7 @@ config UNIX
 
 config NET_KEY
 	tristate "PF_KEY sockets"
+	depends on NET
 	select XFRM
 	---help---
 	  PF_KEYv2 socket family, compatible to KAME ones.
@@ -72,8 +74,127 @@ config NET_KEY
 
 	  Say Y unless you know what you are doing.
 
+config NETPOLL
+	depends on NET
+	def_bool NETCONSOLE
+
+config NETPOLL_RX
+	bool "Netpoll support for trapping incoming packets"
+	default n
+	depends on NETPOLL
+
+config NETPOLL_TRAP
+	bool "Netpoll traffic trapping"
+	default n
+	depends on NETPOLL
+
+config NET_POLL_CONTROLLER
+	def_bool NETPOLL
+	depends on NET
+
+config BRIDGE
+	tristate "802.1d Ethernet Bridging"
+	depends on NET
+	---help---
+	  If you say Y here, then your Linux box will be able to act as an
+	  Ethernet bridge, which means that the different Ethernet segments it
+	  is connected to will appear as one Ethernet to the participants.
+	  Several such bridges can work together to create even larger
+	  networks of Ethernets using the IEEE 802.1 spanning tree algorithm.
+	  As this is a standard, Linux bridges will cooperate properly with
+	  other third party bridge products.
+
+	  In order to use the Ethernet bridge, you'll need the bridge
+	  configuration tools; see <file:Documentation/networking/bridge.txt>
+	  for location. Please read the Bridge mini-HOWTO for more
+	  information.
+
+	  If you enable iptables support along with the bridge support then you
+	  turn your bridge into a bridging IP firewall.
+	  iptables will then see the IP packets being bridged, so you need to
+	  take this into account when setting up your firewall rules.
+	  Enabling arptables support when bridging will let arptables see
+	  bridged ARP traffic in the arptables FORWARD chain.
+
+	  To compile this code as a module, choose M here: the module
+	  will be called bridge.
+
+	  If unsure, say N.
+
+config VLAN_8021Q
+	tristate "802.1Q VLAN Support"
+	depends on NET
+	---help---
+	  Select this and you will be able to create 802.1Q VLAN interfaces
+	  on your ethernet interfaces.  802.1Q VLAN supports almost
+	  everything a regular ethernet interface does, including
+	  firewalling, bridging, and of course IP traffic.  You will need
+	  the 'vconfig' tool from the VLAN project in order to effectively
+	  use VLANs.  See the VLAN web page for more information:
+	  <http://www.candelatech.com/~greear/vlan.html>
+
+	  To compile this code as a module, choose M here: the module
+	  will be called 8021q.
+
+	  If unsure, say N.
+
+config NET_DIVERT
+	bool "Frame Diverter (EXPERIMENTAL)"
+	depends on NET && EXPERIMENTAL
+	---help---
+	  The Frame Diverter allows you to divert packets from the
+	  network, that are not aimed at the interface receiving it (in
+	  promisc. mode). Typically, a Linux box setup as an Ethernet bridge
+	  with the Frames Diverter on, can do some *really* transparent www
+	  caching using a Squid proxy for example.
+
+	  This is very useful when you don't want to change your router's
+	  config (or if you simply don't have access to it).
+
+	  The other possible usages of diverting Ethernet Frames are
+	  numberous:
+	  - reroute smtp traffic to another interface
+	  - traffic-shape certain network streams
+	  - transparently proxy smtp connections
+	  - etc...
+
+	  For more informations, please refer to:
+	  <http://diverter.sourceforge.net/>
+	  <http://perso.wanadoo.fr/magpie/EtherDivert.html>
+
+	  If unsure, say N.
+
+config WAN_ROUTER
+	tristate "WAN router"
+	depends on NET && EXPERIMENTAL
+	---help---
+	  Wide Area Networks (WANs), such as X.25, frame relay and leased
+	  lines, are used to interconnect Local Area Networks (LANs) over vast
+	  distances with data transfer rates significantly higher than those
+	  achievable with commonly used asynchronous modem connections.
+	  Usually, a quite expensive external device called a `WAN router' is
+	  needed to connect to a WAN.
+
+	  As an alternative, WAN routing can be built into the Linux kernel.
+	  With relatively inexpensive WAN interface cards available on the
+	  market, a perfectly usable router can be built for less than half
+	  the price of an external router.  If you have one of those cards and
+	  wish to use your Linux box as a WAN router, say Y here and also to
+	  the WAN driver for your card, below.  You will then need the
+	  wan-tools package which is available from <ftp://ftp.sangoma.com/>.
+	  Read <file:Documentation/networking/wan-router.txt> for more
+	  information.
+
+	  To compile WAN routing support as a module, choose M here: the
+	  module will be called wanrouter.
+
+	  If unsure, say N.
+
+menu "Networking protocols"
+
 config INET
 	bool "TCP/IP networking"
+	depends on NET
 	---help---
 	  These are the protocols used on the Internet and on most local
 	  Ethernets. It is highly recommended to say Y here (this will enlarge
@@ -118,105 +239,12 @@ config IPV6
 
 source "net/ipv6/Kconfig"
 
-menuconfig NETFILTER
-	bool "Network packet filtering (replaces ipchains)"
-	---help---
-	  Netfilter is a framework for filtering and mangling network packets
-	  that pass through your Linux box.
-
-	  The most common use of packet filtering is to run your Linux box as
-	  a firewall protecting a local network from the Internet. The type of
-	  firewall provided by this kernel support is called a "packet
-	  filter", which means that it can reject individual network packets
-	  based on type, source, destination etc. The other kind of firewall,
-	  a "proxy-based" one, is more secure but more intrusive and more
-	  bothersome to set up; it inspects the network traffic much more
-	  closely, modifies it and has knowledge about the higher level
-	  protocols, which a packet filter lacks. Moreover, proxy-based
-	  firewalls often require changes to the programs running on the local
-	  clients. Proxy-based firewalls don't need support by the kernel, but
-	  they are often combined with a packet filter, which only works if
-	  you say Y here.
-
-	  You should also say Y here if you intend to use your Linux box as
-	  the gateway to the Internet for a local network of machines without
-	  globally valid IP addresses. This is called "masquerading": if one
-	  of the computers on your local network wants to send something to
-	  the outside, your box can "masquerade" as that computer, i.e. it
-	  forwards the traffic to the intended outside destination, but
-	  modifies the packets to make it look like they came from the
-	  firewall box itself. It works both ways: if the outside host
-	  replies, the Linux box will silently forward the traffic to the
-	  correct local computer. This way, the computers on your local net
-	  are completely invisible to the outside world, even though they can
-	  reach the outside and can receive replies. It is even possible to
-	  run globally visible servers from within a masqueraded local network
-	  using a mechanism called portforwarding. Masquerading is also often
-	  called NAT (Network Address Translation).
-
-	  Another use of Netfilter is in transparent proxying: if a machine on
-	  the local network tries to connect to an outside host, your Linux
-	  box can transparently forward the traffic to a local server,
-	  typically a caching proxy server.
-
-	  Yet another use of Netfilter is building a bridging firewall. Using
-	  a bridge with Network packet filtering enabled makes iptables "see"
-	  the bridged traffic. For filtering on the lower network and Ethernet
-	  protocols over the bridge, use ebtables (under bridge netfilter
-	  configuration).
-
-	  Various modules exist for netfilter which replace the previous
-	  masquerading (ipmasqadm), packet filtering (ipchains), transparent
-	  proxying, and portforwarding mechanisms. Please see
-	  <file:Documentation/Changes> under "iptables" for the location of
-	  these packages.
-
-	  Make sure to say N to "Fast switching" below if you intend to say Y
-	  here, as Fast switching currently bypasses netfilter.
-
-	  Chances are that you should say Y here if you compile a kernel which
-	  will run as a router and N for regular hosts. If unsure, say N.
-
-if NETFILTER
-
-config NETFILTER_DEBUG
-	bool "Network packet filtering debugging"
-	depends on NETFILTER
-	help
-	  You can say Y here if you want to get additional messages useful in
-	  debugging the netfilter code.
-
-config BRIDGE_NETFILTER
-	bool "Bridged IP/ARP packets filtering"
-	depends on BRIDGE && NETFILTER && INET
-	default y
-	---help---
-	  Enabling this option will let arptables resp. iptables see bridged
-	  ARP resp. IP traffic. If you want a bridging firewall, you probably
-	  want this option enabled.
-	  Enabling or disabling this option doesn't enable or disable
-	  ebtables.
-
-	  If unsure, say N.
-
-source "net/ipv4/netfilter/Kconfig"
-source "net/ipv6/netfilter/Kconfig"
-source "net/decnet/netfilter/Kconfig"
-source "net/bridge/netfilter/Kconfig"
-
-endif
-
-config XFRM
-       bool
-       depends on NET
-
-source "net/xfrm/Kconfig"
-
 source "net/sctp/Kconfig"
 
 config ATM
 	tristate "Asynchronous Transfer Mode (ATM) (EXPERIMENTAL)"
 	depends on EXPERIMENTAL
+	depends on NET
 	---help---
 	  ATM is a high-speed networking technology for Local Area Networks
 	  and Wide Area Networks.  It uses a fixed packet size and is
@@ -285,52 +313,9 @@ config ATM_BR2684_IPFILTER
 	  large number of IP-only vcc's.  Do not enable this unless you are sure
 	  you know what you are doing.
 
-config BRIDGE
-	tristate "802.1d Ethernet Bridging"
-	---help---
-	  If you say Y here, then your Linux box will be able to act as an
-	  Ethernet bridge, which means that the different Ethernet segments it
-	  is connected to will appear as one Ethernet to the participants.
-	  Several such bridges can work together to create even larger
-	  networks of Ethernets using the IEEE 802.1 spanning tree algorithm.
-	  As this is a standard, Linux bridges will cooperate properly with
-	  other third party bridge products.
-
-	  In order to use the Ethernet bridge, you'll need the bridge
-	  configuration tools; see <file:Documentation/networking/bridge.txt>
-	  for location. Please read the Bridge mini-HOWTO for more
-	  information.
-
-	  If you enable iptables support along with the bridge support then you
-	  turn your bridge into a bridging IP firewall.
-	  iptables will then see the IP packets being bridged, so you need to
-	  take this into account when setting up your firewall rules.
-	  Enabling arptables support when bridging will let arptables see
-	  bridged ARP traffic in the arptables FORWARD chain.
-
-	  To compile this code as a module, choose M here: the module
-	  will be called bridge.
-
-	  If unsure, say N.
-
-config VLAN_8021Q
-	tristate "802.1Q VLAN Support"
-	---help---
-	  Select this and you will be able to create 802.1Q VLAN interfaces
-	  on your ethernet interfaces.  802.1Q VLAN supports almost
-	  everything a regular ethernet interface does, including
-	  firewalling, bridging, and of course IP traffic.  You will need
-	  the 'vconfig' tool from the VLAN project in order to effectively
-	  use VLANs.  See the VLAN web page for more information:
-	  <http://www.candelatech.com/~greear/vlan.html>
-
-	  To compile this code as a module, choose M here: the module
-	  will be called 8021q.
-
-	  If unsure, say N.
-
 config DECNET
 	tristate "DECnet Support"
+	depends on NET
 	---help---
 	  The DECnet networking protocol was used in many products made by
 	  Digital (now Compaq).  It provides reliable stream and sequenced
@@ -358,6 +343,7 @@ source "net/llc/Kconfig"
 
 config IPX
 	tristate "The IPX protocol"
+	depends on NET
 	select LLC
 	---help---
 	  This is support for the Novell networking protocol, IPX, commonly
@@ -393,6 +379,7 @@ source "net/ipx/Kconfig"
 
 config ATALK
 	tristate "Appletalk protocol support"
+	depends on NET
 	select LLC
 	---help---
 	  AppleTalk is the protocol that Apple computers can use to communicate
@@ -422,7 +409,7 @@ source "drivers/net/appletalk/Kconfig"
 
 config X25
 	tristate "CCITT X.25 Packet Layer (EXPERIMENTAL)"
-	depends on EXPERIMENTAL
+	depends on NET && EXPERIMENTAL
 	---help---
 	  X.25 is a set of standardized network protocols, similar in scope to
 	  frame relay; the one physical line from your box to the X.25 network
@@ -453,7 +440,7 @@ config X25
 
 config LAPB
 	tristate "LAPB Data Link Driver (EXPERIMENTAL)"
-	depends on EXPERIMENTAL
+	depends on NET && EXPERIMENTAL
 	---help---
 	  Link Access Procedure, Balanced (LAPB) is the data link layer (i.e.
 	  the lower) part of the X.25 protocol. It offers a reliable
@@ -470,32 +457,6 @@ config LAPB
 	  To compile this driver as a module, choose M here: the
 	  module will be called lapb.  If unsure, say N.
 
-config NET_DIVERT
-	bool "Frame Diverter (EXPERIMENTAL)"
-	depends on EXPERIMENTAL
-	---help---
-	  The Frame Diverter allows you to divert packets from the
-	  network, that are not aimed at the interface receiving it (in
-	  promisc. mode). Typically, a Linux box setup as an Ethernet bridge
-	  with the Frames Diverter on, can do some *really* transparent www
-	  caching using a Squid proxy for example.
-
-	  This is very useful when you don't want to change your router's
-	  config (or if you simply don't have access to it).
-
-	  The other possible usages of diverting Ethernet Frames are
-	  numberous:
-	  - reroute smtp traffic to another interface
-	  - traffic-shape certain network streams
-	  - transparently proxy smtp connections
-	  - etc...
-
-	  For more informations, please refer to:
-	  <http://diverter.sourceforge.net/>
-	  <http://perso.wanadoo.fr/magpie/EtherDivert.html>
-
-	  If unsure, say N.
-
 config ECONET
 	tristate "Acorn Econet/AUN protocols (EXPERIMENTAL)"
 	depends on EXPERIMENTAL && INET
@@ -529,32 +490,109 @@ config ECONET_NATIVE
 	  Say Y here if you have a native Econet network card installed in
 	  your computer.
 
-config WAN_ROUTER
-	tristate "WAN router"
-	depends on EXPERIMENTAL
+source "net/ax25/Kconfig"
+
+source "net/irda/Kconfig"
+
+source "net/bluetooth/Kconfig"
+
+endmenu
+# end options and protocols
+
+menuconfig NETFILTER
+	bool "Network packet filtering (replaces ipchains)"
 	---help---
-	  Wide Area Networks (WANs), such as X.25, frame relay and leased
-	  lines, are used to interconnect Local Area Networks (LANs) over vast
-	  distances with data transfer rates significantly higher than those
-	  achievable with commonly used asynchronous modem connections.
-	  Usually, a quite expensive external device called a `WAN router' is
-	  needed to connect to a WAN.
+	  Netfilter is a framework for filtering and mangling network packets
+	  that pass through your Linux box.
 
-	  As an alternative, WAN routing can be built into the Linux kernel.
-	  With relatively inexpensive WAN interface cards available on the
-	  market, a perfectly usable router can be built for less than half
-	  the price of an external router.  If you have one of those cards and
-	  wish to use your Linux box as a WAN router, say Y here and also to
-	  the WAN driver for your card, below.  You will then need the
-	  wan-tools package which is available from <ftp://ftp.sangoma.com/>.
-	  Read <file:Documentation/networking/wan-router.txt> for more
-	  information.
+	  The most common use of packet filtering is to run your Linux box as
+	  a firewall protecting a local network from the Internet. The type of
+	  firewall provided by this kernel support is called a "packet
+	  filter", which means that it can reject individual network packets
+	  based on type, source, destination etc. The other kind of firewall,
+	  a "proxy-based" one, is more secure but more intrusive and more
+	  bothersome to set up; it inspects the network traffic much more
+	  closely, modifies it and has knowledge about the higher level
+	  protocols, which a packet filter lacks. Moreover, proxy-based
+	  firewalls often require changes to the programs running on the local
+	  clients. Proxy-based firewalls don't need support by the kernel, but
+	  they are often combined with a packet filter, which only works if
+	  you say Y here.
 
-	  To compile WAN routing support as a module, choose M here: the
-	  module will be called wanrouter.
+	  You should also say Y here if you intend to use your Linux box as
+	  the gateway to the Internet for a local network of machines without
+	  globally valid IP addresses. This is called "masquerading": if one
+	  of the computers on your local network wants to send something to
+	  the outside, your box can "masquerade" as that computer, i.e. it
+	  forwards the traffic to the intended outside destination, but
+	  modifies the packets to make it look like they came from the
+	  firewall box itself. It works both ways: if the outside host
+	  replies, the Linux box will silently forward the traffic to the
+	  correct local computer. This way, the computers on your local net
+	  are completely invisible to the outside world, even though they can
+	  reach the outside and can receive replies. It is even possible to
+	  run globally visible servers from within a masqueraded local network
+	  using a mechanism called portforwarding. Masquerading is also often
+	  called NAT (Network Address Translation).
+
+	  Another use of Netfilter is in transparent proxying: if a machine on
+	  the local network tries to connect to an outside host, your Linux
+	  box can transparently forward the traffic to a local server,
+	  typically a caching proxy server.
+
+	  Yet another use of Netfilter is building a bridging firewall. Using
+	  a bridge with Network packet filtering enabled makes iptables "see"
+	  the bridged traffic. For filtering on the lower network and Ethernet
+	  protocols over the bridge, use ebtables (under bridge netfilter
+	  configuration).
+
+	  Various modules exist for netfilter which replace the previous
+	  masquerading (ipmasqadm), packet filtering (ipchains), transparent
+	  proxying, and portforwarding mechanisms. Please see
+	  <file:Documentation/Changes> under "iptables" for the location of
+	  these packages.
+
+	  Make sure to say N to "Fast switching" below if you intend to say Y
+	  here, as Fast switching currently bypasses netfilter.
+
+	  Chances are that you should say Y here if you compile a kernel which
+	  will run as a router and N for regular hosts. If unsure, say N.
+
+if NETFILTER
+
+config NETFILTER_DEBUG
+	bool "Network packet filtering debugging"
+	depends on NETFILTER
+	help
+	  You can say Y here if you want to get additional messages useful in
+	  debugging the netfilter code.
+
+config BRIDGE_NETFILTER
+	bool "Bridged IP/ARP packets filtering"
+	depends on BRIDGE && NETFILTER && INET
+	default y
+	---help---
+	  Enabling this option will let arptables resp. iptables see bridged
+	  ARP resp. IP traffic. If you want a bridging firewall, you probably
+	  want this option enabled.
+	  Enabling or disabling this option doesn't enable or disable
+	  ebtables.
 
 	  If unsure, say N.
 
+source "net/ipv4/netfilter/Kconfig"
+source "net/ipv6/netfilter/Kconfig"
+source "net/decnet/netfilter/Kconfig"
+source "net/bridge/netfilter/Kconfig"
+
+endif
+# NETFILTER
+
+config XFRM
+       bool
+
+source "net/xfrm/Kconfig"
+
 menu "QoS and/or fair queueing"
 
 config NET_SCHED
@@ -596,12 +634,14 @@ config NET_SCHED
 source "net/sched/Kconfig"
 
 endmenu
+# end SCHED
 
 menu "Network testing"
 
 config NET_PKTGEN
 	tristate "Packet Generator (USE WITH CAUTION)"
 	depends on PROC_FS
+	depends on INET
 	---help---
 	  This module will inject preconfigured packets, at a configurable
 	  rate, out of a given interface.  It is used for network interface
@@ -615,32 +655,8 @@ config NET_PKTGEN
 	  module will be called pktgen.
 
 endmenu
+# end PKTGEN
 
 endmenu
-
-config NETPOLL
-	def_bool NETCONSOLE
-
-config NETPOLL_RX
-	bool "Netpoll support for trapping incoming packets"
-	default n
-	depends on NETPOLL
-
-config NETPOLL_TRAP
-	bool "Netpoll traffic trapping"
-	default n
-	depends on NETPOLL
-
-config NET_POLL_CONTROLLER
-	def_bool NETPOLL
-
-source "net/ax25/Kconfig"
-
-source "net/irda/Kconfig"
-
-source "net/bluetooth/Kconfig"
-
-source "drivers/net/Kconfig"
-
-endmenu
+# end top support: options and protocols
 

--------------000906010009010506010105--
