Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262637AbUKLVxj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262637AbUKLVxj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 16:53:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262626AbUKLVwC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 16:52:02 -0500
Received: from mail2.speakeasy.net ([216.254.0.202]:61869 "EHLO
	mail2.speakeasy.net") by vger.kernel.org with ESMTP id S262633AbUKLVtw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 16:49:52 -0500
To: linux-kernel@vger.kernel.org
Subject: source address for UDP broadcasts with aliased interfaces?
From: Daniel Risacher <magnus@alum.mit.edu>
Date: Fri, 12 Nov 2004 16:49:50 -0500
Message-ID: <87lld6n3ep.fsf@m5.risacher.org>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.2.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm not sure if this is a bug or a feature.

There seems to be no way to get the kernel to send a UDP broadcast
packet to INADDR_BROADCAST from a specific address, short of using
iptables.  

I would think that bind()ing a socket to a local address would
determine the source address, but the kernel seems to ignore the bound
address.  

I'm trying to write a program that communicates with multiple hosts on
a local net, several of which have firewall rules that drop packets
from external addresses.  The source computer has multiple aliased
addresses on the eth0 interface.  I therefore want to broadcast from a
specific non-routable internal address.  I've experimented with bind()
and setsockopt(,SO_BINDTODEVICE,) to determine the source address
and/or interface but the kernel seems to pick whatever it wants.

Is there a correct way to specify the sender address/interface?

Dan Risacher

(reference code follows; testing was done on Linux 2.6.9)

  struct sockaddr_in to_addr;
  struct sockaddr_in my_addr;
  my_addr.sin_family = AF_INET;
  my_addr.sin_port = htons(0);
  my_addr.sin_addr.s_addr = find_if_addr(interface);
  to_addr.sin_family = AF_INET;
  to_addr.sin_port = htons(11415);
  to_addr.sin_addr.s_addr = INADDR_BROADCAST;

  fd = socket(PF_INET, SOCK_DGRAM, 0);
 
  res = setsockopt(fd, SOL_SOCKET, SO_BROADCAST, &one, sizeof(one));
  if (res) perror ("setsockopt (SO_BROADCAST)");

  res = bind(fd, (struct sockaddr*) &my_addr, sizeof(struct sockaddr_in));
  if (res) perror ("bind");  
  
  res = setsockopt(fd, SOL_SOCKET, SO_BINDTODEVICE, interface, 1+strlen(interface));
  if (res) perror ("setsockopt (SO_BINDTODEVICE)");

  res = sendto(fd, mesg, strlen(mesg), MSG_DONTROUTE, 
	 (struct sockaddr *)&to_addr, 
	 sizeof(struct sockaddr_in));
  if (res == -1) perror ("sendto");



