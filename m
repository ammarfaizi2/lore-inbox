Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131513AbQKZWAw>; Sun, 26 Nov 2000 17:00:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132870AbQKZWAn>; Sun, 26 Nov 2000 17:00:43 -0500
Received: from taku.hut.fi ([130.233.228.87]:10000 "EHLO taku.hut.fi")
        by vger.kernel.org with ESMTP id <S131513AbQKZWAd>;
        Sun, 26 Nov 2000 17:00:33 -0500
Date: Sun, 26 Nov 2000 23:30:26 +0200 (EET)
From: Tuomas Heino <iheino@cc.hut.fi>
To: linux kernel <linux-kernel@vger.kernel.org>
cc: linux net <linux-net@vger.kernel.org>, Tuomas Heino <iheino@cc.hut.fi>
Subject: netfilter, nat & packet floods?
Message-ID: <Pine.OSF.4.10.10011262257160.5186-100000@smaragdi.hut.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anyone know how to properly filter packet floods using iptables w/ nat?

>From my point of view 2.4.x:ish connection tracking seems to be quite
a bit more vulnerable to packet flooding than the 2.2.x:ish
IP Masquerading used to be (when using default configuration that is).

First we try to make both input & output flood-filtered:
iptables -t nat -I PREROUTING -j floodprot
iptables -t nat -I OUTPUT -j floodprot

For example the following rule seems to match no packets:
iptables -t nat -A floodprot -p tcp --tcp-flags ALL NONE -j DROP

(According to the documentation --tcp-flags ALL NONE should match the
so-called "Null scan", aka nmap -sN)

The following rules seem to rate-limit ping & traceroute properly:

iptables -t nat -A floodprot -p icmp --icmp-type echo-request -m limit \
 --limit 4/s ! -f -j RETURN
iptables -t nat -A floodprot -p icmp --icmp-type echo-request -j DROP
iptables -t nat -A floodprot -p udp --dport 33400:33499 --sport \
 50000:65535 -m limit --limit 4/s ! -f -j RETURN
iptables -t nat -A floodprot -p udp --dport 33400:33499 --sport \
 50000:65535 -j DROP

But is there a better (=simpler) way to do that?

Also if I happen to have a bunch of interfaces that are not supposed to
get any routing and/or nat from this box, tracking connections on them
seems to be waste of resources to me - there probably is no way to turn
connection tracking off for some interface pairs?

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
