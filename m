Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964927AbWHWPEP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964927AbWHWPEP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 11:04:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964918AbWHWPEM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 11:04:12 -0400
Received: from dee.erg.abdn.ac.uk ([139.133.204.82]:46810 "EHLO erg.abdn.ac.uk")
	by vger.kernel.org with ESMTP id S964932AbWHWPEI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 11:04:08 -0400
From: gerrit@erg.abdn.ac.uk
To: James Morris <jmorris@namei.org>
Subject: Re: [RFC][PATCH 1/3] net/ipv4: UDP-Lite extensions
Date: Wed, 23 Aug 2006 16:03:07 +0100
User-Agent: KMail/1.8.3
Cc: davem@davemloft.net, alan@lxorguk.ukuu.org.uk, kuznet@ms2.inr.ac.ru,
       pekkas@netcore.fi, kaber@coreworks.de, yoshfuji@linux-ipv6.org,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <200608231150.42039@strip-the-willow> <Pine.LNX.4.64.0608231019010.3198@d.namei>
In-Reply-To: <Pine.LNX.4.64.0608231019010.3198@d.namei>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200608231603.08240@strip-the-willow>
X-ERG-MailScanner: Found to be clean
X-ERG-MailScanner-From: gerrit@erg.abdn.ac.uk
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

Quoting James Morris:
|  On Wed, 23 Aug 2006, gerrit@erg.abdn.ac.uk wrote:
|  
|  > +void __init udplite4_register(void)
|  > +{
|  > +	if (proto_register(&udplite_prot, 1))
|  > +		goto out_register_err;
|  > +
|  > +	if (inet_add_protocol(&udplite_protocol, IPPROTO_UDPLITE) < 0)
|  > +		goto out_unregister_proto;
|  > +
|  > +	inet_register_protosw(&udplite4_protosw);
|  > +
|  > +	return;
|  > +
|  > +out_unregister_proto:
|  > +	proto_unregister(&udplite_prot);
|  > +out_register_err:
|  > +	printk(KERN_ERR "udplite4_register: Cannot add UDP-Lite protocol\n");
|  > +}
|  
|  Other protocols & network components call panic() if they fail during boot 
|  initialization.  Not sure if this is a great thing, but it raises the 
|  issue of whether udp-lite should remain consistent here.

The behaviour is consistent (modulo loglevel) with inet_init()
of net/ipv4/af_inet.c:

	// ...

	rc = proto_register(&udp_prot, 1);
	if (rc)
		goto out_unregister_tcp_proto;

	// ... 
      	if (inet_add_protocol(&udp_protocol, IPPROTO_UDP) < 0)
		printk(KERN_CRIT "inet_init: Cannot add UDP protocol\n");
	if (inet_add_protocol(&tcp_protocol, IPPROTO_TCP) < 0)
		printk(KERN_CRIT "inet_init: Cannot add TCP protocol\n");

	// ...
	for (q = inetsw_array; q < &inetsw_array[INETSW_ARRAY_LEN]; ++q)
		inet_register_protosw(q);

 	// ...

        /* UDP Lite is called here, but the code of udplite4_register()
         * could as well be put in place within inet_init()              */

	udplite4_register();


But your question raises another: 
  * if TCP cannot init, there is no layer-4 protocol
  * if UDP cannot register, TCP is unregistered also
  * if RAW cannot register, only UDP is unregistered, but not TCP

>From that I could not deduct a rule what would happen if UDP-Lite failed
to register. If control had reached that above point, it means that all
other protocols have already successfully registered -- if then UDP-Lite
could not register and called a panic(), it would abort the remainder of the
stack. 

So how should the code be integrated:
 (a) following the same scheme as in af_inet.c (like f.e. raw_prot ) or
 (b) keep separate initialisation (as it is used e.g. in net/dccp/ipv4, dccp_v4_init())
 (c) ... ?


Gerrit
