Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272574AbTHEIce (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 04:32:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272589AbTHEIce
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 04:32:34 -0400
Received: from smtp-102-tuesday.noc.nerim.net ([62.4.17.102]:31500 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id S272574AbTHEIc3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 04:32:29 -0400
Date: Tue, 5 Aug 2003 10:32:40 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Sergey Vlasov <vsu@altlinux.ru>,
       "Robert T. Johnson" <rtjohnso@eecs.berkeley.edu>,
       "Greg KH" <greg@kroah.com>
Cc: sensors@stimpy.netroedge.com, linux-kernel@vger.kernel.org
Subject: Re: PATCH: 2.4.22-pre7 drivers/i2c/i2c-dev.c user/kernel bug and
 mem leak
Message-Id: <20030805103240.02221bed.khali@linux-fr.org>
In-Reply-To: <20030804193212.11786d06.vsu@altlinux.ru>
References: <20030803192312.68762d3c.khali@linux-fr.org>
	<20030804193212.11786d06.vsu@altlinux.ru>
Reply-To: sensors@stimpy.netroedge.com, linux-kernel@vger.kernel.org
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> The current code takes rdwr_arg.msgs (which is a userspace pointer)
> and then reads rdwr_arg.msgs[i].buf directly, which must not be done.

The reason why this must not be done is unknown to me. This is why I am
having a hard time figuring why a fix is necessary. If someone can
explain this to me (off list I guess, unless it is of general interest),
he/she would be welcome.

Anyway, since you seem to agree with Robert T. Johnson on the fact that
this needs to be fixed, I have to believe you. But then again I am not
sure I understand how different your code is from the original one if
copy_to_user and copy_from_user are regular functions. Are these macros?
Maybe taking a look at them would help me understand how the whole thing
works.

> Because both the userspace pointer and the kernel buffer pointer are
> needed, a second copy must be made.

OK, I get this now (wasn't that obvious at first, especially because I
hadn't realized the values were used again after i2c_transfer).

> If you want to conserve memory, you may just allocate an array
> of pointers to keep the userspace buffer pointers during the
> transfer.

Definitely better than what Robert T. Johnson first proposed. This makes
it really clear what data actually needs to be "duplicated" and what
doesn't.

> BTW, an optimization is possible here: the whole rdwr_arg.msgs array
> can be copied into the kernel memory with one copy_from_user() instead
> of copying its items one by one.

Nice one, I like it.

> > Contrary to the proposed fix, my fix does not slow down the
> > non-faulty cases. I also believe it will increase the code size by
> > fewer bytes than the proposed fix (not verified though).
> 
> This fix should work too. Yet another way is to do ++i there, but that
> would be too obscure.

I don't find it that obscure, and after thinking about it for some
times, I even find it more elegant. And I guess it's smaller
(binary-code-wise), although I admit it's almost pointless.

> Here is my version (with the mentioned optimization - warning: not
> even compiled):

Really, I like it much more than Robert's one. It's probably faster,
uses less memory, and was easier to read and understand.

Here comes my version, which is basically yours modified. If it pleases
everyone, we could apply it to 2.4.22-pre10 and i2c-CVS.

Changes:
1* Amount of white space, twice. Ignore.
2* Use ++i instead of kfree as discussed above.
3* Remove conditional test around i2c_transfer, since it isn't necessary
(if I'm not missing something).

diff -ru drivers/i2c/i2c-dev.c drivers/i2c/i2c-dev.c
--- drivers/i2c/i2c-dev.c	Tue Jul 15 12:23:49 2003
+++ drivers/i2c/i2c-dev.c	Tue Aug  5 09:56:50 2003
@@ -219,6 +219,7 @@
 	struct i2c_smbus_ioctl_data data_arg;
 	union i2c_smbus_data temp;
 	struct i2c_msg *rdwr_pa;
+	u8 **data_ptrs;
 	int i,datasize,res;
 	unsigned long funcs;
 
@@ -248,7 +249,7 @@
 		return (copy_to_user((unsigned long *)arg,&funcs,
 		                     sizeof(unsigned long)))?-EFAULT:0;
 
-        case I2C_RDWR:
+	case I2C_RDWR:
 		if (copy_from_user(&rdwr_arg, 
 				   (struct i2c_rdwr_ioctl_data *)arg, 
 				   sizeof(rdwr_arg)))
@@ -265,21 +266,28 @@
 
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
@@ -287,10 +295,11 @@
 				break;
 			}
 			if(copy_from_user(rdwr_pa[i].buf,
-				rdwr_arg.msgs[i].buf,
+				data_ptrs[i],
 				rdwr_pa[i].len))
 			{
-			    	res = -EFAULT;
+				++i; /* Needs to be kfreed too */
+				res = -EFAULT;
 				break;
 			}
 		}
@@ -298,21 +307,19 @@
 			int j;
 			for (j = 0; j < i; ++j)
 				kfree(rdwr_pa[j].buf);
+			kfree(data_ptrs);
 			kfree(rdwr_pa);
 			return res;
 		}
-		if (!res) 
-		{
-			res = i2c_transfer(client->adapter,
-				rdwr_pa,
-				rdwr_arg.nmsgs);
-		}
+		res = i2c_transfer(client->adapter,
+			rdwr_pa,
+			rdwr_arg.nmsgs);
 		while(i-- > 0)
 		{
 			if( res>=0 && (rdwr_pa[i].flags & I2C_M_RD))
 			{
 				if(copy_to_user(
-					rdwr_arg.msgs[i].buf,
+					data_ptrs[i],
 					rdwr_pa[i].buf,
 					rdwr_pa[i].len))
 				{
@@ -321,6 +328,7 @@
 			}
 			kfree(rdwr_pa[i].buf);
 		}
+		kfree(data_ptrs);
 		kfree(rdwr_pa);
 		return res;
 


-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
