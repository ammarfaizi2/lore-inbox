Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964798AbWA3RJp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964798AbWA3RJp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 12:09:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964802AbWA3RJo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 12:09:44 -0500
Received: from pat.uio.no ([129.240.130.16]:53996 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S964798AbWA3RJn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 12:09:43 -0500
Subject: Re: 2.6.15.1: persistent nasty hang in sync_page killing NFS
	(ne2k-pci / DP83815-related?), i686/PIII
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Nix <nix@esperi.org.uk>
Cc: linux-kernel@vger.kernel.org, thockin@hockin.org
In-Reply-To: <874q3lwt7w.fsf@amaterasu.srvr.nix>
References: <87fyn8artm.fsf@amaterasu.srvr.nix>
	 <1138499957.8770.91.camel@lade.trondhjem.org>
	 <87slr79knc.fsf@amaterasu.srvr.nix> <8764o23j0s.fsf@amaterasu.srvr.nix>
	 <1138566075.8711.39.camel@lade.trondhjem.org>
	 <871wyq3dl3.fsf@amaterasu.srvr.nix>
	 <1138572140.8711.82.camel@lade.trondhjem.org>
	 <874q3lwt7w.fsf@amaterasu.srvr.nix>
Content-Type: text/plain
Date: Mon, 30 Jan 2006 12:09:28 -0500
Message-Id: <1138640968.30641.3.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.154, required 12,
	autolearn=disabled, AWL 1.66, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-01-30 at 16:55 +0000, Nix wrote:
> On Sun, 29 Jan 2006, Trond Myklebust stipulated:
> > As a general rule of thumb: if tcpdump/ethereal can see the reply on the
> > client, then the engine socket should see it too. If tcpdump is indeed
> > seeing those replies, you should check the RPC code by
> > setting /proc/sys/sunrpc/rpc_debug to 1.
> 
> tcpdump is seeing them.

The complete packets, including all fragments?


> ... have a pile of messages in the midst of a locked-up transfer:
> 
> Jan 30 16:50:57 loki warning: kernel: -pid- proc flgs status -client- -prog- --rqstp- -timeout -rpcwait -action- --exit--
> Jan 30 16:50:57 loki warning: kernel: 15046 0006 0021 -00011 c1a11600 100003 c801f000 00000000 xprt_resend c02c3798 c01c0e4d
> Jan 30 16:50:57 loki warning: kernel: 15047 0006 0021 000000 c1a11600 100003 c801f0b8 00000070 xprt_pending c02c3869 c01c0e4d
> Jan 30 16:50:57 loki warning: kernel: 15048 0006 0021 -00011 c1a11600 100003 c801f170 00000000 xprt_resend c02c3798 c01c0e4d
> Jan 30 16:50:57 loki warning: kernel: 15049 0006 0001 -00011 c1a11600 100003 c801f228 00000000 xprt_sending c02c3798 c01c0e4d
> Jan 30 16:50:57 loki warning: kernel: RPC: 15047 xprt_timer
> Jan 30 16:50:57 loki warning: kernel: RPC:      cong 256, cwnd was 256, now 256
> Jan 30 16:50:57 loki warning: kernel: RPC: 15048 xprt_cwnd_limited cong = 0 cwnd = 256
> Jan 30 16:50:57 loki warning: kernel: RPC: 15048 xprt_prepare_transmit
> Jan 30 16:50:57 loki warning: kernel: RPC: 15048 xprt_transmit(116)
> Jan 30 16:50:57 loki warning: kernel: RPC: 15048 xmit complete
> Jan 30 16:50:57 loki warning: kernel: RPC: 15047 xprt_prepare_transmit
> Jan 30 16:50:57 loki warning: kernel: RPC: 15047 xprt_cwnd_limited cong = 256 cwnd = 256
> Jan 30 16:50:57 loki warning: kernel: RPC: 15047 failed to lock transport c1a11800
> Jan 30 16:50:58 loki warning: kernel: RPC: 15048 xprt_timer
> Jan 30 16:50:58 loki warning: kernel: RPC:      cong 256, cwnd was 256, now 256
> Jan 30 16:50:58 loki warning: kernel: RPC: 15046 xprt_cwnd_limited cong = 0 cwnd = 256
> Jan 30 16:50:58 loki warning: kernel: RPC: 15046 xprt_prepare_transmit
> Jan 30 16:50:58 loki warning: kernel: RPC: 15046 xprt_transmit(116)
> Jan 30 16:50:58 loki warning: kernel: RPC: 15046 xmit complete
> Jan 30 16:50:58 loki warning: kernel: RPC: 15048 xprt_prepare_transmit
> Jan 30 16:50:58 loki warning: kernel: RPC: 15048 xprt_cwnd_limited cong = 256 cwnd = 256
> Jan 30 16:50:58 loki warning: kernel: RPC: 15048 failed to lock transport c1a11800
> Jan 30 16:50:59 loki warning: kernel: RPC: 15046 xprt_timer
> Jan 30 16:50:59 loki warning: kernel: RPC:      cong 256, cwnd was 256, now 256
> Jan 30 16:50:59 loki warning: kernel: RPC: 15047 xprt_cwnd_limited cong = 0 cwnd = 256
> Jan 30 16:50:59 loki warning: kernel: RPC: 15047 xprt_prepare_transmit
> Jan 30 16:50:59 loki warning: kernel: RPC: 15047 xprt_transmit(116)
> Jan 30 16:50:59 loki warning: kernel: RPC: 15047 xmit complete
> Jan 30 16:50:59 loki warning: kernel: RPC: 15046 xprt_prepare_transmit
> Jan 30 16:50:59 loki warning: kernel: RPC: 15046 xprt_cwnd_limited cong = 256 cwnd = 256
> Jan 30 16:50:59 loki warning: kernel: RPC: 15046 failed to lock transport c1a11800
> Jan 30 16:51:00 loki warning: kernel: RPC: 15047 xprt_timer
> [repeats indefinitely]
> Jan 30 16:51:38 loki warning: kernel: -pid- proc flgs status -client- -prog- --rqstp- -timeout -rpcwait -action- --exit--
> Jan 30 16:51:38 loki warning: kernel: 15046 0006 0021 -00011 c1a11600 100003 c801f000 00000000 xprt_resend c02c3798 c01c0e4d
> Jan 30 16:51:38 loki warning: kernel: 15047 0006 0021 000000 c1a11600 100003 c801f0b8 00000140 xprt_pending c02c3869 c01c0e4d
> Jan 30 16:51:38 loki warning: kernel: 15048 0006 0021 -00011 c1a11600 100003 c801f170 00000000 xprt_resend c02c3798 c01c0e4d
> 
> The RPC messages are emitted at pretty much exactly the same frequency
> as the ACKs.
> 
> I *guess* that the `failed to lock transport' is the underlying error...
> time to add some debugging and find out what task is locking the
> transport. Back soon, must rebuild the kernel and reboot to clear this
> lock ;)

Nope. The congestion window is 1 request, and you do indeed appear to
have one request on the "pending" queue. The problem in the above trace
is a complete lack of data_ready messages, meaning that the socket is
never seeing any complete packets come in.

Cheers,
  Trond

