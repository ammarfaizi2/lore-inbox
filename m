Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264688AbUDVVmS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264688AbUDVVmS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 17:42:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264706AbUDVVmS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 17:42:18 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:31723 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S264688AbUDVVmN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 17:42:13 -0400
Date: Thu, 22 Apr 2004 14:26:43 -0700 (PDT)
From: Sridhar Samudrala <sri@us.ibm.com>
X-X-Sender: sridhar@localhost.localdomain
To: "David S. Miller" <davem@redhat.com>
cc: =?ISO-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       cfriesen@nortelnetworks.com, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: tcp vulnerability?  haven't seen anything on it here...
In-Reply-To: <20040421132047.026ab7f2.davem@redhat.com>
Message-ID: <Pine.LNX.4.58.0404221409570.12585@localhost.localdomain>
References: <40869267.30408@nortelnetworks.com> <Pine.LNX.4.53.0404211153550.1169@chaos>
 <4086A077.2000705@nortelnetworks.com> <20040421170340.GB24201@wohnheim.fh-wedel.de>
 <20040421132047.026ab7f2.davem@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Apr 2004, David S. Miller wrote:

> On Wed, 21 Apr 2004 19:03:40 +0200
> Jörn Engel <joern@wohnheim.fh-wedel.de> wrote:
>
> > Heise.de made it appear, as if the only news was that with tcp
> > windows, the propability of guessing the right sequence number is not
> > 1:2^32 but something smaller.  They said that 64k packets would be
> > enough, so guess what the window will be.
>
> Yes, that is their major discovery.  You need to guess the ports
> and source/destination addresses as well, which is why I don't
> consider this such a serious issue personally.
>
> It is mitigated if timestamps are enabled, because that becomes
> another number you have to guess.

I am not sure if enabling timestamps will help.
>From RFC1323,
  It is recommended that RST segments NOT carry timestamps, and that RST
  segments be acceptable regardless of their timestamp. Old duplicate RST
  segments should be exceedingly unlikely, and their cleanup function should
  take precedence over timestamps.

It looks like linux follows this recommendataion.
tcp_input.c: tcp_rcv_established()
        if (tcp_fast_parse_options(skb, th, tp) && tp->saw_tstamp &&
            tcp_paws_discard(tp, skb)) {
                if (!th->rst) {
                        NET_INC_STATS_BH(PAWSEstabRejected);
                        tcp_send_dupack(sk, skb);
                        goto discard;
                }
                /* Reset is accepted even if it did not pass PAWS. */
        }

Thanks
Sridhar
