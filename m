Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268895AbRHGGny>; Tue, 7 Aug 2001 02:43:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270099AbRHGGne>; Tue, 7 Aug 2001 02:43:34 -0400
Received: from Huntington-Beach.Blue-Labs.org ([208.179.59.198]:14945 "EHLO
	Huntington-Beach.Blue-Labs.org") by vger.kernel.org with ESMTP
	id <S268895AbRHGGnb>; Tue, 7 Aug 2001 02:43:31 -0400
Message-ID: <3B6F8E17.9090100@blue-labs.org>
Date: Tue, 07 Aug 2001 02:43:35 -0400
From: David Ford <david@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010801
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: RP_FILTER runs too late
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I finally figured out why my SNAT setup wasn't working.  I had 1 in 
eth0/rp_filter and that was silently breaking it.

This discussion follows the scripts located at website 
http://blue-labs.org/ , rc.networking and rc.firewalling.  Both are live 
meaning you'll see any changes I make.

Here's the scoop.  I run a VPN from here to my colo server...but I don't 
want all my traffic going through the VPN.  So I need to finagle a 
method of NAT.  Now because the NAT code runs behind the routing code, 
packets are already heading the wrong direction when they get their 
headers changed.  Because of that you need to tag them with a mark and 
implement routing rules based on that mark.  As an aside note, all that 
could be avoided if SNAT would just be available in PREROUTING.

Ok. Now that packets are flowing through the right interfaces, things 
look good but wait...the reply packets are vanishing without a trace.

The culprit is the rp_filter on eth0.  The packet comes in, gets the 
header rewritten then gets chomped by rp_filter.  I'm not quite sure why 
because the src is still an external IP and the destination before and 
after is still an internal IP.

Wouldn't the rp_filter be more effective if it came ahead of the nat 
code?  As it is now, it's useless on that interface.

David


