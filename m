Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263878AbUDNEy5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 00:54:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263880AbUDNEy5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 00:54:57 -0400
Received: from ambr.mtholyoke.edu ([138.110.1.10]:47888 "EHLO
	ambr.mtholyoke.edu") by vger.kernel.org with ESMTP id S263878AbUDNEyx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 00:54:53 -0400
Date: Wed, 14 Apr 2004 00:54:51 -0400 (EDT)
From: Ron Peterson <rpeterso@MtHolyoke.edu>
To: linux-kernel@vger.kernel.org
Subject: Re: network / performance problems
In-Reply-To: <Pine.OSF.4.21.0404121056530.4091-100000@mhc.mtholyoke.edu>
Message-ID: <Pine.OSF.4.21.0404140047170.78613-100000@mhc.mtholyoke.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 12 Apr 2004, Ron Peterson wrote:

> I have another machine that's not in production yet running 2.6.5.  I'm
> adopted the habit of compiling netfilter stuff as modules, but I'll
> statically link everything and run it that way to see what I can see.

Results here:

http://depot.mtholyoke.edu:8080/tmp/tap-stow/2004-04-14/

The problem persists.  To the best of my knowledge, starting with kernel 
version 2.4.21, and including 2.6 series kernels, if you statically link
netfilter code, and use iptables to set up connection tracking rules (as 
below), ksoftirqd will consume increasing cpu%, and ping latencies
will grow.  Eventually the machine will be unuseable.


#! /bin/sh

IPTABLES=/usr/local/sbin/iptables

IFPUB=eth0
IFPRIV=eth1
PUBIP=...
PUBNET=...
PRIVIP=...
PRIVNET=...

# The default policy for each chain is to DROP the packet.
$IPTABLES -P INPUT DROP
$IPTABLES -P OUTPUT DROP
$IPTABLES -P FORWARD DROP

# Flush existing rules for all chains.
$IPTABLES -F
$IPTABLES -t nat -F
$IPTABLES -X

# Allow this host to establish new connections.  Otherwise only accept
# established connections.
$IPTABLES -A OUTPUT --match state --state NEW,ESTABLISHED,RELATED -j ACCEPT
$IPTABLES -A INPUT --match state --state ESTABLISHED,RELATED -j ACCEPT

# Allow ping from on-campus
$IPTABLES -A INPUT -i $IFPUB -s $PUBNET --protocol icmp --icmp-type echo-request -j ACCEPT
$IPTABLES -A INPUT -i $IFPRIV -s $PRIVNET --protocol icmp --icmp-type echo-request -j ACCEPT

# Allow incoming ssh connections.
$IPTABLES -A INPUT --protocol tcp --destination-port 22 -j ACCEPT

# Allow incoming https connections.
# $IPTABLES -A INPUT --protocol tcp --destination-port 443 -j ACCEPT

# Allow Samba/SMB/NetBIOS
$IPTABLES -A INPUT --protocol tcp --destination-port 137:139 -j ACCEPT
$IPTABLES -A INPUT --protocol tcp --destination-port 445 -j ACCEPT

# Allow CUPS
$IPTABLES -A INPUT --protocol tcp --destination-port 631 -j ACCEPT

# Allow this host to talk to itself.
$IPTABLES -A INPUT -d 127.0.0.1 -i lo -j ACCEPT
$IPTABLES -A INPUT -s $PUBIP -d $PUBIP -j ACCEPT
$IPTABLES -A INPUT -s $PRIVIP -d $PRIVIP -j ACCEPT

_________________________
Ron Peterson
Network & Systems Manager
Mount Holyoke College

