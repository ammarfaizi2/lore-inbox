Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131631AbRA2NAf>; Mon, 29 Jan 2001 08:00:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131598AbRA2NA0>; Mon, 29 Jan 2001 08:00:26 -0500
Received: from laurin.munich.netsurf.de ([194.64.166.1]:38554 "EHLO
	laurin.munich.netsurf.de") by vger.kernel.org with ESMTP
	id <S131425AbRA2NAK>; Mon, 29 Jan 2001 08:00:10 -0500
Date: Mon, 29 Jan 2001 13:59:05 +0100
From: Andi Kleen <ak@muc.de>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: John Fremlin <vii@altern.org>, linux-kernel@vger.kernel.org,
        netdev@oss.sgi.com, paulus@linuxcare.com, linux-ppp@vger.kernel.org,
        linux-net@vger.kernel.org
Subject: Re: [PATCH] dynamic IP support for 2.4.0 (SIOCKILLADDR)
Message-ID: <20010129135905.B1591@fred.local>
In-Reply-To: <m2d7d838sj.fsf@boreas.yi.org.> <200101290245.f0T2j2Y438757@saturn.cs.uml.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <200101290245.f0T2j2Y438757@saturn.cs.uml.edu>; from acahalan@cs.uml.edu on Mon, Jan 29, 2001 at 03:46:42AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 29, 2001 at 03:46:42AM +0100, Albert D. Cahalan wrote:
> John Fremlin writes:
> 
> > When the IP address of an interface changes, TCP connections with the
> > old source address are useless. Applications are not notified of this
> > and time out ordinarily, just as if nothing had happened. This is
> > behaviour isn't very helpful when you have a dynamic IP and know
> > you're probably not going to get the old one back. In that case, you
> ...
> > I patched userspace ppp-2.4.0 to use this functionality. It would be
> > better if SIOCKILLADDR were not used until we are sure that the new IP
> > is in fact different from the old one, but pppd in demand mode would
> 
> I get the same IP about 2/3 of the time, so it is pretty important
> to avoid killing connections until after the new IP is known.

I prefer it when the IP is killed as soon as possible so that I can see
when the connection is lost (ssh sessions get killed etc.)

Another reason for killing as soon as possible is the last-ack problem. 
When the other end goes away suddenly TCP often gets into last-ack state.
This means it'll retransmit a FIN until it times out or the other end
answers. Each such retransmitted FIN triggers a new dialin, which can
get quite costly when you don't have flat rate (like still most of Europe).
With your approach (waiting until the new IP is known) it would cost 
at least another dialin in this case.

When you have flatrate your way may be better of course, so a final 
user space solution could switch it via a pppd flag. 

[I agree that the user space way is better than my kernel hacks] 


-Andi

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
