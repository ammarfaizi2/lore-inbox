Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265480AbRGDOHY>; Wed, 4 Jul 2001 10:07:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265003AbRGDOHP>; Wed, 4 Jul 2001 10:07:15 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:44303 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S265480AbRGDOHI>; Wed, 4 Jul 2001 10:07:08 -0400
Date: Wed, 4 Jul 2001 11:06:55 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: fabrizio.gennari@philips.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Re: dev_get_by_name without dev_put
Message-ID: <20010704110655.B897@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	fabrizio.gennari@philips.com, linux-kernel@vger.kernel.org
In-Reply-To: <OF870A7F74.AB18863F-ONC1256A7F.004AB8A1@diamond.philips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <OF870A7F74.AB18863F-ONC1256A7F.004AB8A1@diamond.philips.com>; from fabrizio.gennari@philips.com on Wed, Jul 04, 2001 at 03:49:46PM +0200
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Jul 04, 2001 at 03:49:46PM +0200, fabrizio.gennari@philips.com escreveu:
> Every time dev_get_by_name is called, and it has returned a valid struct net_device*, dev_put should be called afterwards, because otherwise the machine hangs when the device is unregistered (since dev->refcnt > 1). However, it seems that some drivers do
> not call dev_put after dev_get_by_name: for example, drivers/net/pppoe.c at line 573 and net/core/dv.c at line 168. Am I wrong?

For pppoe (and one has to look at the set_item and see if delete_item is
needed).

- Arnaldo

--- linux-2.4.5-ac24/drivers/net/pppoe.c	Tue Jul  3 18:45:41 2001
+++ linux-2.4.5-ac24.acme/drivers/net/pppoe.c	Wed Jul  4 11:00:47 2001
@@ -567,17 +567,17 @@
 		if (!dev)
 			goto end;
 
+		po->pppoe_dev = dev;
+
 		if( ! (dev->flags & IFF_UP) )
-			goto end;
+			goto err_put;
 		memcpy(&po->pppoe_pa,
 		       &sp->sa_addr.pppoe,
 		       sizeof(struct pppoe_addr));
 
 		error = set_item(po);
 		if (error < 0)
-			goto end;
-
-		po->pppoe_dev = dev;
+			goto err_put;
 
 		po->chan.hdrlen = (sizeof(struct pppoe_hdr) +
 				   dev->hard_header_len);
@@ -586,6 +586,8 @@
 		po->chan.ops = &pppoe_chan_ops;
 
 		error = ppp_register_channel(&po->chan);
+		if (error)
+			goto err_put;
 
 		sk->state = PPPOX_CONNECTED;
 	}
@@ -595,6 +597,10 @@
  end:
 	release_sock(sk);
 	return error;
+err_put:
+	dev_put(po->pppoe_dev);
+	po->pppoe_dev = NULL;
+	goto end;
 }
 
- Arnaldo
