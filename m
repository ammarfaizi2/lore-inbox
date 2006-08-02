Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932117AbWHBSBV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932117AbWHBSBV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 14:01:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932118AbWHBSBV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 14:01:21 -0400
Received: from hera.kernel.org ([140.211.167.34]:13734 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S932117AbWHBSBU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 14:01:20 -0400
To: linux-kernel@vger.kernel.org
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: strange issues with simple net module for 2.4
Date: Wed, 2 Aug 2006 11:00:44 -0700
Organization: OSDL
Message-ID: <20060802110044.028718fb@dxpl.pdx.osdl.net>
References: <32831.83.29.18.163.1154472723.squirrel@83.29.18.163>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Trace: build.pdx.osdl.net 1154541648 25746 10.8.0.74 (2 Aug 2006 18:00:48 GMT)
X-Complaints-To: abuse@osdl.org
NNTP-Posting-Date: Wed, 2 Aug 2006 18:00:48 +0000 (UTC)
X-Newsreader: Sylpheed-Claws 2.3.1 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Aug 2006 00:52:03 +0200 (CEST)
gj@pointblue.com.pl wrote:

> /* Please do CC me on replies, I am not subscribed to the list. */
> 
> hi devs
> 
> I have spend some time, and wrote very simple NET device module for 2.4
> kernels. It does allocate certain number of paired net interfaces named
> tola%d , where for instance:
> tola(N*2)<->tola(N*2)+1
> 
> anything you send to tola0, appears on tola1, and the other way around,
> same for all Ns.
> 
> http://podgorze.pl/~gj/tola.tar.bz2
> (~2kb)
> 
> there are few issues however.
> First of all, I am not able to allocate more than 50 pairs (the param is
> at the top of the source - int nrofi; ). Secondly, every once in a while
> it crashes badly on unload, and frankly - I have no idea why.

Since you want a specific device name, ask for it rather than letting
register_netdev assign it. The code to do automagic device names (like eth%d)
is very slow and limited in 2.4. 

So change:
	strcpy(tola_dev[i]->name, "tola%d");

To:
	snprintf(tola_dev[i]->name, "tola%d", i);
	
And rather than putting ascii values in the ethernet address, put
a valid software random address.
Replace this bad code:
	snprintf( mak+1, ETH_ALEN-1, "%dtola", i );
	mak[0] = '\0';
	memcpy(tola_dev[i]->dev_addr, mak, ETH_ALEN );

with:
	get_random_bytes(tola_dev[i]->dev_addr, ETH_ALEN);
	dev->dev_addr[0] &= 0xfe;
	dev->dev_addr[0] |= 0x02;

This is code from random_ether_adddr() in 2.6.

Don't lose the error return from register_netdev and leak memory:

Not:
	r = register_netdev (tola_dev[i]);
	if ( r ) {
	    return -ENOMEM;
	}

Use:
	r = register_netdev(tola_dev[i]);
	if (r) {
		int j;
		free_netdev(tola_dev[i]);
		for (j = 0; j < i; j++) {
			unregister_netdev(tola_dev[j]);
			free_netdev(tola_dev[j]);
		}
		return r;
	}

You don't need tola_open, tola_close stubs, since the core network
code does the right thing if the pointers are NULL.

Lastly, you need to free the netdevice in the cleanup code.


> Once again, this is 2.4.X module! The reason being, we are using here only
> 2.4 series for networking for various reasons that I don't want to get
> into now.
> I do appriciate any help or hints regarding this module please.
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


-- 
Stephen Hemminger <shemminger@osdl.org>
"And in the Packet there writ down that doome"
