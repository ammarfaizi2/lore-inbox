Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964837AbWA3Rbp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964837AbWA3Rbp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 12:31:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964839AbWA3Rbp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 12:31:45 -0500
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:35850 "EHLO
	mail.esperi.org.uk") by vger.kernel.org with ESMTP id S964837AbWA3Rbo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 12:31:44 -0500
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel@vger.kernel.org, thockin@hockin.org
Subject: Re: 2.6.15.1: UDP fragments >27208 bytes lost with ne2k-pci on
 DP83815 (was Re: persistent nasty hang in sync_page killing NFS (ne2k-pci
 / DP83815-related?), i686/PIII)
References: <87fyn8artm.fsf@amaterasu.srvr.nix>
	<1138499957.8770.91.camel@lade.trondhjem.org>
	<87slr79knc.fsf@amaterasu.srvr.nix>
	<8764o23j0s.fsf@amaterasu.srvr.nix>
	<1138566075.8711.39.camel@lade.trondhjem.org>
	<871wyq3dl3.fsf@amaterasu.srvr.nix>
	<1138572140.8711.82.camel@lade.trondhjem.org>
	<874q3lwt7w.fsf@amaterasu.srvr.nix>
	<1138640968.30641.3.camel@lade.trondhjem.org>
From: Nix <nix@esperi.org.uk>
X-Emacs: where editing text is like playing Paganini on a glass harmonica.
Date: Mon, 30 Jan 2006 17:31:24 +0000
In-Reply-To: <1138640968.30641.3.camel@lade.trondhjem.org> (Trond
 Myklebust's message of "Mon, 30 Jan 2006 12:09:28 -0500")
Message-ID: <87vew1vd03.fsf_-_@amaterasu.srvr.nix>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Jan 2006, Trond Myklebust suggested tentatively:
> On Mon, 2006-01-30 at 16:55 +0000, Nix wrote:
>> On Sun, 29 Jan 2006, Trond Myklebust stipulated:
>> > As a general rule of thumb: if tcpdump/ethereal can see the reply on the
>> > client, then the engine socket should see it too. If tcpdump is indeed
>> > seeing those replies, you should check the RPC code by
>> > setting /proc/sys/sunrpc/rpc_debug to 1.
>> 
>> tcpdump is seeing them.
> 
> The complete packets, including all fragments?

Will check. Maybe one fragment or something is getting lost
(but if so, it's getting lost terribly *consistently*, as in,
every single time).

>> I *guess* that the `failed to lock transport' is the underlying error...
>> time to add some debugging and find out what task is locking the
>> transport. Back soon, must rebuild the kernel and reboot to clear this
>> lock ;)
> 
> Nope. The congestion window is 1 request, and you do indeed appear to
> have one request on the "pending" queue. The problem in the above trace
> is a complete lack of data_ready messages, meaning that the socket is
> never seeing any complete packets come in.

O*kay*. I'll do some tcpdumps on both sides and compare them.


... you are quite right. I'm mounting with an rsize and wsize of 32768
(i.e., the default negotiated between a recent Linux NFS client and
kernel server), and, completely consistently, 31504 bytes are sent and
*only 27208 bytes are received*. This is so consistent that there's no
way that this could be due to network congestion (unless it's getting
jammed up inside the receiving NIC or something: it's an NE2K card and
they're rather crap so maybe the card is just too slow: my determination
to replace the card has just gone up a notch. But nonetheless if it was
getting lost by the card I'd see TCP retransmissions, which `netstat -s'
assures me I do not).

This explains why I don't see a problem with DNS: the number of DNS
packets >27208 bytes can be counted on the fingers of one foot.

Captures are available, but I gathered about half a minute's traffic
so they're quite large (1Mb apiece).

Tim? Any ideas? Is anyone else with this card seeing this problem?

-- 
`I won't make a secret of the fact that your statement/question
 sent a wave of shock and horror through us.' --- David Anderson
