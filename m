Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264990AbSLMQAc>; Fri, 13 Dec 2002 11:00:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265051AbSLMQAc>; Fri, 13 Dec 2002 11:00:32 -0500
Received: from 169.imtp.Ilyichevsk.Odessa.UA ([195.66.192.169]:26116 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S264990AbSLMQAa>; Fri, 13 Dec 2002 11:00:30 -0500
Message-Id: <200212130947.gBD9l0O02393@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: linux-kernel@vger.kernel.org
Subject: order of ip tables/chains?
Date: Fri, 13 Dec 2002 12:36:31 -0200
X-Mailer: KMail [version 1.3.2]
Cc: vda@port.imtp.ilyichevsk.odessa.ua
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dunno if this mail and your replies will reach the list/me,
we have some DNS problems here...

I'm setting up a firewall. I want to understand precise order
in which a packet traverse a multitude of ip tables/chains
which exist in recent 2.4 (say 2.4.20). This is what I currently
placed at the top of my script:

### filter This is the default table (if no -t option is passed).  It  contains
###        the  built-in chains INPUT (for packets coming into the box itself),
###        FORWARD (for packets being routed through the box), and OUTPUT  (for
###        locally-generated packets).
###
### nat    This  table is consulted when a packet that creates a new connection
###        is encountered.  It consists of  three  built-ins:  PREROUTING  (for
###        altering  packets  as  soon  as  they come in), OUTPUT (for altering
###        locally-generated packets  before  routing),  and  POSTROUTING  (for
###        altering packets as they are about to go out).
###
### mangle This  table is used for specialized packet alteration.  Until kernel
###        2.4.17 it had two built-in chains: PREROUTING (for altering incoming
###        packets  before  routing) and OUTPUT (for altering locally-generated
###        packets before routing).  Since kernel 2.4.18, three other  built-in
###        chains  are  also  supported: INPUT (for packets coming into the box
###        itself), FORWARD (for altering  packets  being  routed  through  the
###        box),  and POSTROUTING (for altering packets as they are about to go
###        out).

 (above: taken directly from man iptables)
 (below: this is how I understand it. Combined from Rusty's excellent docs
  on NAT and filtering. Thanks Rusty! Anyone spot something wrong below?)

###
###
###        ..iface....................................iface...
###          |                                        ^
###          v                                        |
### -NAT,mangle-               -filter,mangle-   -NAT,mangle--
### |PREROUTING|->[Routing ]-->|FORWARD      |-->|POSTROUTING|
### ------------  [Decision]   ---------------   -------------
###                 |     ^
###                 v     |
###      -filter,mangle-  -filter,NAT,mangle-
###      |INPUT        |  |OUTPUT           |
###      ---------------  -------------------
###                 |     ^
###                 v     |
###         ... Local Process...
###         ....Local Process...

 (below: basically this is what I ask)

### TODO: check order of each a,b
###       check whether is OUTPUT drawn where it should be
###       (or maybe different table's OUTPUTs must be in different places?)
--
vda
