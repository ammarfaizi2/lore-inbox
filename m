Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315871AbSENQvv>; Tue, 14 May 2002 12:51:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315872AbSENQvu>; Tue, 14 May 2002 12:51:50 -0400
Received: from gw.chygwyn.com ([62.172.158.50]:46093 "EHLO gw.chygwyn.com")
	by vger.kernel.org with ESMTP id <S315871AbSENQvs>;
	Tue, 14 May 2002 12:51:48 -0400
From: Steven Whitehouse <steve@gw.chygwyn.com>
Message-Id: <200205141632.RAA16255@gw.chygwyn.com>
Subject: Re: Kernel deadlock using nbd over acenic driver.
To: chen_xiangping@emc.com (chen, xiangping)
Date: Tue, 14 May 2002 17:32:27 +0100 (BST)
Cc: jes@wildopensource.com ('Jes Sorensen'), linux-kernel@vger.kernel.org
In-Reply-To: <FA2F59D0E55B4B4892EA076FF8704F553D1A52@srgraham.eng.emc.com> from "chen, xiangping" at May 14, 2002 12:07:30 PM
Organization: ChyGywn Limited
X-RegisteredOffice: 7, New Yatt Road, Witney, Oxfordshire. OX28 1NU England
X-RegisteredNumber: 03887683
Reply-To: Steve Whitehouse <Steve@ChyGwyn.com>
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The TCP stack should auto-tune the amount of memory that it uses, so that
SO_SNDBUF, cat >/proc/sys/net/core/[rw]mem_default etc. is not required. The
important settings for TCP sockets are only /proc/sys/net/ipv4/tcp_[rw]mem
and tcp_mem I think (at least if I've understood the code correctly).

Since I think we are talking about only a single nbd device, there should
only be a single socket thats doing lots of I/O in this case, or is this
machine doing other heavy network tasks ?
> 
> But how to avoid system hangs due to running out of memory?
> Is there a safe guide line? Generally slow is tolerable, but
> crash is not.
> 
I agree. I also think your earlier comments about the buffer flushing are
correct as being the most likely cause.

I don't think the system has "run out" exactly, more just got itself into
a state where the code path writing out dirty blocks has been blocked
due to lack of freeable memory at that moment and where the process
freeing up memory has blocked waiting for the nbd device. It may well
be that there is freeable memory, just that for whatever reason no
process is trying to free it.

The LVM team has had a similar problem in dealing with I/O which needs
extra memory in order to complete, so I'll ask them for some ideas. Also
I'm going to try and come up with some patches to eliminate some of the
possible theories so that we can narrow down the options,

Steve

