Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318852AbSHWOnO>; Fri, 23 Aug 2002 10:43:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318853AbSHWOnO>; Fri, 23 Aug 2002 10:43:14 -0400
Received: from as4-1-7.has.s.bonet.se ([217.215.31.238]:14509 "EHLO
	K-7.stesmi.com") by vger.kernel.org with ESMTP id <S318852AbSHWOnN>;
	Fri, 23 Aug 2002 10:43:13 -0400
Message-ID: <3D664AE5.7050608@stesmi.com>
Date: Fri, 23 Aug 2002 16:47:01 +0200
From: Stefan Smietanowski <stesmi@stesmi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Problems with routing, solutions and more problems.
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-RAVMilter-Version: 8.3.3(snapshot 20020312) (K-7.stesmi.com)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi people.

I have the following scenario:

I have a linux box with 2 serial ports and an ethernet.

Those serial ports are connected to 2 modems.

I have 500 other machines out in the field. Let's call them toasters. 
These toasters have a modem and a phoneline each. They all have the
same IP number, 192.168.0.1. They can't have anything BUT static ip.

I can call any of these 500 machines using any of my 2 modems,
but it for natural reasons does not work when I call 2 machines
at the same time since they have the same IP.

So I devised this idea:

I invent a fake ip number for the interfaces.

I don't change the actual ip on the interface, just virtually.

My idea is that: any packet going to 192.168.10.1 should go out over
modem0 and go to 192.168.1.1 and any packet going to 192.168.11.1
should go out over modem1 and go to 192.168.1.1.

So, I use netfilter, MANGLE, OUTPUT to tag each packet going to 
192.168.10.1 with fwmark 10 and each packet going to 192.168.11.1 with 
fwmark 11.

Kernel is 2.4.19, otherwise this step wouldn't work:

I NAT each packet using NAT, OUTPUT so that each packet going to 
192.168.10.1 gets nat'ed to 192.168.1.1 and each packet going to
192.168.11.1 gets net'ed to 192.168.1.1.

A packet that should go on modem0 now has the destination IP of
192.168.1.1 and is tagged 10 and a packet that should go on modem1
now has a destination IP of 192.168.1.1 and is tagged 11.

I then add 2 routing tables, one for modem0 and one for modem1. They
just say that everything to 192.168.1.1 go out on ppp0 and ppp1 
respectively.

Then I add an ip RULE that says that everything with fwmark 10
gets to routing table for modem0 and everything with fwmark 11
gets to routing table for modem1.

This sounds great and it actually works.

My problem now is that I believe the route cache is bypassing all my 
junk in the routing and just sends it to the last place sent, as 
everything works but it's being sent to ppp0 all the time.

If anyone thinks I'm wrong, please say so.

Now, is there a way to disable the route cache totally or for a specific 
ip range?

// Stefan

