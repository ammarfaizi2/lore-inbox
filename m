Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264617AbSLQCzC>; Mon, 16 Dec 2002 21:55:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264620AbSLQCzC>; Mon, 16 Dec 2002 21:55:02 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:12747 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S264617AbSLQCy7>;
	Mon, 16 Dec 2002 21:54:59 -0500
Date: Mon, 16 Dec 2002 19:02:43 -0800
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] : More module parameter compatibility for 2.5.52
Message-ID: <20021217030243.GA18584@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20021217012646.GA18021@bougret.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021217012646.GA18021@bougret.hpl.hp.com>
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 16, 2002 at 05:26:46PM -0800, jt wrote:
> 	Hi,
> 
> 	I've just downloaded 2.5.52 to try the new module parameter
> support. Unfortunately, the letter 'c' was not implemented, and I need
> it. This is used in few drivers (such as hp100, wavelan, wlan_cs...).
> 	I've only checked that with this patch my hp100 cards load
> fine, but I didn't test the various corner cases.
> 
> 	Have fun...
> 
> 	Jean

	Yeah, and I really should have tested this stuff properly...
	New (corrected) patch attached... Maybe even correct, who
knows...

	Jean

---------------------------------------------------------------

diff -u -p linux/include/linux/moduleparam.r1.h linux/include/linux/moduleparam.h
--- linux/include/linux/moduleparam.r1.h	Mon Dec 16 16:19:59 2002
+++ linux/include/linux/moduleparam.h	Mon Dec 16 18:37:02 2002
@@ -25,6 +25,7 @@ struct kernel_param {
 	param_set_fn set;
 	param_get_fn get;
 	void *arg;
+	void *priv;
 };
 
 /* Special one for strings we want to copy into */
@@ -123,5 +124,6 @@ int param_array(const char *name,
 		const char *val,
 		unsigned int min, unsigned int max,
 		void *elem, int elemsize,
-		int (*set)(const char *, struct kernel_param *kp));
+		int (*set)(const char *, struct kernel_param *kp),
+		void *priv);
 #endif /* _LINUX_MODULE_PARAM_TYPES_H */
diff -u -p linux/kernel/params.r1.c linux/kernel/params.c
--- linux/kernel/params.r1.c	Mon Dec 16 16:08:35 2002
+++ linux/kernel/params.c	Mon Dec 16 18:38:33 2002
@@ -228,7 +228,8 @@ int param_array(const char *name,
 		const char *val,
 		unsigned int min, unsigned int max,
 		void *elem, int elemsize,
-		int (*set)(const char *, struct kernel_param *kp))
+		int (*set)(const char *, struct kernel_param *kp),
+		void *priv)
 {
 	int ret;
 	unsigned int count = 0;
@@ -237,6 +238,7 @@ int param_array(const char *name,
 	/* Get the name right for errors. */
 	kp.name = name;
 	kp.arg = elem;
+	kp.priv = priv;
 
 	/* No equals sign? */
 	if (!val) {
@@ -285,7 +287,7 @@ int param_set_intarray(const char *val, 
 	/* Grab min and max as first two elements */
 	array = kp->arg;
 	return param_array(kp->name, val, array[0], array[1], &array[2],
-			   sizeof(int), param_set_int);
+			   sizeof(int), param_set_int, NULL);
 }
 
 int param_get_intarray(char *buffer, struct kernel_param *kp)
diff -u -p linux/kernel/module.r1.c linux/kernel/module.c
--- linux/kernel/module.r1.c	Mon Dec 16 16:08:42 2002
+++ linux/kernel/module.c	Mon Dec 16 18:58:32 2002
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
@@ -593,18 +626,24 @@ extern int set_obsolete(const char *val,
 	switch (*endp) {
 	case 'b':
 		return param_array(kp->name, val, min, max, obsparm->addr,
-				   1, param_set_byte);
+				   1, param_set_byte, NULL);
 	case 'h':
 		return param_array(kp->name, val, min, max, obsparm->addr,
-				   sizeof(short), param_set_short);
+				   sizeof(short), param_set_short, NULL);
 	case 'i':
 		return param_array(kp->name, val, min, max, obsparm->addr,
-				   sizeof(int), param_set_int);
+				   sizeof(int), param_set_int, NULL);
 	case 'l':
 		return param_array(kp->name, val, min, max, obsparm->addr,
-				   sizeof(long), param_set_long);
+				   sizeof(long), param_set_long, NULL);
 	case 's':
 		return param_string(kp->name, val, min, max, obsparm->addr);
+	case 'c':
+		p = endp+1;
+		line = simple_strtol(p, &endp, 10);
+		/* Maybe we should check that line doesn't get absurdly big */
+		return param_array(kp->name, val, min, max, obsparm->addr,
+				   line, param_set_chara, (void *) line);
 	}
 	printk(KERN_ERR "Unknown obsolete parameter type %s\n", obsparm->type);
 	return -EINVAL;
