Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932174AbWBGRgU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932174AbWBGRgU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 12:36:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932187AbWBGRgU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 12:36:20 -0500
Received: from smtp.osdl.org ([65.172.181.4]:39851 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932174AbWBGRgT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 12:36:19 -0500
Date: Tue, 7 Feb 2006 09:34:58 -0800
From: Andrew Morton <akpm@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: dada1@cosmosbay.com, heiko.carstens@de.ibm.com,
       linux-kernel@vger.kernel.org, davem@davemloft.net,
       James.Bottomley@steeleye.com, mingo@elte.hu, axboe@suse.de,
       anton@samba.org, wli@holomorphy.com, ak@muc.de
Subject: Re: [PATCH] percpu data: only iterate over possible CPUs
Message-Id: <20060207093458.176ac271.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0602070833590.3854@g5.osdl.org>
References: <200602051959.k15JxoHK001630@hera.kernel.org>
	<20060207151541.GA32139@osiris.boeblingen.de.ibm.com>
	<43E8CA10.5070501@cosmosbay.com>
	<Pine.LNX.4.64.0602070833590.3854@g5.osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:
>
> 
> 
> On Tue, 7 Feb 2006, Eric Dumazet wrote:
> > 
> > This patch assumes that cpu_possible_map is setup before
> > setup_per_cpu_areas().
> > 
> > That sounds a reasonable assumption, but maybe not on your architecture ?
> 
> I have to say, it sounds not just like a reasonable assumption, but like 
> the only sane assumption that there _could_ be.
> 
> > I dont think cpu_possible_map has to be filled at smp_prepare_cpus() time, but
> > long before.
> > 
> > On i386/x86_64/ia64, this is done from setup_arch() called from start_kernel()
> > just before setup_per_cpu_areas()
> > 
> > On powerpc it's done from setup_system(), called before start_kernel()
> 
> It absolutely _has_ to be done from setup_arch() or earlier, as shown by 
> the fact that "setup_per_cpu_areas()" is the very next thing that 
> init/main.c calls (and clearly, that needs to know what CPU's are 
> possible).
> 
> ppc64 certainly calls it early enough, as does x86/x86-64/ia64. I don't 
> see anybody else doing it too late either.
> 
> Heiko, can you point to the "old comment" you mentioned in the email, or 
> the architecture that does this wrong?
> 

This one:

--- devel/fs/file.c~reduce-size-of-percpudata-and-make-sure-per_cpuobject	2006-02-04 23:27:17.000000000 -0800
+++ devel-akpm/fs/file.c	2006-02-04 23:27:17.000000000 -0800
@@ -379,7 +379,6 @@ static void __devinit fdtable_defer_list
 void __init files_defer_init(void)
 {
 	int i;
-	/* Really early - can't use for_each_cpu */
-	for (i = 0; i < NR_CPUS; i++)
+	for_each_cpu(i)
 		fdtable_defer_list_init(i);
 }

And yes, me too - when I saw that comment disappear I checked and decided
that the comment was both wrong and undesirable.
