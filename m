Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265305AbTLMXfm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Dec 2003 18:35:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265306AbTLMXfm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Dec 2003 18:35:42 -0500
Received: from elpis.telenet-ops.be ([195.130.132.40]:7392 "EHLO
	elpis.telenet-ops.be") by vger.kernel.org with ESMTP
	id S265305AbTLMXfk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Dec 2003 18:35:40 -0500
From: Bart De Schuymer <bdschuym@pandora.be>
To: Steve Hill <steve@navaho.co.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <ebtables-devel@lists.sourceforge.net>,
       <netfilter-devel@lists.netfilter.org>
Subject: Re: memory leak related to bridging, conntrack and frags in 2.6.0
Date: Sun, 14 Dec 2003 00:35:38 +0100
User-Agent: KMail/1.5
References: <Pine.LNX.4.44.0312121948321.8670-200000@sorbus2.navaho>
In-Reply-To: <Pine.LNX.4.44.0312121948321.8670-200000@sorbus2.navaho>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312140035.38759.bdschuym@pandora.be>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 12 December 2003 20:55, Steve Hill wrote:
> Sorry for the cross-post - I thought this would be of interest to all the
> lists and also wasn't sure where the best people to help hang out.

The right mailing list for this is netdev@oss.sgi.com.

> With both conntrack and bridging turned on in the 2.6.0test11 kernel,
> sending fragmented packets over the bridge reveals a memory leak
> (specifically, forwarding packets from any interface to a bridge).  The
> memory that is leaking seems to be being allocated on line 299 on
> net/bridge/br_netfilter.c:
>
>         if ((nf_bridge = nf_bridge_alloc(skb)) == NULL)
>                 return NF_DROP;

Thanks for the good diagnose.

> Only the first fragment gets freed later on.
>
> The patch attached fixes the problem by freeing nf_bridge when the
> packets are defragmented, however I am sure this is not the right place
> to do this.  Where would the skb's for the fragments usually get freed?

I believe they are freed in skbuff.c::skb_release_data().

I think the place where you've put the fix doesn't cover all cases. If 
ip_frag_destroy() is called, there will still be a memory leak. So I think 
the right place for this is in skb_release_data. But consulting with the 
netdev list seems appropriate :)

You can change
+		if (fp->nf_bridge) {
+			nf_bridge_put(fp->nf_bridge);
+			fp->nf_bridge = NULL;
+		};
into
+		nf_bridge_put(fp->nf_bridge);

cheers,
Bart

