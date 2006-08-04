Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161447AbWHDVCy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161447AbWHDVCy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 17:02:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161452AbWHDVCy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 17:02:54 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:27118 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1161447AbWHDVCx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 17:02:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JbqPBEbrxPydmLOEYKrBULdZUD/x8oBsvyOoBNZC7wQ2elsi7mxvn3xfq9vnFokYCHOr/YD4Zgiu/KU2x4nEWDgtCDZ/LzsTiAa868ofEsDkvXuU9GISAqFCUYxqxjgMqXhrg7KZwU/Icduc+C+ZM1TW09ksSGbAVUtygrw8HaY=
Message-ID: <4807377b0608041402p10149bfbrd9e5f3b8849d3f56@mail.gmail.com>
Date: Fri, 4 Aug 2006 14:02:51 -0700
From: "Jesse Brandeburg" <jesse.brandeburg@gmail.com>
To: "Evgeniy Polyakov" <johnpol@2ka.mipt.ru>
Subject: Re: problems with e1000 and jumboframes
Cc: "Chris Leech" <chris.leech@gmail.com>,
       "Herbert Xu" <herbert@gondor.apana.org.au>, arnd@arndnet.de,
       olel@ans.pl, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
In-Reply-To: <20060804194209.GA25167@2ka.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <41b516cb0608031334s6e159e99tb749240f44ae608d@mail.gmail.com>
	 <E1G8sif-0003oY-00@gondolin.me.apana.org.au>
	 <20060804061513.GB413@2ka.mipt.ru>
	 <41b516cb0608040834o1d433f23v2f2ba1a1b05ccbc6@mail.gmail.com>
	 <20060804194209.GA25167@2ka.mipt.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/4/06, Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> On Fri, Aug 04, 2006 at 08:34:46AM -0700, Chris Leech (chris.leech@gmail.com) wrote:
> > So how many skb allocation schemes do you code into a single driver?
> > Kmalloc everything, page alloc everything, combination of kmalloc and
> > page buffers for hardware that does header split?  That's three
> > versions of the drivers receive processing and skb allocation that
> > need to be maintained.
>
> At least try to create scheme which will not end up in 32k allocation in
> atomic context. Generally I would recommend to use frag_list as much as
> possible (or you can reuse skb list).

this is exactly what we ran into, you can't use skb list because the
ip fragmentation reassembly code overwrites it.  If someone is feeling
particularly miffed by this i would love to see a patch that used
alloc_page() for all of our receive buffers for the legacy receive
path (e1000_clean_rx_irq) then we would be able to use nr_frags and
frag_list for receives.

Oh, except that eth_type_trans can't handle the entire packet in the
frag_list (it wants the header in the skb->data)

anyway, this is not as easy a problem to solve as it would seem on the surface.

Jesse
