Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262986AbSIPVek>; Mon, 16 Sep 2002 17:34:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263099AbSIPVek>; Mon, 16 Sep 2002 17:34:40 -0400
Received: from eos.telenet-ops.be ([195.130.132.40]:11139 "EHLO
	eos.telenet-ops.be") by vger.kernel.org with ESMTP
	id <S262986AbSIPVei> convert rfc822-to-8bit; Mon, 16 Sep 2002 17:34:38 -0400
Content-Type: text/plain; charset=US-ASCII
From: Bart De Schuymer <bart.de.schuymer@pandora.be>
To: "David S. Miller" <davem@redhat.com>
Subject: Re: bridge-netfilter patch
Date: Mon, 16 Sep 2002 23:41:17 +0200
X-Mailer: KMail [version 1.4]
Cc: buytenh@math.leidenuniv.nl, linux-kernel@vger.kernel.org
References: <20020913144518.A31318@math.leidenuniv.nl> <200209140905.40816.bart.de.schuymer@pandora.be> <20020915.203528.08097520.davem@redhat.com>
In-Reply-To: <20020915.203528.08097520.davem@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200209162341.17032.bart.de.schuymer@pandora.be>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>    This is for purely bridged packets.
>
> Why is it being added, therefore, to ip_queue_xmit() which is only
> ever invoked by TCP output processing?
>
> If the patch adds the call somewhere else, please correct me, but
> I specifically remember it being added to ip_queue_xmit() which is
> why I barfed when seeing it :-)

I've never seen this in the patch. It sure isn't in it now.

To be more precise:
net/ipv4/netfilter/ip_conntrack_standalone.c:ip_refrag() is (or can be) 
attached to the NF_IP_POST_ROUTING hook. This function calls:
net/ipv4/ip_output.c:ip_fragment()
In this function the copy of the Ethernet frame is added for each fragment (by 
the br-nf patch).
The bridge-netfilter patch lets IP packets/frames passing the 
NF_BR_POST_ROUTING hook go through the NF_IP_POST_ROUTING hook, so the 
ip_fragment() code is executed while the IP packet/frame is really in the 
bridge code. After this, the fragments get queued:
net/bridge/br_forward.c:br_dev_queue_push_xmit() calls dev_queue_xmit()

Lennert's previous mail says in which cases and why this header copy has to be 
explicitly done.

The following document might be useful to know what we are doing:
http://users.pandora.be/bart.de.schuymer/ebtables/br_fw_ia/br_fw_ia.html

-- 
cheers,
Bart

