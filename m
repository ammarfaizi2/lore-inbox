Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262901AbSLQBTQ>; Mon, 16 Dec 2002 20:19:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262913AbSLQBTQ>; Mon, 16 Dec 2002 20:19:16 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:65216 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S262901AbSLQBTO>;
	Mon, 16 Dec 2002 20:19:14 -0500
Date: Mon, 16 Dec 2002 17:26:46 -0800
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>, Jeff Garzik <jgarzik@pobox.com>
Subject: [PATCH] : More module parameter compatibility for 2.5.52
Message-ID: <20021217012646.GA18021@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi,

	I've just downloaded 2.5.52 to try the new module parameter
support. Unfortunately, the letter 'c' was not implemented, and I need
it. This is used in few drivers (such as hp100, wavelan, wlan_cs...).
	I've only checked that with this patch my hp100 cards load
fine, but I didn't test the various corner cases.

	Have fun...

	Jean

---------------------------------------------------------------

diff -u -p linux/include/linux/moduleparam.r1.h linux/include/linux/moduleparam.h
--- linux/include/linux/moduleparam.r1.h	Mon Dec 16 16:19:59 2002
+++ linux/include/linux/moduleparam.h	Mon Dec 16 16:23:55 2002
@@ -25,6 +25,7 @@ struct kernel_param {
 	param_set_fn set;
 	param_get_fn get;
 	void *arg;
+	void *priv;
 };
 
 /* Special one for strings we want to copy into */
diff -u -p linux/kernel/module.r1.c linux/kernel/module.c
--- linux/kernel/module.r1.c	Mon Dec 16 16:08:42 2002
+++ linux/kernel/module.c	Mon Dec 16 16:39:00 2002
@@ -569,9 +569,41 @@ static int param_string(const char *name
 	return 0;
 }
 
+/* Do char array. This probably should be made available in the new stuff.
+ * Note : driver has already allocated the char array and tell us the
+ * size. The array is in fact two dimensional.
+ * Quick'n'dirty hack by Jean II */
+int param_set_chara(const char *val, struct kernel_param *kp)
+{
+	int	maxchar = (int) kp->priv;
+
+	if (!val) {
+		printk(KERN_ERR "%s: char array parameter expected\n",
+		       kp->name);
+		return -EINVAL;
+	}
+
+	/* Let's be on the safe side with respect to nul-termination
+	 * and always set strings with a nul. */
+	if ((strlen(val) + 1) > maxchar) {
+		printk(KERN_ERR "%s: char array parameter too long\n",
+		       kp->name);
+		return -ENOSPC;
+	}
+
+	strcpy((char *)kp->arg, (char *) val);
+	return 0;
+}
+
+int param_get_chara(char *buffer, struct kernel_param *kp)
+{
+	/* We may want to check the array size ? */
+	return sprintf(buffer, "%s", ((char *)kp->arg));
+}
+
 extern int set_obsolete(const char *val, struct kernel_param *kp)
 {
-	unsigned int min, max;
+	unsigned int min, max, line;
 	char *p, *endp;
 	struct obsolete_modparm *obsparm = kp->arg;
 
@@ -581,6 +613,7 @@ extern int set_obsolete(const char *val,
 	}
 
 	/* type is: [min[-max]]{b,h,i,l,s} */
+	/* or [min[-max]]{c}line for 2d array of chars - Jean II */
 	p = obsparm->type;
 	min = simple_strtol(p, &endp, 10);
 	if (endp == obsparm->type)
@@ -605,6 +638,13 @@ extern int set_obsolete(const char *val,
 				   sizeof(long), param_set_long);
 	case 's':
 		return param_string(kp->name, val, min, max, obsparm->addr);
+	case 'c':
+		p = endp+1;
+		line = simple_strtol(p, &endp, 10);
+		/* Maybe we should check that line doesn't get absurdly big */
+		kp->priv = (void *) line;
+		return param_array(kp->name, val, min, max, obsparm->addr,
+				   line, param_set_chara);
 	}
 	printk(KERN_ERR "Unknown obsolete parameter type %s\n", obsparm->type);
 	return -EINVAL;
