Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261151AbTJNXNh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 19:13:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261239AbTJNXNh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 19:13:37 -0400
Received: from nwkea-mail-1.sun.com ([192.18.42.13]:52168 "EHLO
	nwkea-mail-1.sun.com") by vger.kernel.org with ESMTP
	id S261151AbTJNXNf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 19:13:35 -0400
Date: Tue, 14 Oct 2003 19:12:47 -0400
From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: [NFS] RE: [autofs] multiple servers per automount
In-reply-to: <bmhn7t$odm$1@cesium.transmeta.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org, Ian Kent <raven@themaw.net>
Message-id: <3F8C82EF.2010104@sun.com>
MIME-version: 1.0
Content-type: multipart/mixed; boundary=------------080904030401060300010907
X-Accept-Language: en
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030618
 Debian/1.3.1-3
References: <Pine.LNX.4.44.0310142131090.3044-100000@raven.themaw.net>
 <3F8C1BB6.9010202@sun.com> <bmhn7t$odm$1@cesium.transmeta.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080904030401060300010907
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

H. Peter Anvin wrote:
> Followup to:  <3F8C1BB6.9010202@sun.com>
> By author:    Mike Waychison <Michael.Waychison@Sun.COM>
> In newsgroup: linux.dev.kernel
> 
>>Here is the quick fix for this in RH 2.1AS kernels:
>>
>>http://www.kernelnewbies.org/kernels/rh21as/SOURCES/linux-2.4.9-moreunnamed.patch
>>
>>It makes unnamed block devices use majors 12, 14, 38, 39, as well as 0. 
>>
>>I don't know if anyone is working out a better scheme for 
>>get_unnamed_dev in 2.6 yet.  It does need to be done though.  A simple 
>>patch for 2.6 would maybe see the unnamed_dev_in_use bitmap grow to 
>>PAGE_SIZE, automatically allowing for 32768 unnamed devices.
>>
> 
> 
> dev_t enlargement, which solves this without a bunch of auxilliary
> majors, should be in 2.6.
> 
> 	-hpa

The problem still remains in 2.6 that we limit the count to 256.  I've 
attached a quick patch that I've compiled and tested.  I don't know if 
there is a better way to handle dynamic assignment of minors (haven't 
kept up to date in that realm), but if there is, then we should probably 
  use it instead.

Mike Waychison

--------------080904030401060300010907
Content-Type: text/plain;
 name="max_anon.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="max_anon.patch"

===== fs/super.c 1.108 vs edited =====
--- 1.108/fs/super.c	Wed Oct  1 15:36:45 2003
+++ edited/fs/super.c	Tue Oct 14 22:52:12 2003
@@ -528,14 +528,22 @@
  * filesystems which don't use real block-devices.  -- jrs
  */
 
-enum {Max_anon = 256};
-static unsigned long unnamed_dev_in_use[Max_anon/(8*sizeof(unsigned long))];
+enum {Max_anon = PAGE_SIZE * 8};
+static void *unnamed_dev_in_use = NULL;
 static spinlock_t unnamed_dev_lock = SPIN_LOCK_UNLOCKED;/* protects the above */
 
 int set_anon_super(struct super_block *s, void *data)
 {
 	int dev;
 	spin_lock(&unnamed_dev_lock);
+
+	if (!unnamed_dev_in_use)
+		unnamed_dev_in_use = (void *)get_zeroed_page(GFP_KERNEL);
+	if (!unnamed_dev_in_use) {
+		spin_unlock(&unnamed_dev_lock);
+		return -ENOMEM;
+	}
+
 	dev = find_first_zero_bit(unnamed_dev_in_use, Max_anon);
 	if (dev == Max_anon) {
 		spin_unlock(&unnamed_dev_lock);

--------------080904030401060300010907--

