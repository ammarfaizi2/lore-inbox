Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263358AbTEYP4g (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 May 2003 11:56:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263418AbTEYP4g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 May 2003 11:56:36 -0400
Received: from pimout4-ext.prodigy.net ([207.115.63.103]:26580 "EHLO
	pimout4-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S263358AbTEYP4e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 May 2003 11:56:34 -0400
From: dan carpenter <d_carpenter@sbcglobal.net>
To: "Paulo Andre'" <l16083@alunos.uevora.pt>,
       Christoph Hellwig <hch@infradead.org>
Subject: Re: Question on verify_area() and friends wrt
Date: Sun, 25 May 2003 00:46:31 +0200
User-Agent: KMail/1.5.1
Cc: kernel-janitor-discuss@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20030525124625.4dedc758.l16083@alunos.uevora.pt> <20030525130706.B9127@infradead.org> <20030525145319.6f66a8aa.l16083@alunos.uevora.pt>
In-Reply-To: <20030525145319.6f66a8aa.l16083@alunos.uevora.pt>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200305250045.19458.d_carpenter@sbcglobal.net>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 25 May 2003 03:53 pm, Paulo Andre' wrote:
> Christoph Hellwig <hch@infradead.org> wrote:
> > verify_area only does some checks so you need to check the return
> > value from copy_to_user.  You could switch to __copy_to_user, though.
>
> Why would __copy_to_user be a good choice? AFAIK, __copy_to_user does no
> validy checks (as opposed to copy_to_user which does access_ok()) so,
> considering verify_area() does only some checks, one could argue that
> there's even less checking done if using __copy_to_user. Where am I
> interpreting this wrong (as I certainly am) ?
>

copy_to_user() does the equivelent of a verify_area().  __copy_to_user() 
doesn't 
make the verify_area() check.If a function is going to be making a lot of 
copies to 
the same area, it makes sense to just do one verify_area() and use 
__copy_to_user().
Both copy_to_user() and __copy_to_user() can fail even though the 
verify_area() 
checks pass.

In this case there is only one copy to each area so it doesn't really make
sense to use __copy_to_user().

My patch would look like this:

--- net/bluetooth/hci_core.c.orig       2003-05-25 00:25:16.000000000 +0200
+++ net/bluetooth/hci_core.c    2003-05-25 00:25:34.000000000 +0200
@@ -431,14 +431,14 @@
 
        BT_DBG("num_rsp %d", ir.num_rsp);
 
-       if (!verify_area(VERIFY_WRITE, ptr, sizeof(ir) + 
-                       (sizeof(struct inquiry_info) * ir.num_rsp))) {
-               copy_to_user(ptr, &ir, sizeof(ir));
-               ptr += sizeof(ir);
-               copy_to_user(ptr, buf, sizeof(struct inquiry_info) * 
ir.num_rsp);
-       } else 
+       if (copy_to_user(ptr, &ir, sizeof(ir))) {
                err = -EFAULT;
-
+               goto free:
+       }
+       ptr += sizeof(ir);
+       if (copy_to_user(ptr, buf, sizeof(struct inquiry_info) * ir.num_rsp))
+               err = -EFAULT;
+free:
        kfree(buf);
 
 done:


