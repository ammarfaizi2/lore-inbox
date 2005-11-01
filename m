Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750805AbVKAOMn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750805AbVKAOMn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 09:12:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750802AbVKAOMn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 09:12:43 -0500
Received: from postel.suug.ch ([195.134.158.23]:29158 "EHLO postel.suug.ch")
	by vger.kernel.org with ESMTP id S1750800AbVKAOMm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 09:12:42 -0500
Date: Tue, 1 Nov 2005 15:13:02 +0100
From: Thomas Graf <tgraf@suug.ch>
To: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Cc: bunk@stusta.de, jengelh@linux01.gwdg.de, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: [PKT_SCHED]: Rework QoS and/or fair queueing configuration
Message-ID: <20051101141302.GM23537@postel.suug.ch>
References: <Pine.LNX.4.61.0510280902470.6910@yvahk01.tjqt.qr> <20051031102621.GF8009@stusta.de> <20051031132729.GK23537@postel.suug.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051031132729.GK23537@postel.suug.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Make "QoS and/or fair queueing" have its own menu, it's too big to be
inlined into "Network options". Remove the obsolete NET_QOS option.
Automatically select NET_CLS if needed. Do the same for NET_ESTIMATOR
but allow it to be selected manually for statistical purposes. Add
comments to separate queueing from classification. Fix dependencies
and ordering of classifiers. Improve descriptions/help texts and
remove outdated pieces.

Signed-off-by: Thomas Graf <tgraf@suug.ch>

Index: linux-2.6/net/sched/Kconfig
===================================================================
--- linux-2.6.orig/net/sched/Kconfig
+++ linux-2.6/net/sched/Kconfig
@@ -2,13 +2,15 @@
 # Traffic control configuration.
 # 
 
-menuconfig NET_SCHED
+menu "QoS and/or fair queueing"
+
+config NET_SCHED
 	bool "QoS and/or fair queueing"
 	---help---
 	  When the kernel has several packets to send out over a network
 	  device, it has to decide which ones to send first, which ones to
-	  delay, and which ones to drop. This is the job of the packet
-	  scheduler, and several different algorithms for how to do this
+	  delay, and which ones to drop. This is the job of the queueing
+	  disciplines, several different algorithms for how to do this
 	  "fairly" have been proposed.
 
 	  If you say N here, you will get the standard packet scheduler, which
@@ -23,13 +25,13 @@ menuconfig NET_SCHED
 	  To administer these schedulers, you'll need the user-level utilities
 	  from the package iproute2+tc at <ftp://ftp.tux.org/pub/net/ip-routing/>.
 	  That package also contains some documentation; for more, check out
-	  <http://snafu.freedom.org/linux2.2/iproute-notes.html>.
+	  <http://linux-net.osdl.org/index.php/Iproute2>.
 
 	  This Quality of Service (QoS) support will enable you to use
 	  Differentiated Services (diffserv) and Resource Reservation Protocol
-	  (RSVP) on your Linux router if you also say Y to "QoS support",
-	  "Packet classifier API" and to some classifiers below. Documentation
-	  and software is at <http://diffserv.sourceforge.net/>.
+	  (RSVP) on your Linux router if you also say Y to the corresponding
+	  classifiers below.  Documentation and software is at
+	  <http://diffserv.sourceforge.net/>.
 
 	  If you say Y here and to "/proc file system" below, you will be able
 	  to read status information about packet schedulers from the file
@@ -42,7 +44,7 @@ choice
 	prompt "Packet scheduler clock source"
 	depends on NET_SCHED
 	default NET_SCH_CLK_JIFFIES
-	help
+	---help---
 	  Packet schedulers need a monotonic clock that increments at a static
 	  rate. The kernel provides several suitable interfaces, each with
 	  different properties:
@@ -56,7 +58,7 @@ choice
 
 config NET_SCH_CLK_JIFFIES
 	bool "Timer interrupt"
-	help
+	---help---
 	  Say Y here if you want to use the timer interrupt (jiffies) as clock
 	  source. This clock source is fast, synchronized on all processors and
 	  handles cpu clock frequency changes, but its resolution is too low
