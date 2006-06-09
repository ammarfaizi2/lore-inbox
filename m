Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030330AbWFIVG3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030330AbWFIVG3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 17:06:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965300AbWFIVG3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 17:06:29 -0400
Received: from AToulouse-252-1-74-163.w81-49.abo.wanadoo.fr ([81.49.44.163]:4051
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S965296AbWFIVG2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 17:06:28 -0400
Message-Id: <20060609210202.215291000@localhost.localdomain>
Date: Fri, 09 Jun 2006 23:02:02 +0200
From: dlezcano@fr.ibm.com
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: serue@us.ibm.com, haveblue@us.ibm.com, clg@fr.ibm.com, dlezcano@fr.ibm.com
Subject: [RFC] [patch 0/6] [Network namespace] introduction
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patches create a private "network namespace" for use
within containers. This is intended for use with system containers
like vserver, but might also be useful for restricting individual
applications' access to the network stack.

These patches isolate traffic inside the network namespace. The
network ressources, the incoming and the outgoing packets are
identified to be related to a namespace. 

It hides network resource not contained in the current namespace, but
still allows administration of the network with normal commands like
ifconfig.

It applies to the kernel version 2.6.17-rc6-mm1

It provides the following:
-------------------------
   - when an application unshares its network namespace, it looses its
     view of all network devices by default. The administrator can
     choose to make any devices to become visible again. The container
     then gains a view to the device but without the ip address
     configured on it. It is up to the container administrator to use
     ifconfig or ip command to setup a new ip address. This ip address
     is only visible inside the container.

   - the loopback is isolated inside the container and it is not
     possible to communicate between containers via the
     loopback. 

   - several containers can have an application bind to the same
     address:port without conflicting. 

What is for ?
-------------
   - security : an application can be bounded inside a container
     without interacting with the network used by another container

   - consolidation : several instance of the same application can be
     ran in different container because the network namespace allows
     to bind to the same addr:port

What could be done ?
--------------------
    - because the network ressources are related to a namespace, it is
      easy to identify them. That facilitate the implementation of the
      network migration

How to use ?
------------
   - do unshare with the CLONE_NEWNET flag as root
   - do echo eth0 > /sys/kernel/debug/net_ns/dev
   - use ifconfig or ip command to set a new ip address

What is missing ?
-----------------
The routes are not yet isolated, that implies:

   - binding to another container's address is allowed

   - an outgoing packet which has an unset source address can
     potentially get another container's address

   - an incoming packet can be routed to the wrong container if there
     are several containers listening to the same addr:port

--
