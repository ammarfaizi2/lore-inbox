Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267445AbUIAUqw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267445AbUIAUqw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 16:46:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267711AbUIAUnq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 16:43:46 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:62395 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S267503AbUIAUkx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 16:40:53 -0400
Date: Wed, 1 Sep 2004 21:40:35 +0100
From: Dave Jones <davej@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix leak in PNP interface code.
Message-ID: <20040901204035.GC10829@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	linux-kernel@vger.kernel.org
References: <200409011551.i81FpKj2000605@delerium.codemonkey.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409011551.i81FpKj2000605@delerium.codemonkey.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 01, 2004 at 04:51:20PM +0100, Dave Jones wrote:
 > Spotted with the source checker from Coverity.com.
 > 
 > Signed-off-by: Dave Jones <davej@redhat.com>
 > 
 > 
 > diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/pnp/interface.c linux-2.6/drivers/pnp/interface.c
 > --- bk-linus/drivers/pnp/interface.c	2004-06-03 13:40:04.000000000 +0100
 > +++ linux-2.6/drivers/pnp/interface.c	2004-06-03 13:42:25.000000000 +0100
 > @@ -244,8 +244,10 @@ static ssize_t pnp_show_current_resource
 >  				pnp_alloc(sizeof(pnp_info_buffer_t));
 >  	if (!buffer)
 >  		return -ENOMEM;
 > -	if (!dev)
 > +	if (!dev) {
 > +		kfree(buffer);
 >  		return -EINVAL;
 > +	}
 >  	buffer->len = PAGE_SIZE;
 >  	buffer->buffer = buf;
 >  	buffer->curr = buffer->buffer;
 > -

Joe Perches pointed out that it may be better to just avoid the
allocation completely if !dev, which makes perfect sense to me.

Signed-off-by: Dave Jones <davej@redhat.com>


--- 1/drivers/pnp/interface.c~	2004-09-01 21:37:37.572983736 +0100
+++ 2/drivers/pnp/interface.c	2004-09-01 21:38:41.056332800 +0100
@@ -240,12 +240,14 @@
 {
 	struct pnp_dev *dev = to_pnp_dev(dmdev);
 	int i, ret;
-	pnp_info_buffer_t *buffer = (pnp_info_buffer_t *)
-				pnp_alloc(sizeof(pnp_info_buffer_t));
-	if (!buffer)
-		return -ENOMEM;
+	pnp_info_buffer_t *buffer;
+
 	if (!dev)
 		return -EINVAL;
+
+	buffer = (pnp_info_buffer_t *) pnp_alloc(sizeof(pnp_info_buffer_t));
+	if (!buffer)
+		return -ENOMEM;
 	buffer->len = PAGE_SIZE;
 	buffer->buffer = buf;
 	buffer->curr = buffer->buffer;
