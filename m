Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132252AbRAYL43>; Thu, 25 Jan 2001 06:56:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132942AbRAYL4T>; Thu, 25 Jan 2001 06:56:19 -0500
Received: from Cantor.suse.de ([194.112.123.193]:44301 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S132252AbRAYL4M>;
	Thu, 25 Jan 2001 06:56:12 -0500
Date: Thu, 25 Jan 2001 12:56:09 +0100
From: Andi Kleen <ak@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: Andi Kleen <ak@suse.de>, kuznet@ms2.inr.ac.ru,
        Manfred Spraul <manfred@colorfullife.COM>,
        linux-kernel@vger.kernel.org
Subject: Re: Linux 2.2.16 through 2.2.18preX TCP hang bug triggered by rsync
Message-ID: <20010125125609.A16226@gruyere.muc.suse.de>
In-Reply-To: <3A6E02E6.B3261E1@colorfullife.com> <200101242003.XAA21040@ms2.inr.ac.ru> <20010124215634.A2992@gruyere.muc.suse.de> <14960.3804.197814.496909@pizda.ninka.net> <20010125124036.A15952@gruyere.muc.suse.de> <14960.4487.540768.312023@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <14960.4487.540768.312023@pizda.ninka.net>; from davem@redhat.com on Thu, Jan 25, 2001 at 03:44:07AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 25, 2001 at 03:44:07AM -0800, David S. Miller wrote:
> 
> Andi Kleen writes:
>  > > BSD and Solaris both make these kinds of packets, therefore it is must
>  > > to handle them properly.  So we will fix Linux, there is no argument.
>  > 
>  > How do you propose to handle them? Queue the data anyways or just process
>  > the ACK?
> 
> tcp_sequence returns two flag bits instead of it's current binary
> state.  One bit says "accept data", the other says "accept control
> bits" (such as RST, ACK, etc.)

Sounds ugly @) tcp_sequence is already far too complicated.


> 
> tcp_sequence also will truncate the data len of the SKB area if
> necessary, BSD really puts total crap in the probe byte.
> 
> Callers of tcp_sequence check the return value bits accordingly.
> This is all slow path code, so there are no performance issues.

How about simply queueing the data in that case if it already fits into the
receive buffer? The alternative would be to skb_trim() it to 0 in the slow path
of tcp_sequence and queue, but that looks wasteful.  Basically it would accept
the acks with the data in most cases except when the application has totally 
stopped reading and in that case it doesn't harm to ignore the acks. 

I have been played with a different embedded stack and it uses that 
approach and it seems to work and makes much simpler code. 


-Andi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
