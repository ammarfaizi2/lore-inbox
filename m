Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263997AbSIQJnM>; Tue, 17 Sep 2002 05:43:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264002AbSIQJm5>; Tue, 17 Sep 2002 05:42:57 -0400
Received: from mail-01.iinet.net.au ([203.59.3.33]:20231 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id <S263997AbSIQJmP>;
	Tue, 17 Sep 2002 05:42:15 -0400
Message-ID: <3D86F8C4.6080600@iinet.net.au>
Date: Tue, 17 Sep 2002 19:41:24 +1000
From: Nero <neroz@iinet.net.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2a) Gecko/20020910
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: marcelo@conectiva.com.br
Subject: [PATCH 2.4][TRIVIAL] ppp_generic.c warning fix
Content-Type: multipart/mixed;
 boundary="------------030503070101080704040204"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030503070101080704040204
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi, I had been getting this warning for a while, decided to do something
about it :-)

The warning:

gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes
-Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer
-pipe -mpreferred-stack-boundary=2 -march=athlon  -DMODULE  -nostdinc -I
/usr/lib/gcc-lib/i386-linux/3.2.1/include -DKBUILD_BASENAME=ppp_generic
    -DEXPORT_SYMTAB -c ppp_generic.c
ppp_generic.c: In function `ppp_read':
ppp_generic.c:381: warning: `ret' might be used uninitialized in this
function

I realise 2.5 has this fixed, but for some reason they initialize it as
count, but shortly after that it gets set back to 0...

[attached patch as well, incase the inline one got fubared. I don't
trust paste]
------------------------------------------------------------------------


diff -urN linux-2.4.19-old/drivers/net/ppp_generic.c
linux-2.4.19-new/drivers/net/ppp_generic.c
--- linux-2.4.19-old/drivers/net/ppp_generic.c	2002-07-20
20:52:50.000000000 +1000
+++ linux-2.4.19-new/drivers/net/ppp_generic.c	2002-09-17
18:12:19.000000000 +1000
@@ -378,18 +378,20 @@
    {
    	struct ppp_file *pf = file->private_data;
    	DECLARE_WAITQUEUE(wait, current);
-	ssize_t ret;
+	ssize_t ret = 0;
    	struct sk_buff *skb = 0;

-	if (pf == 0)
-		return -ENXIO;
+	if (pf == 0) {
+		ret = -ENXIO;
+		goto out;
+	}
+	
    	add_wait_queue(&pf->rwait, &wait);
    	for (;;) {
    		set_current_state(TASK_INTERRUPTIBLE);
    		skb = skb_dequeue(&pf->rq);
    		if (skb)
    			break;
-		ret = 0;
    		if (pf->dead)
    			break;
    		ret = -EAGAIN;



--------------030503070101080704040204
Content-Type: text/plain;
 name="ppp_generic.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ppp_generic.patch"

diff -urN linux-2.4.19-old/drivers/net/ppp_generic.c linux-2.4.19-new/drivers/net/ppp_generic.c
--- linux-2.4.19-old/drivers/net/ppp_generic.c	2002-07-20 20:52:50.000000000 +1000
+++ linux-2.4.19-new/drivers/net/ppp_generic.c	2002-09-17 18:12:19.000000000 +1000
@@ -378,18 +378,20 @@
 {
 	struct ppp_file *pf = file->private_data;
 	DECLARE_WAITQUEUE(wait, current);
-	ssize_t ret;
+	ssize_t ret = 0;
 	struct sk_buff *skb = 0;
 
-	if (pf == 0)
-		return -ENXIO;
+	if (pf == 0) {
+		ret = -ENXIO;
+		goto out;
+	}
+	
 	add_wait_queue(&pf->rwait, &wait);
 	for (;;) {
 		set_current_state(TASK_INTERRUPTIBLE);
 		skb = skb_dequeue(&pf->rq);
 		if (skb)
 			break;
-		ret = 0;
 		if (pf->dead)
 			break;
 		ret = -EAGAIN;



--------------030503070101080704040204--

