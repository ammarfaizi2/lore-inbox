Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287596AbSBRVTc>; Mon, 18 Feb 2002 16:19:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287306AbSBRVTN>; Mon, 18 Feb 2002 16:19:13 -0500
Received: from quechua.inka.de ([212.227.14.2]:13084 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S286590AbSBRVTK>;
	Mon, 18 Feb 2002 16:19:10 -0500
From: Bernd Eckenfels <ecki-news2002-02@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: ARP timeout value, why 1 minute ?
In-Reply-To: <E16ckba-0001mi-00@mcclure.tinet.ie>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.0.39 (i686))
Message-Id: <E16cvBl-0007ul-00@sites.inka.de>
Date: Mon, 18 Feb 2002 22:19:09 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <E16ckba-0001mi-00@mcclure.tinet.ie> you wrote:
> and early version of Linux. But from a certain point, Linux(only?) changed from 20 minutes to one minute. This changes the system configuration to shorten the ARP expiration timer to one minute instead of the default 20 minutes. 

> Why was it changed to 1 minute ? 

Thei neighbouring subsystem of Linux 2.4 is a bit more "complex" than a simple
timeout:

/proc/sys/net/ipv4/neigh/default/anycast_delay:100
/proc/sys/net/ipv4/neigh/default/app_solicit:0
/proc/sys/net/ipv4/neigh/default/base_reachable_time:30
/proc/sys/net/ipv4/neigh/default/delay_first_probe_time:5
/proc/sys/net/ipv4/neigh/default/gc_interval:30
/proc/sys/net/ipv4/neigh/default/gc_stale_time:60
/proc/sys/net/ipv4/neigh/default/gc_thresh1:128
/proc/sys/net/ipv4/neigh/default/gc_thresh2:512
/proc/sys/net/ipv4/neigh/default/gc_thresh3:1024
/proc/sys/net/ipv4/neigh/default/locktime:100
/proc/sys/net/ipv4/neigh/default/mcast_solicit:3
/proc/sys/net/ipv4/neigh/default/proxy_delay:80
/proc/sys/net/ipv4/neigh/default/proxy_qlen:64
/proc/sys/net/ipv4/neigh/default/retrans_time:100
/proc/sys/net/ipv4/neigh/default/ucast_solicit:3
/proc/sys/net/ipv4/neigh/default/unres_qlen:3

It is actually probing hosts on a regularbut random time. Multiple retries are
done until a neighbour is marked as not reachable.

If the kernel sends any payload packet to a host, a neighbour is in delay
state, if the delay timer expires, it will suspect that something is not ok.
It will send an arp request and go into probe state.

This has the advantage, that as long as the system is up and used, the entry
will never be expired, and as soon as it fails to respond, it will marked dead
quickly. This will also affect all queued packets and all routes, so it can
recover from an unreachable router. It is also not spamming the network with
unneeded unicast or multicast arp requests, because normal payload ip packets
are accounted.

If you are curious what is going on try "/sbin/ip -s neigh"

The times for an entry show "last used"/"last confirmed"/"last updated"

Greetings
Bernd

