Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265780AbUAMWJy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 17:09:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265783AbUAMWJy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 17:09:54 -0500
Received: from DELFT.AURA.CS.CMU.EDU ([128.2.206.88]:46469 "EHLO
	delft.aura.cs.cmu.edu") by vger.kernel.org with ESMTP
	id S265780AbUAMWJv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 17:09:51 -0500
Date: Tue, 13 Jan 2004 17:09:51 -0500
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: What is codaauth? Why is Linux polling it?
Message-ID: <20040113220950.GA12308@delft.aura.cs.cmu.edu>
Mail-Followup-To: Linux kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.53.0401082135560.1311@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0401082135560.1311@chaos>
User-Agent: Mutt/1.5.4i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 09, 2004 at 07:33:49AM -0500, Richard B. Johnson wrote:
> I have a RH System at home, no mods, right out of the box.
> It keeps sending UDP packets to 63.240.115.23.codaauth, so fast
> it's killing my PPP bandwidth.

Codaauth2 is the IANA port for the Coda authentication daemon.

In any normal Coda environment, only the 'clog' command sends any data
to this port. It is started by the user when that user wants to get a
new token for the next 25 hours, and gives up after couple of retries
(about 30 seconds?) when it doesn't get a reply.

Network impact should be pretty much insignificant, here is a tcpdump of
a successful connection,

    16:58:19.226110 client.34702 > server.codaauth2: udp 301 (DF)
    16:58:19.249315 server.codaauth2 > client.34702: udp 80
    16:58:19.249530 client.34702 > server.codaauth2: udp 76 (DF)
    16:58:19.250009 server.codaauth2 > client.34702: udp 84
    16:58:19.250300 client.34702 > server.codaauth2: udp 60 (DF)
    16:58:19.250855 server.codaauth2 > client.34702: udp 140
    16:58:19.251073 client.34702 > server.codaauth2: udp 60 (DF)
    16:58:19.251503 server.codaauth2 > client.34702: udp 60

And here is a tcpdump of a failing handshake (i.e. no replies from the
codauth2 server).

    17:00:54.047567 client.34703 > server.codaauth2: udp 301 (DF)
    17:00:54.348124 client.34703 > server.codaauth2: udp 301 (DF)
    17:00:54.649048 client.34703 > server.codaauth2: udp 301 (DF)
    17:00:55.121980 client.34703 > server.codaauth2: udp 301 (DF)
    17:00:56.067797 client.34703 > server.codaauth2: udp 301 (DF)
    17:00:57.958431 client.34703 > server.codaauth2: udp 301 (DF)
    17:01:01.738718 client.34703 > server.codaauth2: udp 301 (DF)

As you can see, we never retransmit withing 300ms and are backing off on
each successive try. If something is hogging your PPP connection, I
don't think it is Coda related. I run Coda over dialup pretty often
myself.

Jan

