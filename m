Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131023AbRAWWQC>; Tue, 23 Jan 2001 17:16:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129983AbRAWWPy>; Tue, 23 Jan 2001 17:15:54 -0500
Received: from netcore.fi ([193.94.160.1]:18444 "EHLO netcore.fi")
	by vger.kernel.org with ESMTP id <S131527AbRAWWMk>;
	Tue, 23 Jan 2001 17:12:40 -0500
Date: Wed, 24 Jan 2001 00:12:35 +0200 (EET)
From: Pekka Savola <pekkas@netcore.fi>
To: <linux-kernel@vger.kernel.org>
cc: <linux-net@vger.kernel.org>
Subject: PACKET_MR_PROMISC doesn't set IFF_PROMISC
Message-ID: <Pine.LNX.4.31.0101240002380.29105-100000@netcore.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

Using recent libpcap/tcpdump versions and packet socket mode in
promiscuous mode.

The kernel doesn't set IFF_PROMISC flag on the interfaces in promiscuous
mode when PACKET_MR_PROMISC is used to put them there.  This happens
with both 2.2 and 2.4. The traditional 2.0 kernel approach works.

So, 'ifconfig' doesn't report interfaces in promisc mode due to packet
socket mode as PROMISC.

This appears to be a design decision or bug in net/core/dev.c.

Shouldn't the kernel keep track of IFF_PROMISC?

-- 
Pekka Savola                  "Tell me of difficulties surmounted,
Netcore Oy                    not those you stumble over and fall"
Systems. Networks. Security.   -- Robert Jordan: A Crown of Swords

---------- Forwarded message ----------
Date: Tue, 23 Jan 2001 13:34:53 -0800 (PST)
From: Guy Harris <guy@netapp.com>
To: Pekka Savola <pekkas@netcore.fi>
Cc: robbi8 <robbi8@gblx.net>, tcpdump-workers@tcpdump.org
Subject: Re: [tcpdump-workers] concerns about tcpdump

> On Tue, 23 Jan 2001, Pekka Savola wrote:
>
> > On Tue, 23 Jan 2001, robbi8 wrote:
> > > Greetings,
> > >  I sent the below over a week ago and haven't heard a response. I just
> > > wanted to see if you received it and if you had seen similar issues.
> >
> > Thisi is a problem with ifconfig in net-tools package I believe, not
> > tcpdump, as the kernel log shows:
> >
> > device eth0 entered promiscuous mode
> > device eth0 left promiscuous mode
> >
> > I haven't really dug into this deeper.
>
> Whoops.
>
> This is an issue with tcpdump/libpcap after all I suppose, caused by the
> fact that new packet socket mode is used for 2.2+ kernel.
>
> In libpcap/pcap-linux.c:
>
> ---
>                        mr.mr_type    = promisc ?
>                                 PACKET_MR_PROMISC : PACKET_MR_ALLMULTI;
> ---
>
> IFF_PROMISC is not set,

It's not supposed to be set.

The correct way to put into promiscuous mode the device to which a
PF_PACKET socket is to do a SOL_PACKET/PACKET_ADD_MEMBERSHIP
"setsockopt()" call with PACKET_MR_PROMISC as the argument (see the
"packet(7)" man page), and that's what libpcap is doing.

The old way of directly setting IFF_PROMISC had problems - to quote the
comment at the front of "pcap-linux.c":

 *   - We have to set the interface's IFF_PROMISC flag ourselves, if
 *     we're to run in promiscuous mode, which means we have to turn
 *     it off ourselves when we're done; the kernel doesn't keep track
 *     of how many sockets are listening promiscuously, which means
 *     it won't get turned off automatically when no sockets are
 *     listening promiscuously.  We catch "pcap_close()" and, for
 *     interfaces we put into promiscuous mode, take them out of
 *     promiscuous mode - which isn't necessarily the right thing to
 *     do, if another socket also requested promiscuous mode between
 *     the time when we opened the socket and the time when we close
 *     the socket.

With the new mechanism, the kernel *does* keep track of how many
requests for promiscuous mode there were, so that libpcap doesn't have
to turn promiscuous mode off by itself.

The kernel code appears to set the IFF_PROMISC flag in the "flags" field
of the "struct device" structure for the interface - see
"dev_set_promiscuity()" in "net/core/dev.c".

However, the code to handle SIOCGIFFLAGS doesn't return the IFF_PROMISC
flag from that field, ti returns the IFF_PROMISC flag from the "gflags"
field - see "dev_ifsioc()" in "net/core/dev.c".

"dev_change_flags()" (also in "net/core/dev.c") does appear to set the
IFF_PROMISC flag in "gflags" if the "flags" argument has it set; it then
calls "dev_set_promiscuity()".

However, the code to handle PACKET_MR_PROMISC directly calls
"dev_set_promiscuity()"; it doesn't set the "gflags" bit.

This means that only promiscuity requested by SIOCSIFFLAGS will show up
in SIOCGIFFLAGS, not promiscuity requested by PACKET_MR_PROMISC.

This may be intentional; if anybody doesn't like that behavior, they
should take it up with the Linux networking folk - I don't think libpcap
should use the deprecated SOCK_PACKET mechanism merely so that
"ifconfig" will report PROMISC on interfaces on which promiscuous
captures are being done, especially given that there are *other*
versions of libpcap that use PF_PACKET sockets as well (e.g., the
versions with Alexey Kuznetzov's patches - the Red Hat 6.1 and later,
and SuSE 6.whatever and later, distributions have those patches
applied).

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
