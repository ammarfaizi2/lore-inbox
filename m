Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135633AbRDSLqc>; Thu, 19 Apr 2001 07:46:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135634AbRDSLqX>; Thu, 19 Apr 2001 07:46:23 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:63749 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S135633AbRDSLqO>;
	Thu, 19 Apr 2001 07:46:14 -0400
Date: Thu, 19 Apr 2001 13:46:01 +0200
From: Jens Axboe <axboe@suse.de>
To: stefan@jaschke-net.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problems with Toshiba SD-W2002 DVD-RAM drive (IDE)
Message-ID: <20010419134601.P16822@suse.de>
In-Reply-To: <01041714250400.01376@antares> <20010418123941.H492@suse.de> <20010418143953.D490@suse.de> <01041913393800.01240@antares>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="dDRMvlgZJXvWKvBx"
Content-Disposition: inline
In-Reply-To: <01041913393800.01240@antares>; from s-jaschke@t-online.de on Thu, Apr 19, 2001 at 01:39:38PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 19 2001, Stefan Jaschke wrote:
> Hi Jens,
> 
> I applied your patch to 2.4.4-pre4. It compiled fine, but crashed during
> boot (just right after the IDE init) with
> -------------------
> Uniform CD-ROM driver Revision: 3.12
> Unable to handle kernel NULL pointer dereference at virtual address 00000000
> printing eip: ...
> Oops: 0000
> ...
> -------------------

This should fix it.

-- 
Jens Axboe


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=cd-get-entry-1

--- drivers/cdrom/cdrom.c~	Thu Apr 19 13:44:46 2001
+++ drivers/cdrom/cdrom.c	Thu Apr 19 13:45:33 2001
@@ -350,6 +350,12 @@
 {
 	int i, nr, foo;
 
+	if (!cdrom_numbers) {
+		int n_entries = CDROM_MAX_CDROMS / (sizeof(unsigned long) * 8);
+		cdrom_numbers = kmalloc(n_entries * sizeof(unsigned long), GFP_KERNEL);
+		memset(cdrom_numbers, 0, n_entries * sizeof(unsigned long));
+	}
+
 	nr = 0;
 	foo = -1;
 	for (i = 0; i < CDROM_MAX_CDROMS / (sizeof(unsigned long) * 8); i++) {
@@ -2696,10 +2702,6 @@
 
 static int __init cdrom_init(void)
 {
-	int n_entries = CDROM_MAX_CDROMS / (sizeof(unsigned long) * 8);
-
-	cdrom_numbers = kmalloc(n_entries * sizeof(unsigned long), GFP_KERNEL);
-
 #ifdef CONFIG_SYSCTL
 	cdrom_sysctl_register();
 #endif

--dDRMvlgZJXvWKvBx--
