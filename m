Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261268AbUBTS0l (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 13:26:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261280AbUBTSYr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 13:24:47 -0500
Received: from fw.osdl.org ([65.172.181.6]:30595 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261268AbUBTSXh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 13:23:37 -0500
Date: Fri, 20 Feb 2004 10:16:04 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: DervishD <raul@pleyades.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Help with /proc/net/tcp fields
Message-Id: <20040220101604.0686f351.rddunlap@osdl.org>
In-Reply-To: <20040220105013.GA5606@DervishD>
References: <20040220105013.GA5606@DervishD>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Feb 2004 11:50:13 +0100 DervishD <raul@pleyades.net> wrote:

|     Hi all :)
| 
|     I'm trying to decode what the field in the output of
| /proc/net/tcp means, with little success. Apart from the fact that
| the four last fields have no description (and looking at undocumented
| sources is really a pain a very time-consuming), I have the following
| doubts:
| 
|     - I assume that 'sl' is the socket number, but, what does 'sl'
| stand for?

'sl is just an index.  Maybe it means 'slot'.

|     - What represents the 'st' field?

socket 'state' -- enumerated in include/linux/tcp.h

|     - I suppose that 'tr:tm->when' represents if there is any timer
| on that socket (well, 'tr' is the number of timers), and when will
| expire the nearest one, but I'm not sure.

Looks right at a quick glance.

|     - I suppose that 'timeout' is the time to die when the socket is
| in FIN_WAIT state, but I'm afraid I'm wrong :(

It's the value of 'probes_out', which has a comment (?) of:
/* unanswered 0 window probes */

|     - Does the 'retrnsmt' field show the retransmissions happened in
| this socket?

Looks like a counter that is incremented up to a threshold...
For ACK handling.

|     If anyone can explain me these fields (and the unnamed fields at
| the end) I will be very grateful, and if someone could direct me to a
| site with related information it will help, too.

Last 2 - 7 unnamed fields:

depending on 'state':

case TCP_SEQ_STATE_TIME_WAIT:
	refcnt bucket_pointer (no trailing 5 fields)

case TCP_SEQ_STATE_OPENREQ:
	refcnt open_request_pointer (no trailing 5 fields)

case TCP_SEQ_STATE_LISTENING:
case TCP_SEQ_STATE_ESTABLISHED:
	refcnt socket_pointer rto ato qpp snd_cwnd snd_ssthresh
where:
  rto == retransmit_timeout
  ato == delayed ACK predicted tick
  qpp == (scheduled number of quick acks << 1) | pingpong(interactive)
  snd_cwnd == sending congestion window
  snd_ssthresh == slow start size threshold (-1 if >= 0xFFFF)


I suggest asking such questions on the netdev mailing list
(netdev@oss.sgi.com).

HTH.
--
~Randy
