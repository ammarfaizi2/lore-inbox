Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265250AbUEVBEH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265250AbUEVBEH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 21:04:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265108AbUEVA7B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 20:59:01 -0400
Received: from websrv.werbeagentur-aufwind.de ([213.239.197.241]:62118 "EHLO
	websrv.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S264488AbUEVAun (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 20:50:43 -0400
Date: Thu, 20 May 2004 23:37:44 +0200
From: Christophe Saout <christophe@saout.de>
To: "David S. Miller" <davem@redhat.com>
Cc: James Morris <jmorris@redhat.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: Fw: IPsec/crypto kernel panic in 2.6.[456]
Message-ID: <20040520213743.GA9702@leto.cs.pocnet.net>
References: <20040520003739.624cc2d2.akpm@osdl.org> <Xine.LNX.4.44.0405200409530.15731-100000@thoron.boston.redhat.com> <20040520081049.4bfa7e3f.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040520081049.4bfa7e3f.davem@redhat.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 20, 2004 at 08:10:49AM -0700, David S. Miller wrote:

> > > erp, unprivileged users can oops the box?  Is anyone looking into
> > > this?
> > 
> > I hope Christophe can, as he can also verify that the original problem 
> > remains fixed.
> 
> James is travelling today, and if Christophe doesn't get to it I'll
> dig into this today.

I've no idea what's going on there. I found two small problems but they
don't explain the Oops.

It looks like dst points into nirvana.

The two problems I found:

After calling scatterwalk_copychunks walk_in might point to the next
page which will break scatterwalk_samebuf (in this case src_p should
point to tmp_src anyway and scatterwalk_samembuf returns 0).

scatterwalk_samebuf should also check for equal offsets inside the
page (just bad for performance in some cases).

Both don't explain the Oops and shouldn't corrupt data,

--- linux-2.6.6/crypto/cipher.c	2004-05-10 04:32:37.000000000 +0200
+++ linux/crypto/cipher.c	2004-05-20 13:07:39.000000000 +0200
@@ -68,19 +68,20 @@
 
 	for(;;) {
 		u8 *src_p, *dst_p;
+		int in_place;
 
 		scatterwalk_map(&walk_in, 0);
 		scatterwalk_map(&walk_out, 1);
 		src_p = scatterwalk_whichbuf(&walk_in, bsize, tmp_src);
 		dst_p = scatterwalk_whichbuf(&walk_out, bsize, tmp_dst);
+		in_place = scatterwalk_samebuf(&walk_in, &walk_out,
+					       src_p, dst_p);
 
 		nbytes -= bsize;
 
 		scatterwalk_copychunks(src_p, &walk_in, bsize, 0);
 
-		prfn(tfm, dst_p, src_p, crfn, enc, info,
-		     scatterwalk_samebuf(&walk_in, &walk_out,
-					 src_p, dst_p));
+		prfn(tfm, dst_p, src_p, crfn, enc, info, in_place);
 
 		scatterwalk_done(&walk_in, 0, nbytes);
 
--- linux-2.6.6/crypto/scatterwalk.h	2004-05-10 04:33:20.000000000 +0200
+++ linux/crypto/scatterwalk.h	2004-05-20 13:02:44.000000000 +0200
@@ -38,6 +38,7 @@
 				      void *src_p, void *dst_p)
 {
 	return walk_in->page == walk_out->page &&
+	       walk_in->offset == walk_out->offset &&
 	       walk_in->data == src_p && walk_out->data == dst_p;
 }
 
