Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265351AbSKKCTa>; Sun, 10 Nov 2002 21:19:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265355AbSKKCTa>; Sun, 10 Nov 2002 21:19:30 -0500
Received: from p0037.as-l042.contactel.cz ([194.108.237.37]:1408 "EHLO
	ppc.vc.cvut.cz") by vger.kernel.org with ESMTP id <S265351AbSKKCT3>;
	Sun, 10 Nov 2002 21:19:29 -0500
Date: Mon, 11 Nov 2002 03:26:02 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.46-bk3: BUG in skbuff.c:178
Message-ID: <20021111022602.GA1498@ppc.vc.cvut.cz>
References: <6F45EB551A2@vcnet.vc.cvut.cz> <20021108220215.GA2437@vana> <20021110041855.GA17760@conectiva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021110041855.GA17760@conectiva.com.br>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 10, 2002 at 02:18:55AM -0200, Arnaldo Carvalho de Melo wrote:
> Em Fri, Nov 08, 2002 at 11:02:15PM +0100, Petr Vandrovec escreveu:
> > On Fri, Nov 08, 2002 at 09:33:24PM +0200, Petr Vandrovec wrote:
> > > On  8 Nov 02 at 12:01, Andrew Morton wrote:
>  
> > Patch below removes 'bucket' from arp_iter_state, and merges it to the pos.
> > It is based on assumption that there is no more than 16M of entries in each
> > bucket, and that NEIGH_HASHMASK + 1 + PNEIGH_HASHMASK + 1 < 127
> 
> I did that in the past, but it gets too ugly, see previous changeset in
> bk tree, lemme see... 1.781.1.52, but anyway, I was aware of this bug but I
> was on the run, going to Japan and back in 5 days :-\ Well, I have already
> sent this one to several people, so if you could review/test it...

I tried to find how it is supposed to work, and after I tried to boot kernel
(at home) with it, I can say that it does not work...

I tried it only at home (where arp table is empty by default), so I did not
test whether lock is released properly (if there will be arp_seq_start
and arp_seq_stop, with pos == 0 and without intervening arp_seq_next, you'll 
unlock unlocked arp_tbl.lock in arp_seq_stop (and from what I see in
seq_file.c, it can happen), but when I just tried to ping various addresses 
at vmware's vmnet8, I got very short output of /proc/net/arp, although it 
should contain couple of entries:

ppc:~# cat /proc/net/arp
IP address       HW type     Flags       HW address            Mask     Device
ppc:~# ping 192.168.27.2
PING 192.168.27.2 (192.168.27.2) 56(84) bytes of data.

--- 192.168.27.2 ping statistics ---
1 packets transmitted, 0 received, 100% packet loss, time 0ms

ppc:~# ping 192.168.27.3
PING 192.168.27.3 (192.168.27.3) 56(84) bytes of data.

--- 192.168.27.3 ping statistics ---
1 packets transmitted, 0 received, 100% packet loss, time 0ms

ppc:~# ping 192.168.27.4
PING 192.168.27.4 (192.168.27.4) 56(84) bytes of data.

--- 192.168.27.4 ping statistics ---
1 packets transmitted, 0 received, 100% packet loss, time 0ms

ppc:~# ping 192.168.27.5
PING 192.168.27.5 (192.168.27.5) 56(84) bytes of data.

--- 192.168.27.5 ping statistics ---
1 packets transmitted, 0 received, 100% packet loss, time 0ms

ppc:~# ping 192.168.27.6
PING 192.168.27.6 (192.168.27.6) 56(84) bytes of data.

--- 192.168.27.6 ping statistics ---
1 packets transmitted, 0 received, 100% packet loss, time 0ms

ppc:~# cat /proc/net/arp
IP address       HW type     Flags       HW address            Mask     Device
192.168.27.2     0x1         0x0         00:00:00:00:00:00     *        vmnet8
ppc:~#

Not something I expect. Before reboot it was listing all 6 addresses, not
only first.
						Best regards,
							Petr Vandrovec
							vandrove@vc.cvut.cz
