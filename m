Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135465AbRAGDNA>; Sat, 6 Jan 2001 22:13:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135508AbRAGDMu>; Sat, 6 Jan 2001 22:12:50 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:10230 "HELO
	brinquedo.distro.conectiva") by vger.kernel.org with SMTP
	id <S135465AbRAGDMn>; Sat, 6 Jan 2001 22:12:43 -0500
Date: Sun, 7 Jan 2001 01:12:26 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Steve.Ralston@lsil.com
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: [PATCH] mptctl.c memory leak on failure
Message-ID: <20010107011226.C8362@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Steve.Ralston@lsil.com, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

	Please consider applying this patch. And I got confused by the
kmalloc and the comment: the buffer is used for DMA but the kmalloc doesn't
has GFP_DMA, maybe I'm missing something here, its about time for me to
sleep 8) but if it doesn't needs DMA you should consider using vmalloc and
you'll get rid of the 32 pages limitation, like I did for wanrouter that
used kmalloc but didn't needed DMA, so I've changed it to vmalloc as per
Alan's cluebating^Wsuggestion at the time 8)

- Arnaldo

--- linux-2.4.0-ac3/drivers/message/fusion/mptctl.c	Sat Jan  6 23:13:11 2001
+++ linux-2.4.0-ac3.acme/drivers/message/fusion/mptctl.c	Sun Jan  7 01:02:52 2001
@@ -290,6 +290,7 @@
 	dma_addr_t		 fwbuf_dma;
 	FWDownloadTCSGE_t	*fwVoodoo;
 	SGEAllUnion_t		*fwSgl;
+	int ret;
 
 	dprintk((KERN_INFO "mptctl_do_fwdl called. mptctl_id = %xh.\n", mptctl_id)); //tc
 
@@ -309,20 +310,22 @@
 	}
 //dprintk((KERN_INFO "DbG: fwbuf       = %p\n", fwbuf));
 
+	ret = -EFAULT;
 	if (copy_from_user(fwbuf, ufwbuf, fwlen) < 0) {
 		printk(KERN_ERR "%s@%d::_ioctl_fwdl - "
 				"Unable to copy f/w buffer @ %p\n",
 				__FILE__, __LINE__, (void*)ufwbuf);
-		return -EFAULT;
+		goto out;
 	}
 
 	/* Perform Firmware download.
 	 */
 
+	ret = -ENXIO; /* (-6) No such device or address */
 	if ((ioc = mpt_verify_adapter(ioc, &iocp)) < 0) {
 		printk("%s@%d::_ioctl_fwdl - ioc%d not found!\n",
 				__FILE__, __LINE__, ioc);
-		return -ENXIO;			  /* (-6) No such device or address */
+		goto out;
 	}
 
 	mf = MptGetMsgFrame(mptctl_id, ioc);
@@ -373,8 +376,9 @@
 					   "In ReplyMsg loop - iteration %d\n",
 					   foo)); //tc
 			}
+			ret = -ETIME;
 			if (++foo > 60000000)
-				return -ETIME;
+				goto out;
 			mb();
 			schedule();
 			barrier();
@@ -402,6 +406,9 @@
 		printk(KERN_WARNING MYNAM ": (bad VooDoo):\n");
 		return -ENOMSG;
 	}
+	return 0;
+out:	kfree(fwbuf);
+	return ret;
 }
 
 /*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
