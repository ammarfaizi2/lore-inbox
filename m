Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751391AbWENLD6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751391AbWENLD6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 May 2006 07:03:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751393AbWENLD6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 May 2006 07:03:58 -0400
Received: from canuck.infradead.org ([205.233.218.70]:44209 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S1751391AbWENLD6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 May 2006 07:03:58 -0400
Subject: Re: [PATCH] mtd: fix memory leaks in phram_setup
From: David Woodhouse <dwmw2@infradead.org>
To: =?ISO-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: Jesper Juhl <jesper.juhl@gmail.com>, linux-kernel@vger.kernel.org,
       Jochen =?ISO-8859-1?Q?Sch=E4uble?= <psionic@psionic.de>,
       Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <20060514063731.GA22033@wohnheim.fh-wedel.de>
References: <200605140107.18293.jesper.juhl@gmail.com>
	 <1147562300.12379.1.camel@pmac.infradead.org>
	 <9a8748490605131634w73b8d40ax278fac343602123b@mail.gmail.com>
	 <1147563643.16761.1.camel@shinybook.infradead.org>
	 <20060514063731.GA22033@wohnheim.fh-wedel.de>
Content-Type: text/plain; charset=UTF-8
Date: Sun, 14 May 2006 12:03:49 +0100
Message-Id: <1147604629.12379.4.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 (2.6.1-1.fc5.2.dwmw2.1) 
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-05-14 at 08:37 +0200, Jörn Engel wrote:
> The only question is: does it make the code better?  The code has
> seven printk/return combinations.  Each of them would chew up 2 more
> lines without the macro.  So phram_setup would grow from 44 to 58
> lines, not nice either.

How about this then...

diff --git a/drivers/mtd/devices/phram.c b/drivers/mtd/devices/phram.c
index e09e416..fd2d43f 100644
--- a/drivers/mtd/devices/phram.c
+++ b/drivers/mtd/devices/phram.c
@@ -187,36 +187,41 @@ static int ustrtoul(const char *cp, char
 	return result;
 }
 
-static int parse_num32(uint32_t *num32, const char *token)
+static int parse_num32(uint32_t *num32, const char *token, char *name)
 {
 	char *endp;
 	unsigned long n;
 
 	n = ustrtoul(token, &endp, 0);
-	if (*endp)
+	if (*endp) {
+		ERROR("Illegal %s\n", name);
 		return -EINVAL;
+	}
 
 	*num32 = n;
 	return 0;
 }
 
-static int parse_name(char **pname, const char *token)
+static char *parse_name(const char *token)
 {
 	size_t len;
 	char *name;
 
 	len = strlen(token) + 1;
-	if (len > 64)
-		return -ENOSPC;
+	if (len > 64) {
+		ERROR("name too long");
+		return ERR_PTR(-ENOSPC);
+	}
 
 	name = kmalloc(len, GFP_KERNEL);
-	if (!name)
-		return -ENOMEM;
+	if (!name) {
+		ERROR("out of memory");
+		return ERR_PTR(-ENOMEM);
+	}
 
 	strcpy(name, token);
 
-	*pname = name;
-	return 0;
+	return name;
 }
 
 
@@ -228,11 +233,6 @@ static inline void kill_final_newline(ch
 }
 
 
-#define parse_err(fmt, args...) do {	\
-	ERROR(fmt , ## args);	\
-	return 0;		\
-} while (0)
-
 static int phram_setup(const char *val, struct kernel_param *kp)
 {
 	char buf[64+12+12], *str = buf;
@@ -242,8 +242,10 @@ static int phram_setup(const char *val, 
 	uint32_t len;
 	int i, ret;
 
-	if (strnlen(val, sizeof(buf)) >= sizeof(buf))
-		parse_err("parameter too long\n");
+	if (strnlen(val, sizeof(buf)) >= sizeof(buf)) {
+		ERROR("parameter too long\n");
+		return -EINVAL;
+	}
 
 	strcpy(str, val);
 	kill_final_newline(str);
@@ -251,30 +253,24 @@ static int phram_setup(const char *val, 
 	for (i=0; i<3; i++)
 		token[i] = strsep(&str, ",");
 
-	if (str)
-		parse_err("too many arguments\n");
-
-	if (!token[2])
-		parse_err("not enough arguments\n");
-
-	ret = parse_name(&name, token[0]);
-	if (ret == -ENOMEM)
-		parse_err("out of memory\n");
-	if (ret == -ENOSPC)
-		parse_err("name too long\n");
-	if (ret)
-		return 0;
+	if (str) {
+		ERROR("too many arguments\n");
+		return -EINVAL;
+	}
 
-	ret = parse_num32(&start, token[1]);
-	if (ret) {
-		kfree(name);
-		parse_err("illegal start address\n");
+	if (!token[2]) {
+		ERROR("not enough arguments\n");
+		return -EINVAL;
 	}
 
-	ret = parse_num32(&len, token[2]);
-	if (ret) {
+	name = prase_name(token[0]);
+	if (IS_ERR(name))
+	    return PTR_ERR(name);
+
+	if ((ret = parse_num32(&start, token[1], "start address")) ||
+	    (ret = parse_num32(&len, token[2], "device length"))) {
 		kfree(name);
-		parse_err("illegal device length\n");
+		return ret;
 	}
 
 	register_device(name, start, len);

-- 
dwmw2

