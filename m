Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262789AbVA1UdM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262789AbVA1UdM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 15:33:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262749AbVA1U34
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 15:29:56 -0500
Received: from fw.osdl.org ([65.172.181.6]:8077 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262751AbVA1U2Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 15:28:24 -0500
Date: Fri, 28 Jan 2005 12:28:17 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: ierdnah <ierdnah@go.ro>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kernel oops!
In-Reply-To: <1106942401.27217.8.camel@ierdnac>
Message-ID: <Pine.LNX.4.58.0501281218020.2362@ppc970.osdl.org>
References: <1106437010.32072.0.camel@ierdnac>  <Pine.LNX.4.58.0501222223090.4191@ppc970.osdl.org>
  <1106483340.21951.4.camel@ierdnac>  <Pine.LNX.4.58.0501230943020.4191@ppc970.osdl.org>
  <1106866066.20523.3.camel@ierdnac>  <Pine.LNX.4.58.0501271532420.2362@ppc970.osdl.org>
 <1106942401.27217.8.camel@ierdnac>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 28 Jan 2005, ierdnah wrote:
> 
> the last patch works, but the load increases very much (normally with
> 200 VPN connections I have a load of maximum 10, with this patch I have
> a load of 50-100 - after 30 min of uptime)

Yeah, that "tty_ldisc_try()" is pretty expensive, and it really would be 
worth trying to get both sides of the tty at the same time, since with my 
patch in place it has to get that "tty_ldisc_lock" four times (and disable 
interrupts etc - twice for getting the lock, twice for releasing it).

I'm surprised that it makes _that_ much of a difference, but it sounds
like you used to be borderline on CPU usage before, and this just made it
much worse.

One option is to instead of locking both master and slave on use in the 
pty side, lock both when _changing_ the ldisc instead. That's the rare 
case. Much more complex, though.

Alan, any clever ideas?

		Linus
