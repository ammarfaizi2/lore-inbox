Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262838AbSLZJqc>; Thu, 26 Dec 2002 04:46:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262859AbSLZJqc>; Thu, 26 Dec 2002 04:46:32 -0500
Received: from dp.samba.org ([66.70.73.150]:987 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S262838AbSLZJq3>;
	Thu, 26 Dec 2002 04:46:29 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, jt@hpl.hp.com
Subject: [PATCH] MODULE_PARM "c" support
Date: Thu, 26 Dec 2002 18:11:59 +1100
Message-Id: <20021226095445.30F132C08B@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

	Turns out there was an undocumented "c" flag for MODULE_PARM.
This implementation is a little ugly, but it works, and will do for
compatibility (I haven't implemented such a two-dimensional array
primitive, but the whole point of the module_parm et al is that they
are extensible).

Please apply,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Name: Implement c in MODULE_PARM compatibility wedge
Author: Rusty Russell and Jean Tourrilhes
Status: Experimental

D: The "c" MODULE_PARM type was missing, as pointed out by Jean Tourrilhes.

diff -urNp --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.52/kernel/module.c working-2.5.52-cparam/kernel/module.c
--- linux-2.5.52/kernel/module.c	Tue Dec 17 08:11:03 2002
+++ working-2.5.52-cparam/kernel/module.c	Tue Dec 17 14:42:05 2002
@@ -569,10 +569,19 @@ static int param_string(const char *name
 	return 0;
 }
 
+/* Bounds checking done below */
+static int obsparm_copy_string(const char *val, struct kernel_param *kp)
+{
+	strcpy(kp->arg, val);
+	return 0;
+}
+
 extern int set_obsolete(const char *val, struct kernel_param *kp)
 {
 	unsigned int min, max;
-	char *p, *endp;
+	unsigned int size, maxsize;
+	char *endp;
+	const char *p;
 	struct obsolete_modparm *obsparm = kp->arg;
 
 	if (!val) {
@@ -605,8 +614,29 @@ extern int set_obsolete(const char *val,
 				   sizeof(long), param_set_long);
 	case 's':
 		return param_string(kp->name, val, min, max, obsparm->addr);
+
+	case 'c':
+		/* Undocumented: 1-5c50 means 1-5 strings of up to 49 chars,
+		   and the decl is "char xxx[5][50];" */
+		p = endp+1;
+		maxsize = simple_strtol(p, &endp, 10);
+		/* We check lengths here (yes, this is a hack). */
+		p = val;
+		while (p[size = strcspn(p, ",")]) {
+			if (size >= maxsize) 
+				goto oversize;
+			p += size+1;
+		}
+		if (size >= maxsize) 
+			goto oversize;
+		return param_array(kp->name, val, min, max, obsparm->addr,
+				   maxsize, obsparm_copy_string);
 	}
 	printk(KERN_ERR "Unknown obsolete parameter type %s\n", obsparm->type);
+	return -EINVAL;
+ oversize:
+	printk(KERN_ERR
+	       "Parameter %s doesn't fit in %u chars.\n", kp->name, maxsize);
 	return -EINVAL;
 }
 
