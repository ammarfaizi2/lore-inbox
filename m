Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262476AbULOUJF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262476AbULOUJF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 15:09:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262486AbULOUJE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 15:09:04 -0500
Received: from alog0285.analogic.com ([208.224.222.61]:5248 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262476AbULOUI6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 15:08:58 -0500
Date: Wed, 15 Dec 2004 15:06:18 -0500 (EST)
From: linux-os <linux-os@chaos.analogic.com>
Reply-To: linux-os@analogic.com
To: Adam Denenberg <adam@dberg.org>
cc: Jan Harkes <jaharkes@cs.cmu.edu>, Kyle Moffett <mrmacman_g4@mac.com>,
       linux-kernel@vger.kernel.org, Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: bind() udp behavior 2.6.8.1
In-Reply-To: <1103138573.6825.11.camel@sucka>
Message-ID: <Pine.LNX.4.61.0412151459150.4365@chaos.analogic.com>
References: <1103038728.10965.12.camel@sucka>  <Pine.LNX.4.61.0412141700430.24308@yvahk01.tjqt.qr>
  <1103042538.10965.27.camel@sucka>  <Pine.LNX.4.61.0412141742590.22148@yvahk01.tjqt.qr>
  <1103043716.10965.40.camel@sucka>  <8AF1BC56-4E1C-11D9-B94B-000393ACC76E@mac.com>
  <57782EC8-4E40-11D9-B971-003065B11AE8@dberg.org>  <20F668EE-4E48-11D9-B94B-000393ACC76E@mac.com>
  <1103120162.5517.14.camel@sucka>  <20041215190725.GA24635@delft.aura.cs.cmu.edu>
 <1103138573.6825.11.camel@sucka>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Dec 2004, Adam Denenberg wrote:

> almost yes.  The firewall never passes the retransmit onto the DNS
> server since it has the same DNS ID, source port and source ip.  What is
> happening is the following
>
> request 1
> --------------------
> linux box.32789 (id 001) ->  FW -> DNS SERVER.53
> DNS SERVER.53 (id 001) -> FW -> linux box.32789
>
> request 2
> -------------------
> linux box.32789 (id 002) -> FW -> DNS SERVER.53
> DNS SERVER (id 002).53 -> FW -> linux box.32789
>
> request 3
> -----------------------
> linux box (id 002).32789 -> FW -> NEVER GETS HERE, B/C ITS DROPPED
>
> the time between request 2 and request 3 is under 60ms.  The firewall is
> in the midst of clearing its table for the dns request with ID 002
> already so it thinks its a duplicate and drops it.  So my question is,
> why is the kernel not incrementing the DNS ID in this case? It does it
> for almost all other tests that i can find, and the firewall does not
> drop any traffic.  Only when the DNS ID does not increment does this
> problem occur.  This does not seem to always be the default behavior.  I
> wrote a small C program to just put a gethostbyname_r() in a for loop
> and each DNS ID is incremented all 40 times.  But there are times when
> this doesnt happen, and this seems to be what is causing the issue.  The
> firewall needs some sort of identifier to know which dns request is
> associated with which dns reply (source ip, source port, ID).
>
> this is the behavior I am trying to debug.
>
> thanks
> adam

The ID portion of the IP header, offset 32, is 16 bits of unique
identification that is supposed to be unique for the entire time
that any message should be in the system. That's what firewalls
and routers use to determine if it's a duplicate packet. You
never before stated that Linux was duplicating the ID portion,
and if it is, it's a bug. But, I'll bet that it isn't. Nothing
would work if it was. All TCP/IP messages are composed of
Datagrams. If these basic elements were mucked up, this would
have been discovered long before now, and if not discovered,
you wouldn't receive this message. Also UCP is connectionless
and stateless. If you have some box that handles it differently,
its broken.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.9 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by John Ashcroft.
                  98.36% of all statistics are fiction.