@@ -64,7 +66,7 @@ config NET_SCH_CLK_JIFFIES
 
 config NET_SCH_CLK_GETTIMEOFDAY
 	bool "gettimeofday"
-	help
+	---help---
 	  Say Y here if you want to use gettimeofday as clock source. This clock
 	  source has high resolution, is synchronized on all processors and
 	  handles cpu clock frequency changes, but it is slow.
@@ -77,7 +79,7 @@ config NET_SCH_CLK_GETTIMEOFDAY
 config NET_SCH_CLK_CPU
 	bool "CPU cycle counter"
 	depends on ((X86_TSC || X86_64) && !SMP) || ALPHA || SPARC64 || PPC64 || IA64
-	help
+	---help---
 	  Say Y here if you want to use the CPU's cycle counter as clock source.
 	  This is a cheap and high resolution clock source, but on some
 	  architectures it is not synchronized on all processors and doesn't
@@ -95,134 +97,129 @@ config NET_SCH_CLK_CPU
 
 endchoice
 
+comment "Queueing/Scheduling"
+	depends on NET_SCHED
+
 config NET_SCH_CBQ
-	tristate "CBQ packet scheduler"
+	tristate "Class Based Queueing (CBQ)"
 	depends on NET_SCHED
 	---help---
 	  Say Y here if you want to use the Class-Based Queueing (CBQ) packet
-	  scheduling algorithm for some of your network devices.  This
-	  algorithm classifies the waiting packets into a tree-like hierarchy
-	  of classes; the leaves of this tree are in turn scheduled by
-	  separate algorithms (called "disciplines" in this context).
+	  scheduling algorithm. This algorithm classifies the waiting packets
+	  into a tree-like hierarchy of classes; the leaves of this tree are
+	  in turn scheduled by separate algorithms.
 
-	  See the top of <file:net/sched/sch_cbq.c> for references about the
-	  CBQ algorithm.
+	  See the top of <file:net/sched/sch_cbq.c> for more details.
 
 	  CBQ is a commonly used scheduler, so if you're unsure, you should
 	  say Y here. Then say Y to all the queueing algorithms below that you
-	  want to use as CBQ disciplines.  Then say Y to "Packet classifier
-	  API" and say Y to all the classifiers you want to use; a classifier
-	  is a routine that allows you to sort your outgoing traffic into
-	  classes based on a certain criterion.
+	  want to use as leaf disciplines.
 
 	  To compile this code as a module, choose M here: the
 	  module will be called sch_cbq.
 
 config NET_SCH_HTB
-	tristate "HTB packet scheduler"
+	tristate "Hierarchical Token Bucket (HTB)"
 	depends on NET_SCHED
 	---help---
 	  Say Y here if you want to use the Hierarchical Token Buckets (HTB)
-	  packet scheduling algorithm for some of your network devices. See
+	  packet scheduling algorithm. See
 	  <http://luxik.cdi.cz/~devik/qos/htb/> for complete manual and
 	  in-depth articles.
 
-	  HTB is very similar to the CBQ regarding its goals however is has 
+	  HTB is very similar to CBQ regarding its goals however is has
 	  different properties and different algorithm.
 
 	  To compile this code as a module, choose M here: the
 	  module will be called sch_htb.
 
 config NET_SCH_HFSC
-	tristate "HFSC packet scheduler"
+	tristate "Hierarchical Fair Service Curve (HFSC)"
 	depends on NET_SCHED
 	---help---
 	  Say Y here if you want to use the Hierarchical Fair Service Curve
-	  (HFSC) packet scheduling algorithm for some of your network devices.
+	  (HFSC) packet scheduling algorithm.
 
 	  To compile this code as a module, choose M here: the
 	  module will be called sch_hfsc.
 
-#tristate '  H-PFQ packet scheduler' CONFIG_NET_SCH_HPFQ
 config NET_SCH_ATM
