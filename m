Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030215AbVLSBa6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030215AbVLSBa6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 20:30:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030216AbVLSBa6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 20:30:58 -0500
Received: from xproxy.gmail.com ([66.249.82.194]:6577 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030215AbVLSBa5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 20:30:57 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=nEA1MAzAHOcENF5qPKZeCCu3Q0SHTctzz69l1YFAlaavtphfKBflxkCE4A+NsvJ3Lv7zs5b45zC6ke5ujUoBByRFZpxEYBTEABQZ56yPU7S7LR4RK0CCvfHU5M9BE2RwPK8Bm/VbBefDtLR7DNHhBfjvWxROh1HnPnPIve/NO/c=
Date: Mon, 19 Dec 2005 02:30:58 +0100
From: Diego Calleja <diegocg@gmail.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, matthltc@us.ibm.com
Subject: Re: Linux 2.6.15-rc6
Message-Id: <20051219023058.6d94b13d.diegocg@gmail.com>
In-Reply-To: <Pine.LNX.4.64.0512181641580.4827@g5.osdl.org>
References: <Pine.LNX.4.64.0512181641580.4827@g5.osdl.org>
X-Mailer: Sylpheed version 2.1.6 (GTK+ 2.8.9; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Sun, 18 Dec 2005 16:47:33 -0800 (PST),
Linus Torvalds <torvalds@osdl.org> escribió:

> Matt Helsley:
>       Add getnstimestamp function
>       Add timestamp field to process events


This last change (5650b736ad328f7f3e4120e8790940289b8ac144) "broke" a
small process event connector test program (the one matt posted here
http://lkml.org/lkml/2005/9/28/347, slighty modified) due to a headers
conflict. I think it's due to my setup, but...

--- a/include/linux/cn_proc.h
+++ b/include/linux/cn_proc.h
@@ -26,6 +26,7 @@
#define CN_PROC_H
#include <linux/types.h>
+#include <linux/time.h>
#include <linux/connector.h>



and the program:
31: #include <stdio.h>
32: #include <stdlib.h>
33: #include <string.h>
34: #include <unistd.h>
35: 
36: #include <sys/socket.h>
37: #include <sys/types.h>
38: 
39: #include <linux/connector.h>
40: #include <linux/netlink.h>
41: #include <linux/cn_proc.h>



This gives me 

diego@estel 2J2 ~/kernel # LC_ALL='C' make
gcc -I 2.6/include test_cn_proc.c -o test_cn_proc
In file included from 2.6/include/linux/cn_proc.h:29,
                 from test_cn_proc.c:41:
2.6/include/linux/time.h:12: error: redefinition of 'struct timespec'
2.6/include/linux/time.h:18: error: redefinition of 'struct timeval'
In file included from 2.6/include/linux/cn_proc.h:29,
                 from test_cn_proc.c:41:
2.6/include/linux/time.h:121:1: warning: "FD_SET" redefined
In file included from /usr/include/sys/types.h:216,
                 from /usr/include/stdlib.h:433,
                 from test_cn_proc.c:32:
/usr/include/sys/select.h:93:1: warning: this is the location of the previous definitio

(My "debian testing" box supplies an old and apparently incompatible
version of connector.h so I had to point gcc to kernel's headers directly)
