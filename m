Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271808AbTHDPc2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 11:32:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271812AbTHDPc2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 11:32:28 -0400
Received: from mivlgu.ru ([81.18.140.87]:20631 "EHLO mail.mivlgu.ru")
	by vger.kernel.org with ESMTP id S271808AbTHDPcU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 11:32:20 -0400
Date: Mon, 4 Aug 2003 19:32:12 +0400
From: Sergey Vlasov <vsu@altlinux.ru>
To: sensors@stimpy.netroedge.com, linux-kernel@vger.kernel.org
Subject: Re: PATCH: 2.4.22-pre7 drivers/i2c/i2c-dev.c user/kernel bug and  
 mem leak
Message-Id: <20030804193212.11786d06.vsu@altlinux.ru>
In-Reply-To: <20030803192312.68762d3c.khali@linux-fr.org>
References: <20030803192312.68762d3c.khali@linux-fr.org>
X-Mailer: Sylpheed version 0.9.4cvs2 (GTK+ 1.2.10; i586-alt-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Aug 2003 19:23:12 +0200
Jean Delvare <khali@linux-fr.org> wrote:

> Ten days ago, Robert T. Johnson repported two bugs in 2.4's
> drivers/i2c/i2c-dev.c. It also applies to i2c CVS (out of kernel), which
> is intended to become 2.4's soon. Being a member of the LM Sensors dev
> team, I took a look at the repport. My knowledge is somewhat limited but
> I'll do my best to help (unless Greg wants to handle it alone? ;-)).
> 
> For the user/kernel bug, I'm not sure I understand how copy_from_user is
> supposed to work. If I understand what the proposed patch does, it
> simply allocates a second buffer, copy_from_user to that buffer instead
> of to the original one, and then copies from that second buffer to the
> original one (kernel to kernel). I just don't see how different it is
> from what the current code does, as far as user/kernel issues are
> concerned. I must be missing something obvious, can someone please bring
> me some light?

The current code takes rdwr_arg.msgs (which is a userspace pointer)
and then reads rdwr_arg.msgs[i].buf directly, which must not be done.
This is done in two places - when copying the user data before
i2c_transfer(), and when copying the result back to the userspace
after it.

Because both the userspace pointer and the kernel buffer pointer are
needed, a second copy must be made. If you want to conserve memory,
you may just allocate an array of pointers to keep the userspace
buffer pointers during the transfer.

BTW, an optimization is possible here: the whole rdwr_arg.msgs array
can be copied into the kernel memory with one copy_from_user() instead
of copying its items one by one.

> For the mem leak bug, it's clearly there. I admit the proposed patch
> fixes it, but I think there is a better way to fix it. Compare what the
> proposed patch does:
> 
> --- i2c-dev.c	Sun Aug  3 18:24:33 2003
> +++ i2c-dev.c.proposed	Sun Aug  3 19:13:58 2003
> @@ -226,6 +226,7 @@
>  		res = 0;
>  		for( i=0; i<rdwr_arg.nmsgs; i++ )
>  		{
> +			rdwr_pa[i].buf = NULL;
>  		    	if(copy_from_user(&(rdwr_pa[i]),
>  					&(rdwr_arg.msgs[i]),
>  					sizeof(rdwr_pa[i])))
> @@ -254,8 +255,9 @@
>  		}
>  		if (res < 0) {
>  			int j;
> -			for (j = 0; j < i; ++j)
> -				kfree(rdwr_pa[j].buf);
> +			for (j = 0; j <= i; ++j)
> +				if (rdwr_pa[j].buf)
> +					kfree(rdwr_pa[j].buf);
>  			kfree(rdwr_pa);
>  			return res;
>  		}
> 
> with what I suggest:
> 
> --- i2c-dev.c	Sun Aug  3 18:24:33 2003
> +++ i2c-dev.c.khali	Sun Aug  3 19:15:04 2003
> @@ -247,8 +247,9 @@
>  			if(copy_from_user(rdwr_pa[i].buf,
>  				rdwr_arg.msgs[i].buf,
>  				rdwr_pa[i].len))
>  			{
> +				kfree(rdwr_pa[i].buf);
>  			    	res = -EFAULT;
>  				break;
>  			}
>  		}
> 
> Contrary to the proposed fix, my fix does not slow down the non-faulty
> cases. I also believe it will increase the code size by fewer bytes than
> the proposed fix (not verified though).

This fix should work too. Yet another way is to do ++i there, but that
would be too obscure.

> So, what about it?

Here is my version (with the mentioned optimization - warning: not
even compiled):

--- i2c-dev.c.old	2003-07-28 16:14:34 +0400
+++ i2c-dev.c	2003-08-04 19:28:25 +0400
@@ -171,6 +171,7 @@
 	struct i2c_smbus_ioctl_data data_arg;
 	union i2c_smbus_data temp;
 	struct i2c_msg *rdwr_pa;
+	u8 **data_ptrs;
 	int i,datasize,res;
 	unsigned long funcs;
 
@@ -223,21 +224,28 @@
 
 		if (rdwr_pa == NULL) return -ENOMEM;
 
+		if (copy_from_user(rdwr_pa, rdwr_arg.msgs,
+				   rdwr_arg.nmsgs * sizeof(struct i2c_msg))) {
+			kfree(rdwr_pa);
+			return -EFAULT;
+		}
+
+		data_ptrs = (u8 **) kmalloc(rdwr_arg.nmsgs * sizeof(u8 *),
+					    GFP_KERNEL);
+		if (data_ptrs == NULL) {
+			kfree(rdwr_pa);
+			return -ENOMEM;
+		}
+
 		res = 0;
 		for( i=0; i<rdwr_arg.nmsgs; i++ )
 		{
-		    	if(copy_from_user(&(rdwr_pa[i]),
-					&(rdwr_arg.msgs[i]),
-					sizeof(rdwr_pa[i])))
-			{
-			        res = -EFAULT;
-				break;
-			}
 			/* Limit the size of the message to a sane amount */
 			if (rdwr_pa[i].len > 8192) {
 				res = -EINVAL;
 				break;
 			}
+			data_ptrs[i] = rdwr_pa[i].buf;
 			rdwr_pa[i].buf = kmalloc(rdwr_pa[i].len, GFP_KERNEL);
 			if(rdwr_pa[i].buf == NULL)
 			{
@@ -245,9 +253,10 @@
 				break;
 			}
 			if(copy_from_user(rdwr_pa[i].buf,
-				rdwr_arg.msgs[i].buf,
+				data_ptrs[i],
 				rdwr_pa[i].len))
 			{
+				kfree(rdwr_pa[i].buf);
 			    	res = -EFAULT;
 				break;
 			}
@@ -256,6 +265,7 @@
 			int j;
 			for (j = 0; j < i; ++j)
 				kfree(rdwr_pa[j].buf);
+			kfree(data_ptrs);
 			kfree(rdwr_pa);
 			return res;
 		}
@@ -270,7 +280,7 @@
 			if( res>=0 && (rdwr_pa[i].flags & I2C_M_RD))
 			{
 				if(copy_to_user(
-					rdwr_arg.msgs[i].buf,
+					data_ptrs[i],
 					rdwr_pa[i].buf,
 					rdwr_pa[i].len))
 				{
@@ -279,6 +289,7 @@
 			}
 			kfree(rdwr_pa[i].buf);
 		}
+		kfree(data_ptrs);
 		kfree(rdwr_pa);
 		return res;
 