-	tristate "ATM pseudo-scheduler"
+	tristate "ATM Virtual Circuits (ATM)"
 	depends on NET_SCHED && ATM
 	---help---
 	  Say Y here if you want to use the ATM pseudo-scheduler.  This
-	  provides a framework for invoking classifiers (aka "filters"), which
-	  in turn select classes of this queuing discipline.  Each class maps
-	  the flow(s) it is handling to a given virtual circuit (see the top of
-	  <file:net/sched/sch_atm.c>).
+	  provides a framework for invoking classifiers, which in turn
+	  select classes of this queuing discipline.  Each class maps
+	  the flow(s) it is handling to a given virtual circuit.
+
+	  See the top of <file:net/sched/sch_atm.c>) for more details.
 
 	  To compile this code as a module, choose M here: the
 	  module will be called sch_atm.
 
 config NET_SCH_PRIO
-	tristate "The simplest PRIO pseudoscheduler"
+	tristate "Multi Band Priority Queueing (PRIO)"
 	depends on NET_SCHED
-	help
+	---help---
 	  Say Y here if you want to use an n-band priority queue packet
-	  "scheduler" for some of your network devices or as a leaf discipline
-	  for the CBQ scheduling algorithm. If unsure, say Y.
+	  scheduler.
 
 	  To compile this code as a module, choose M here: the
 	  module will be called sch_prio.
 
 config NET_SCH_RED
-	tristate "RED queue"
+	tristate "Random Early Detection (RED)"
 	depends on NET_SCHED
-	help
+	---help---
 	  Say Y here if you want to use the Random Early Detection (RED)
-	  packet scheduling algorithm for some of your network devices (see
-	  the top of <file:net/sched/sch_red.c> for details and references
-	  about the algorithm).
+	  packet scheduling algorithm.
+
+	  See the top of <file:net/sched/sch_red.c> for more details.
 
 	  To compile this code as a module, choose M here: the
 	  module will be called sch_red.
 
 config NET_SCH_SFQ
-	tristate "SFQ queue"
+	tristate "Stochastic Fairness Queueing (SFQ)"
 	depends on NET_SCHED
 	---help---
 	  Say Y here if you want to use the Stochastic Fairness Queueing (SFQ)
-	  packet scheduling algorithm for some of your network devices or as a
-	  leaf discipline for the CBQ scheduling algorithm (see the top of
-	  <file:net/sched/sch_sfq.c> for details and references about the SFQ
-	  algorithm).
+	  packet scheduling algorithm .
+
+	  See the top of <file:net/sched/sch_sfq.c> for more details.
 
 	  To compile this code as a module, choose M here: the
 	  module will be called sch_sfq.
 
 config NET_SCH_TEQL
-	tristate "TEQL queue"
+	tristate "True Link Equalizer (TEQL)"
 	depends on NET_SCHED
 	---help---
 	  Say Y here if you want to use the True Link Equalizer (TLE) packet
-	  scheduling algorithm for some of your network devices or as a leaf
-	  discipline for the CBQ scheduling algorithm. This queueing
-	  discipline allows the combination of several physical devices into
-	  one virtual device. (see the top of <file:net/sched/sch_teql.c> for
-	  details).
+	  scheduling algorithm. This queueing discipline allows the combination
+	  of several physical devices into one virtual device.
+
+	  See the top of <file:net/sched/sch_teql.c> for more details.
 
 	  To compile this code as a module, choose M here: the
 	  module will be called sch_teql.
 
 config NET_SCH_TBF
-	tristate "TBF queue"
+	tristate "Token Bucket Filter (TBF)"
 	depends on NET_SCHED
-	help
-	  Say Y here if you want to use the Simple Token Bucket Filter (TBF)
-	  packet scheduling algorithm for some of your network devices or as a
-	  leaf discipline for the CBQ scheduling algorithm (see the top of
-	  <file:net/sched/sch_tbf.c> for a description of the TBF algorithm).
+	---help---
+	  Say Y here if you want to use the Token Bucket Filter (TBF) packet
+	  scheduling algorithm.
+
+	  See the top of <file:net/sched/sch_tbf.c> for more details.
 
 	  To compile this code as a module, choose M here: the
 	  module will be called sch_tbf.
 
 config NET_SCH_GRED
-	tristate "GRED queue"
+	tristate "Generic Random Early Detection (GRED)"
 	depends on NET_SCHED
-	help
+	---help---
 	  Say Y here if you want to use the Generic Random Early Detection
 	  (GRED) packet scheduling algorithm for some of your network devices
 	  (see the top of <file:net/sched/sch_red.c> for details and
@@ -232,9 +229,9 @@ config NET_SCH_GRED
 	  module will be called sch_gred.
 
 config NET_SCH_DSMARK
-	tristate "Diffserv field marker"
+	tristate "Differentiated Services marker (DSMARK)"
 	depends on NET_SCHED
-	help
+	---help---
 	  Say Y if you want to schedule packets according to the
 	  Differentiated Services architecture proposed in RFC 2475.
 	  Technical information on this method, with pointers to associated
@@ -244,9 +241,9 @@ config NET_SCH_DSMARK
 	  module will be called sch_dsmark.
 
 config NET_SCH_NETEM
-	tristate "Network emulator"
+	tristate "Network emulator (NETEM)"
 	depends on NET_SCHED
-	help
+	---help---
 	  Say Y if you want to emulate network delay, loss, and packet
 	  re-ordering. This is often useful to simulate networks when
 	  testing applications or protocols.
@@ -259,58 +256,23 @@ config NET_SCH_NETEM
 config NET_SCH_INGRESS
 	tristate "Ingress Qdisc"
 	depends on NET_SCHED 
-	help
-	  If you say Y here, you will be able to police incoming bandwidth
-	  and drop packets when this bandwidth exceeds your desired rate.
+	---help---
+	  Say Y here if you want to use classifiers for incoming packets.
 	  If unsure, say Y.
 
 	  To compile this code as a module, choose M here: the
 	  module will be called sch_ingress.
 
-config NET_QOS
-	bool "QoS support"
+comment "Classification"
 	depends on NET_SCHED
-	---help---
-	  Say Y here if you want to include Quality Of Service scheduling
-	  features, which means that you will be able to request certain
-	  rate-of-flow limits for your network devices.
-
-	  This Quality of Service (QoS) support will enable you to use
-	  Differentiated Services (diffserv) and Resource Reservation Protocol
-	  (RSVP) on your Linux router if you also say Y to "Packet classifier
-	  API" and to some classifiers below. Documentation and software is at
-	  <http://diffserv.sourceforge.net/>.
-
-	  Note that the answer to this question won't directly affect the
-	  kernel: saying N will just cause the configurator to skip all
-	  the questions about QoS support.
-
-config NET_ESTIMATOR
-	bool "Rate estimator"
-	depends on NET_QOS
-	help
-	  In order for Quality of Service scheduling to work, the current
-	  rate-of-flow for a network device has to be estimated; if you say Y
-	  here, the kernel will do just that.
 
 config NET_CLS
-	bool "Packet classifier API"
-	depends on NET_SCHED
-	---help---
-	  The CBQ scheduling algorithm requires that network packets which are
-	  scheduled to be sent out over a network device be classified
-	  according to some criterion. If you say Y here, you will get a
-	  choice of several different packet classifiers with the following
-	  questions.
-
-	  This will enable you to use Differentiated Services (diffserv) and
-	  Resource Reservation Protocol (RSVP) on your Linux router.
-	  Documentation and software is at
-	  <http://diffserv.sourceforge.net/>.
+	boolean
 
 config NET_CLS_BASIC
-	tristate "Basic classifier"
-	depends on NET_CLS
+	tristate "Elementary classification (BASIC)"
+	depends NET_SCHED
+	select NET_CLS
 	---help---
 	  Say Y here if you want to be able to classify packets using
 	  only extended matches and actions.
@@ -319,24 +281,25 @@ config NET_CLS_BASIC
 	  module will be called cls_basic.
 
 config NET_CLS_TCINDEX
-	tristate "TC index classifier"
-	depends on NET_CLS
-	help
-	  If you say Y here, you will be able to classify outgoing packets
-	  according to the tc_index field of the skb. You will want this
-	  feature if you want to implement Differentiated Services using
-	  sch_dsmark. If unsure, say Y.
+	tristate "Traffic-Control Index (TCINDEX)"
+	depends NET_SCHED
+	select NET_CLS
+	---help---
+	  Say Y here if you want to be able to classify packets based on
+	  traffic control indices. You will want this feature if you want
+	  to implement Differentiated Services together with DSMARK.
 
 	  To compile this code as a module, choose M here: the
 	  module will be called cls_tcindex.
 
 config NET_CLS_ROUTE4
-	tristate "Routing table based classifier"
-	depends on NET_CLS
+	tristate "Routing decision (ROUTE)"
+	depends NET_SCHED
 	select NET_CLS_ROUTE
-	help
-	  If you say Y here, you will be able to classify outgoing packets
-	  according to the route table entry they matched. If unsure, say Y.
+	select NET_CLS
+	---help---
+	  If you say Y here, you will be able to classify packets
+	  according to the route table entry they matched.
 
 	  To compile this code as a module, choose M here: the
 	  module will be called cls_route.
@@ -346,58 +309,45 @@ config NET_CLS_ROUTE
 	default n
 
 config NET_CLS_FW
-	tristate "Firewall based classifier"
-	depends on NET_CLS
-	help
-	  If you say Y here, you will be able to classify outgoing packets
-	  according to firewall criteria you specified.
+	tristate "Netfilter mark (FW)"
+	depends NET_SCHED
+	select NET_CLS
+	---help---
+	  If you say Y here, you will be able to classify packets
+	  according to netfilter/firewall marks.
 
 	  To compile this code as a module, choose M here: the
 	  module will be called cls_fw.
 
 config NET_CLS_U32
-	tristate "U32 classifier"
-	depends on NET_CLS
-	help
-	  If you say Y here, you will be able to classify outgoing packets
-	  according to their destination address. If unsure, say Y.
+	tristate "Universal 32bit comparisons w/ hashing (U32)"
+	depends NET_SCHED
+	select NET_CLS
+	---help---
+	  Say Y here to be able to classify packetes using a universal
+	  32bit pieces based comparison scheme.
 
 	  To compile this code as a module, choose M here: the
 	  module will be called cls_u32.
 
 config CLS_U32_PERF
-	bool "U32 classifier performance counters"
+	bool "Performance counters support"
 	depends on NET_CLS_U32
-	help
-	  gathers stats that could be used to tune u32 classifier performance.
-	  Requires a new iproute2
-	  You MUST NOT turn this on if you dont have an update iproute2.
-
-config NET_CLS_IND
-	bool "classify input device (slows things u32/fw) "
-	depends on NET_CLS_U32 || NET_CLS_FW
-	help
-	  This option will be killed eventually when a 
-          metadata action appears because it slows things a little
-          Available only for u32 and fw classifiers.
-	  Requires a new iproute2
-	  You MUST NOT turn this on if you dont have an update iproute2.
+	---help---
+	  Say Y here to make u32 gather additional statistics useful for
+	  fine tuning u32 classifiers.
 
 config CLS_U32_MARK
-	bool "Use nfmark as a key in U32 classifier"
+	bool "Netfilter marks support"
 	depends on NET_CLS_U32 && NETFILTER
-	help
-	  This allows you to match mark in a u32 filter.
-	  Example:
-	  tc filter add dev eth0 protocol ip parent 1:0 prio 5 u32 \
-		match mark 0x0090 0xffff \
-		match ip dst 4.4.4.4 \
-		flowid 1:90
-	  You must use a new iproute2 to use this feature.
+	---help---
+	  Say Y here to be able to use netfilter marks as u32 key.
 
 config NET_CLS_RSVP
-	tristate "Special RSVP classifier"
-	depends on NET_CLS && NET_QOS
+	tristate "IPv4 Resource Reservation Protocol (RSVP)"
+	depends on NET_SCHED
+	select NET_CLS
+	select NET_ESTIMATOR
 	---help---
 	  The Resource Reservation Protocol (RSVP) permits end systems to
 	  request a minimum and maximum data flow rate for a connection; this
@@ -410,31 +360,33 @@ config NET_CLS_RSVP
 	  module will be called cls_rsvp.
 
 config NET_CLS_RSVP6
-	tristate "Special RSVP classifier for IPv6"
-	depends on NET_CLS && NET_QOS
+	tristate "IPv6 Resource Reservation Protocol (RSVP6)"
+	depends on NET_SCHED
+	select NET_CLS
+	select NET_ESTIMATOR
 	---help---
 	  The Resource Reservation Protocol (RSVP) permits end systems to
 	  request a minimum and maximum data flow rate for a connection; this
 	  is important for real time data such as streaming sound or video.
 
 	  Say Y here if you want to be able to classify outgoing packets based
-	  on their RSVP requests and you are using the new Internet Protocol
-	  IPv6 as opposed to the older and more common IPv4.
+	  on their RSVP requests and you are using the IPv6.
 
 	  To compile this code as a module, choose M here: the
 	  module will be called cls_rsvp6.
 
 config NET_EMATCH
 	bool "Extended Matches"
-	depends on NET_CLS
+	depends NET_SCHED
+	select NET_CLS
 	---help---
 	  Say Y here if you want to use extended matches on top of classifiers
 	  and select the extended matches below.
 
 	  Extended matches are small classification helpers not worth writing
-	  a separate classifier.
+	  a separate classifier for.
 
-	  You must have a recent version of the iproute2 tools in order to use
+	  A recent version of the iproute2 package is required to use
 	  extended matches.
 
 config NET_EMATCH_STACK
@@ -468,7 +420,7 @@ config NET_EMATCH_NBYTE
 	  module will be called em_nbyte.
 
 config NET_EMATCH_U32
-	tristate "U32 hashing key"
+	tristate "U32 key"
 	depends on NET_EMATCH
 	---help---
 	  Say Y here if you want to be able to classify packets using
@@ -496,76 +448,120 @@ config NET_EMATCH_TEXT
 	select TEXTSEARCH_BM
 	select TEXTSEARCH_FSM
 	---help---
-	  Say Y here if you want to be ablt to classify packets based on
+	  Say Y here if you want to be able to classify packets based on
 	  textsearch comparisons.
 
 	  To compile this code as a module, choose M here: the
 	  module will be called em_text.
 
 config NET_CLS_ACT
-	bool "Packet ACTION"
-	depends on EXPERIMENTAL && NET_CLS && NET_QOS
-	---help---
-	This option requires you have a new iproute2. It enables
-	tc extensions which can be used with tc classifiers.
-	  You MUST NOT turn this on if you dont have an update iproute2.
+	bool "Actions"
+	depends on EXPERIMENTAL && NET_SCHED
+	select NET_ESTIMATOR
+	---help---
+	  Say Y here if you want to use traffic control actions. Actions
+	  get attached to classifiers and are invoked after a successful
+	  classification. They are used to overwrite the classification
+	  result, instantly drop or redirect packets, etc.
+
+	  A recent version of the iproute2 package is required to use
+	  extended matches.
 
 config NET_ACT_POLICE
-	tristate "Policing Actions"
+	tristate "Traffic Policing"
         depends on NET_CLS_ACT 
         ---help---
-        If you are using a newer iproute2 select this one, otherwise use one
-	below to select a policer.
-	  You MUST NOT turn this on if you dont have an update iproute2.
+	  Say Y here if you want to do traffic policing, i.e. strict
+	  bandwidth limiting. This action replaces the existing policing
+	  module.
+
+	  To compile this code as a module, choose M here: the
+	  module will be called police.
 
 config NET_ACT_GACT
-        tristate "generic Actions"
+        tristate "Generic actions"
         depends on NET_CLS_ACT
         ---help---
-        You must have new iproute2 to use this feature.
-        This adds simple filtering actions like drop, accept etc.
+	  Say Y here to take generic actions such as dropping and
+	  accepting packets.
+
+	  To compile this code as a module, choose M here: the
+	  module will be called gact.
 
 config GACT_PROB
-        bool "generic Actions probability"
+        bool "Probability support"
         depends on NET_ACT_GACT
         ---help---
-        Allows generic actions to be randomly or deterministically used.
+	  Say Y here to use the generic action randomly or deterministically.
 
 config NET_ACT_MIRRED
-        tristate "Packet In/Egress redirecton/mirror Actions"
+        tristate "Redirecting and Mirroring"
         depends on NET_CLS_ACT
         ---help---
-        requires new iproute2
-        This allows packets to be mirrored or redirected to netdevices
+	  Say Y here to allow packets to be mirrored or redirected to
+	  other devices.
+
+	  To compile this code as a module, choose M here: the
+	  module will be called mirred.
 
 config NET_ACT_IPT
-        tristate "iptables Actions"
+        tristate "IPtables targets"
         depends on NET_CLS_ACT && NETFILTER && IP_NF_IPTABLES
         ---help---
-        requires new iproute2
-        This allows iptables targets to be used by tc filters
+	  Say Y here to be able to invoke iptables targets after succesful
+	  classification.
+
+	  To compile this code as a module, choose M here: the
+	  module will be called ipt.
 
 config NET_ACT_PEDIT
-        tristate "Generic Packet Editor Actions"
+        tristate "Packet Editing"
         depends on NET_CLS_ACT
         ---help---
-        requires new iproute2
-        This allows for packets to be generically edited
+	  Say Y here if you want to mangle the content of packets.
 
-config NET_CLS_POLICE
-	bool "Traffic policing (needed for in/egress)"
-	depends on NET_CLS && NET_QOS && NET_CLS_ACT!=y
-	help
-	  Say Y to support traffic policing (bandwidth limits).  Needed for
-	  ingress and egress rate limiting.
+	  To compile this code as a module, choose M here: the
+	  module will be called pedit.
 
 config NET_ACT_SIMP
-        tristate "Simple action"
+        tristate "Simple Example (Debug)"
         depends on NET_CLS_ACT
         ---help---
-        You must have new iproute2 to use this feature.
-        This adds a very simple action for demonstration purposes
-	The idea is to give action authors a basic example to look at.
-	All this action will do is print on the console the configured
-	policy string followed by _ then packet count.
+	  Say Y here to add a simple action for demonstration purposes.
+	  It is meant as an example and for debugging purposes. It will
+	  print a configured policy string followed by the packet count
+	  to the console for every packet that passes by.
+
+	  If unsure, say N.
+
+	  To compile this code as a module, choose M here: the
+	  module will be called simple.
+
+config NET_CLS_POLICE
+	bool "Traffic Policing (obsolete)"
+	depends on NET_SCHED && NET_CLS_ACT!=y
+	select NET_ESTIMATOR
+	---help---
+	  Say Y here if you want to do traffic policing, i.e. strict
+	  bandwidth limiting. This option is obsoleted by the traffic
+	  policer implemented as action, it stays here for compatibility
+	  reasons.
+
+config NET_CLS_IND
+	bool "Incoming device classification"
+	depends on NET_SCHED && (NET_CLS_U32 || NET_CLS_FW)
+	---help---
+	  Say Y here to extend the u32 and fw classifier to support
+	  classification based on the incoming device. This option is
+	  likely to disappear in favour of the metadata ematch.
+
+config NET_ESTIMATOR
+	bool "Rate estimator"
+	depends on NET_SCHED
+	---help---
+	  Say Y here to allow using rate estimators to estimate the current
+	  rate-of-flow for network devices, queues, etc. This module is
+	  automaticaly selected if needed but can be selected manually for
+	  statstical purposes.
 
+endmenu
