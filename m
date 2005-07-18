Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261551AbVGRL23@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261551AbVGRL23 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Jul 2005 07:28:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261655AbVGRL2U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Jul 2005 07:28:20 -0400
Received: from village.ehouse.ru ([193.111.92.18]:14600 "EHLO mail.ehouse.ru")
	by vger.kernel.org with ESMTP id S261551AbVGRL1m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Jul 2005 07:27:42 -0400
From: "Alexander Y. Fomichev" <gluk@php4.ru>
Reply-To: "Alexander Y. Fomichev" <gluk@php4.ru>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: 2.6.12 hangs on boot
Date: Mon, 18 Jul 2005 15:27:16 +0400
User-Agent: KMail/1.8.1
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>, admin@list.net.ru,
       Git Mailing List <git@vger.kernel.org>, ak@suse.de
References: <200506221813.50385.gluk@php4.ru> <Pine.LNX.4.58.0506241446440.11175@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0506241446440.11175@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507181527.16652.gluk@php4.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 25 June 2005 02:20, Linus Torvalds wrote:
> On Wed, 22 Jun 2005, Alexander Y. Fomichev wrote:
> > I've been trying to switch from 2.6.12-rc3 to 2.6.12 on Dual EM64T 2.8
> > GHz [ MoBo: Intel E7520, intel 82801 ]
> > but kernel hangs on boot right after records:
> >
> > Booting processor 2/1 rip 6000 rsp ffff8100023dbf58
> > Initializing CPU#2
>
> Hmm.. Since you seem to be a git user, maybe you could try the git
> "bisect" thing to help narrow down exactly where this happened (and help
> test that thing too ;).

[skiped]

Ok, as i can see  [and as Andi guessed 
http://bugme.osdl.org/show_bug.cgi?id=4792] 
issue have been introduced by new TSC sync algorithm
git id: dda50e716dc9451f40eebfb2902c260e4f62cf34.

And, yes, seems like it depends of timings...
In my case kludge with insertion of low delay (e.g. printk) between 
cpu_set/mb and tsc_sync_wait() makes kernel bootable.

diff -urN b/arch/x86_64/kernel/smpboot.c a/arch/x86_64/kernel/smpboot.c
--- b/arch/x86_64/kernel/smpboot.c	2005-07-17 21:55:55.000000000 +0400
+++ a/arch/x86_64/kernel/smpboot.c	2005-07-17 21:57:56.000000000 +0400
@@ -451,6 +451,7 @@
 	cpu_set(smp_processor_id(), cpu_online_map);
 	mb();
 
+	printk(KERN_INFO "We're still here!\n");
 	/* Wait for TSC sync to not schedule things before.
 	   We still process interrupts, which could see an inconsistent
 	   time in that window unfortunately. */ 

-- 
Best regards.
        Alexander Y. Fomichev <gluk@php4.ru>
        Public PGP key: http://sysadminday.org.ru/gluk.asc
